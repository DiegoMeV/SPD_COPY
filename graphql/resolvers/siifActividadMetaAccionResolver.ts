import { Resolver, Query, Mutation, Arg, Ctx, Int } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { SiifActividadMetaAccion, CreateSiifActividadMetaAccion, DeleteSiifActividadMetaAcciones } from "../types";
import prisma from "../../lib/prisma";
import type { Context } from "../types/common";

@Resolver(() => SiifActividadMetaAccion)
export class SiifActividadMetaAccionResolver extends SPDResolver {

    @Query(() => [SiifActividadMetaAccion])
    async getSiifActividadMetaAcciones(@Arg("actividadMetaId", () => Int) actividadMetaId: number, @Ctx() ctx: Context): Promise<SiifActividadMetaAccion[]> {
        const result = await prisma.siifActividadMetaAccion.findMany({
            where: {
                actividadMetaId

            }
        });
        return result;
    }

    @Mutation(() => [SiifActividadMetaAccion])
    async saveSiifActividadMetaAccion(@Arg("data", () => [CreateSiifActividadMetaAccion]) data: CreateSiifActividadMetaAccion[], @Ctx() ctx: Context): Promise<SiifActividadMetaAccion[]> {
        const { actividadMetaId = 0 } = data?.length ? data[0] : {};
        // Delete
        await prisma.siifActividadMetaAccion.deleteMany({
            where: {
                actividadMetaId,
                id: { notIn: (data.filter(record => !!record.id).map(record => record.id) as number[]) }
            }
        });
        // Update
        await Promise.all(data.filter(record => !!record.id).map(async (record) => {
            await prisma.siifActividadMetaAccion.update({
                where: {
                    id: record.id
                },
                data: record
            })
        }));
        // Insert
        await prisma.siifActividadMetaAccion.createMany({
            data: data.filter(record => !record.id)
        });

        return this.getSiifActividadMetaAcciones(data?.[0]?.actividadMetaId, ctx);
    }

    @Mutation(() => [SiifActividadMetaAccion])
    async deleteSiifActividadMetaAcciones(@Arg("data", () => DeleteSiifActividadMetaAcciones) data: DeleteSiifActividadMetaAcciones, @Ctx() ctx: Context): Promise<SiifActividadMetaAccion[]> {
        // Delete
        await prisma.siifActividadMetaAccion.deleteMany({
            where: data
        });

        return this.getSiifActividadMetaAcciones(data.actividadMetaId, ctx);
    }
}
