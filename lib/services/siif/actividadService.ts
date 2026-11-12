import { OracleDBClient } from "../../oracle";
import {
  VActividadesPry,
  VActividadesPryWithGoals,
} from "../../../graphql/types/siif/vActividadesPry";
import { VSeguimientoActividad } from "../../../graphql/types/siif/vSeguimientoActividad";
import { DevPlanService } from "../devPlanService";
import { GoalActivitySource } from "@prisma/client";
import { GoalService } from "../goalService";
import { GoalActivityService } from "../goalActivityService";
import { TenantService } from "../tenantService";
import { VSaldopptalEgrActividadWp, VValorFisicoActividad } from "../../../graphql/types";

export class ActividadService {
  private static _instance: ActividadService | undefined;

  private constructor() {}

  static get instance() {
    if (this._instance === undefined) {
      this._instance = new this();
    }
    return this._instance;
  }

  async getActividadById({
    tenantKey,
    id,
  }: {
    tenantKey: string;
    id: number;
  }): Promise<VActividadesPry | null> {
    const client = OracleDBClient.getInstance({ tenantKey });
    const sql = `
      SELECT *
      FROM   v_actividades_pry
      WHERE  nit_compania = :nitCompania
      AND    id = :id
    `;
    const actividad = await client.findFirst<VActividadesPry>(sql, {
      id: id,
      nitCompania: tenantKey,
    });

    return actividad;
  }

  async getActividades({
    tenantKey,
    proyecto,
    proyectos,
  }: {
    tenantKey: string;
    proyecto?: string;
    proyectos?: string[];
  }): Promise<VActividadesPry[]> {
    const client = OracleDBClient.getInstance({ tenantKey });
    const sql = `
      SELECT *
      FROM   v_actividades_pry
      WHERE  nit_compania = :nitCompania
    `;
    const actividades = (
      await client.findMany<VActividadesPry>(
        sql,
        {
          nitCompania: tenantKey,
        },
        {
          where: {
            ...(proyecto ? { proyecto } : {}),
            ...(proyectos ? { proyecto: { in: proyectos } } : {}),
          },
        },
      )
    ).map((actividad) => {
      const { proyecto: code, ...rest } = actividad;
      return { ...rest, proyecto: `${code}` };
    });

    return actividades;
  }

  async addLinkedGoalsToActivities({
    tenantKey,
    actividades,
  }: {
    tenantKey: string;
    actividades: VActividadesPryWithGoals[];
  }): Promise<VActividadesPryWithGoals[]> {
    const devPlan = await DevPlanService.instance.getDevPlan({
      tenantKey,
      code: `${actividades[0].plan}`,
    });

    const goalActivitySource = devPlan?.goalActivitySource;

    if (goalActivitySource === GoalActivitySource.SIIF) {
      const codigoMetas = Array.from(
        new Set(actividades.map((act) => act.codigoMeta).filter((act) => !!act)),
      ) as string[];
      const goals = await GoalService.instance.getGoals({
        tenantKey,
        codes: codigoMetas,
      });

      return actividades.map((act) => {
        return { ...act, linkedGoal: goals.find((goal) => goal.code === act.codigoMeta) };
      });
    } else if (goalActivitySource === GoalActivitySource.MANUAL) {
      const goalsAndActivities = await GoalActivityService.instance.getGoalsToActivities({
        tenantKey,
        activityIds: actividades.map((act) => act.id),
      });
      const goalIds = goalsAndActivities.map((gta) => gta.goalId);
      const goals = await GoalService.instance.getGoals({
        tenantKey,
        ids: goalIds,
      });
      return actividades.map((act) => {
        const goalToActivity = goalsAndActivities.find((gta) => gta.activityId === act.id);
        const goal = goals.find((goal) => goal.id === goalToActivity?.goalId);
        return {
          ...act,
          goalId: goalToActivity?.goalId,
          nombreMeta: goal?.name,
          codigoMeta: goal?.code,
          linkedGoal: goal,
          linkedGoalId: goalToActivity?.id,
        };
      });
    }

    return actividades;
  }

  async addGoalsToActivities({
    tenantKey,
    actividades,
  }: {
    tenantKey: string;
    actividades: VActividadesPryWithGoals[];
  }): Promise<VActividadesPryWithGoals[]> {
    const tenant = await TenantService.instance.getTenant({ key: tenantKey });
    const goals = await GoalService.instance.getGoals({
      tenantId: tenant.id,
      activityIds: actividades.map((act) => act.id),
    });

    return actividades.map((act) => {
      const goal = goals.find((goal) => goal.activityId === act.id);
      return {
        ...act,
        goal,
      };
    });
  }

  async getActividadesWithGoals({
    tenantKey,
    proyecto,
    proyectos,
  }: {
    tenantKey: string;
    proyecto?: string;
    proyectos?: string[];
  }): Promise<VActividadesPryWithGoals[]> {
    let actividades = await this.getActividades({ tenantKey, proyecto, proyectos });
    // Add linkedGoal to each activity
    actividades = await this.addLinkedGoalsToActivities({ tenantKey, actividades });
    // Add goal to each activity
    actividades = await this.addGoalsToActivities({ tenantKey, actividades });

    return actividades;
  }

  async getValoresFisicos({
    tenantKey,
    period,
    subperiod,
    projects,
  }: {
    tenantKey: string;
    period: number;
    subperiod: number;
    projects: string[];
  }): Promise<VValorFisicoActividad[]> {
    const client = OracleDBClient.getInstance({ tenantKey });
    const sql = `
      SELECT *
      FROM   v_valor_fisico_actividad
      WHERE  nit_compania = :nitCompania
    `;

    return client.findMany<VValorFisicoActividad>(
      sql,
      {
        nitCompania: tenantKey,
      },
      {
        where: {
          vigencia: period,
          trimestre: subperiod,
          proyecto: {
            in: projects,
          },
        },
      },
    );
  }

  async getValoresFinancieros({
    tenantKey,
    period,
    subperiod,
    projects,
  }: {
    tenantKey: string;
    period: number;
    subperiod: number;
    projects: string[];
  }): Promise<VSaldopptalEgrActividadWp[]> {
    const client = OracleDBClient.getInstance({ tenantKey });
    const sql = `
      SELECT *
      FROM   v_saldopptal_egr_actividad_wp
      WHERE  nit_compania = :nitCompania
    `;

    return client.findMany<VSaldopptalEgrActividadWp>(
      sql,
      {
        nitCompania: tenantKey,
      },
      {
        where: {
          vigencia: period,
          trimestre: subperiod,
          proyecto: {
            in: projects,
          },
        },
      },
    );
  }
}
