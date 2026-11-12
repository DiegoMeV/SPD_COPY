import { Resolver, Query, Arg, Ctx, Int, FieldResolver, Root } from "type-graphql";
import { SPDResolver } from "../spdResolver";
import { ProgramaPry, SubprogramaPry } from "../../types";
import { OracleDBClient } from "../../../lib/oracle";
// import { getPlanDesarrolloByCodeData } from "./data";
import type { Context } from "../../types/common";

@Resolver(() => ProgramaPry)
export class ProgramaPryResolver extends SPDResolver {
  private TABLE_NAME = "programa_pry";

  @FieldResolver(() => [SubprogramaPry], { nullable: true })
  async subprogramas(@Root() programa: ProgramaPry): Promise<SubprogramaPry[] | null> {
    // return (
    //   getPlanDesarrolloByCodeData.ejes
    //     .find((e) => e.eje === programa.eje)
    //     ?.sectores?.find((s) => s.sector === programa.sector)
    //     ?.programas?.find((p) => p.programa === programa.programa)?.subprogramas || []
    // );
    const client = OracleDBClient.getInstance({ tenantKey: programa.nitCompania });
    const sql = `
      SELECT *
      FROM   subprograma_pry
      WHERE  nit_compania = :nitCompania
      AND    plan = :plan
      AND    eje = :eje
      AND    sector = :sector
      AND    programa = :programa
    `;
    const subprogramas = await client.findMany<SubprogramaPry>(sql, {
      nitCompania: programa.nitCompania,
      plan: programa.plan,
      eje: programa.eje,
      sector: programa.sector,
      programa: programa.programa,
    });

    return subprogramas;
  }

  @Query(() => [ProgramaPry])
  async getProgramas(
    @Arg("plan", () => Int) plan: number,
    @Arg("eje", () => Int) eje: number,
    @Arg("sector", () => Int) sector: number,
    @Ctx() ctx: Context,
  ): Promise<ProgramaPry[]> {
    // return (
    //   getPlanDesarrolloByCodeData.ejes
    //     .find((e) => e.eje === eje)
    //     ?.sectores?.find((s) => s.sector === sector)?.programas || []
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
      ORDER BY sector ASC
    `;
    const programas = await client.findMany<ProgramaPry>(sql, {
      nitCompania,
      plan,
      eje,
      sector,
    });

    return programas;
  }
}
