import { Resolver, Query, Arg, Int } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { Unit } from "../types";
import prisma from "../../lib/prisma";

@Resolver()
export class UnitResolver extends SPDResolver {
    @Query(() => [Unit])
    async getUnits(): Promise<Unit[]> {
        const result = await prisma.unit.findMany({ orderBy: { id: "asc" } });
        return result;
    }

    @Query(() => Unit, { nullable: true })
    async getUnit(@Arg("id", () => Int) id: number): Promise<Unit | null> {
        return await prisma.unit.findUnique({ where: { id } });
    }
}
