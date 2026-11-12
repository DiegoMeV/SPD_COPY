import { Resolver, Query, Mutation, Arg, Int, FieldResolver, Root, Ctx } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import {
  CreateMonitoringRecord,
  UpdateMonitoringRecord,
  MonitoringRecordResource,
  MonitoringRecordAttachment,
  Goal,
} from "../types";
import prisma from "../../lib/prisma";
import type { Context } from "../types/common";
import { GoalHistoryResolver } from "./goalHistoryResolver";
import {
  GoalHistoryEvent,
  GoalType,
  MonitoringRecordStatus,
  MonitoringResourceType,
} from "@prisma/client";
import {
  SavePlannedMonitoringRecord,
  MonitoringRecord,
  GetMonitoringRecord,
  SaveTrackingMonitoringRecord,
} from "../types/monitoringRecord";
import { round2dp } from "../../client/utils/formatUtils";
import { MonitoringRecordService } from "../../lib/services";

@Resolver(() => MonitoringRecord)
export class MonitoringRecordResolver extends SPDResolver {
  @FieldResolver(() => [MonitoringRecordResource], { nullable: true })
  resources(
    @Root() monitoringRecord: MonitoringRecord,
  ): Promise<MonitoringRecordResource[] | null> {
    return prisma.monitoringRecord
      .findUnique({
        where: {
          id: monitoringRecord.id,
        },
      })
      .resources();
  }

  @FieldResolver(() => [MonitoringRecordAttachment], { nullable: true })
  attachments(
    @Root() monitoringRecord: MonitoringRecord,
  ): Promise<MonitoringRecordAttachment[] | null> {
    return prisma.monitoringRecord
      .findUnique({
        where: {
          id: monitoringRecord.id,
        },
      })
      .attachments();
  }

  @FieldResolver(() => Goal)
  async goal(@Root() monitoringRecord: MonitoringRecord): Promise<Goal> {
    const goal = await prisma.monitoringRecord
      .findUnique({
        where: {
          id: monitoringRecord.id,
        },
      })
      .goal();
    if (!goal) {
      throw new Error("No se encontró la meta asociada a la programación");
    }
    return goal;
  }

  @Query(() => MonitoringRecord, { nullable: true })
  async getMonitoringRecord(
    @Arg("data") data: GetMonitoringRecord,
  ): Promise<MonitoringRecord | null> {
    const result = await prisma.monitoringRecord.findFirst({ where: data });
    return result;
  }

  @Mutation(() => MonitoringRecord)
  async createMonitoringRecord(
    @Arg("data") data: CreateMonitoringRecord,
    @Ctx() ctx: Context,
  ): Promise<MonitoringRecord> {
    const monitoringRecord = await prisma.monitoringRecord.create({
      data: {
        ...data,
      },
    });
    const goalHistoryResolver = new GoalHistoryResolver();
    await goalHistoryResolver.createGoalHistory(
      {
        goalId: monitoringRecord.goalId,
        monitoringRecordId: monitoringRecord.id,
        event:
          data.recordStatus === MonitoringRecordStatus.PLANNED
            ? GoalHistoryEvent.SCHEDULED
            : GoalHistoryEvent.MONITORED,
      },
      ctx,
    );

    return monitoringRecord;
  }

  @Mutation(() => MonitoringRecord)
  async savePlannedMonitoringRecord(
    @Arg("data", () => SavePlannedMonitoringRecord) data: SavePlannedMonitoringRecord,
    @Ctx() ctx: Context,
  ): Promise<MonitoringRecord> {
    return MonitoringRecordService.instance.savePlannedMonitoringRecord({
      data,
      userId: ctx.user.id,
    });
  }

  calculateFinancialIndicator(
    schedulingResource: MonitoringRecordResource,
    trackingResource: Omit<MonitoringRecordResource, "id" | "monitoringRecordId" | "createdAt">,
  ) {
    const calculateTotals = (
      resource: Omit<MonitoringRecordResource, "id" | "createdAt" | "monitoringRecordId">,
    ) =>
      resource.capital +
      resource.cd +
      resource.cn +
      resource.credit +
      resource.de +
      resource.operation +
      resource.management +
      resource.monopoly +
      resource.others +
      resource.rp +
      resource.sgp +
      resource.sgr;
    const trackingTotals = calculateTotals(schedulingResource);
    return trackingTotals
      ? round2dp(
          Math.min(calculateTotals(trackingResource) / calculateTotals(schedulingResource), 1.0),
          4,
        )
      : 0;
  }

  @Mutation(() => MonitoringRecord)
  async saveTrackingMonitoringRecord(
    @Arg("data", () => SaveTrackingMonitoringRecord) data: SaveTrackingMonitoringRecord,
    @Ctx() ctx: Context,
  ): Promise<MonitoringRecord> {
    // const goalHistoryResolver = new GoalHistoryResolver();
    const { id, monitoringResources, reviewNotes, ...monitoringRecordData } = data;

    let monitoringRecord: MonitoringRecord | undefined = undefined;
    if (id) {
      const currentMonitoringRecord = await prisma.monitoringRecord.findUnique({
        where: {
          id,
        },
      });

      monitoringRecord = await prisma.monitoringRecord.update({
        where: { id },
        data: {
          ...monitoringRecordData,
          recordStatus: monitoringRecordData.recordStatus ?? MonitoringRecordStatus.REPORTED,
          physicalIndicator: currentMonitoringRecord?.goalValue
            ? round2dp(
                Math.min(
                  (monitoringRecordData.goalAchievedValue ??
                    currentMonitoringRecord?.goalAchievedValue) / currentMonitoringRecord.goalValue,
                  1,
                ),
                4,
              )
            : 0.0,
        },
      });
    }

    if (!monitoringRecord) {
      throw new Error("No se encontró la programación de la meta");
    }

    if (monitoringResources?.length && monitoringRecord) {
      const goal = await prisma.goal.findUnique({
        where: { id: monitoringRecord.goalId },
      });
      if (!goal) {
        throw new Error("No se encontró la meta asociada a la programación");
      }
      const schedulingResource = await prisma.monitoringRecordResource.findFirst({
        where: {
          monitoringRecordId: id,
          resourceType:
            goal.goalType === GoalType.ACTION_PLAN ||
            goal.goalType === GoalType.ACTION_PLAN_ACTIVITY
              ? MonitoringResourceType.MANUAL
              : MonitoringResourceType.DEFINITIVE,
        },
      });
      await Promise.all(
        monitoringResources?.map(async (monitoringResource) => {
          const { id: resourceId, ...resourceData } = monitoringResource;
          if (resourceId) {
            const currentMonitoringRecordResource =
              await prisma.monitoringRecordResource.findUnique({
                where: { id: resourceId },
              });
            if (currentMonitoringRecordResource) {
              return await prisma.monitoringRecordResource.update({
                where: { id: resourceId },
                data: {
                  ...resourceData,
                  ...(schedulingResource
                    ? {
                        financialIndicator: this.calculateFinancialIndicator(schedulingResource, {
                          ...currentMonitoringRecordResource,
                          ...resourceData,
                        }),
                      }
                    : {}),
                },
              });
            }
            return null;
          } else {
            return await prisma.monitoringRecordResource.create({
              data: {
                ...monitoringResource,
                monitoringRecordId: monitoringRecord?.id as number,
                ...(schedulingResource
                  ? {
                      financialIndicator: this.calculateFinancialIndicator(
                        schedulingResource,
                        monitoringResource,
                      ),
                    }
                  : {}),
              },
            });
          }
        }),
      );
    }

    const goalHistoryResolver = new GoalHistoryResolver();
    await goalHistoryResolver.createGoalHistory(
      {
        goalId: monitoringRecord.goalId,
        monitoringRecordId: monitoringRecord.id,
        event:
          monitoringRecord.recordStatus === MonitoringRecordStatus.REPORTED
            ? GoalHistoryEvent.MONITORED
            : monitoringRecord.recordStatus === MonitoringRecordStatus.VALIDATED
              ? GoalHistoryEvent.VALIDATED
              : monitoringRecord.recordStatus === MonitoringRecordStatus.REVIEWED
                ? GoalHistoryEvent.REVIEWED
                : monitoringRecord.recordStatus === MonitoringRecordStatus.REJECTED
                  ? GoalHistoryEvent.REJECTED
                  : monitoringRecord.recordStatus === MonitoringRecordStatus.PLANNED
                    ? GoalHistoryEvent.SCHEDULED
                    : GoalHistoryEvent.CREATED,
        description: reviewNotes,
      },
      ctx,
    );

    return monitoringRecord;
  }

  @Mutation(() => MonitoringRecord)
  async updateMonitoringRecord(
    @Arg("data") data: UpdateMonitoringRecord,
    @Ctx() ctx: Context,
  ): Promise<MonitoringRecord> {
    const { id, reviewNotes, ...updateData } = data;
    const monitoringRecord = await prisma.monitoringRecord.update({
      where: { id },
      data: updateData,
    });
    const goalHistoryResolver = new GoalHistoryResolver();
    await goalHistoryResolver.createGoalHistory(
      {
        goalId: monitoringRecord.goalId,
        monitoringRecordId: monitoringRecord.id,
        event:
          monitoringRecord.recordStatus === MonitoringRecordStatus.REPORTED
            ? GoalHistoryEvent.MONITORED
            : monitoringRecord.recordStatus === MonitoringRecordStatus.VALIDATED
              ? GoalHistoryEvent.VALIDATED
              : monitoringRecord.recordStatus === MonitoringRecordStatus.REVIEWED
                ? GoalHistoryEvent.REVIEWED
                : monitoringRecord.recordStatus === MonitoringRecordStatus.REJECTED
                  ? GoalHistoryEvent.REJECTED
                  : monitoringRecord.recordStatus === MonitoringRecordStatus.PLANNED
                    ? GoalHistoryEvent.SCHEDULED
                    : GoalHistoryEvent.UPDATED,
        description: reviewNotes ?? "Actualización de datos",
      },
      ctx,
    );

    return monitoringRecord;
  }
}
