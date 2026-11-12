import { Resolver, Query, Mutation, Arg, Ctx, Int, FieldResolver, Root } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { SiifActividadMeta, CreateSiifActividadMeta, DeleteSiifActividadMetas, SiifActividadMetaAccion } from "../types";
import prisma from "../../lib/prisma";
import type { Context } from "../types/common";

@Resolver(() => SiifActividadMeta)
export class SiifActividadMetaResolver extends SPDResolver {

    @FieldResolver(() => [SiifActividadMetaAccion], { nullable: true })
    acciones(
        @Root() actividadMeta: SiifActividadMeta,
    ): Promise<SiifActividadMetaAccion[] | null> {
        return prisma.siifActividadMeta.findUnique({
            where: {
                id: actividadMeta.id
            }
        }).acciones();
    }

    @Query(() => [SiifActividadMeta])
    async getSiifActividadMetas(@Arg("proyecto", () => String) proyecto: string, @Arg("codigoAct", () => Int) codigoAct: number, @Ctx() ctx: Context): Promise<SiifActividadMeta[]> {
        const result = await prisma.siifActividadMeta.findMany({
            where: {
                nitCompania: this.getContextTenantKey(ctx),
                proyecto,

            }
        });
        return result;
    }

    @Mutation(() => [SiifActividadMeta])
    async saveSiifActividadMeta(@Arg("data", () => [CreateSiifActividadMeta]) data: CreateSiifActividadMeta[], @Ctx() ctx: Context): Promise<SiifActividadMeta[]> {
        const { nitCompania = "", proyecto = "", codigoAct = 0 } = data?.length ? data[0] : {};
        const weightingTotal = data.map(record => record.weighting).reduce((accum, value) => accum + value, 0);
        if (weightingTotal !== 100.0) {
            throw new Error(`El total de ponderación de las metas vinculadas a la actividad debe ser 100%. Total actual: ${weightingTotal}%`);
        }
        // Delete
        await prisma.siifActividadMeta.deleteMany({
            where: {
                nitCompania,
                proyecto,
                codigoAct,
                id: { notIn: (data.filter(record => !!record.id).map(record => record.id) as number[]) }
            }
        });
        // Update
        await Promise.all(data.filter(record => !!record.id).map(async (record) => {
            await prisma.siifActividadMeta.update({
                where: {
                    id: record.id
                },
                data: record
            })
        }));
        // Insert
        await prisma.siifActividadMeta.createMany({
            data: data.filter(record => !record.id)
        });

        return this.getSiifActividadMetas(data?.[0]?.proyecto, data?.[0]?.codigoAct, ctx);
    }

    @Mutation(() => [SiifActividadMeta])
    async deleteSiifActividadMetas(@Arg("data", () => DeleteSiifActividadMetas) data: DeleteSiifActividadMetas, @Ctx() ctx: Context): Promise<SiifActividadMeta[]> {
        const { nitCompania = "", proyecto = "", codigoAct = 0 } = data;
        // Delete
        await prisma.siifActividadMeta.deleteMany({
            where: {
                nitCompania,
                proyecto,
                codigoAct,
            }
        });

        return this.getSiifActividadMetas(proyecto, codigoAct, ctx);
    }
}
