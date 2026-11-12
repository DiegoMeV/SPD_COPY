import { Resolver, FieldResolver, Root, Query, Arg, Ctx } from "type-graphql";
import { SPDResolver } from "../spdResolver";
import { VSpdMeta, InsumosPry, SearchSpdMeta } from "../../types";
import { OracleDBClient } from "../../../lib/oracle";
import type { Context } from "../../types/common";

@Resolver(() => VSpdMeta)
export class VSpdMetaResolver extends SPDResolver {
  private TABLE_NAME = "v_spd_meta";

  @Query(() => [VSpdMeta], { nullable: true })
  async getMetas(
    @Arg("data", () => SearchSpdMeta) data: SearchSpdMeta,
    @Ctx() ctx: Context,
  ): Promise<VSpdMeta[] | null> {
    const { tipos, codigoPlanDesarrollo } = data;
    const client = OracleDBClient.getInstance({ tenantKey: this.getContextTenantKey(ctx) });

    const where = {
      ...(codigoPlanDesarrollo ? { codigoPlanDesarrollo } : {}),
      ...(tipos
        ? {
            tipo: {
              in: tipos,
            },
          }
        : {}),
    };

    const sql = `
      SELECT *
      FROM  ${this.TABLE_NAME}
      WHERE nit_compania = :nitCompania

    `;
    const metas = await client.findMany<VSpdMeta>(
      sql,
      {
        nitCompania: this.getContextTenantKey(ctx),
      },
      {
        where,
        orderBy: { codigo: "asc" },
      },
    );

    return metas;
  }
}
