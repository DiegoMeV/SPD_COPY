import { Resolver, Query, Mutation, Arg, Int, FieldResolver, Root, Ctx } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import {
  Goal,
  CreateGoal,
  UpdateGoal,
  SearchGoals,
  Entity,
  Ods,
  PublicPolitic,
  ProductCatalog,
  DevPlanLevel,
  MonitoringRecord,
  SiifActividadMeta,
  MonitoringConfig,
  MonitoringRecordResource,
  PublicPoliticComponent,
  MacroProject,
  VActividadesPry,
  Proyecto,
} from "../types/";
import prisma from "../../lib/prisma";
import {
  SearchGoalsResponse,
  SearchGoalsFormat,
  GetGoalsToCopyFromSIIFResponse,
} from "../types/goal";
import { GoalType, MonitoringRecordStatus, MonitoringResourcesOrigin } from "@prisma/client";
import type { Context } from "../types/common";
import { GoalHistory } from "../types/goalHistory";
import { MonitoringRecordWithStatus } from "../types/monitoringRecord";
import { GoalMonitoringRecordStatus } from "../../shared/const";
import _ from "lodash";
import { ActividadService, EntityService, GoalService, ProyectoService } from "../../lib/services";
import { DevPlanLevelService } from "../../lib/services";

@Resolver(() => Goal)
export class GoalResolver extends SPDResolver {
  @FieldResolver(() => [Goal], { nullable: true })
  async children(@Root() goal: Goal): Promise<Goal[] | null> {
    if (goal.goalType === GoalType.PROJECT || goal.goalType === GoalType.ACTION_PLAN) {
      const goals = await prisma.goal
        .findUnique({
          where: {
            id: goal.id,
          },
        })
        .childrenGoals();
      return GoalService.instance.sortGoalsByCode(goals ?? []);
    }
    return null;
  }

  @FieldResolver(() => Entity, { nullable: true })
  async entity(@Root() goal: Goal): Promise<Entity | null> {
    return EntityService.instance.getEntity({ goal });
  }

  @FieldResolver(() => [Ods], { nullable: true })
  async ods(@Root() goal: Goal): Promise<Ods[] | null> {
    if (goal.odsIds === null) return null;
    const odsIds: number[] = goal.odsIds as number[];
    return prisma.ods.findMany({ where: { id: { in: odsIds } } });
  }

  @FieldResolver(() => PublicPolitic, { nullable: true })
  async publicPolitic(@Root() goal: Goal): Promise<PublicPolitic | null> {
    if (goal.publicPoliticId)
      return prisma.goal
        .findUnique({
          where: {
            id: goal.id,
          },
        })
        .publicPolitic();

    return null;
  }

  @FieldResolver(() => PublicPoliticComponent, { nullable: true })
  async publicPoliticComponent(@Root() goal: Goal): Promise<PublicPoliticComponent | null> {
    if (goal.publicPoliticComponentId)
      return prisma.goal
        .findUnique({
          where: {
            id: goal.id,
          },
        })
        .publicPoliticComponent();

    return null;
  }

  @FieldResolver(() => PublicPolitic, { nullable: true })
  async peacePolitic(@Root() goal: Goal): Promise<PublicPolitic | null> {
    if (goal.peacePoliticId)
      return prisma.goal
        .findUnique({
          where: {
            id: goal.id,
          },
        })
        .peacePolitic();

    return null;
  }

  @FieldResolver(() => PublicPolitic, { nullable: true })
  async victimsPolitic(@Root() goal: Goal): Promise<PublicPolitic | null> {
    if (goal.victimsPoliticId)
      return prisma.goal
        .findUnique({
          where: {
            id: goal.id,
          },
        })
        .victimsPolitic();

    return null;
  }

  @FieldResolver(() => ProductCatalog, { nullable: true })
  async productCatalog(@Root() goal: Goal): Promise<ProductCatalog | null> {
    if (goal.productCatalogId)
      return prisma.goal
        .findUnique({
          where: {
            id: goal.id,
          },
        })
        .productCatalog();

    return null;
  }

  @FieldResolver(() => MacroProject, { nullable: true })
  async macroProject(@Root() goal: Goal): Promise<MacroProject | null> {
    if (goal.macroProjectId)
      return prisma.goal
        .findUnique({
          where: {
            id: goal.id,
          },
        })
        .macroProject();
    return null;
  }

  @FieldResolver(() => DevPlanLevel, { nullable: true })
  async devPlanLevel(@Root() goal: Goal): Promise<DevPlanLevel | null> {
    return DevPlanLevelService.instance.getDevPlanLevel({ goal });
  }

  @FieldResolver(() => [MonitoringRecord], { nullable: true })
  async schedule(@Root() goal: Goal): Promise<MonitoringRecord[] | null> {
    return prisma.goal
      .findUnique({
        where: {
          id: goal.id,
        },
      })
      .monitoringRecords({});
  }

  @FieldResolver(() => [MonitoringRecord], { nullable: true })
  async tracking(@Root() goal: Goal): Promise<MonitoringRecord[] | null> {
    return prisma.goal
      .findUnique({
        where: {
          id: goal.id,
        },
      })
      .monitoringRecords({});
  }

  @FieldResolver(() => Proyecto, { nullable: true })
  async proyecto(@Root() goal: Goal, @Ctx() ctx: Context): Promise<Proyecto | null> {
    if (!goal.projectCode) return null;
    return ProyectoService.instance.getProyecto({
      tenantKey: this.getContextTenantKey(ctx),
      code: goal.projectCode,
    });
  }

  @FieldResolver(() => VActividadesPry, { nullable: true })
  async actividad(@Root() goal: Goal, @Ctx() ctx: Context): Promise<VActividadesPry | null> {
    if (!goal.activityId) return null;
    return ActividadService.instance.getActividadById({
      tenantKey: this.getContextTenantKey(ctx),
      id: goal.activityId,
    });
  }

  getGoalMonitoringRecordStatus(
    goal: Goal,
    monitoringRecord: MonitoringRecord & {
      monitoringConfig: MonitoringConfig;
      resources: MonitoringRecordResource[];
    },
  ): GoalMonitoringRecordStatus {
    if (monitoringRecord.recordStatus === MonitoringRecordStatus.REVIEWED) {
      return GoalMonitoringRecordStatus.REVIEWED;
    }
    if (monitoringRecord.recordStatus === MonitoringRecordStatus.VALIDATED) {
      return GoalMonitoringRecordStatus.VALIDATED;
    }
    if (monitoringRecord.recordStatus === MonitoringRecordStatus.REPORTED) {
      return GoalMonitoringRecordStatus.REPORTED;
    }
    if (monitoringRecord.recordStatus === MonitoringRecordStatus.COPIED) {
      return GoalMonitoringRecordStatus.PARTIALLY_SCHEDULED;
    }
    if (monitoringRecord.recordStatus === MonitoringRecordStatus.PLANNED) {
      if (
        (monitoringRecord.resources?.length ?? 0) <
        (monitoringRecord.monitoringConfig.monitoringResourcesOrigin ===
        MonitoringResourcesOrigin.USER_AND_FINANCIAL
          ? 2
          : 1)
      ) {
        return GoalMonitoringRecordStatus.PARTIALLY_SCHEDULED;
      }
      return GoalMonitoringRecordStatus.SCHEDULED;
    }

    return GoalMonitoringRecordStatus.NEW;
  }

  @FieldResolver(() => [MonitoringRecordWithStatus], { nullable: true })
  async monitoringRecords(@Root() goal: Goal): Promise<MonitoringRecordWithStatus[] | null> {
    const monitoringRecords = await prisma.goal
      .findUnique({
        where: {
          id: goal.id,
        },
      })
      .monitoringRecords({
        include: {
          monitoringConfig: true,
          resources: true,
        },
      });
    const monitoringRecordsWithStatus =
      monitoringRecords?.map((monitoringRecord) => {
        return {
          ..._.omit(monitoringRecord, ["monitoringConfig"]),
          goalStatus: this.getGoalMonitoringRecordStatus(goal, monitoringRecord),
        };
      }) ?? [];
    return monitoringRecordsWithStatus;
  }

  @FieldResolver(() => [GoalHistory], { nullable: true })
  async history(@Root() goal: Goal): Promise<GoalHistory[] | null> {
    return prisma.goal
      .findUnique({
        where: {
          id: goal.id,
        },
      })
      .goalHistory({
        orderBy: {
          createdAt: "desc",
        },
      });
  }

  @FieldResolver(() => [SiifActividadMeta], { nullable: true })
  async activities(@Root() goal: Goal): Promise<SiifActividadMeta[] | null> {
    return prisma.goal
      .findUnique({
        where: {
          id: goal.id,
        },
      })
      .siifActividadMetas({
        orderBy: [{ proyecto: "asc" }, { codigoAct: "asc" }],
      });
  }

  @Query(() => [Goal])
  async getGoals(
    @Arg("devPlanLevelId", () => Int) devPlanLevelId: number,
    @Arg("goalTypes", () => [GoalType], { nullable: true }) goalTypes: GoalType[],
  ): Promise<Goal[]> {
    return GoalService.instance.getGoals({
      devPlanLevelId,
      goalTypes,
      sortByCode: true,
    });
  }

  @Query(() => [Goal])
  async getPublicPoliticGoals(
    @Arg("publicPoliticId", () => Int) publicPoliticId: number,
  ): Promise<Goal[]> {
    const result = await prisma.goal.findMany({
      where: {
        publicPoliticId,
      },
      orderBy: [{ code: "asc" }],
    });

    return result;
  }

  @Query(() => [Goal])
  async getParentLevelGoals(
    @Arg("devPlanLevelId", () => Int) devPlanLevelId: number,
  ): Promise<Goal[]> {
    // Get parent level
    const level = await prisma.devPlanLevel.findUnique({
      where: {
        id: devPlanLevelId,
      },
    });
    if (level?.parentId) {
      const result = await prisma.goal.findMany({
        where: {
          devPlanLevelId: level.parentId,
        },
      });
      return result;
    }
    return [];
  }

  @Query(() => Goal, { nullable: true })
  async getGoal(@Arg("id", () => Int) id: number): Promise<Goal | null> {
    const result = await prisma.goal.findUnique({ where: { id } });
    return result;
  }

  @Query(() => SearchGoalsResponse, { nullable: true })
  async searchGoals(
    @Arg("data") data: SearchGoals,
    @Ctx() ctx: Context,
  ): Promise<SearchGoalsResponse> {
    return GoalService.instance.searchGoals(data);
  }

  @Query(() => String, { nullable: true })
  async searchGoalsFormat(@Arg("data") data: SearchGoalsFormat): Promise<string | null> {
    return GoalService.instance.searchGoalsFormat(data);
  }

  @Query(() => String, { nullable: true })
  async dashboardGoalsFormat(@Arg("data") data: SearchGoalsFormat): Promise<string | null> {
    return GoalService.instance.getDashboardGoalsFormat(data);
  }

  @Mutation(() => Goal)
  async createGoal(@Arg("data") data: CreateGoal, @Ctx() ctx: Context): Promise<Goal> {
    const goal = await GoalService.instance.createGoal({
      ...data,
      userId: this.getContextUserId(ctx),
    });

    return goal;
  }

  @Mutation(() => Goal)
  async updateGoal(@Arg("data") data: UpdateGoal, @Ctx() ctx: Context): Promise<Goal> {
    const { id, ...updateData } = data;
    const goal = await GoalService.instance.updateGoal({
      ...updateData,
      id,
      userId: this.getContextUserId(ctx),
    });

    return goal;
  }

  @Mutation(() => Goal)
  async deleteGoal(@Arg("id", () => Int) id: number): Promise<Goal | null> {
    await prisma.goalHistory.deleteMany({
      where: {
        goalId: id,
      },
    });
    return await prisma.goal.delete({
      where: { id },
    });
  }

  @Query(() => GetGoalsToCopyFromSIIFResponse)
  async getGoalsToCopyFromSIIF(
    @Arg("devPlanId") devPlanId: number,
    @Ctx() ctx: Context,
  ): Promise<GetGoalsToCopyFromSIIFResponse> {
    return GoalService.instance.getGoalsToCopyFromSIIF({
      devPlanId,
      tenantKey: this.getContextTenantKey(ctx),
    });
  }

  @Mutation(() => [Goal])
  async copyGoalsFromSIIF(
    @Arg("devPlanId") devPlanId: number,
    @Ctx() ctx: Context,
  ): Promise<Goal[]> {
    return GoalService.instance.copyGoalsFromSIIF({
      devPlanId,
      tenantKey: this.getContextTenantKey(ctx),
      userId: this.getContextUserId(ctx),
    });
  }
}
