import { Resolver, Query, Mutation, Arg, Int, Ctx, FieldResolver, Root } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { PublicPolitic, CreatePublicPolitic, UpdatePublicPolitic, SearchPublicPolitic, SearchPublicPoliticResponse, PublicPoliticComponent, Goal } from "../types";
import prisma from "../../lib/prisma";
import { Prisma, PublicPoliticCategory } from "@prisma/client";
import type { Context } from "../types/common";
import _ from "lodash";

@Resolver(() => PublicPolitic)
export class PublicPoliticResolver extends SPDResolver {

    @FieldResolver(() => [PublicPoliticComponent], { nullable: true })
    async components(
        @Root() publicPolitic: PublicPolitic,
    ): Promise<PublicPoliticComponent[] | null> {

        return prisma.publicPolitic.findUnique({
            where: {
                id: publicPolitic.id
            }
        }).components();
    }

    @FieldResolver(() => [Goal], { nullable: true })
    async goals(
        @Root() publicPolitic: PublicPolitic,
    ): Promise<Goal[] | null> {
        return prisma.publicPolitic.findUnique({
            where: {
                id: publicPolitic.id
            }
        }).publicPoliticGoals();
    }

    @FieldResolver(() => Int)
    async goalCount(
        @Root() publicPolitic: PublicPolitic,
    ): Promise<number> {
        return (await prisma.publicPolitic.findUnique({
            where: {
                id: publicPolitic.id
            }
        }).publicPoliticGoals())?.length ?? 0;
    }

    @Query(() => [PublicPolitic])
    async getPublicPolitics(@Ctx() ctx: Context): Promise<PublicPolitic[]> {
        const result = await prisma.publicPolitic.findMany({
            where: {
                tenantId: this.getContextTenantId(ctx)
            }
        });
        return result;
    }

    @Query(() => PublicPolitic, { nullable: true })
    async getPublicPolitic(@Arg("id", () => Int) id: number): Promise<PublicPolitic | null> {
        return await prisma.publicPolitic.findUnique({ where: { id } });
    }

    @Query(() => SearchPublicPoliticResponse)
    async searchPublicPolitics(@Arg("data") data: SearchPublicPolitic, @Ctx() ctx: Context): Promise<SearchPublicPoliticResponse> {
        const {
            limit,
            offset = 0,
            sort,
            text,
            categories,
            ...searchData
        } = data || {};

        const where = {
            ...searchData,
            tenantId: this.getContextTenantId(ctx),
            ...(categories
                ? {
                    category: {
                        in: categories,
                    },
                }
                : {}),
            ...(text ? {
                OR: [
                    { code: { contains: text } },
                    { name: { contains: text } },
                    { description: { contains: text } },
                ]
            } : {}),
        };

        let orderBy: Prisma.PublicPoliticOrderByWithRelationInput | undefined = undefined;
        if (sort?.field && sort?.order) {
            orderBy = { [sort.field]: sort.order };

        }

        const result = await prisma.publicPolitic.findMany({
            where,
            ...(limit ? { take: limit } : {}),
            skip: offset,
            orderBy: orderBy ?? [{ id: "asc" }],
        });

        // Total records
        const countItems = await prisma.publicPolitic.count({
            where,
        });

        return { items: result, count: countItems };
    }

    @Mutation(() => PublicPolitic)
    async createPublicPolitic(@Arg("data") data: CreatePublicPolitic, @Ctx() ctx: Context): Promise<PublicPolitic> {
        const {
            componentIds,
            ...inserData
        } = data;
        return await prisma.publicPolitic.create({
            data: {
                ...inserData,
                tenantId: this.getContextTenantId(ctx),
                category: data.category ?? PublicPoliticCategory.TERRITORY,
                components: {
                    connect: componentIds?.map(id => ({ id }))
                }
            },

        });
    }

    @Mutation(() => PublicPolitic)
    async updatePublicPolitic(@Arg("data") data: UpdatePublicPolitic): Promise<PublicPolitic> {
        const { id, componentIds, ...updateData } = data;
        const existingComponentIds = (await prisma.publicPolitic.findUnique({
            where: {
                id
            },
        }).components())?.map(component => component.id) ?? [];
        const deletedComponentIds = _.difference(existingComponentIds, componentIds ?? []);
        const newComponentIds = _.difference(componentIds ?? [], existingComponentIds);

        return await prisma.publicPolitic.update({
            where: { id },
            data: {
                ...updateData,
                components: {
                    connect: newComponentIds?.map(id => ({ id })),
                    disconnect: deletedComponentIds?.map(id => ({ id })),
                }
            },
        });
    }

    @Mutation(() => PublicPolitic)
    async deletePublicPolitic(@Arg("id", () => Int) id: number): Promise<PublicPolitic | null> {
        return await prisma.publicPolitic.delete({
            where: { id },
        });
    }
}
