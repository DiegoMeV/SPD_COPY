import {
  AccumulationType,
  GoalHistoryEvent,
  GoalType,
  MonitoringConfigUsedFor,
  MonitoringRecordStatus,
  MonitoringResourceType,
  MonitoringStatus,
  Prisma,
  SpentDoc,
} from "@prisma/client";
import {
  CreateGoal,
  DevPlan,
  DevPlanLevel,
  Entity,
  Goal,
  MonitoringConfig,
  Proyecto,
  ProyectoWithGoals,
  SearchGoals,
  SearchGoalsResponse,
} from "../../graphql/types";
import {
  VActividadesPry,
  VActividadesPryWithGoals,
} from "../../graphql/types/siif/vActividadesPry";
import prisma from "../prisma";
import { EntityService } from "./entityService";
import { devPlanLevels } from "../../prisma/seedData/890102006/devPlanLevels";
import { DevPlanLevelService } from "./devPlanLevelService";
import { lpad } from "../utils";
import { ActividadService, ProyectoService, VSpdMetaService } from "./siif";
import { GoalHistoryService } from "./goalHistoryService";
import {
  GetGoalsToCopyFromSIIFResponse,
  SearchGoalsFormat,
  UpdateGoal,
} from "../../graphql/types/goal";
import { ExportFormat } from "../../graphql/types/common";
import { S3Reports } from "../s3Reports";
import { DevPlanService } from "./devPlanService";
import { MonitoringRecordResourceService } from "./monitoringRecordResourceService";
import _ from "lodash";
import { TenantService } from "./tenantService";
import { MonitoringConfigService } from "./monitoringConfigService";
import { MonitoringRecordService } from "./monitoringRecordService";
import { RESOURCES_FIELDS } from "../../shared/const";
import { MonitoringRecordResourceFragment } from "../../graphql/gen/ops";
import { monitoringRecords } from "../../prisma/seedData/8913800073/monitoringRecords";

export class GoalService {
  private static _instance: GoalService | undefined;

  private constructor() {}

  static get instance() {
    if (this._instance === undefined) {
      this._instance = new this();
    }
    return this._instance;
  }

  async getGoal({
    tenantId,
    tenantKey,
    ids,
    codes,
    activityId,
    projectCode,
  }: {
    tenantId?: number;
    tenantKey?: string;
    ids?: number[];
    codes?: string[];
    activityId?: number;
    projectCode?: string;
  }): Promise<Goal | null> {
    return prisma.goal.findFirst({
      where: {
        tenantId,
        ...(tenantKey ? { devPlanLevel: { devPlan: { tenant: { key: tenantKey } } } } : {}),
        activityId,
        ...(ids ? { id: { in: ids } } : {}),
        ...(codes ? { code: { in: codes } } : {}),
        projectCode,
      },
    });
  }

  async getGoals({
    tenantId,
    tenantKey,
    ids,
    codes,
    activityIds,
    projectCodes,
    devPlanId,
    goalTypes,
    devPlanLevelId,
    parentGoalId,
    sortByCode,
  }: {
    tenantId?: number;
    tenantKey?: string;
    ids?: number[];
    codes?: string[];
    activityIds?: number[];
    projectCodes?: string[];
    devPlanId?: number;
    goalTypes?: GoalType[];
    devPlanLevelId?: number;
    parentGoalId?: number;
    sortByCode?: boolean;
  }): Promise<Goal[]> {
    const goals = await prisma.goal.findMany({
      where: {
        tenantId,
        devPlanId,
        devPlanLevelId,
        parentGoalId,
        ...(tenantKey ? { devPlanLevel: { devPlan: { tenant: { key: tenantKey } } } } : {}),
        ...(ids ? { id: { in: ids } } : {}),
        ...(codes ? { code: { in: codes } } : {}),
        ...(activityIds ? { activityId: { in: activityIds } } : {}),
        ...(projectCodes ? { projectCode: { in: projectCodes } } : {}),
        ...(goalTypes ? { goalType: { in: goalTypes } } : {}),
      },
    });
    if (sortByCode) {
      return this.sortGoalsByCode(goals);
    }
    return goals;
  }

  sortGoalsByCode = (goals: Goal[]): Goal[] => {
    const LAST_NUMBER_REGEX = /^.*?(\d+)$/;
    if (LAST_NUMBER_REGEX.test(goals?.[0]?.code)) {
      return [...goals].sort((goalA, goalB) => {
        const codeA: string | undefined = LAST_NUMBER_REGEX.exec(goalA.code)?.[1] ?? "0";
        const codeB: string | undefined = LAST_NUMBER_REGEX.exec(goalB.code)?.[1] ?? "0";
        try {
          return parseInt(codeA) - parseInt(codeB);
        } catch (e) {
          return 0;
        }
      });
    }
    return goals;
  };

  async createGoal(data: CreateGoal): Promise<Goal> {
    const { userId, historyDescription, ...createData } = data;
    let devPlanId: number | undefined = undefined;
    if (createData.goalType !== GoalType.PUBLIC_POLITIC) {
      if (!createData.devPlanLevelId)
        throw new Error(`No se ha vinculado un nodo del plan de desarrollo para esta meta`);
      // Get dev plan id
      const devPlanLevel = await prisma.devPlanLevel.findUnique({
        where: {
          id: createData.devPlanLevelId,
        },
      });
      if (!devPlanLevel)
        throw new Error(`No existe nodo plan de desarrollo con id: ${createData.devPlanLevelId}`);
      devPlanId = devPlanLevel.devPlanId;
    }
    const goal = await prisma.goal.create({
      data: {
        ...createData,
        devPlanId,
        createdBy: userId,
      },
    });
    if (historyDescription) {
      await GoalHistoryService.instance.createGoalHistory({
        goalId: goal.id,
        event: GoalHistoryEvent.CREATED,
        description: historyDescription,
        createdBy: userId,
      });
    }

    return goal;
  }

  async updateGoal(data: UpdateGoal): Promise<Goal> {
    const { id, userId, historyDescription, ...updateData } = data;
    const goal = await prisma.goal.update({
      where: {
        id,
      },
      data: updateData,
    });
    if (historyDescription) {
      await GoalHistoryService.instance.createGoalHistory({
        goalId: goal.id,
        event: GoalHistoryEvent.UPDATED,
        createdBy: userId,
      });
    }

    return goal;
  }

  async getSearchGoalsQuery(data: SearchGoals): Promise<any> {
    const {
      limit,
      offset = 0,
      sort,
      name,
      text,
      monitoringConfigId,
      ids,
      entityIds,
      devPlanLevelIds,
      goalTypes,
      isScheduled,
      isReported,
      isValidated,
      isReviewed,
      stage = MonitoringStatus.SCHEDULING,
      ...searchData
    } = data || {};
    let monitoringConfig: MonitoringConfig | null = null;
    let devPlan: DevPlan | null = null;

    if (monitoringConfigId) {
      monitoringConfig = await prisma.monitoringConfig.findUnique({
        where: { id: monitoringConfigId },
      });
      if (!monitoringConfig) throw new Error(`No existe seguimiento con ID: ${monitoringConfigId}`);
      if (monitoringConfig.usedFor === MonitoringConfigUsedFor.DEVELOPMENT_PLANS) {
        if (!monitoringConfig.devPlanId)
          throw new Error(
            `El seguimiento con ID ${monitoringConfig.id} no está vinculado a un plan de desarrollo`,
          );
        devPlan = await DevPlanService.instance.getDevPlan({
          id: monitoringConfig.devPlanId,
        });
        if (!devPlan)
          throw new Error(`No existe plan de desarrollo con ID: ${monitoringConfig.devPlanId}`);
      }
    }

    const where: Prisma.GoalWhereInput = {
      ...searchData,
      ...(name ? { name: { contains: name } } : {}),
      ...(text
        ? {
            OR: [
              { code: { contains: text, mode: "insensitive" } },
              { name: { contains: text, mode: "insensitive" } },
              { indicator: { contains: text, mode: "insensitive" } },
            ],
          }
        : {}),
      ...(ids
        ? {
            id: { in: ids },
          }
        : {}),
      ...(entityIds
        ? {
            entityId: { in: entityIds },
          }
        : {}),
      ...(devPlanLevelIds
        ? {
            devPlanLevelId: { in: devPlanLevelIds },
          }
        : {}),
      ...(goalTypes
        ? {
            goalType: { in: goalTypes },
          }
        : {}),
      ...(isScheduled
        ? {
            monitoringRecords: {
              some: {
                OR: [
                  _.omitBy(
                    { recordStatus: MonitoringRecordStatus.PLANNED, monitoringConfigId },
                    _.isUndefined,
                  ),
                  _.omitBy(
                    { recordStatus: MonitoringRecordStatus.REPORTED, monitoringConfigId },
                    _.isUndefined,
                  ),
                  _.omitBy(
                    { recordStatus: MonitoringRecordStatus.VALIDATED, monitoringConfigId },
                    _.isUndefined,
                  ),
                  _.omitBy(
                    { recordStatus: MonitoringRecordStatus.REVIEWED, monitoringConfigId },
                    _.isUndefined,
                  ),
                ],
              },
            },
          }
        : {}),
      ...(isReported
        ? {
            monitoringRecords: {
              some: {
                OR: [
                  _.omitBy(
                    { recordStatus: MonitoringRecordStatus.REPORTED, monitoringConfigId },
                    _.isUndefined,
                  ),
                  _.omitBy(
                    { recordStatus: MonitoringRecordStatus.VALIDATED, monitoringConfigId },
                    _.isUndefined,
                  ),
                  _.omitBy(
                    { recordStatus: MonitoringRecordStatus.REVIEWED, monitoringConfigId },
                    _.isUndefined,
                  ),
                ],
              },
            },
          }
        : {}),
      ...(isValidated
        ? {
            monitoringRecords: {
              some: {
                OR: [
                  _.omitBy(
                    { recordStatus: MonitoringRecordStatus.VALIDATED, monitoringConfigId },
                    _.isUndefined,
                  ),
                  _.omitBy(
                    { recordStatus: MonitoringRecordStatus.REVIEWED, monitoringConfigId },
                    _.isUndefined,
                  ),
                ],
              },
            },
          }
        : {}),
      ...(isReviewed
        ? {
            monitoringRecords: {
              some: _.omitBy(
                { recordStatus: MonitoringRecordStatus.REVIEWED, monitoringConfigId },
                _.isUndefined,
              ),
            },
          }
        : {}),
    };

    if (monitoringConfig && devPlan) {
      where.devPlanId = monitoringConfig.devPlanId;
      const currentDate = new Date();

      if (
        goalTypes?.length &&
        devPlan?.startDate &&
        devPlan?.endDate &&
        currentDate >= devPlan?.startDate &&
        currentDate <= devPlan?.endDate &&
        (goalTypes.includes(GoalType.PROJECT) ||
          goalTypes.includes(GoalType.ACTIVITY) ||
          goalTypes.includes(GoalType.ACTION_PLAN) ||
          goalTypes.includes(GoalType.ACTION_PLAN_ACTIVITY)) &&
        (stage === MonitoringStatus.SCHEDULING || stage === MonitoringStatus.REPORTING)
      ) {
        if (goalTypes.includes(GoalType.PROJECT) || goalTypes.includes(GoalType.ACTIVITY)) {
          // Create records required for scheduling
          if (stage === MonitoringStatus.SCHEDULING) {
            // Create non-existing project goals
            await this.createOrUpdateGoalsFromProjects({
              monitoringConfigId: monitoringConfig.id,
            });
          }
          // Scheduling stage: Create non-existing activities goals, monitoring records and resources
          // Reporting stage: Create monitoring record resources
          await this.createOrUpdateGoalsFromActivities({
            monitoringConfigId: monitoringConfig.id,
            stage,
          });
          // Aggregate activities monitoring resources to projects
          if (stage === MonitoringStatus.SCHEDULING) {
            await MonitoringRecordService.instance.createOrUpdateMonitoringRecordsFromProjects({
              monitoringConfigId: monitoringConfig.id,
              resourceType: MonitoringResourceType.DEFINITIVE,
              stage,
            });
          } else if (stage === MonitoringStatus.REPORTING) {
            const spentDocs = (monitoringConfig.spentDocs ?? []) as SpentDoc[];
            for (let i = 0; i < spentDocs.length; i++) {
              // Create or update the monitoring records resources
              await MonitoringRecordService.instance.createOrUpdateMonitoringRecordsFromProjects({
                monitoringConfigId: monitoringConfig.id,
                resourceType: spentDocs[i] as MonitoringResourceType,
                stage,
              });
            }
          }
        } else {
          // Aggregate activities monitoring resources to projects
          if (stage === MonitoringStatus.SCHEDULING) {
            await MonitoringRecordService.instance.createOrUpdateMonitoringRecordsFromChildren({
              monitoringConfigId: monitoringConfig.id,
              resourceType: MonitoringResourceType.MANUAL,
              stage,
              goalType: GoalType.ACTION_PLAN,
            });
          } else if (stage === MonitoringStatus.REPORTING) {
            const spentDocs = (monitoringConfig.spentDocs ?? []) as SpentDoc[];
            for (let i = 0; i < spentDocs.length; i++) {
              // Create or update the monitoring records resources
              await MonitoringRecordService.instance.createOrUpdateMonitoringRecordsFromChildren({
                monitoringConfigId: monitoringConfig.id,
                resourceType: spentDocs[i] as MonitoringResourceType,
                stage,
                goalType: GoalType.ACTION_PLAN,
              });
            }
          }
        }
      }
    }

    let orderBy = undefined;
    if (sort?.field && sort?.order) {
      orderBy = { [sort.field]: sort.order };
    }

    const filterAttributes = ["entityId", "goalType"];
    const groupedRecords = await prisma.goal.groupBy({
      by: filterAttributes.map((attribute) => attribute as any),
      _count: true,
      where,
    });
    const filtersCount: Record<string, Record<any, number>> = {};
    filterAttributes.map((attribute) => {
      groupedRecords.map((record) => {
        if (!filtersCount[attribute]) filtersCount[attribute] = {};
        filtersCount[attribute][record[attribute]] =
          (filtersCount[attribute][record[attribute]] ?? 0) + record._count;
      });
    });
    const filters = Object.fromEntries(
      Object.entries(filtersCount).map(([k, v]) => {
        return [
          k,
          Object.keys(v)
            .sort()
            .map((filterValue) => ({ value: filterValue, count: v[filterValue] })),
        ];
      }),
    );

    return {
      where,
      limit,
      offset,
      orderBy,
      filters,
    };
  }

  async searchGoals(data: SearchGoals): Promise<SearchGoalsResponse> {
    const { where, limit, offset, orderBy, filters } = await this.getSearchGoalsQuery(data);
    const result = await prisma.goal.findMany({
      where,
      ...(limit ? { take: limit } : {}),
      skip: offset,
      orderBy: orderBy ?? [{ code: "asc" }],
    });

    // Total records
    const countItems = await prisma.goal.count({
      where,
    });

    // Total records by goalType
    console.log("where countItemsByGoalType", JSON.stringify(where, null, 2));
    const countItemsByGoalType = (
      await prisma.goal.groupBy({
        by: ["goalType"],
        _count: true,
        where: {
          ...where,
          ...((data.goalTypes ?? []).includes(GoalType.PROJECT)
            ? { goalType: { in: [...(data.goalTypes ?? []), GoalType.ACTIVITY] } }
            : {}),
        },
      })
    ).map((record) => ({ goalType: record.goalType, count: record._count }));

    return { items: result, count: countItems, countByType: countItemsByGoalType, filters };
  }

  async searchGoalsFormat(data: SearchGoalsFormat): Promise<string | null> {
    let url = null;
    const { format, ...searchData } = data;
    const { where, offset, orderBy } = await this.getSearchGoalsQuery(searchData);

    const goals = await prisma.goal.findMany({
      where,
      skip: offset,
      orderBy: orderBy ?? [{ code: "asc" }],
      include: {
        devPlanLevel: {
          include: { devPlan: true },
        },
        entity: true,
      },
    });

    if (format === ExportFormat.EXCEL)
      url = await S3Reports.instance.generateExcelReport({
        reportName: "searchGoals",
        data: goals,
      });

    return url;
  }

  async getDashboardGoalsFormat(data: SearchGoalsFormat): Promise<string | null> {
    let url = null;
    const { format, ...searchData } = data;
    const { where, offset, orderBy } = await this.getSearchGoalsQuery(searchData);
    const { monitoringConfigId } = searchData;

    if (!monitoringConfigId)
      throw new Error(`No se ha definido un periodo de seguimiento en los filtros`);

    const goals = (
      await prisma.goal.findMany({
        where,
        skip: offset,
        orderBy: orderBy ?? [{ code: "asc" }],
        include: {
          devPlanLevel: {
            include: { devPlan: true },
          },
          entity: true,
          monitoringRecords: {
            where: { monitoringConfigId },
            include: {
              resources: true,
            },
          },
        },
      })
    ).map((goal) => {
      return {
        ...goal,
        manualResources: MonitoringRecordResourceService.instance.getResourcesTotal(
          goal.monitoringRecords?.[0]?.resources?.find(
            (resource) => resource.resourceType === MonitoringResourceType.MANUAL,
          ),
        ),
        definitiveResources: MonitoringRecordResourceService.instance.getResourcesTotal(
          goal.monitoringRecords?.[0]?.resources?.find(
            (resource) => resource.resourceType === MonitoringResourceType.DEFINITIVE,
          ),
        ),
        commitmentResources: MonitoringRecordResourceService.instance.getResourcesTotal(
          goal.monitoringRecords?.[0]?.resources?.find(
            (resource) => resource.resourceType === MonitoringResourceType.COMMITMENT,
          ),
        ),
        obligationResources: MonitoringRecordResourceService.instance.getResourcesTotal(
          goal.monitoringRecords?.[0]?.resources?.find(
            (resource) => resource.resourceType === MonitoringResourceType.OBLIGATION,
          ),
        ),
      };
    });

    if (format === ExportFormat.EXCEL)
      url = await S3Reports.instance.generateExcelReport({
        reportName: "dashboardGoals",
        data: goals,
      });

    return url;
  }

  async getGoalsToCopyFromSIIF({
    devPlanId,
    tenantKey,
  }: {
    devPlanId: number;
    tenantKey: string;
  }): Promise<GetGoalsToCopyFromSIIFResponse> {
    // Get dev plan info
    const devPlan = await DevPlanService.instance.getDevPlan({ id: devPlanId });
    if (!devPlan) throw new Error(`No existe plan de desarrollo con ID: ${devPlanId}`);
    // Get goals from SIIF
    const goalsSIIF = await VSpdMetaService.instance.getMetas({
      tenantKey,
      codigoPlanDesarrollo: parseInt(devPlan.code),
      tipos: ["PRODUCTO", "RESULTADO"],
    });
    // Get goals from SPD
    const goals = await GoalService.instance.getGoals({
      tenantKey,
      devPlanId,
    });
    const goalsCodes = new Set(goals.map((goal) => goal.code));
    const goalsToCopy =
      goalsSIIF?.filter((goal) => goal.codigo && !goalsCodes.has(goal.codigo)) ?? [];
    // Generate response object
    const response = {
      countGoalsSIIF: goalsSIIF?.length ?? 0,
      countGoalsSPD: goals.length ?? 0,
      goalstoCopyFromSIIF: goalsToCopy,
    };

    return response;
  }

  async copyGoalsFromSIIF({
    devPlanId,
    tenantKey,
    userId,
  }: {
    devPlanId: number;
    tenantKey: string;
    userId: number;
  }): Promise<Goal[]> {
    const goalsToCopy = await this.getGoalsToCopyFromSIIF({ devPlanId, tenantKey });

    const devPlan = await DevPlanService.instance.getDevPlan({ id: devPlanId });
    const entities = await EntityService.instance.getEntities({ tenantKey });
    const devPlanLevels = await DevPlanLevelService.instance.getDevPlanLevels({
      devPlanId,
    });

    const getLevelForGoalType = (goalType: GoalType) => {
      const level: number = JSON.parse(JSON.stringify(devPlan?.config))?.levels?.findIndex(
        (level: any) => `${level.goalType}` === `${goalType}`,
      );
      return level + 1;
    };

    // Generate array of goals to create

    const goalsData: Prisma.GoalCreateManyInput[] = goalsToCopy.goalstoCopyFromSIIF.map((goal) => {
      const goalType = goal.tipo === "PRODUCTO" ? GoalType.PRODUCT : GoalType.RESULT;
      const entityId = entities?.find((entity) => entity.code === goal.codigoEntidad)?.id;
      if (!entityId) throw new Error(`No existe entidad con código: ${goal.codigoEntidad}`);
      if (!goal.codigo)
        throw new Error(`La meta ${goal.id} con nombre ${goal.nombre} no tiene código`);
      if (!goal.valorMeta) throw new Error(`La meta ${goal.codigo} no tiene valor meta`);
      const devPlanLevelId = devPlanLevels.find(
        (level) =>
          level.level === getLevelForGoalType(goalType) && level.code === goal.codigoNivelPlan,
      )?.id;
      if (!devPlanLevelId)
        throw new Error(
          `No se encontró nivel de plan de desarrollo con código ${goal.codigoNivelPlan}`,
        );

      return {
        devPlanId,
        devPlanLevelId,
        goalType,
        code: goal.codigo,
        name: goal.nombre,
        indicator: goal.indicador,
        entityId,
        accumulationType:
          goal.accion === "AUMENTO"
            ? AccumulationType.ACCUMULATED
            : goal.accion === "MANTENIMIENTO"
              ? AccumulationType.STOCK
              : AccumulationType.REDUCTION,
        goalValue: goal.valorMeta,
        baseValue: goal.valorBase,
        unitsFactor: goal.factorMeta ?? 1,
        weighting: goal.ponderacion ?? 0.0,
        unitsName: goal.unidad,
        createdBy: userId,
      };
    });

    await prisma.goal.createMany({
      data: goalsData,
    });

    return prisma.goal.findMany({
      where: {
        devPlanId,
        code: { in: goalsData.map((goal) => goal.code) },
      },
    });
  }

  async createGoalsFromActivities({
    tenantKey,
    projects,
    activities,
    devPlan,
  }: {
    tenantKey: string;
    projects: ProyectoWithGoals[];
    activities: VActividadesPryWithGoals[];
    devPlan: DevPlan;
  }): Promise<Goal[]> {
    const entities = await EntityService.instance.getEntities({
      tenantKey,
      codes: Array.from(
        new Set(
          projects.map((project) => project.codigoEntPry).filter((code) => !!code) as string[],
        ),
      ),
    });
    const getEntityForActivity = (activity: VActividadesPry): Entity | null => {
      const project = projects.find((project) => project.proyecto === activity.proyecto);
      const entity = entities?.find((entity) => entity.code === project?.codigoEntPry);
      return entity ?? null;
    };
    const devPlanLevels = await DevPlanLevelService.instance.getDevPlanLevels({
      devPlanId: devPlan.id,
    });
    const getDevPlanLevelForProject = (project: Proyecto): DevPlanLevel | null => {
      const code = [project.eje, project.sector, project.programa, project.subprograma]
        .filter((code) => !!code)
        .join(".");
      const devPlanLevel = devPlanLevels.find((devPlanLevel) => devPlanLevel.code === code);
      return devPlanLevel ?? null;
    };

    const goals = activities
      .filter((activity) => !activity.goal)
      .map((activity) => {
        const project = projects.find((project) => project.proyecto === activity.proyecto);
        return {
          goalType: GoalType.ACTIVITY,
          accumulationType: AccumulationType.ACCUMULATED,
          goalValue: activity.cantidad ?? 0,
          unitsFactor: 1,
          code: `${activity.proyecto}_${lpad(`${activity.codigoAct}`, 2, "0")}`,
          name: activity.descripcion,
          activityId: activity.id,
          tenantId: devPlan.tenantId,
          entityId: getEntityForActivity(activity)?.id ?? 0,
          devPlanLevelId: getDevPlanLevelForProject(project!)?.id ?? 0,
          devPlanId: devPlan.id,
          parentGoalId: project?.goal?.id,
          historyDescription: `Meta creada a partir de la actividad ${activity.codigoAct} del proyecto ${activity.proyecto} en SIIFWEB.`,
        };
      })
      .filter((goal) => !!goal.entityId && !!goal.devPlanLevelId);

    const newGoals = await Promise.all(
      goals.map(async (goal) => {
        return this.createGoal(goal);
      }),
    );

    return newGoals;
  }

  async createGoalsFromProjects({
    tenantKey,
    projectCodes,
    devPlan,
  }: {
    tenantKey: string;
    projectCodes?: string[];
    devPlan: DevPlan;
  }): Promise<Goal[]> {
    const proyectos = await ProyectoService.instance.getProyectosWithGoals({
      tenantKey,
      projectCodes,
      plan: devPlan.code,
    });
    const entities = await EntityService.instance.getEntities({
      tenantKey,
      codes: Array.from(
        new Set(
          proyectos.map((proyecto) => proyecto.codigoEntPry).filter((code) => !!code) as string[],
        ),
      ),
    });
    const getEntityForProject = (project: Proyecto): Entity | null => {
      const entity = entities?.find((entity) => entity.code === project?.codigoEntPry);
      return entity ?? null;
    };
    const devPlanLevels = await DevPlanLevelService.instance.getDevPlanLevels({
      devPlanId: devPlan.id,
    });
    const getDevPlanLevelForProject = (project: Proyecto): DevPlanLevel | null => {
      const code = [project.eje, project.sector, project.programa, project.subprograma]
        .filter((code) => !!code)
        .join(".");
      const devPlanLevel = devPlanLevels.find((devPlanLevel) => devPlanLevel.code === code);
      return devPlanLevel ?? null;
    };

    const goals = proyectos
      .filter((project) => !project.goal)
      .map((proyecto) => {
        return {
          goalType: GoalType.PROJECT,
          accumulationType: AccumulationType.ACCUMULATED,
          goalValue: null,
          unitsFactor: 1,
          code: proyecto.proyecto,
          name: proyecto.nombre,
          projectCode: proyecto.proyecto,
          tenantId: devPlan.tenantId,
          entityId: getEntityForProject(proyecto)?.id ?? 0,
          devPlanLevelId: getDevPlanLevelForProject(proyecto)?.id ?? 0,
          devPlanId: devPlan.id,
          historyDescription: `Meta creada a partir del proyecto ${proyecto.proyecto} en SIIFWEB.`,
        };
      })
      .filter((goal) => !!goal.entityId && !!goal.devPlanLevelId);

    const newGoals = await Promise.all(
      goals.map(async (goal) => {
        return this.createGoal(goal);
      }),
    );

    return newGoals;
  }

  async createOrUpdateGoalsFromProjects({ monitoringConfigId }: { monitoringConfigId: number }) {
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

    // Create the goals for the projects
    await GoalService.instance.createGoalsFromProjects({
      tenantKey: tenant.key,
      devPlan,
    });
  }

  async createOrUpdateGoalsFromActivities({
    monitoringConfigId,
    stage,
  }: {
    monitoringConfigId: number;
    stage: MonitoringStatus;
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
    const tenantKey = tenant.key;

    const proyectos = await ProyectoService.instance.getProyectosWithGoals({
      tenantKey,
      plan: devPlan.code,
    });

    const projectCodes = proyectos.map((proyecto) => proyecto.proyecto);

    let actividades = await ActividadService.instance.getActividadesWithGoals({
      tenantKey,
      proyectos: projectCodes,
    });

    if (stage === MonitoringStatus.SCHEDULING) {
      // Create the goals for the activities
      await this.createGoalsFromActivities({
        tenantKey,
        projects: proyectos,
        activities: actividades,
        devPlan,
      });
      const goals = await this.getGoals({
        tenantKey,
        activityIds: actividades.map((actividad) => actividad.id),
      });
      actividades = actividades.map((actividad) => {
        const goal = goals.find((goal) => goal.activityId === actividad.id);
        return {
          ...actividad,
          goal: goal,
        };
      });

      // Create or update the monitoring records
      await MonitoringRecordService.instance.createMonitoringRecordsFromActivities({
        tenantKey,
        projectCodes,
        activities: actividades,
        monitoringConfig,
      });

      // Create or update the monitoring records resources
      await MonitoringRecordResourceService.instance.createMonitoringRecordResourcesFromActivities({
        tenantKey,
        monitoringConfig,
        projectCodes,
        activities: actividades,
        stage,
        resourceType: MonitoringResourceType.DEFINITIVE,
      });
    }
    if (stage === MonitoringStatus.REPORTING) {
      const spentDocs = (monitoringConfig.spentDocs ?? []) as SpentDoc[];
      for (let i = 0; i < spentDocs.length; i++) {
        // Create or update the monitoring records resources
        await MonitoringRecordResourceService.instance.createMonitoringRecordResourcesFromActivities(
          {
            tenantKey,
            monitoringConfig,
            projectCodes,
            activities: actividades,
            stage,
            resourceType: spentDocs[i] as MonitoringResourceType,
          },
        );
      }
    }
  }

  async getGoalIdsByGoalType({
    goalType,
    devPlanId,
  }: {
    goalType: GoalType;
    devPlanId: number;
  }): Promise<number[]> {
    const goals = await prisma.goal.findMany({
      where: {
        goalType,
        devPlanId,
      },
      select: {
        id: true,
      },
    });
    return goals.map((goal) => goal.id);
  }
}
