import { Resolver, Query, Mutation, Arg, Int, FieldResolver, Root } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import {
  DevPlanLevel,
  CreateDevPlanLevel,
  UpdateDevPlanLevel,
  SearchDevPlanLevel,
  GoalTypeCount,
  DevPlan,
} from "../types/";
import prisma from "../../lib/prisma";
import { JsonObject } from "../types/common";
import { GoalType } from "../gen/schema";

type DevPlanConfigLevel = {
  number: number;
  singularName: string;
  pluralName: string;
};

type DevPlanConfig = {
  levels: DevPlanConfigLevel[];
};

@Resolver(() => DevPlanLevel)
export class DevPlanLevelResolver extends SPDResolver {
  // Tags for singular and plural
  // @FieldResolver(() => [String])
  // async tags(
  //     @Root() devPlanLevel: DevPlanLevel,
  // ): string[] {
  //     // Get dev plan config
  //     const devPlan = await prisma.devPlan.findUnique({ where: { id: devPlanLevel.devPlanId } });
  //     if (!devPlan) throw new Error(`No se ha encontrado el plan de desarrollo ID: ${devPlanLevel.devPlanId}`);
  //     const config: DevPlanConfig = (devPlan.config || {}) as JsonObject;

  // }

  @FieldResolver(() => DevPlan, { nullable: true })
  async devPlan(@Root() devPlanLevel: DevPlanLevel): Promise<DevPlan | null> {
    if (devPlanLevel.devPlanId)
      return await prisma.devPlanLevel
        .findUnique({
          where: {
            id: devPlanLevel.id,
          },
        })
        .devPlan();
    return null;
  }

  @FieldResolver(() => [GoalTypeCount])
  async goalCount(@Root() devPlanLevel: DevPlanLevel): Promise<GoalTypeCount[]> {
    if (devPlanLevel.level === 0) return [];
    const goals = await prisma.devPlanLevel
      .findUnique({
        where: {
          id: devPlanLevel.id,
        },
      })
      .goals({
        select: {
          goalType: true,
        },
      });
    const countByGoalType: Partial<Record<GoalType, number>> = {};
    goals?.forEach((goal) => {
      countByGoalType[goal.goalType] = (countByGoalType[goal.goalType] ?? 0) + 1;
    });
    return Object.entries(countByGoalType).map(([k, v]) => ({ goalType: k as GoalType, count: v }));
  }

  @FieldResolver(() => String)
  key(@Root() devPlanLevel: DevPlanLevel): string {
    return `${devPlanLevel.id}`;
  }

  @FieldResolver(() => [DevPlanLevel])
  async children(@Root() devPlanLevel: DevPlanLevel): Promise<DevPlanLevel[] | null> {
    if (devPlanLevel.level === 0) {
      return await prisma.devPlanLevel.findMany({
        where: {
          devPlanId: devPlanLevel.devPlanId,
          parentId: null,
        },
        orderBy: { code: "asc" },
      });
    }
    return prisma.devPlanLevel
      .findUnique({
        where: {
          id: devPlanLevel.id,
        },
      })
      .childrenLevels({ orderBy: { code: "asc" } });
  }

  @FieldResolver(() => DevPlanLevel, { nullable: true })
  async parent(@Root() devPlanLevel: DevPlanLevel): Promise<DevPlanLevel | null> {
    if (devPlanLevel.parentId)
      return prisma.devPlanLevel.findUnique({ where: { id: devPlanLevel.parentId } });
    return null;
  }

  @Query(() => [DevPlanLevel])
  async getDevPlanLevels(@Arg("devPlanId", () => Int) devPlanId: number): Promise<DevPlanLevel[]> {
    const result = await prisma.devPlanLevel.findMany({
      where: {
        devPlanId,
      },
    });
    return result;
  }

  @Query(() => [DevPlanLevel])
  async getDevPlanLevelsTree(
    @Arg("devPlanId", () => Int) devPlanId: number,
    @Arg("getRootAsNode", () => Boolean, { defaultValue: false }) getRootAsNode: boolean,
  ): Promise<DevPlanLevel[]> {
    let result: DevPlanLevel[] = [];
    if (getRootAsNode) {
      const devPlan = await prisma.devPlan.findUnique({
        where: {
          id: devPlanId,
        },
      });

      if (devPlan) {
        result = [
          {
            id: devPlan.id,
            devPlanId: devPlan.id,
            code: devPlan.code,
            name: devPlan.name,
            isActive: devPlan.isActive,
            parentId: null,
            weighting: undefined,
            level: 0,
            productCatalogId: null,
            createdAt: devPlan.createdAt,
          },
        ];
      }
    } else {
      result = await prisma.devPlanLevel.findMany({
        where: {
          devPlanId,
          parentId: null,
        },
        orderBy: {
          code: "asc",
        },
      });
    }

    return result;
  }

  @Query(() => DevPlanLevel, { nullable: true })
  async getDevPlanLevel(@Arg("id", () => Int) id: number): Promise<DevPlanLevel | null> {
    const result = await prisma.devPlanLevel.findUnique({ where: { id } });
    return result;
  }

  @Query(() => [DevPlanLevel], { nullable: true })
  async searchDevPlanLevels(@Arg("data") data: SearchDevPlanLevel): Promise<DevPlanLevel[]> {
    const result = await prisma.devPlanLevel.findMany({ where: { ...data } });
    return result;
  }

  @Mutation(() => DevPlanLevel)
  async createDevPlanLevel(@Arg("data") data: CreateDevPlanLevel): Promise<DevPlanLevel> {
    return await prisma.devPlanLevel.create({
      data: {
        ...data,
      },
    });
  }

  @Mutation(() => DevPlanLevel)
  async updateDevPlanLevel(@Arg("data") data: UpdateDevPlanLevel): Promise<DevPlanLevel> {
    const { id, ...updateData } = data;
    return await prisma.devPlanLevel.update({
      where: { id },
      data: updateData,
    });
  }

  @Mutation(() => DevPlanLevel)
  async deleteDevPlanLevel(@Arg("id", () => Int) id: number): Promise<DevPlanLevel | null> {
    const devPlanLevelGoals = await prisma.devPlanLevel
      .findUnique({
        where: {
          id,
        },
      })
      .goals();
    if (devPlanLevelGoals?.length)
      throw new Error(`No se puede eliminar el nivel del plan, tiene metas asociadas`);

    const childrenLevels = await prisma.devPlanLevel
      .findUnique({
        where: {
          id,
        },
      })
      .childrenLevels();
    if (childrenLevels?.length)
      throw new Error(`No se puede eliminar el nivel del plan, tiene hijos asociados`);

    return await prisma.devPlanLevel.delete({
      where: { id },
    });
  }

  @Mutation(() => Int)
  async deleteDevPlanLevels(@Arg("ids", () => [Int]) ids: number[]): Promise<number | null> {
    const devPlanLevelGoals = await prisma.goal.findMany({
      where: {
        devPlanLevelId: { in: ids },
      },
    });
    if (devPlanLevelGoals?.length)
      throw new Error(`No se pueden eliminar los niveles del plan, tienen metas asociadas`);

    const result = await prisma.devPlanLevel.deleteMany({
      where: { id: { in: ids.reverse() } },
    });

    return result.count;
  }
}
