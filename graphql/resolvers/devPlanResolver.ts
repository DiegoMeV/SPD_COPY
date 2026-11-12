import { Resolver, Query, Mutation, Arg, Int, Ctx, Root, FieldResolver } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { DevPlan, CreateDevPlan, UpdateDevPlan, DevPlanLevel } from "../types/";
import prisma from "../../lib/prisma";
import type { Context } from "../types/common";
import { CopyDevPlan } from "../types/devPlan";
import {
  EjeEstructuranteResolver,
  ProgramaPryResolver,
  SectorResolver,
  SubprogramaPryResolver,
} from "./siif";

@Resolver(() => DevPlan)
export class DevPlanResolver extends SPDResolver {
  @FieldResolver(() => [DevPlanLevel], { nullable: true })
  async levels(@Root() devPlan: DevPlan): Promise<DevPlanLevel[] | null> {
    const result = await prisma.devPlan
      .findUnique({
        where: {
          id: devPlan.id,
        },
      })
      .devPlanLevels({
        orderBy: {
          code: "asc",
        },
      });
    return result;
  }

  @Query(() => [DevPlan])
  async getDevPlans(@Ctx() ctx: Context): Promise<DevPlan[]> {
    const result = await prisma.devPlan.findMany({
      where: {
        tenantId: this.getContextTenantId(ctx),
      },
      orderBy: {
        startDate: "desc",
      },
    });
    return result;
  }

  @Query(() => DevPlan, { nullable: true })
  async getDevPlan(@Arg("id", () => Int) id: number): Promise<DevPlan | null> {
    const result = await prisma.devPlan.findUnique({ where: { id } });
    return result;
  }

  @Query(() => DevPlan, { nullable: true })
  async getDevPlanByCode(
    @Arg("code", () => String) code: string,
    @Ctx() ctx: Context,
  ): Promise<DevPlan | null> {
    const result = await prisma.devPlan.findFirst({
      where: {
        code,
        tenantId: this.getContextTenantId(ctx),
      },
    });
    return result;
  }

  @Mutation(() => DevPlan)
  async createDevPlan(@Arg("data") data: CreateDevPlan, @Ctx() ctx: Context): Promise<DevPlan> {
    return await prisma.devPlan.create({
      data: {
        ...data,
        tenantId: this.getContextTenantId(ctx),
        createdBy: this.getContextUserId(ctx),
        updatedBy: this.getContextUserId(ctx),
      },
    });
  }

  @Mutation(() => DevPlan)
  async updateDevPlan(@Arg("data") data: UpdateDevPlan, @Ctx() ctx: Context): Promise<DevPlan> {
    const { id, ...updateData } = data;
    return await prisma.devPlan.update({
      where: { id },
      data: {
        ...updateData,
        updatedBy: this.getContextUserId(ctx),
      },
    });
  }

  @Mutation(() => DevPlan)
  async deleteDevPlan(@Arg("id", () => Int) id: number): Promise<DevPlan | null> {
    return await prisma.devPlan.delete({
      where: { id },
    });
  }

  @Mutation(() => DevPlan, { nullable: true })
  async copyDevPlan(@Arg("data") data: CopyDevPlan, @Ctx() ctx: Context): Promise<DevPlan | null> {
    // Make sure destination devPlan is empty (has no levels)
    const levels = await prisma.devPlan
      .findUnique({
        where: {
          id: data.toId,
        },
      })
      .devPlanLevels();
    if (levels?.length) {
      throw new Error("El plan de desarrollo destino no está vacío.");
    }
    // Get data from source devPlan (SIIF)
    // First level
    const ejeResolver = new EjeEstructuranteResolver();
    let ejes = await ejeResolver.getEjes(data.fromCode, ctx);
    const firstLevelRecords = await prisma.devPlanLevel.createManyAndReturn({
      data: ejes.map((eje) => ({
        code: `${eje.codigo ?? eje.eje}`,
        name: eje.nombre,
        devPlanId: data.toId,
        level: 1,
        originId: eje.id,
      })),
    });

    // Third level
    const sectoreResolver = new SectorResolver();
    const programaResolver = new ProgramaPryResolver();
    const subprogramaResolver = new SubprogramaPryResolver();
    await Promise.all(
      ejes.map(async (eje) => {
        let sectores = await sectoreResolver.getSectores(data.fromCode, eje.eje, ctx);
        // Create second level records
        const secondLevelRecords = await prisma.devPlanLevel.createManyAndReturn({
          data: sectores.map((sector) => ({
            code: `${sector.codigo ?? sector.sector}`,
            name: sector.nombre,
            devPlanId: data.toId,
            parentId: firstLevelRecords.find((r) => r.originId === eje.id)?.id,
            level: 2,
            originId: sector.id,
          })),
        });
        return await Promise.all(
          sectores.map(async (sector) => {
            let programas = await programaResolver.getProgramas(
              data.fromCode,
              eje.eje,
              sector.sector,
              ctx,
            );
            // Create third level records
            const thirdLevelRecords = await prisma.devPlanLevel.createManyAndReturn({
              data: programas.map((programa) => ({
                code: `${programa.codigo ?? programa.programa}`,
                name: programa.nombre,
                devPlanId: data.toId,
                parentId: secondLevelRecords.find((r) => r.originId === sector.id)?.id,
                level: 3,
                originId: programa.id,
              })),
            });
            // Create fourth level records
            return await Promise.all(
              programas.map(async (programa) => {
                let subprogramas = await subprogramaResolver.getSubprogramas(
                  data.fromCode,
                  eje.eje,
                  sector.sector,
                  programa.programa,
                  ctx,
                );
                return await prisma.devPlanLevel.createManyAndReturn({
                  data: subprogramas.map((subprograma) => ({
                    code: `${subprograma.codigo ?? subprograma.subprograma}`,
                    name: subprograma.nombre,
                    devPlanId: data.toId,
                    parentId: thirdLevelRecords.find((r) => r.originId === programa.id)?.id,
                    level: 4,
                    originId: subprograma.id,
                  })),
                });
              }),
            );
          }),
        );
      }),
    );

    return prisma.devPlan.findUnique({ where: { id: data.toId } });
  }
}
