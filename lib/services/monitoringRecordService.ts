import {
  GoalHistoryEvent,
  GoalType,
  MonitoringRecordStatus,
  MonitoringResourcesOrigin,
  MonitoringResourceType,
  MonitoringStatus,
} from "@prisma/client";
import {
  CreateMonitoringRecord,
  DevPlan,
  MonitoringConfig,
  MonitoringRecord,
  MonitoringRecordResource,
  Proyecto,
  UpdateMonitoringRecord,
  VActividadesPryWithGoals,
} from "../../graphql/types";
import prisma from "../prisma";
import { ActividadService, ProyectoService } from "./siif";
import { MonitoringConfigService } from "./monitoringConfigService";
import { TenantService } from "./tenantService";
import { MonitoringRecordResourceService } from "./monitoringRecordResourceService";
import { SavePlannedMonitoringRecord } from "../../graphql/types/monitoringRecord";
import { GoalHistoryService } from "./goalHistoryService";
import { GoalService } from "./goalService";

type MonitoringRecordWithResources = MonitoringRecord & {
  resources?: MonitoringRecordResource[];
};

export class MonitoringRecordService {
  private static _instance: MonitoringRecordService | undefined;

  private constructor() {}

  static get instance() {
    if (this._instance === undefined) {
      this._instance = new this();
    }
    return this._instance;
  }

  async getMonitoringRecords({
    monitoringConfigId,
    goalId,
    goalIds,
    period,
    includeResources = false,
    recordStatus,
  }: {
    monitoringConfigId?: number;
    activityId?: number;
    goalId?: number;
    goalIds?: number[];
    period?: number;
    includeResources?: boolean;
    recordStatus?: MonitoringRecordStatus;
  }): Promise<MonitoringRecordWithResources[]> {
    return prisma.monitoringRecord.findMany({
      where: {
        monitoringConfigId,
        goalId,
        period,
        recordStatus,
        ...(goalIds && goalIds.length > 0 ? { goalId: { in: goalIds } } : {}),
      },
      include: {
        resources: includeResources,
      },
    });
  }

  async getMonitoringRecord({
    id,
    monitoringConfigId,
    goalId,
    period,
    includeResources = false,
    recordStatus,
  }: {
    id?: number;
    monitoringConfigId?: number;
    activityId?: number;
    goalId?: number;
    period?: number;
    includeResources?: boolean;
    recordStatus?: MonitoringRecordStatus;
  }): Promise<MonitoringRecordWithResources | null> {
    if (id) {
      return prisma.monitoringRecord.findUnique({
        where: {
          id,
        },
        include: {
          resources: includeResources,
        },
      });
    }
    return prisma.monitoringRecord.findFirst({
      where: {
        monitoringConfigId,
        goalId,
        period,
        recordStatus,
      },
      include: {
        resources: includeResources,
      },
    });
  }

  async createMonitoringRecord(
    data: Omit<CreateMonitoringRecord, "id" | "createdAt" | "updatedAt" | "fromMonth" | "toMonth"> &
      Partial<
        Pick<CreateMonitoringRecord, "id" | "createdAt" | "updatedAt" | "fromMonth" | "toMonth">
      >,
  ): Promise<MonitoringRecord> {
    const { historyDescription, ...createData } = data;
    const record = await prisma.monitoringRecord.create({
      data: createData,
    });
    if (historyDescription) {
      await GoalHistoryService.instance.createGoalHistory({
        goalId: record.goalId,
        monitoringRecordId: record.id,
        event: GoalHistoryEvent.SCHEDULED,
        description: historyDescription,
      });
    }
    return record;
  }

  async updateMonitoringRecord(
    data: Omit<UpdateMonitoringRecord, "createdAt"> &
      Partial<Pick<UpdateMonitoringRecord, "createdAt">>,
  ): Promise<MonitoringRecord> {
    const { id, historyDescription, ...updateData } = data;
    const record = await prisma.monitoringRecord.update({
      where: {
        id,
      },
      data: updateData,
    });
    if (historyDescription) {
      await GoalHistoryService.instance.createGoalHistory({
        goalId: record.goalId,
        monitoringRecordId: record.id,
        event: GoalHistoryEvent.SCHEDULED,
        description: historyDescription,
      });
    }
    return record;
  }

  async createMonitoringRecordsFromActivities({
    tenantKey,
    monitoringConfig,
    activities,
    projectCodes,
  }: {
    tenantKey: string;
    monitoringConfig: MonitoringConfig;
    projectCodes: string[];
    activities: VActividadesPryWithGoals[];
  }): Promise<MonitoringRecord[]> {
    const valoresActividades = await ActividadService.instance.getValoresFisicos({
      tenantKey,
      projects: projectCodes,
      period: monitoringConfig.period,
      subperiod: monitoringConfig.subperiod,
    });
    const monitoringRecords: MonitoringRecord[] = [];
    const activitiesWithGoals = activities.filter((activity) => !!activity.goal);

    for (let i = 0; i < activitiesWithGoals.length; i++) {
      const actividad = activitiesWithGoals[i];
      const valorActividadSubperiodo = valoresActividades.find(
        (valorActividad) => valorActividad.id === actividad.id,
      );

      if (valorActividadSubperiodo) {
        // Create a new schedule record for the activity or update it
        const existingMonitoringRecord = await MonitoringRecordService.instance.getMonitoringRecord(
          {
            monitoringConfigId: monitoringConfig.id,
            goalId: actividad.goal?.id,
            period: monitoringConfig.period,
          },
        );
        if (existingMonitoringRecord) {
          if (
            (existingMonitoringRecord.recordStatus === MonitoringRecordStatus.COPIED ||
              existingMonitoringRecord.recordStatus === MonitoringRecordStatus.PLANNED) &&
            (valorActividadSubperiodo?.cantidadAct ?? 0) !== existingMonitoringRecord.goalValue
          ) {
            monitoringRecords.push(
              await this.updateMonitoringRecord({
                id: existingMonitoringRecord.id,
                goalValue: valorActividadSubperiodo?.cantidadAct ?? 0,
                historyDescription: `Valor físico de la actividad actualizado a ${valorActividadSubperiodo?.cantidadAct}.`,
              }),
            );
          }
        } else {
          monitoringRecords.push(
            await this.createMonitoringRecord({
              monitoringConfigId: monitoringConfig.id,
              goalId: actividad.goal?.id!,
              period: monitoringConfig.period,
              goalValue: valorActividadSubperiodo?.cantidadAct ?? 0,
              recordStatus: MonitoringRecordStatus.COPIED,
              historyDescription: `Valor físico de la actividad copiado de SIIFWEB a seguimiento.`,
            }),
          );
        }
      }
    }
    return monitoringRecords;
  }

  async createOrUpdateMonitoringRecordsFromProjects({
    monitoringConfigId,
    stage,
    resourceType,
  }: {
    monitoringConfigId: number;
    stage: MonitoringStatus;
    resourceType: MonitoringResourceType;
  }) {
    const monitoringConfig = await MonitoringConfigService.instance.getMonitoringConfigById({
      id: monitoringConfigId,
      include: {
        devPlan: true,
      },
    });
    if (!monitoringConfig) {
      throw new Error(`No se encontró seguimiento con ID ${monitoringConfigId}`);
    }
    const devPlan = monitoringConfig?.devPlan;
    if (!devPlan) {
      throw new Error(`No se encontró plan de desarrollo con ID ${monitoringConfig?.devPlanId}`);
    }
    const tenant = await TenantService.instance.getTenantById({ id: devPlan.tenantId });

    const proyectos = await ProyectoService.instance.getProyectosWithGoals({
      tenantKey: tenant.key,
      plan: devPlan.code,
    });
    const projectCodes = proyectos.map((proyecto) => proyecto.proyecto);

    let monitoringRecords: MonitoringRecord[] = [];
    if (stage === MonitoringStatus.SCHEDULING) {
      monitoringRecords = await this.createMonitoringRecordsFromProjects({
        tenantKey: tenant.key,
        projectCodes,
        monitoringConfig,
      });
    } else if (stage === MonitoringStatus.REPORTING) {
      monitoringRecords = await this.getMonitoringRecords({
        goalIds: proyectos.map((proyecto) => proyecto.goal?.id as number),
      });
    }

    const resourcesByProjectGoalId =
      await MonitoringRecordResourceService.instance.getAggregatedMonitoringResources({
        monitoringConfigId,
        sourceGoalType: GoalType.ACTIVITY,
        resourceType,
      });

    // Create or update the monitoring records resources
    await MonitoringRecordResourceService.instance.createMonitoringRecordResourcesFromProjects({
      tenantKey: tenant.key,
      monitoringConfig,
      projects: proyectos,
      monitoringRecords,
      resources: resourcesByProjectGoalId,
      resourceType,
    });
  }

  async createOrUpdateMonitoringRecordsFromChildren({
    monitoringConfigId,
    stage,
    resourceType,
    goalType,
  }: {
    monitoringConfigId: number;
    stage: MonitoringStatus;
    resourceType: MonitoringResourceType;
    goalType: GoalType;
  }) {
    const sourceGoalType =
      goalType === GoalType.ACTION_PLAN
        ? GoalType.ACTION_PLAN_ACTIVITY
        : goalType === GoalType.PROJECT
          ? GoalType.ACTIVITY
          : goalType;
    const monitoringConfig = await MonitoringConfigService.instance.getMonitoringConfigById({
      id: monitoringConfigId,
      include: {
        devPlan: true,
      },
    });
    if (!monitoringConfig) {
      throw new Error(`No se encontró seguimiento con ID ${monitoringConfigId}`);
    }
    const devPlan = monitoringConfig?.devPlan;
    if (!devPlan) {
      throw new Error(`No se encontró plan de desarrollo con ID ${monitoringConfig?.devPlanId}`);
    }
    const tenant = await TenantService.instance.getTenantById({ id: devPlan.tenantId });

    const goalIds = await GoalService.instance.getGoalIdsByGoalType({
      devPlanId: devPlan.id,
      goalType,
    });

    console.log("[createOrUpdateMonitoringRecordsFromChildren] goalIds", goalIds);
    console.log("[createOrUpdateMonitoringRecordsFromChildren] sourceGoalType", sourceGoalType);
    console.log("[createOrUpdateMonitoringRecordsFromChildren] resourceType", resourceType);
    console.log(
      "[createOrUpdateMonitoringRecordsFromChildren] monitoringConfigId",
      monitoringConfigId,
    );
    console.log("[createOrUpdateMonitoringRecordsFromChildren] stage", stage);

    let monitoringRecords: MonitoringRecord[] = [];
    if (stage === MonitoringStatus.SCHEDULING) {
      monitoringRecords = await this.createMonitoringRecordsFromGoals({
        monitoringConfig,
        goalIds,
      });
    } else if (stage === MonitoringStatus.REPORTING) {
      monitoringRecords = await this.getMonitoringRecords({
        goalIds,
      });
    }

    const resourcesByParentGoalId =
      await MonitoringRecordResourceService.instance.getAggregatedMonitoringResources({
        monitoringConfigId,
        sourceGoalType,
        resourceType,
      });

    // Create or update the monitoring records resources
    await MonitoringRecordResourceService.instance.createMonitoringRecordResourcesFromGoals({
      monitoringConfig,
      goalIds,
      resources: resourcesByParentGoalId,
      resourceType,
    });
  }

  async createMonitoringRecordsFromProjects({
    tenantKey,
    monitoringConfig,
    projectCodes,
  }: {
    tenantKey: string;
    monitoringConfig: MonitoringConfig;
    projectCodes: string[];
  }): Promise<MonitoringRecord[]> {
    const projectsWithGoals = (
      await ProyectoService.instance.getProyectosWithGoals({
        tenantKey,
        projectCodes,
      })
    ).filter((project) => !!project.goal);

    const monitoringRecords: MonitoringRecord[] =
      await MonitoringRecordService.instance.createMonitoringRecordsFromGoals({
        monitoringConfig,
        goalIds: projectsWithGoals.map((project) => project.goal?.id as number),
      });

    return monitoringRecords;
  }

  async createMonitoringRecordsFromGoals({
    monitoringConfig,
    goalIds,
  }: {
    monitoringConfig: MonitoringConfig;
    goalIds: number[];
  }): Promise<MonitoringRecord[]> {
    const monitoringRecords: MonitoringRecord[] = [];

    for (let i = 0; i < goalIds.length; i++) {
      const goalId = goalIds[i];
      // Create a new schedule record for the activity or update it
      const existingMonitoringRecord = await MonitoringRecordService.instance.getMonitoringRecord({
        monitoringConfigId: monitoringConfig.id,
        goalId: goalId,
        period: monitoringConfig.period,
      });
      if (!existingMonitoringRecord) {
        monitoringRecords.push(
          await this.createMonitoringRecord({
            monitoringConfigId: monitoringConfig.id,
            goalId: goalId,
            period: monitoringConfig.period,
            recordStatus: MonitoringRecordStatus.COPIED,
          }),
        );
      }
    }
    return monitoringRecords;
  }

  async savePlannedMonitoringRecord({
    data,
    userId,
  }: {
    data: SavePlannedMonitoringRecord;
    userId: number;
  }): Promise<MonitoringRecord> {
    const { id, monitoringResources, ...monitoringRecordData } = data;

    let monitoringRecord: MonitoringRecord | undefined = undefined;
    if (id) {
      monitoringRecord = await MonitoringRecordService.instance.updateMonitoringRecord({
        id,
        ...monitoringRecordData,
        recordStatus: MonitoringRecordStatus.PLANNED,
      });
    } else {
      monitoringRecord = await MonitoringRecordService.instance.createMonitoringRecord({
        ...monitoringRecordData,
        recordStatus: MonitoringRecordStatus.PLANNED,
      });
    }

    if (monitoringResources?.length && monitoringRecord) {
      const monitoringConfig = await MonitoringConfigService.instance.getMonitoringConfigById({
        id: monitoringRecord.monitoringConfigId,
        include: {
          devPlan: true,
        },
      });
      if (!monitoringConfig) {
        throw new Error(`No se encontró seguimiento con ID ${monitoringRecord.monitoringConfigId}`);
      }
      if (!monitoringConfig.devPlan) {
        throw new Error(
          `No se encontró plan de desarrollo asociado al seguimiento ${monitoringRecord.monitoringConfigId}`,
        );
      }
      if (MonitoringConfigService.instance.supportUserResources(monitoringConfig)) {
        await Promise.all(
          monitoringResources?.map(async (monitoringResource) => {
            const { id: resourceId, ...resourceData } = monitoringResource;
            if (resourceId) {
              return await prisma.monitoringRecordResource.update({
                where: { id: resourceId },
                data: resourceData,
              });
            } else {
              return await prisma.monitoringRecordResource.create({
                data: {
                  ...monitoringResource,
                  monitoringRecordId: monitoringRecord?.id as number,
                },
              });
            }
          }),
        );
      }
    }

    await GoalHistoryService.instance.createGoalHistory({
      goalId: monitoringRecord.goalId,
      monitoringRecordId: monitoringRecord.id,
      event: GoalHistoryEvent.SCHEDULED,
      createdBy: userId,
      description: "Programación actualizada por el usuario",
    });

    return monitoringRecord;
  }
}
