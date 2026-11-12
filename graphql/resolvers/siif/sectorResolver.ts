import { Resolver, FieldResolver, Root, Query, Arg, Ctx, Int } from "type-graphql";
import { SPDResolver } from "../spdResolver";
import { Sector, ProgramaPry } from "../../types";
import { OracleDBClient } from "../../../lib/oracle";
// import { getPlanDesarrolloByCodeData } from "./data";
import type { Context } from "../../types/common";

@Resolver(() => Sector)
export class SectorResolver extends SPDResolver {
  private TABLE_NAME = "sector";

  @FieldResolver(() => [ProgramaPry], { nullable: true })
  async programas(@Root() sector: Sector): Promise<ProgramaPry[] | null> {
    // return (
    //   getPlanDesarrolloByCodeData.ejes
    //     .find((e) => e.eje === sector.eje)
    //     ?.sectores?.find((s) => s.sector === sector.sector)?.programas || []
    // );
    const client = OracleDBClient.getInstance({ tenantKey: sector.nitCompania });
    const sql = `
      SELECT *
      FROM   programa_pry
      WHERE  nit_compania = :nitCompania
      AND    plan = :plan
      AND    eje = :eje
      AND    sector = :sector
    `;
    const programas = await client.findMany<ProgramaPry>(sql, {
      nitCompania: sector.nitCompania,
      plan: sector.plan,
      eje: sector.eje,
      sector: sector.sector,
    });

    return programas;
  }

  @Query(() => [Sector])
  async getSectores(
    @Arg("plan", () => Int) plan: number,
    @Arg("eje", () => Int) eje: number,
    @Ctx() ctx: Context,
  ): Promise<Sector[]> {
    // return getPlanDesarrolloByCodeData.ejes.find((e) => e.eje === eje)?.sectores || [];
    const nitCompania = this.getContextTenantKey(ctx);
    const client = OracleDBClient.getInstance({ tenantKey: nitCompania });

    const sql = `
      SELECT *
      FROM   ${this.TABLE_NAME}
      WHERE  nit_compania = :nitCompania
      AND    plan = :plan
      AND    eje = :eje
      ORDER BY sector ASC
    `;
    const sectores = await client.findMany<Sector>(sql, {
      nitCompania,
      plan,
      eje,
    });

    return sectores;
  }
}
