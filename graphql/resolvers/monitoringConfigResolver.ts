import { Resolver, Query, Mutation, Arg, Int, Root, FieldResolver, Ctx } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import {
  MonitoringConfig,
  CreateMonitoringConfig,
  UpdateMonitoringConfig,
  DevPlan,
  MonitoringRecord,
} from "../types";
import prisma from "../../lib/prisma";
import type { Context, JsonObject } from "../types/common";
import { MonitoringStatus } from "../gen/schema";
import {
  CopyMonitoringConfigFromPeriod,
  CopyMonitoringConfigPreviousSchedule,
  GetMonitoringConfig,
  SetActiveMonitoringConfig,
} from "../types/monitoringConfig";
import {
  MonitoringConfigUsedFor,
  MonitoringRecordStatus,
  MonitoringResourceType,
} from "@prisma/client";
import _ from "lodash";

type DatesConfig = {
  reporting?: [string, string];
  reviewing?: [string, string];
  scheduling?: [string, string];
  validating?: [string, string];
};

@Resolver(() => MonitoringConfig)
export class MonitoringConfigResolver extends SPDResolver {
  @FieldResolver(() => [String])
  statusDates(@Root() monitoringConfig: MonitoringConfig): string[] {
    const datesConfig: DatesConfig = (monitoringConfig.datesConfig || {}) as JsonObject;
    const { reporting, reviewing, scheduling, validating } = datesConfig || {};
    switch (monitoringConfig.status) {
      case MonitoringStatus.Created:
        return [monitoringConfig.createdAt.toISOString()];
      case MonitoringStatus.Reporting:
        return [...(reporting || [])];
      case MonitoringStatus.Reviewing:
        return [...(reviewing || [])];
      case MonitoringStatus.Scheduling:
        return [...(scheduling || [])];
      case MonitoringStatus.Validating:
        return [...(validating || [])];
      case MonitoringStatus.Closed:
        return monitoringConfig.updatedAt ? [monitoringConfig.updatedAt?.toISOString()] : [];
      default:
        return [];
    }
  }

  @FieldResolver(() => DevPlan, { nullable: true })
  async devPlan(@Root() monitoringConfig: MonitoringConfig): Promise<DevPlan | null> {
    if (!monitoringConfig?.devPlanId) return null;
    return prisma.devPlan.findUnique({ where: { id: monitoringConfig.devPlanId } });
  }

  @Query(() => [MonitoringConfig])
  async getMonitoringConfigs(
    @Ctx() ctx: Context,
    @Arg("data", () => GetMonitoringConfig, { nullable: true }) data?: GetMonitoringConfig,
  ): Promise<MonitoringConfig[]> {
    const tenantId = this.getContextTenantId(ctx);
    console.debug("tenantId", tenantId);
    const records = await prisma.monitoringConfig.findMany({
      where: {
        ...data,
        tenantId: this.getContextTenantId(ctx),
      },
      orderBy: [{ period: "desc" }, { subperiod: "desc" }],
    });
    return records.sort((recordA, recordB) => (recordA.isActive ? -1 : recordB.isActive ? 1 : 0));
  }

  @Query(() => MonitoringConfig, { nullable: true })
  async getMonitoringConfig(@Arg("id", () => Int) id: number): Promise<MonitoringConfig | null> {
    const result = await prisma.monitoringConfig.findUnique({ where: { id } });
    return result;
  }

  @Query(() => MonitoringConfig, { nullable: true })
  async getActiveMonitoringConfig(
    @Ctx() ctx: Context,
    @Arg("data", () => GetMonitoringConfig, { nullable: true }) data?: GetMonitoringConfig,
  ): Promise<MonitoringConfig | null> {
    const result = await prisma.monitoringConfig.findFirst({
      where: {
        ...data,
        isActive: true,
        tenantId: this.getContextTenantId(ctx),
      },
    });
    return result;
  }

  async inactiveTenantMonitoringConfigs(
    tenantId: number,
    monitoringConfigId: number,
    usedFor: MonitoringConfigUsedFor,
  ) {
    const activeMonitorings = await prisma.monitoringConfig.findMany({
      where: {
        isActive: true,
        tenantId,
        usedFor,
        id: { not: monitoringConfigId },
      },
    });
    if (activeMonitorings?.length) {
      await prisma.monitoringConfig.updateMany({
        where: {
          id: { in: activeMonitorings.map((x) => x.id) },
        },
        data: {
          isActive: false,
        },
      });
    }
  }

  async copyMonitoringScheduleFromPrevious({
    currentMonitoringConfigId,
    previousMonitoringConfigId,
    copyPhysical = false,
    copyFinancial = false,
  }: {
    currentMonitoringConfigId: number;
    previousMonitoringConfigId: number;
    copyPhysical?: boolean;
    copyFinancial?: boolean;
  }): Promise<MonitoringRecord[] | null> {
    const monitoringConfig = await prisma.monitoringConfig.findUnique({
      where: {
        id: currentMonitoringConfigId,
      },
    });
    if (!monitoringConfig) return null;

    const previousMonitoringConfig = await prisma.monitoringConfig.findUnique({
      where: {
        id: previousMonitoringConfigId,
      },
    });
    if (!previousMonitoringConfig) return null;

    // Copy if previous period/subperiod is the previous of the current period/subperiod
    if (
      (previousMonitoringConfig.period === monitoringConfig.period &&
        previousMonitoringConfig.subperiod === monitoringConfig.subperiod - 1) ||
      (monitoringConfig.subperiod === 1 &&
        previousMonitoringConfig.period === monitoringConfig.period - 1 &&
        previousMonitoringConfig.subperiod === 12 / previousMonitoringConfig.periodicity)
    ) {
      // Previous monitoring records
      const previousRecords = await prisma.monitoringRecord.findMany({
        where: {
          monitoringConfigId: previousMonitoringConfig.id,
          resources: {
            some: {
              resourceType: {
                in: [MonitoringResourceType.MANUAL, MonitoringResourceType.DEFINITIVE],
              },
            },
          },
        },
        include: {
          resources: true,
        },
      });

      const result = await Promise.all(
        previousRecords.map(async (record) => {
          const {
            goalId,
            period,
            goalValue,
            piGoalValue,
            fromMonth,
            toMonth,
            weighting,
            resources,
          } = record;
          const existingRecord = await prisma.monitoringRecord.findFirst({
            where: {
              monitoringConfigId: currentMonitoringConfigId,
              goalId,
            },
          });
          let monitoringRecord: MonitoringRecord | null = null;
          // Physical schedule can be copied for existing records
          if (existingRecord && copyPhysical && !copyFinancial) {
            monitoringRecord = await prisma.monitoringRecord.update({
              where: {
                id: existingRecord.id,
              },
              data: {
                goalValue,
                piGoalValue,
                fromMonth,
                toMonth,
                weighting,
                recordStatus: MonitoringRecordStatus.COPIED,
              },
            });
          }
          // Financial schedule can be created for non-existing records
          if (!existingRecord && (copyFinancial || copyPhysical)) {
            monitoringRecord = await prisma.monitoringRecord.create({
              data: {
                monitoringConfigId: currentMonitoringConfigId,
                goalId,
                period,
                goalValue: 0, // 0 unless it is copied from previous
                ...(copyPhysical
                  ? {
                      goalValue,
                      piGoalValue,
                      fromMonth,
                      toMonth,
                      weighting,
                    }
                  : {}),
                recordStatus: MonitoringRecordStatus.COPIED,
                ...(copyFinancial
                  ? {
                      resources: {
                        createMany: {
                          data: resources.map((resource) => ({
                            ..._.omit(resource, [
                              "id",
                              "monitoringRecordId",
                              "createdAt",
                              "updatedAt",
                              "createdBy",
                              "updatedBy",
                            ]),
                          })),
                        },
                      },
                    }
                  : {}),
              },
            });
          }
          return monitoringRecord;
        }),
      );
      return result.filter((record) => !!record) as MonitoringRecord[];
    }
    return null;
  }

  @Mutation(() => [MonitoringRecord], { nullable: true })
  async copyMonitoringConfigPreviousSchedule(
    @Arg("data") data: CopyMonitoringConfigPreviousSchedule,
  ): Promise<MonitoringRecord[] | null> {
    const monitoringConfig = await prisma.monitoringConfig.findUnique({
      where: {
        id: data.id,
      },
    });
    if (!monitoringConfig) return null;

    const previousMonitoringConfig = await prisma.monitoringConfig.findFirst({
      where: {
        id: { not: data.id },
        usedFor: monitoringConfig.usedFor,
        tenantId: monitoringConfig.tenantId,
      },
      orderBy: [{ period: "desc" }, { subperiod: "desc" }],
    });
    if (!previousMonitoringConfig) return null;

    return this.copyMonitoringScheduleFromPrevious({
      currentMonitoringConfigId: data.id,
      previousMonitoringConfigId: previousMonitoringConfig.id,
      copyPhysical: true,
      copyFinancial: true,
    });
  }

  @Mutation(() => [MonitoringRecord], { nullable: true })
  async copyMonitoringConfigFromPeriod(
    @Arg("data") data: CopyMonitoringConfigFromPeriod,
  ): Promise<MonitoringRecord[] | null> {
    const monitoringConfig = await prisma.monitoringConfig.findUnique({
      where: {
        id: data.id,
      },
    });
    if (!monitoringConfig) return null;

    const previousMonitoringConfig = await prisma.monitoringConfig.findFirst({
      where: {
        id: { not: data.id },
        usedFor: monitoringConfig.usedFor,
        tenantId: monitoringConfig.tenantId,
        period: data.period,
        subperiod: data.subperiod,
      },
    });
    if (!previousMonitoringConfig) return null;

    return this.copyMonitoringScheduleFromPrevious({
      currentMonitoringConfigId: data.id,
      previousMonitoringConfigId: previousMonitoringConfig.id,
      copyPhysical: data.copyPhysical,
      copyFinancial: data.copyFinancial,
    });
  }

  @Mutation(() => MonitoringConfig)
  async createMonitoringConfig(
    @Ctx() ctx: Context,
    @Arg("data") data: CreateMonitoringConfig,
  ): Promise<MonitoringConfig | null> {
    const { copyGoals, ...inserData } = data;
    const newMonitoring = await prisma.monitoringConfig.create({
      data: {
        ...inserData,
        tenantId: this.getContextTenantId(ctx),
        status: MonitoringStatus.Created,
      },
    });
    if (newMonitoring?.isActive) {
      await this.inactiveTenantMonitoringConfigs(
        this.getContextTenantId(ctx),
        newMonitoring.id,
        data.usedFor,
      );
    }
    if (copyGoals) {
      await this.copyMonitoringConfigPreviousSchedule({ id: newMonitoring.id });
    }

    return prisma.monitoringConfig.findUnique({ where: { id: newMonitoring.id } });
  }

  @Mutation(() => MonitoringConfig)
  async updateMonitoringConfig(
    @Ctx() ctx: Context,
    @Arg("data") data: UpdateMonitoringConfig,
  ): Promise<MonitoringConfig> {
    const { id, ...updateData } = data;
    const monitoringConfig = await prisma.monitoringConfig.findUnique({
      where: {
        id,
      },
    });
    if (!monitoringConfig)
      throw new Error(`No se encontraron los parámetros de seguimiento con ID: ${id}`);
    if (!monitoringConfig.usedFor)
      throw new Error(`No se ha definido el uso para los parámetros de seguimiento con ID: ${id}`);
    if (updateData?.isActive) {
      await this.inactiveTenantMonitoringConfigs(
        this.getContextTenantId(ctx),
        id,
        monitoringConfig.usedFor,
      );
    }
    return await prisma.monitoringConfig.update({
      where: { id },
      data: updateData,
    });
  }

  @Mutation(() => MonitoringConfig)
  async setActiveMonitoringConfig(
    @Ctx() ctx: Context,
    @Arg("data") data: SetActiveMonitoringConfig,
  ): Promise<MonitoringConfig> {
    const { id } = data;
    const monitoringConfig = await prisma.monitoringConfig.findUnique({
      where: {
        id,
      },
    });
    if (!monitoringConfig)
      throw new Error(`No se encontraron los parámetros de seguimiento con ID: ${id}`);
    if (!monitoringConfig.usedFor)
      throw new Error(`No se ha definido el uso para los parámetros de seguimiento con ID: ${id}`);
    await this.inactiveTenantMonitoringConfigs(
      this.getContextTenantId(ctx),
      id,
      monitoringConfig.usedFor,
    );
    return await prisma.monitoringConfig.update({
      where: { id },
      data: { isActive: true },
    });
  }

  @Mutation(() => MonitoringConfig)
  async deleteMonitoringConfig(@Arg("id", () => Int) id: number): Promise<MonitoringConfig | null> {
    const monitoringRecords = await prisma.monitoringRecord.count({
      where: {
        monitoringConfigId: id,
      },
    });
    if (monitoringRecords)
      throw new Error("No se puede eliminar parámetros de seguimiento, tiene registros asociados");

    return await prisma.monitoringConfig.delete({
      where: { id },
    });
  }
}
