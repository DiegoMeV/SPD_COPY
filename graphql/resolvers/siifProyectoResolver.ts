import { Resolver, Query, Mutation, Arg, Ctx, FieldResolver, Root } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { SiifProyecto, CreateSiifProyecto, UpdateSiifProyecto, DeleteSiifProyecto, SearchSiifProyectoResponse, SearchSiifProyecto, Entity, SiifActividad } from "../types";
import prisma from "../../lib/prisma";
import type { Context } from "../types/common";
import { Prisma } from "@prisma/client";


@Resolver(() => SiifProyecto)
export class SiifProyectoResolver extends SPDResolver {
    @FieldResolver(() => Entity, { nullable: true })
    async entity(
        @Root() siifProyecto: SiifProyecto,
    ): Promise<Entity | null> {
        if (siifProyecto.codigoEntPry)
            return prisma.entity.findFirst({
                where: {
                    tenant: {
                        key: siifProyecto.nitCompania,
                    },
                    code: siifProyecto.codigoEntPry
                }
            });
        return null;
    }

    @FieldResolver(() => [SiifActividad], { nullable: true })
    async actividades(
        @Root() siifProyecto: SiifProyecto,
    ): Promise<SiifActividad[] | null> {
        return prisma.siifProyecto.findUnique({
            where: {
                id: siifProyecto.id
            }
        }).actividades({
            orderBy: { "codigoAct": "asc" }
        });
    }

    @Query(() => [SiifProyecto])
    async getSiifProyectos(@Ctx() ctx: Context): Promise<SiifProyecto[]> {
        const result = await prisma.siifProyecto.findMany({
            where: {
                nitCompania: this.getContextTenantKey(ctx)
            }
        });
        return result;
    }

    @Query(() => SiifProyecto, { nullable: true })
    async getSiifProyecto(@Arg("proyecto", () => String) proyecto: string, @Ctx() ctx: Context): Promise<SiifProyecto | null> {
        return await prisma.siifProyecto.findUnique({
            where:
            {
                uqSiifProyecto: {
                    nitCompania: this.getContextTenantKey(ctx),
                    proyecto,
                }
            }
        });
    }

    @Mutation(() => SiifProyecto)
    async createSiifProyecto(@Arg("data") data: CreateSiifProyecto): Promise<SiifProyecto> {
        return await prisma.siifProyecto.create({
            data: {
                ...data,
            },
        });
    }

    @Mutation(() => SiifProyecto)
    async updateSiifProyecto(@Arg("data") data: UpdateSiifProyecto): Promise<SiifProyecto> {
        const { nitCompania, proyecto, ...updateData } = data;
        return await prisma.siifProyecto.update({
            where:
            {
                uqSiifProyecto: {
                    nitCompania,
                    proyecto,
                }
            },
            data: updateData,
        });
    }

    @Mutation(() => SiifProyecto)
    async deleteSiifProyecto(@Arg("data") data: DeleteSiifProyecto, @Ctx() ctx: Context): Promise<SiifProyecto | null> {
        return await prisma.siifProyecto.delete({
            where:
            {
                uqSiifProyecto: data
            }
        });
    }

    @Query(() => SearchSiifProyectoResponse, { nullable: true })
    async searchSiifProyectos(@Arg("data") data: SearchSiifProyecto, @Ctx() ctx: Context): Promise<SearchSiifProyectoResponse> {
        const {
            limit,
            offset = 0,
            sort,
            proyecto,
            nombre,
            codigosEntPry,
            ...searchData
        } = data || {};

        const where = {
            ...searchData,
            nitCompania: this.getContextTenantKey(ctx),
            ...(proyecto ? { proyecto: { contains: proyecto } } : {}),
            ...(nombre ? { nombre: { contains: nombre } } : {}),
            ...(codigosEntPry
                ? {
                    codigoEntPry: {
                        in: codigosEntPry,
                    },
                }
                : {}),
        };

        let orderBy: Prisma.UserAccountOrderByWithRelationInput | undefined = undefined;
        if (sort?.field && sort?.order) {
            orderBy = { [sort.field]: sort.order };
        }

        const result = await prisma.siifProyecto.findMany({
            where,
            ...(limit ? { take: limit } : {}),
            skip: offset,
            orderBy: orderBy ?? [{ proyecto: "asc" }],
        });

        // Total records
        const countItems = await prisma.siifProyecto.count({
            where,
        });

        return { items: result, count: countItems };
    }
}
