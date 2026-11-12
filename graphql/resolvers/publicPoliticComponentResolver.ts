import { Resolver, Query, Mutation, Arg, Int, Ctx } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { PublicPoliticComponent, CreatePublicPoliticComponent, UpdatePublicPoliticComponent } from "../types";
import prisma from "../../lib/prisma";
import type { Context } from "../types/common";

@Resolver()
export class PublicPoliticComponentResolver extends SPDResolver {
    @Query(() => [PublicPoliticComponent])
    async getPublicPoliticComponents(@Ctx() ctx: Context): Promise<PublicPoliticComponent[]> {
        const result = await prisma.publicPoliticComponent.findMany({
            where: {
                tenantId: this.getContextTenantId(ctx)
            }
        });
        return result;
    }

    @Query(() => PublicPoliticComponent, { nullable: true })
    async getPublicPoliticComponent(@Arg("id", () => Int) id: number): Promise<PublicPoliticComponent | null> {
        return await prisma.publicPoliticComponent.findUnique({ where: { id } });
    }

    @Mutation(() => PublicPoliticComponent)
    async createPublicPoliticComponent(@Arg("data") data: CreatePublicPoliticComponent, @Ctx() ctx: Context): Promise<PublicPoliticComponent> {
        return await prisma.publicPoliticComponent.create({
            data: {
                ...data,
                tenantId: this.getContextTenantId(ctx),
            },
        });
    }

    @Mutation(() => PublicPoliticComponent)
    async updatePublicPoliticComponent(@Arg("data") data: UpdatePublicPoliticComponent): Promise<PublicPoliticComponent> {
        const { id, ...updateData } = data;
        return await prisma.publicPoliticComponent.update({
            where: { id },
            data: updateData,
        });
    }

    @Mutation(() => PublicPoliticComponent)
    async deletePublicPoliticComponent(@Arg("id", () => Int) id: number): Promise<PublicPoliticComponent | null> {
        return await prisma.publicPoliticComponent.delete({
            where: { id },
        });
    }
}
