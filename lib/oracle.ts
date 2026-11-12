import oracledb from "oracledb";
import { objKeysToCamelCase, toSnakeCase } from "./utils";

try {
  oracledb.initOracleClient();
} catch (error) {
  // Oracle Instant Client is optional: without it, SIIF (Oracle) queries are unavailable.
  // eslint-disable-next-line no-console
  console.warn("[oracle] Oracle Instant Client not available, SIIF queries disabled:", (error as Error).message);
}

export interface OracleDBConfig {
  user?: string;
  password?: string;
  connectString?: string;
  tenantKey?: string;
  poolMin?: number;
  poolMax?: number;
  poolIncrement?: number;
}

export class OracleDBClient {
  private static instances: Map<string, OracleDBClient> = new Map();
  private config: OracleDBConfig;
  private pool: oracledb.Pool | undefined;

  constructor(config: OracleDBConfig) {
    this.config = config;
  }

  public static getInstance(config: OracleDBConfig): OracleDBClient {
    const tenantKey = config.tenantKey ?? "default";
    if (!OracleDBClient.instances.has(tenantKey)) {
      const instance = new OracleDBClient(config);
      OracleDBClient.instances.set(tenantKey, instance);
    }
    return OracleDBClient.instances.get(tenantKey)!;
  }

  private async init() {
    try {
      if (this.config.tenantKey && !this.config.connectString) {
        this.config.connectString = process.env[`SIIF_CONNECTION_STRING_${this.config.tenantKey}`];
      }
      const poolConfig = {
        user: this.config.user ?? process.env.SIIF_USER ?? "siif_web",
        password: this.config.password ?? process.env.SIIF_PASSWORD ?? "siif_web",
        connectString: this.config.connectString,
        poolMin: this.config.poolMin ?? 5,
        poolMax: this.config.poolMax ?? 15,
        poolIncrement: this.config.poolIncrement ?? 1,
      };
      console.log("Pool config", poolConfig);
      this.pool = await oracledb.createPool(poolConfig);
      console.log("Connection pool created");
    } catch (error) {
      console.error("Error creating connection pool", error);
      throw error;
    }
  }

  async getConnection(): Promise<oracledb.Connection> {
    try {
      if (!this.pool) {
        await this.init();
      }
      if (!this.pool) {
        throw new Error("Connection pool has not been initialized.");
      }
      const connection = await this.pool.getConnection();
      console.log("Successfully obtained connection from pool");
      return connection;
    } catch (error) {
      console.error("Error getting connection from pool", error);
      throw error;
    }
  }

  async closePool() {
    try {
      if (this.pool) {
        await this.pool.close(10); // Close the pool with 10 seconds of drain time
        console.log("Connection pool closed");
      }
    } catch (error) {
      console.error("Error closing connection pool", error);
      throw error;
    }
  }

  async withConnection(callback: (connection: oracledb.Connection) => Promise<void>) {
    const connection = await this.getConnection();
    try {
      await callback(connection);
    } finally {
      await connection.close();
    }
  }

  async executeQuery(query: string, params?: Record<string, any>) {
    let connection: oracledb.Connection | undefined;
    try {
      connection = await this.getConnection();
      const result = await connection.execute(query, params ?? {}, {
        outFormat: oracledb.OUT_FORMAT_OBJECT,
      });
      console.log("Query executed successfully", result);
      return result.rows as any[];
    } catch (error) {
      console.error("Error executing query", error);
      throw error;
    } finally {
      if (connection) {
        try {
          await connection.close();
        } catch (err) {
          console.error("Error closing connection", err);
        }
      }
    }
  }

  async findFirst<T>(query: string, params: Record<string, any>): Promise<T | null> {
    const result = await this.executeQuery(query, params);
    if (result.length === 0) {
      return null;
    }
    return objKeysToCamelCase(result[0]) as T;
  }

  buildOperatorLine(key: string, operator: string, value: any): string {
    if (operator === "like") {
      return `LOWER(${toSnakeCase(key)}) LIKE LOWER('%${value}%')`;
    }
    if (operator === "in" && Array.isArray(value)) {
      return `${toSnakeCase(key)} IN (${value.map((item) => `'${item}'`).join(", ")})`;
    }
    return `${toSnakeCase(key)} = '${value}'`;
  }

  buildWhereClauseLine({ key, value }: { key: string; value: any }): string {
    if (value === undefined) return "";
    if (typeof value === "object") {
      const operator = Object.keys(value)[0];
      return `${this.buildOperatorLine(key, operator, value[operator])}`;
    }
    return `${toSnakeCase(key)} = '${value}'`;
  }

  buildWhereClause(where: Record<string, any>): string {
    if (Object.keys(where).length === 0) {
      return "";
    }
    return Object.keys(where)
      .filter((key) => where[key] !== undefined)
      .map((key) => {
        const value = where[key];
        return this.buildWhereClauseLine({ key, value });
      })
      .join(" AND ");
  }

  buildOrderClause(orderBy: Record<string, "asc" | "desc">): string {
    if (Object.keys(orderBy).length === 0) {
      return "";
    }
    return `ORDER BY ${Object.keys(orderBy)
      .map((key) => `${toSnakeCase(key)} ${orderBy[key]}`)
      .join(", ")}`;
  }

  async findMany<T>(
    query: string,
    params: Record<string, any>,
    queryConfig?: {
      where?: Record<string, any>;
      orderBy?: Record<string, "asc" | "desc">;
      take?: number;
      skip?: number;
    },
  ): Promise<T[]> {
    const whereStr = this.buildWhereClause(queryConfig?.where ?? {});
    const orderStr = this.buildOrderClause(queryConfig?.orderBy ?? {});
    const skip = queryConfig?.skip ?? 0;
    const queryStr = `
      SELECT * 
      FROM (
        SELECT t.*, rownum num_row
        FROM (
          ${query} 
          ${whereStr ? `${/where/gi.test(query) ? "AND" : "WHERE"} ${whereStr}` : ""}
          ${orderStr ? orderStr : ""}
        ) t
      )
      ${queryConfig?.take ? `WHERE num_row BETWEEN ${skip + 1} AND ${queryConfig.take + skip}` : ""}
    `;
    console.log("Query string", queryStr);
    const result = await this.executeQuery(queryStr, params);
    return result.map((row) => objKeysToCamelCase(row)) as T[];
  }

  async count(
    query: string,
    params: Record<string, any>,
    queryConfig?: {
      where?: Record<string, any>;
    },
  ): Promise<number> {
    const whereStr = this.buildWhereClause(queryConfig?.where ?? {});
    const queryStr = `
      ${query} 
      ${whereStr ? `${/where/gi.test(query) ? "AND" : "WHERE"} ${whereStr}` : ""}
    `;
    const result = await this.executeQuery(queryStr, params);
    return result?.[0]?.COUNT ?? 0;
  }
}
