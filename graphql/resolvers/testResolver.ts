import { Resolver, Query, Mutation, Arg, Ctx, FieldResolver, Root } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import type { Context, JsonObject } from "../types/common";
import { OracleDBClient } from "../../lib/oracle";
import { GraphQLJSON } from "graphql-scalars";

@Resolver()
export class TestResolver extends SPDResolver {
  @Query(() => GraphQLJSON)
  async oracleTest(@Ctx() ctx: Context): Promise<JsonObject> {
    const client = OracleDBClient.getInstance({ tenantKey: this.getContextTenantKey(ctx) });

    try {
      const result = await client.executeQuery("SELECT * FROM proyecto WHERE rownum <= 10");
      console.log("Result", JSON.stringify(result, null, 2));
      return JSON.parse(JSON.stringify(result));
    } catch (error) {
      console.error(error);
      return {};
    }
  }
}
