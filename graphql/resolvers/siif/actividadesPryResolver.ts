import { Resolver, FieldResolver, Root, Query, Arg, Ctx } from "type-graphql";
import type { Context } from "../../types/common";
import { SPDResolver } from "../spdResolver";
import { ActividadesPry, InsumosPry, Proyecto, VActividadesPry } from "../../types";
import { OracleDBClient } from "../../../lib/oracle";
import { ActividadService } from "../../../lib/services";

@Resolver(() => ActividadesPry)
export class ActividadesPryResolver extends SPDResolver {
  @FieldResolver(() => [InsumosPry], { nullable: true })
  async insumos(@Root() actividadPry: ActividadesPry): Promise<InsumosPry[] | null> {
    const client = OracleDBClient.getInstance({ tenantKey: actividadPry.nitCompania });
    const sql = `
      SELECT  *
      FROM    v_insumos_pry
      WHERE   proyecto = :proyecto
      AND     nit_compania = :nitCompania
      AND     codigo_act = :codigoAct
    `;
    const insumos = await client.findMany<InsumosPry>(sql, {
      proyecto: actividadPry.proyecto,
      nitCompania: actividadPry.nitCompania,
      codigoAct: actividadPry.codigoAct,
    });

    return insumos;
  }

  @Query(() => [VActividadesPry], { nullable: true })
  async getActividades(
    @Arg("proyecto", () => String) proyecto: string,
    @Ctx() ctx: Context,
  ): Promise<VActividadesPry[] | null> {
    // Get actividades from SIIF
    const actividades = await ActividadService.instance.getActividades({
      tenantKey: this.getContextTenantKey(ctx),
      proyecto: proyecto,
    });

    return actividades;
  }
}
