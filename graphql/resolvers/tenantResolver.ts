import { Resolver, Query, Mutation, Arg, Int } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { Tenant, CreateTenant, UpdateTenant } from "../types";
import prisma from "../../lib/prisma";

@Resolver()
export class TenantResolver extends SPDResolver {
  @Query(() => [Tenant])
  async getTenants(): Promise<Tenant[]> {
    const result = await prisma.tenant.findMany();
    return result;
  }

  @Query(() => Tenant, { nullable: true })
  async getTenant(@Arg("id", () => Int) id: number): Promise<Tenant | null> {
    return await prisma.tenant.findUnique({ where: { id } });
  }

  @Query(() => Tenant, { nullable: true })
  async getTenantByKey(@Arg("key", () => String) key: string): Promise<Tenant | null> {
    return await prisma.tenant.findFirst({ where: { key } });
  }

  @Mutation(() => Tenant)
  async createTenant(@Arg("data") data: CreateTenant): Promise<Tenant> {
    return await prisma.tenant.create({
      data: {
        ...data,
      },
    });
  }

  @Mutation(() => Tenant)
  async updateTenant(@Arg("data") data: UpdateTenant): Promise<Tenant> {
    const { id, ...updateData } = data;
    return await prisma.tenant.update({
      where: { id },
      data: updateData,
    });
  }

  @Mutation(() => Tenant)
  async deleteTenant(@Arg("id", () => Int) id: number): Promise<Tenant | null> {
    return await prisma.tenant.delete({
      where: { id },
    });
  }
}
