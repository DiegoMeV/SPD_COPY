import { Resolver, FieldResolver, Root, Query, Arg, Int, Ctx } from "type-graphql";
import { SPDResolver } from "../spdResolver";
import { EjeEstructurante, Sector } from "../../types";
import { OracleDBClient } from "../../../lib/oracle";
// import { getPlanDesarrolloByCodeData } from "./data";
import type { Context } from "../../types/common";
import _ from "lodash";

@Resolver(() => EjeEstructurante)
export class EjeEstructuranteResolver extends SPDResolver {
  private TABLE_NAME = "eje_estructurante";

  @FieldResolver(() => [Sector], { nullable: true })
  async sectores(@Root() eje: EjeEstructurante): Promise<Sector[] | null> {
    // return (
    //   getPlanDesarrolloByCodeData.ejes
    //     .find((e) => e.eje === eje.eje)
    //     ?.sectores?.map((s) => _.omit(s, ["programas"])) || []
    // );
    const client = OracleDBClient.getInstance({ tenantKey: eje.nitCompania });
    const sql = `
      SELECT *
      FROM   sector
      WHERE  nit_compania = :nitCompania
      AND    plan = :plan
      AND    eje = :eje
    `;
    const sectores = await client.findMany<Sector>(sql, {
      nitCompania: eje.nitCompania,
      plan: eje.plan,
      eje: eje.eje,
    });

    return sectores;
  }

  @Query(() => [EjeEstructurante])
  async getEjes(
    @Arg("plan", () => Int) plan: number,
    @Ctx() ctx: Context,
  ): Promise<EjeEstructurante[]> {
    // return getPlanDesarrolloByCodeData.ejes;
    const nitCompania = this.getContextTenantKey(ctx);
    const client = OracleDBClient.getInstance({ tenantKey: nitCompania });

    const sql = `
      SELECT *
      FROM   ${this.TABLE_NAME}
      WHERE  nit_compania = :nitCompania
      AND    plan = :plan
      ORDER BY eje ASC
    `;
    const ejes = await client.findMany<EjeEstructurante>(sql, {
      nitCompania,
      plan,
    });

    return ejes;
  }
}
