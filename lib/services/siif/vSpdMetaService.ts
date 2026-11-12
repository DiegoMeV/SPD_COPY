import { SearchSpdMeta, VSpdMeta } from "../../../graphql/types";
import { OracleDBClient } from "../../oracle";

export class VSpdMetaService {
  private static _instance: VSpdMetaService | undefined;

  private constructor() {}

  static get instance() {
    if (this._instance === undefined) {
      this._instance = new this();
    }
    return this._instance;
  }

  async getMetas(data: SearchSpdMeta & { tenantKey: string }): Promise<VSpdMeta[] | null> {
    const { tipos, codigoPlanDesarrollo, tenantKey } = data;
    const client = OracleDBClient.getInstance({ tenantKey });

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
      FROM  v_spd_meta
      WHERE nit_compania = :nitCompania

    `;
    const metas = await client.findMany<VSpdMeta>(
      sql,
      {
        nitCompania: tenantKey,
      },
      {
        where,
        orderBy: { codigo: "asc" },
      },
    );

    return metas;
  }
}
