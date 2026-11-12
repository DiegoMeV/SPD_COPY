import { MonitoringRecordStatus } from "@prisma/client";
import {
  Proyecto,
  ProyectoWithGoals,
  SearchProyecto,
  SearchProyectoForSchedule,
  SearchProyectoResponse,
} from "../../../graphql/types/siif";
import { OracleDBClient } from "../../oracle";
import { MonitoringConfigService } from "../monitoringConfigService";
import { MonitoringRecordService } from "../monitoringRecordService";
import { ActividadService } from "./actividadService";
import { DevPlanService } from "../devPlanService";
import { GoalService } from "../goalService";
import { MonitoringRecordResourceService } from "../monitoringRecordResourceService";
import { TenantService } from "../tenantService";

export class ProyectoService {
  private static _instance: ProyectoService | undefined;

  private constructor() {}

  static get instance() {
    if (this._instance === undefined) {
      this._instance = new this();
    }
    return this._instance;
  }

  async getProyecto({
    tenantKey,
    code,
  }: {
    tenantKey: string;
    code: string;
  }): Promise<Proyecto | null> {
    const client = OracleDBClient.getInstance({ tenantKey });
    const sql = `
      SELECT *
      FROM   v_proyecto
      WHERE  proyecto = :proyecto
      AND   nit_compania = :nitCompania
    `;
    const proyecto = await client.findFirst<Proyecto>(sql, {
      proyecto: code,
      nitCompania: tenantKey,
    });

    return proyecto;
  }

  async getProyectos({
    tenantKey,
    codes,
    plan,
  }: {
    tenantKey: string;
    codes?: string[];
    plan?: string;
  }): Promise<Proyecto[]> {
    const client = OracleDBClient.getInstance({ tenantKey });
    const sql = `
      SELECT *
      FROM   v_proyecto
      WHERE  nit_compania = :nitCompania
    `;
    const proyectos = (
      await client.findMany<Proyecto>(
        sql,
        {
          nitCompania: tenantKey,
        },
        {
          where: {
            ...(codes?.length ? { proyecto: { in: codes } } : {}),
            ...(plan ? { plan } : {}),
          },
        },
      )
    ).map((proyecto) => {
      const { proyecto: code, ...rest } = proyecto;
      return { ...rest, proyecto: `${code}` };
    });

    return proyectos;
  }

  async searchProyectos({
    data,
    tenantKey,
  }: {
    data: SearchProyecto;
    tenantKey: string;
  }): Promise<SearchProyectoResponse> {
    const client = OracleDBClient.getInstance({ tenantKey });
    const { limit, offset = 0, sort, proyecto, nombre, codigosEntPry, ...searchData } = data || {};

    const where = {
      ...searchData,
      ...(proyecto ? { proyecto: { like: proyecto } } : {}),
      ...(nombre ? { nombre: { like: nombre } } : {}),
      ...(codigosEntPry
        ? {
            codigoEntPry: {
              in: codigosEntPry,
            },
          }
        : {}),
    };

    let orderBy: Record<string, "asc" | "desc"> | undefined = undefined;
    if (sort?.field && sort?.order) {
      orderBy = { [sort.field]: sort.order };
    }

    const sql = `
      SELECT * 
      FROM   v_proyecto
      WHERE  nit_compania = :nitCompania
    `;

    const proyectos = (
      await client.findMany<Proyecto>(
        sql,
        { nitCompania: tenantKey },
        {
          where,
          orderBy,
          ...(limit ? { take: limit } : {}),
          skip: offset,
        },
      )
    ).map((proyecto) => {
      const { proyecto: code, ...rest } = proyecto;
      return { ...rest, proyecto: `${code}` };
    });

    // Total records
    const count = await client.count(
      sql.replace("*", "count(*) as count"),
      { nitCompania: tenantKey },
      {
        where,
      },
    );

    return { items: proyectos, count };
  }

  async getProyectosWithGoals({
    tenantKey,
    projectCodes,
    plan,
  }: {
    tenantKey: string;
    projectCodes?: string[];
    plan?: string;
  }): Promise<ProyectoWithGoals[]> {
    let projects = await this.getProyectos({ tenantKey, codes: projectCodes, plan });
    // Add goal to each project
    projects = await this.addGoalsToProjects({ tenantKey, proyectos: projects });

    return projects;
  }

  async addGoalsToProjects({
    tenantKey,
    proyectos,
  }: {
    tenantKey: string;
    proyectos: Proyecto[];
  }): Promise<ProyectoWithGoals[]> {
    const tenant = await TenantService.instance.getTenant({ key: tenantKey });
    const goals = await GoalService.instance.getGoals({
      tenantId: tenant.id,
      projectCodes: proyectos.map((proyecto) => `${proyecto.proyecto}`),
    });

    return proyectos.map((proyecto) => {
      const goal = goals.find((goal) => goal.projectCode === proyecto.proyecto);
      return {
        ...proyecto,
        goal,
      };
    });
  }

  async createOrUpdateScheduleForProjects({
    tenantKey,
    proyectos,
    monitoringConfigId,
  }: {
    tenantKey: string;
    proyectos: Proyecto[];
    monitoringConfigId: number;
  }) {
    const projectCodes = proyectos.map((proyecto) => proyecto.proyecto);
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

    // Create the goals for the projects
    await GoalService.instance.createGoalsFromProjects({
      tenantKey,
      projectCodes,
      devPlan,
    });
    // const goals = await GoalService.instance.getGoals({
    //   tenantKey,
    //   activityIds: actividades.map((actividad) => actividad.id),
    // });
    // actividades = actividades.map((actividad) => {
    //   const goal = goals.find((goal) => goal.activityId === actividad.id);
    //   return {
    //     ...actividad,
    //     goal: goal,
    //   };
    // });

    // // Create or update the monitoring records
    // const monitoringConfig = await MonitoringConfigService.instance.getMonitoringConfigById({
    //   id: monitoringConfigId,
    // });

    // const monitoringRecords =
    //   await MonitoringRecordService.instance.createMonitoringRecordsFromActivities({
    //     tenantKey,
    //     projectCodes,
    //     activities: actividades,
    //     monitoringConfig,
    //   });

    // // Create or update the monitoring records resources
    // await MonitoringRecordResourceService.instance.createMonitoringRecordResourcesFromActivities({
    //   tenantKey,
    //   monitoringConfig,
    //   projectCodes,
    //   activities: actividades,
    // });
  }

  async createOrUpdateScheduleForActivities({
    tenantKey,
    proyectos,
    monitoringConfigId,
  }: {
    tenantKey: string;
    proyectos: Proyecto[];
    monitoringConfigId: number;
  }) {
    const projectCodes = proyectos.map((proyecto) => proyecto.proyecto);
    let actividades = await ActividadService.instance.getActividadesWithGoals({
      tenantKey,
      proyectos: projectCodes,
    });
    const devPlan = await DevPlanService.instance.getDevPlan({
      tenantKey,
      code: `${proyectos[0].plan}`,
    });
    if (!devPlan) {
      throw new Error(`Plan de desarrollo código ${proyectos[0].plan} no encontrado`);
    }

    // Create the goals for the activities
    await GoalService.instance.createGoalsFromActivities({
      tenantKey,
      projects: proyectos,
      activities: actividades,
      devPlan,
    });
    const goals = await GoalService.instance.getGoals({
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
    const monitoringConfig = await MonitoringConfigService.instance.getMonitoringConfigById({
      id: monitoringConfigId,
    });

    const monitoringRecords =
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
    });
  }

  async getProyectosForSchedule({
    data,
    tenantKey,
  }: {
    data: SearchProyectoForSchedule;
    tenantKey: string;
  }): Promise<SearchProyectoResponse> {
    const { monitoringConfigId, updateSchedule, ...searchData } = data;

    // Search projects and activities
    const searchProyectosResponse = await this.searchProyectos({ data: searchData, tenantKey });
    const { items: proyectos, count: countProyectos } = searchProyectosResponse;

    // Update the schedule: create goals, monitoring records and monitoring records resources
    if (countProyectos > 0 && Boolean(updateSchedule)) {
      await this.createOrUpdateScheduleForProjects({
        tenantKey,
        proyectos,
        monitoringConfigId,
      });
      await this.createOrUpdateScheduleForActivities({
        tenantKey,
        proyectos,
        monitoringConfigId,
      });
    }

    return searchProyectosResponse;
  }
}
