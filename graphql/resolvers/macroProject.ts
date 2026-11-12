import { Resolver, Query, Mutation, Arg, Int, Ctx } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { MacroProject, CreateMacroProject, UpdateMacroProject } from "../types";
import prisma from "../../lib/prisma";
import type { Context } from "../types/common";

@Resolver()
export class MacroProjectResolver extends SPDResolver {
    @Query(() => [MacroProject])
    async getMacroProjects(@Ctx() ctx: Context): Promise<MacroProject[]> {
        const result = await prisma.macroProject.findMany({
            where: {
                tenantId: this.getContextTenantId(ctx)
            }
        });
        return result;
    }

    @Query(() => MacroProject, { nullable: true })
    async getMacroProject(@Arg("id", () => Int) id: number): Promise<MacroProject | null> {
        return await prisma.macroProject.findUnique({ where: { id } });
    }

    @Mutation(() => MacroProject)
    async createMacroProject(@Arg("data") data: CreateMacroProject, @Ctx() ctx: Context): Promise<MacroProject> {
        return await prisma.macroProject.create({
            data: {
                ...data,
                tenantId: this.getContextTenantId(ctx),
            },
        });
    }

    @Mutation(() => MacroProject)
    async updateMacroProject(@Arg("data") data: UpdateMacroProject): Promise<MacroProject> {
        const { id, ...updateData } = data;
        return await prisma.macroProject.update({
            where: { id },
            data: updateData,
        });
    }

    @Mutation(() => MacroProject)
    async deleteMacroProject(@Arg("id", () => Int) id: number): Promise<MacroProject | null> {
        return await prisma.macroProject.delete({
            where: { id },
        });
    }
}
