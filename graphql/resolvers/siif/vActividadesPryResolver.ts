import { Resolver, FieldResolver, Root } from "type-graphql";
import { SPDResolver } from "../spdResolver";
import { VActividadesPry, InsumosPry, VActividadesPryWithGoals, Goal } from "../../types";
import { OracleDBClient } from "../../../lib/oracle";
import proyectoData from "../proyectoData";
import { GoalService } from "../../../lib/services";

@Resolver(() => VActividadesPry)
export class VActividadesPryResolver extends SPDResolver {
  @FieldResolver(() => [InsumosPry], { nullable: true })
  async insumos(@Root() actividadPry: VActividadesPry): Promise<InsumosPry[] | null> {
    const client = OracleDBClient.getInstance({ tenantKey: actividadPry.nitCompania });
    const sql = `
      SELECT *
      FROM v_insumos_pry
      WHERE proyecto = :proyecto
      AND nit_compania = :nitCompania
      AND  codigo_act = :codigoAct
    `;
    const insumos = await client.findMany<InsumosPry>(sql, {
      proyecto: actividadPry.proyecto,
      nitCompania: actividadPry.nitCompania,
      codigoAct: actividadPry.codigoAct,
    });

    return insumos;
  }

  @FieldResolver(() => Goal, { nullable: true })
  async goal(@Root() actividadPry: VActividadesPry): Promise<Goal | null> {
    return GoalService.instance.getGoal({
      tenantKey: actividadPry.nitCompania,
      activityId: actividadPry.id,
    });
  }
}

@Resolver(() => VActividadesPryWithGoals)
export class VActividadesPryWithGoalsResolver extends SPDResolver {
  @FieldResolver(() => [InsumosPry], { nullable: true })
  async insumos(@Root() actividadPry: VActividadesPryWithGoals): Promise<InsumosPry[] | null> {
    const client = OracleDBClient.getInstance({ tenantKey: actividadPry.nitCompania });
    const sql = `
      SELECT *
      FROM v_insumos_pry
      WHERE proyecto = :proyecto
      AND nit_compania = :nitCompania
      AND  codigo_act = :codigoAct
    `;
    const insumos = await client.findMany<InsumosPry>(sql, {
      proyecto: actividadPry.proyecto,
      nitCompania: actividadPry.nitCompania,
      codigoAct: actividadPry.codigoAct,
    });

    return insumos;
  }
}
