import { Resolver, Query, Arg, Ctx, Int, FieldResolver, Root } from "type-graphql";
import { SPDResolver } from "../spdResolver";
import { SubprogramaPry } from "../../types";
import { OracleDBClient } from "../../../lib/oracle";
// import { getPlanDesarrolloByCodeData } from "./data";
import type { Context } from "../../types/common";

@Resolver(() => SubprogramaPry)
export class SubprogramaPryResolver extends SPDResolver {
  private TABLE_NAME = "subprograma_pry";

  @Query(() => [SubprogramaPry])
  async getSubprogramas(
    @Arg("plan", () => Int) plan: number,
    @Arg("eje", () => Int) eje: number,
    @Arg("sector", () => Int) sector: number,
    @Arg("programa", () => Int) programa: number,
    @Ctx() ctx: Context,
  ): Promise<SubprogramaPry[]> {
    // return (
    //   getPlanDesarrolloByCodeData.ejes
    //     .find((e) => e.eje === eje)
    //     ?.sectores?.find((s) => s.sector === sector)
    //     ?.programas?.find((p) => (p.programa = programa))?.subprogramas || []
    // );
    const nitCompania = this.getContextTenantKey(ctx);
    const client = OracleDBClient.getInstance({ tenantKey: nitCompania });

    const sql = `
      SELECT *
      FROM   ${this.TABLE_NAME}
      WHERE  nit_compania = :nitCompania
      AND    plan = :plan
      AND    eje = :eje
      AND    sector = :sector
      AND    programa = :programa
      ORDER BY programa ASC
    `;
    const subprogramas = await client.findMany<SubprogramaPry>(sql, {
      nitCompania,
      plan,
      eje,
      sector,
      programa,
    });

    return subprogramas;
  }
}
