import { Resolver, Query, Arg, Int } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { Ods } from "../types";
import prisma from "../../lib/prisma";

@Resolver()
export class OdsResolver extends SPDResolver {
    @Query(() => [Ods])
    async getOdss(): Promise<Ods[]> {
        const result = await prisma.ods.findMany({ orderBy: { id: "asc" } });
        return result;
    }

    @Query(() => Ods, { nullable: true })
    async getOds(@Arg("id", () => Int) id: number): Promise<Ods | null> {
        return await prisma.ods.findUnique({ where: { id } });
    }
}
