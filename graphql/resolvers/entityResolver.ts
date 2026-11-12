import { Resolver, Query, Mutation, Arg, Int, Ctx } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { Entity, CreateEntity, UpdateEntity, SearchEntityResponse, SearchEntity } from "../types";
import prisma from "../../lib/prisma";
import type { Context } from "../types/common";
import { Prisma } from "@prisma/client";
import { EntityService } from "../../lib/services";

@Resolver()
export class EntityResolver extends SPDResolver {
  @Query(() => [Entity])
  async getEntities(@Ctx() ctx: Context): Promise<Entity[]> {
    return EntityService.instance.getEntities({ tenantKey: this.getContextTenantKey(ctx) });
  }

  @Query(() => Entity, { nullable: true })
  async getEntity(@Arg("id", () => Int) id: number): Promise<Entity | null> {
    return await prisma.entity.findUnique({ where: { id } });
  }

  @Mutation(() => Entity)
  async createEntity(@Arg("data") data: CreateEntity, @Ctx() ctx: Context): Promise<Entity> {
    return await prisma.entity.create({
      data: {
        ...data,
        tenantId: this.getContextTenantId(ctx),
      },
    });
  }

  @Mutation(() => Entity)
  async updateEntity(@Arg("data") data: UpdateEntity): Promise<Entity> {
    const { id, ...updateData } = data;
    return await prisma.entity.update({
      where: { id },
      data: updateData,
    });
  }

  @Mutation(() => Int)
  async deleteEntity(@Arg("id", () => Int) id: number): Promise<number | null> {
    const result = await prisma.entity.delete({
      where: { id },
    });
    return result.id;
  }

  @Query(() => SearchEntityResponse, { nullable: true })
  async searchEntities(
    @Arg("data") data: SearchEntity,
    @Ctx() ctx: Context,
  ): Promise<SearchEntityResponse> {
    const { limit, offset = 0, sort, text, active, ...searchData } = data || {};

    const where: Prisma.EntityWhereInput = {
      ...searchData,
      tenantId: this.getContextTenantId(ctx),
      ...(active
        ? {
            OR: [{ isActive: active?.[0] }, { isActive: active?.[1] }],
          }
        : {}),
      ...(text
        ? {
            OR: [
              { name: { contains: text, mode: "insensitive" } },
              { code: { contains: text, mode: "insensitive" } },
            ],
          }
        : {}),
    };
    console.log("where", where);

    let orderBy: Prisma.EntityOrderByWithRelationInput | undefined = undefined;
    if (sort?.field && sort?.order) {
      orderBy = { [sort.field]: sort.order };
    }

    const result = await prisma.entity.findMany({
      where,
      ...(limit ? { take: limit } : {}),
      skip: offset,
      orderBy: orderBy ?? [{ name: "asc" }],
    });

    // Total records
    const countItems = await prisma.entity.count({
      where,
    });

    return { items: result, count: countItems };
  }
}
