import { Resolver, Query, Mutation, Arg, Ctx, Int, FieldResolver, Root } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { SiifActividad, CreateSiifActividad, UpdateSiifActividad, DeleteSiifActividad, SiifActividadMeta } from "../types";
import prisma from "../../lib/prisma";
import type { Context } from "../types/common";

@Resolver(() => SiifActividad)
export class SiifActividadResolver extends SPDResolver {
    @FieldResolver(() => [SiifActividadMeta], { nullable: true })
    async siifActividadMetas(
        @Root() siifActividad: SiifActividad,
    ): Promise<SiifActividadMeta[] | null> {
        return prisma.siifActividad.findUnique({
            where: {
                uqSiifActividad: {
                    nitCompania: siifActividad.nitCompania,
                    proyecto: siifActividad.proyecto,
                    codigoAct: siifActividad.codigoAct
                }
            }
        }).siifActividadMetas();
    }

    @Query(() => [SiifActividad])
    async getSiifActividades(@Arg("proyecto", () => String) proyecto: string, @Ctx() ctx: Context): Promise<SiifActividad[]> {
        const result = await prisma.siifActividad.findMany({
            where: {
                nitCompania: this.getContextTenantKey(ctx),
                proyecto
            }
        });
        return result;
    }

    @Query(() => SiifActividad, { nullable: true })
    async getSiifActividadById(@Arg("id", () => Int) id: number, @Ctx() ctx: Context): Promise<SiifActividad | null> {
        return await prisma.siifActividad.findFirst({
            where:
            {
                id
            }
        });
    }

    @Query(() => SiifActividad, { nullable: true })
    async getSiifActividadByCode(@Arg("proyecto", () => String) proyecto: string, @Arg("codigoAct", () => Int) codigoAct: number, @Ctx() ctx: Context): Promise<SiifActividad | null> {
        return await prisma.siifActividad.findUnique({
            where:
            {
                uqSiifActividad: {
                    nitCompania: this.getContextTenantKey(ctx),
                    proyecto,
                    codigoAct
                }
            }
        });
    }

    @Mutation(() => SiifActividad)
    async createSiifActividad(@Arg("data") data: CreateSiifActividad): Promise<SiifActividad> {
        return await prisma.siifActividad.create({
            data: {
                ...data,
            },
        });
    }

    @Mutation(() => SiifActividad)
    async updateSiifActividad(@Arg("data") data: UpdateSiifActividad): Promise<SiifActividad> {
        const { nitCompania, proyecto, codigoAct, ...updateData } = data;
        return await prisma.siifActividad.update({
            where:
            {
                uqSiifActividad: {
                    nitCompania,
                    proyecto,
                    codigoAct
                }
            },
            data: updateData,
        });
    }

    @Mutation(() => SiifActividad)
    async deleteSiifActividad(@Arg("data") data: DeleteSiifActividad, @Ctx() ctx: Context): Promise<SiifActividad | null> {
        return await prisma.siifActividad.delete({
            where:
            {
                uqSiifActividad: data
            }
        });
    }
}
