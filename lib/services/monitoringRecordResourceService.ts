import {
  GoalHistoryEvent,
  GoalType,
  MonitoringRecordStatus,
  MonitoringResourceType,
  MonitoringStatus,
} from "@prisma/client";
import {
  CreateMonitoringRecord,
  CreateMonitoringRecordResource,
  DevPlan,
  MonitoringConfig,
  MonitoringRecord,
  MonitoringRecordResource,
  Proyecto,
  ProyectoWithGoals,
  UpdateMonitoringRecord,
  UpdateMonitoringRecordResource,
  VActividadesPryWithGoals,
  VSaldopptalEgrActividadWp,
} from "../../graphql/types";
import prisma from "../prisma";
import { ActividadService } from "./siif";
import { monitoringConfig } from "../../prisma/seedData/890102006/monitoring";
import { camelCase, includes } from "lodash";
import { MonitoringRecordService } from "./monitoringRecordService";
import { GoalFragment } from "../../graphql/gen/ops";
import { GoalHistoryService } from "./goalHistoryService";
import { RESOURCES_FIELDS } from "../../shared/const";

export type MonitoringResource = MonitoringRecordResource & {
  monitoringRecord?: MonitoringRecord;
};

export type MonitoringResourceFromActivity = Pick<
  CreateMonitoringRecordResource,
  "cd" | "cn" | "credit" | "operation" | "management" | "others" | "rp" | "sgp" | "sgr"
>;

export type MonitoringResourceTotal = { goalId: number } & MonitoringResourceFromActivity;

export class MonitoringRecordResourceService {
  private static _instance: MonitoringRecordResourceService | undefined;

  private constructor() {}

  static get instance() {
    if (this._instance === undefined) {
      this._instance = new this();
    }
    return this._instance;
  }

  async getMonitoringRecordResource({
    monitoringConfigId,
    goalId,
    period,
    resourceType,
  }: {
    monitoringConfigId: number;
    activityId?: number;
    goalId?: number;
    period?: number;
    resourceType: MonitoringResourceType;
  }): Promise<MonitoringResource | null> {
    const record = await prisma.monitoringRecordResource.findFirst({
      where: {
        monitoringRecord: {
          monitoringConfig: {
            id: monitoringConfigId,
          },
          goalId,
          period,
        },
        resourceType,
      },
      include: {
        monitoringRecord: true,
      },
    });
    return record;
  }

  async createMonitoringRecordResource(
    data: Omit<
      CreateMonitoringRecordResource,
      "id" | "createdAt" | "updatedAt" | "capital" | "de" | "monopoly"
    > &
      Partial<
        Pick<
          CreateMonitoringRecordResource,
          "id" | "createdAt" | "updatedAt" | "capital" | "de" | "monopoly"
        >
      >,
  ): Promise<MonitoringRecordResource> {
    const { historyDescription, ...resourceData } = data;
    const record = await prisma.monitoringRecordResource.create({
      data: {
        ...resourceData,
        capital: data.capital ?? 0,
        de: data.de ?? 0,
        monopoly: data.monopoly ?? 0,
      },
      include: {
        monitoringRecord: true,
      },
    });
    if (historyDescription) {
      await GoalHistoryService.instance.createGoalHistory({
        goalId: record.monitoringRecord.goalId,
        monitoringRecordId: record.monitoringRecordId,
        event: GoalHistoryEvent.SCHEDULED,
        description: historyDescription,
      });
    }
    return record;
  }

  async updateMonitoringRecordResource(
    data: Omit<UpdateMonitoringRecordResource, "createdAt"> &
      Partial<Pick<UpdateMonitoringRecordResource, "createdAt">>,
  ): Promise<MonitoringRecordResource> {
    const { id, historyDescription, ...updateData } = data;
    const record = await prisma.monitoringRecordResource.update({
      where: {
        id,
      },
      data: updateData,
      include: {
        monitoringRecord: true,
      },
    });
    if (historyDescription) {
      await GoalHistoryService.instance.createGoalHistory({
        goalId: record.monitoringRecord.goalId,
        monitoringRecordId: record.monitoringRecordId,
        event: GoalHistoryEvent.UPDATED,
        description: historyDescription,
      });
    }
    return record;
  }

  hasActivityFinancialValuesChanged = (
    valorActividadSubperiodo: VSaldopptalEgrActividadWp,
    monitoringRecordResource: MonitoringRecordResource,
  ): boolean => {
    const resourceTypeMap = {
      [MonitoringResourceType.DEFINITIVE]: "apropiado",
      [MonitoringResourceType.COMMITMENT]: "compromiso",
      [MonitoringResourceType.OBLIGATION]: "obligacion",
      [MonitoringResourceType.PAYMENT]: "pago",
      [MonitoringResourceType.MANUAL]: "",
    };
    const resourcesKeysMap: Record<string, string> = {
      cd: "cd",
      cn: "cn",
      credit: "credito",
      operation: "funcionamiento",
      management: "gestion",
      others: "otros",
      rp: "rp",
      sgp: "sgp",
      sgr: "sgr",
    };

    return Object.keys(resourcesKeysMap).some((key) => {
      const keyActividad = camelCase(
        `${resourceTypeMap[monitoringRecordResource.resourceType] as string}_${resourcesKeysMap[key] as string}`,
      );
      return (
        monitoringRecordResource[key as keyof MonitoringRecordResource] !==
        valorActividadSubperiodo[keyActividad as keyof VSaldopptalEgrActividadWp]
      );
    });
  };

  hasProjectFinancialValuesChanged = (
    resourcesData: Partial<MonitoringRecordResource>,
    monitoringRecordResource: MonitoringRecordResource,
  ): boolean => {
    return RESOURCES_FIELDS.some((key) => {
      return (
        monitoringRecordResource[key as keyof MonitoringRecordResource] !==
        resourcesData[key as keyof Partial<MonitoringRecordResource>]
      );
    });
  };

  getMonitoringResourceFromActivity = (
    valorActividadSubperiodo: VSaldopptalEgrActividadWp,
    resourceType: MonitoringResourceType,
  ): MonitoringResourceFromActivity => {
    const resourceTypeMap = {
      [MonitoringResourceType.DEFINITIVE]: "apropiado",
      [MonitoringResourceType.COMMITMENT]: "compromiso",
      [MonitoringResourceType.OBLIGATION]: "obligacion",
      [MonitoringResourceType.PAYMENT]: "pago",
      [MonitoringResourceType.MANUAL]: "",
    };
    const resourcesKeysMap: Record<string, string> = {
      cd: "cd",
      cn: "cn",
      credit: "credito",
      operation: "funcionamiento",
      management: "gestion",
      others: "otros",
      rp: "rp",
      sgp: "sgp",
      sgr: "sgr",
    };

    const monitoringResource = Object.fromEntries(
      Object.keys(resourcesKeysMap).map((key) => {
        const keyActividad = camelCase(
          `${resourceTypeMap[resourceType] as string}_${resourcesKeysMap[key] as string}`,
        );
        return [
          key,
          (valorActividadSubperiodo[keyActividad as keyof VSaldopptalEgrActividadWp] ??
            0) as number,
        ];
      }),
    ) as MonitoringResourceFromActivity;

    return monitoringResource;
  };

  async createMonitoringRecordResourcesFromActivities({
    tenantKey,
    monitoringConfig,
    activities,
    projectCodes,
    stage,
    resourceType,
  }: {
    tenantKey: string;
    monitoringConfig: MonitoringConfig;
    projectCodes: string[];
    activities: VActividadesPryWithGoals[];
    stage: MonitoringStatus;
    resourceType: MonitoringResourceType;
  }): Promise<MonitoringRecordResource[]> {
    const valoresActividades = await ActividadService.instance.getValoresFinancieros({
      tenantKey,
      period: monitoringConfig.period,
      subperiod: monitoringConfig.subperiod,
      projects: projectCodes,
    });
    const monitoringRecordResources: MonitoringRecordResource[] = [];
    const activitiesWithGoals = activities.filter((activity) => !!activity.goal);

    for (let i = 0; i < activitiesWithGoals.length; i++) {
      const actividad = activitiesWithGoals[i];
      let valorActividadSubperiodo = valoresActividades.find(
        (valorActividad) =>
          valorActividad.idActividad === actividad.id &&
          valorActividad.trimestre === monitoringConfig.subperiod,
      );
      if (valorActividadSubperiodo) {
        // Create a new schedule record for the activity or update it
        const existingMonitoringRecord = await MonitoringRecordService.instance.getMonitoringRecord(
          {
            monitoringConfigId: monitoringConfig.id,
            goalId: actividad.goal?.id,
            period: monitoringConfig.period,
            includeResources: true,
          },
        );
        if (existingMonitoringRecord) {
          // Update initial month if required
          if (
            existingMonitoringRecord.fromMonth !== valorActividadSubperiodo.mesInicial &&
            existingMonitoringRecord.recordStatus === MonitoringRecordStatus.COPIED
          ) {
            await MonitoringRecordService.instance.updateMonitoringRecord({
              id: existingMonitoringRecord.id,
              fromMonth: valorActividadSubperiodo.mesInicial,
              historyDescription:
                "Se utiliza como mes inicial el de la apropiación financiera de la actividad.",
            });
          }
          const existingMonitoringRecordResource = existingMonitoringRecord.resources?.find(
            (resource) => resource.resourceType === resourceType,
          );
          if (existingMonitoringRecordResource) {
            if (
              (existingMonitoringRecord.recordStatus === MonitoringRecordStatus.COPIED ||
                existingMonitoringRecord.recordStatus === MonitoringRecordStatus.PLANNED) &&
              this.hasActivityFinancialValuesChanged(
                valorActividadSubperiodo,
                existingMonitoringRecordResource,
              )
            ) {
              monitoringRecordResources.push(
                await this.updateMonitoringRecordResource({
                  ...existingMonitoringRecordResource,
                  ...this.getMonitoringResourceFromActivity(valorActividadSubperiodo, resourceType),
                  historyDescription:
                    "Los valores financieros de la actividad han cambiado en SIIFWEB.",
                }),
              );
            }
          } else {
            monitoringRecordResources.push(
              await this.createMonitoringRecordResource({
                monitoringRecordId: existingMonitoringRecord.id,
                resourceType: resourceType,
                ...this.getMonitoringResourceFromActivity(valorActividadSubperiodo, resourceType),
                capital: 0,
                de: 0,
                monopoly: 0,
                historyDescription:
                  "Se crea la programación financiera de la actividad con valores de SIIFWEB.",
              }),
            );
          }
        }
      }
    }
    return monitoringRecordResources;
  }

  getResourcesTotal(resources?: MonitoringRecordResource) {
    return {
      ...resources,
      resourcesTotal: resources
        ? resources.capital +
          resources.cd +
          resources.cn +
          resources.credit +
          resources.de +
          resources.operation +
          resources.management +
          resources.monopoly +
          resources.others +
          resources.rp +
          resources.sgp +
          resources.sgr
        : 0,
    };
  }

  async getAggregatedMonitoringResources({
    monitoringConfigId,
    sourceGoalType,
    resourceType,
  }: {
    monitoringConfigId: number;
    sourceGoalType: GoalType;
    resourceType: MonitoringResourceType;
  }): Promise<MonitoringResourceTotal[]> {
    // Get monitoring record resources for the source goal type
    const resources = await prisma.$queryRaw<MonitoringResourceTotal[]>`
      SELECT  g.parent_goal_id "goalId", 
              SUM(mrr.capital) as capital,
              SUM(mrr.cd) as cd,
              SUM(mrr.cn) as cn,
              SUM(mrr.credit) as credit,
              SUM(mrr.de) as de,
              SUM(mrr.operation) as operation,
              SUM(mrr.management) as management,
              SUM(mrr.monopoly) as monopoly,
              SUM(mrr.others) as others,
              SUM(mrr.rp) as rp,
              SUM(mrr.sgp) as sgp,
              SUM(mrr.sgr) as sgr
      FROM   goal g
      JOIN   monitoring_record mr ON mr.goal_id = g.id
      JOIN   monitoring_record_resource mrr ON mrr.monitoring_record_id = mr.id
      WHERE  mr.monitoring_config_id = ${monitoringConfigId}
      AND    g.goal_type = ${sourceGoalType}::"GoalType"
      AND    mrr.resource_type = ${resourceType}::"MonitoringResourceType"
      GROUP BY g.parent_goal_id
    `;

    return resources;
  }

  async createMonitoringRecordResourcesFromProjects({
    tenantKey,
    monitoringConfig,
    projects,
    monitoringRecords,
    resources,
    resourceType,
  }: {
    tenantKey: string;
    monitoringConfig: MonitoringConfig;
    projects: ProyectoWithGoals[];
    monitoringRecords: MonitoringRecord[];
    resources: MonitoringResourceTotal[];
    resourceType: MonitoringResourceType;
  }): Promise<MonitoringRecordResource[]> {
    const monitoringRecordResources: MonitoringRecordResource[] = [];

    for (let i = 0; i < projects.length; i++) {
      const project = projects[i];
      const resource = resources.find((resource) => resource.goalId === project.goal?.id);

      if (resource) {
        const { goalId, ...resourceData } = resource;

        // Create a new schedule record for the project or update it
        const existingMonitoringRecord = await MonitoringRecordService.instance.getMonitoringRecord(
          {
            monitoringConfigId: monitoringConfig.id,
            goalId: project.goal?.id,
            period: monitoringConfig.period,
            includeResources: true,
          },
        );
        if (existingMonitoringRecord) {
          const existingMonitoringRecordResource = existingMonitoringRecord.resources?.find(
            (resource) => resource.resourceType === resourceType,
          );
          if (existingMonitoringRecordResource) {
            if (
              (existingMonitoringRecord.recordStatus === MonitoringRecordStatus.COPIED ||
                existingMonitoringRecord.recordStatus === MonitoringRecordStatus.PLANNED) &&
              this.hasProjectFinancialValuesChanged(resourceData, existingMonitoringRecordResource)
            ) {
              monitoringRecordResources.push(
                await this.updateMonitoringRecordResource({
                  ...existingMonitoringRecordResource,
                  ...resourceData,
                  historyDescription:
                    "Los valores financieros del proyecto han cambiado en SIIFWEB.",
                }),
              );
            }
          } else {
            monitoringRecordResources.push(
              await this.createMonitoringRecordResource({
                monitoringRecordId: existingMonitoringRecord.id,
                resourceType: resourceType,
                ...resourceData,
                historyDescription:
                  "Se crea la programación financiera del proyecto con valores de SIIFWEB.",
              }),
            );
          }
        }
      }
    }

    return monitoringRecordResources;
  }

  async createMonitoringRecordResourcesFromGoals({
    monitoringConfig,
    goalIds,
    resources,
    resourceType,
  }: {
    monitoringConfig: MonitoringConfig;
    goalIds: number[];
    resources: MonitoringResourceTotal[];
    resourceType: MonitoringResourceType;
  }): Promise<MonitoringRecordResource[]> {
    const monitoringRecordResources: MonitoringRecordResource[] = [];

    for (let i = 0; i < goalIds.length; i++) {
      const goalId = goalIds[i];
      const resource = resources.find((resource) => resource.goalId === goalId);

      if (resource) {
        const { goalId, ...resourceData } = resource;

        // Create a new schedule record for the project or update it
        const existingMonitoringRecord = await MonitoringRecordService.instance.getMonitoringRecord(
          {
            monitoringConfigId: monitoringConfig.id,
            goalId: goalId,
            period: monitoringConfig.period,
            includeResources: true,
          },
        );
        if (existingMonitoringRecord) {
          const existingMonitoringRecordResource = existingMonitoringRecord.resources?.find(
            (resource) => resource.resourceType === resourceType,
          );
          if (existingMonitoringRecordResource) {
            if (
              (existingMonitoringRecord.recordStatus === MonitoringRecordStatus.COPIED ||
                existingMonitoringRecord.recordStatus === MonitoringRecordStatus.PLANNED) &&
              this.hasProjectFinancialValuesChanged(resourceData, existingMonitoringRecordResource)
            ) {
              monitoringRecordResources.push(
                await this.updateMonitoringRecordResource({
                  ...existingMonitoringRecordResource,
                  ...resourceData,
                  historyDescription: "Los valores financieros han cambiado.",
                }),
              );
            }
          } else {
            monitoringRecordResources.push(
              await this.createMonitoringRecordResource({
                monitoringRecordId: existingMonitoringRecord.id,
                resourceType: resourceType,
                ...resourceData,
                historyDescription: "Se crea la programación financiera.",
              }),
            );
          }
        }
      }
    }

    return monitoringRecordResources;
  }
}
