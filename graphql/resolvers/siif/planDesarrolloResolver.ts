import { Resolver, Query, Arg, Int, Ctx, FieldResolver, Root } from "type-graphql";
import { SPDResolver } from "../spdResolver";
import { EjeEstructurante, PlanDesarrollo } from "../../types/";
import type { Context } from "../../types/common";
import { OracleDBClient } from "../../../lib/oracle";
// import { getPlanDesarrolloByCodeData } from "./data";
import _ from "lodash";

@Resolver(() => PlanDesarrollo)
export class PlanDesarrolloResolver extends SPDResolver {
  private TABLE_NAME = "plan_desarrollo";

  @FieldResolver(() => [EjeEstructurante], { nullable: true })
  async ejes(@Root() planDesarrollo: PlanDesarrollo): Promise<EjeEstructurante[] | null> {
    const client = OracleDBClient.getInstance({ tenantKey: planDesarrollo.nitCompania });
    const sql = `
      SELECT *
      FROM   eje_estructurante
      WHERE  nit_compania = :nitCompania
      AND    plan = :plan
      ORDER BY eje
    `;
    const ejes = await client.findMany<EjeEstructurante>(sql, {
      nitCompania: planDesarrollo.nitCompania,
      plan: planDesarrollo.plan,
    });

    return ejes;
    // return getPlanDesarrolloByCodeData.ejes?.map((eje) => _.omit(eje, ["sectores"])) ?? [];
  }

  @Query(() => [PlanDesarrollo])
  async getPlanesDesarrollo(@Ctx() ctx: Context): Promise<PlanDesarrollo[]> {
    const nitCompania = this.getContextTenantKey(ctx);
    const client = OracleDBClient.getInstance({ tenantKey: nitCompania });

    const sql = `
      SELECT *
      FROM   ${this.TABLE_NAME}
      WHERE  nit_compania = :nitCompania
      ORDER BY plan DESC
    `;
    const planesDesarrollo = await client.findMany<PlanDesarrollo>(sql, {
      nitCompania,
    });

    return planesDesarrollo;
  }

  @Query(() => PlanDesarrollo, { nullable: true })
  async getPlanDesarrollo(
    @Arg("id", () => Int) id: number,
    @Ctx() ctx: Context,
  ): Promise<PlanDesarrollo | null> {
    const nitCompania = this.getContextTenantKey(ctx);
    const client = OracleDBClient.getInstance({ tenantKey: nitCompania });

    const sql = `
      SELECT *
      FROM   ${this.TABLE_NAME}
      WHERE  nit_compania = :nitCompania
      AND    id = :id
    `;
    const planDesarrollo = await client.findFirst<PlanDesarrollo>(sql, {
      nitCompania,
      id,
    });

    return planDesarrollo;
  }

  @Query(() => PlanDesarrollo, { nullable: true })
  async getPlanDesarrolloByCode(
    @Arg("code", () => String) code: string,
    @Ctx() ctx: Context,
  ): Promise<PlanDesarrollo | null> {
    // return getPlanDesarrolloByCodeData;
    const nitCompania = this.getContextTenantKey(ctx);
    const client = OracleDBClient.getInstance({ tenantKey: nitCompania });

    const sql = `
      SELECT *
      FROM   ${this.TABLE_NAME}
      WHERE  nit_compania = :nitCompania
      AND    plan = :plan
    `;

    console.log("sql", sql);
    console.log("nitCompania", nitCompania);
    console.log("code", code);

    const planDesarrollo = await client.findFirst<PlanDesarrollo>(sql, {
      nitCompania,
      plan: code,
    });

    return planDesarrollo;
  }
}
