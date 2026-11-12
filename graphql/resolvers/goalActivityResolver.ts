import { Resolver, Query, Mutation, Arg, Int, Ctx, Root, FieldResolver, Field } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { Goal, GoalToActivity, LinkGoalToActivity, VActividadesPry } from "../types/";
import prisma from "../../lib/prisma";
import type { Context } from "../types/common";

@Resolver(() => GoalToActivity)
export class GoalActivityResolver extends SPDResolver {
  @FieldResolver(() => Goal)
  async goal(@Root() goalToActivity: GoalToActivity): Promise<Goal | null> {
    return await prisma.goal.findUnique({
      where: {
        id: goalToActivity.goalId,
      },
    });
  }

  @Mutation(() => GoalToActivity)
  async linkGoalToActivity(
    @Arg("data") data: LinkGoalToActivity,
    @Ctx() ctx: Context,
  ): Promise<GoalToActivity> {
    const tenantId = this.getContextTenantId(ctx);
    const { id, ...linkData } = data;
    if (id) {
      return await prisma.goalToActivity.update({
        where: {
          id,
        },
        data: {
          ...linkData,
          tenantId,
        },
      });
    } else {
      return await prisma.goalToActivity.create({
        data: {
          ...linkData,
          tenantId,
          createdBy: this.getContextUserId(ctx),
        },
      });
    }
  }
}
