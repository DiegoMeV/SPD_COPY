import { Resolver, Query, Mutation, FieldResolver, Arg, Int, Root, Ctx } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { GoalHistory, CreateGoalHistory, UserAccount, MonitoringRecord } from "../types";
import prisma from "../../lib/prisma";
import type { Context } from "../types/common";
import { MonitoringRecordService } from "../../lib/services";

@Resolver(() => GoalHistory)
export class GoalHistoryResolver extends SPDResolver {
  @FieldResolver(() => UserAccount, { nullable: true })
  async createdByAccount(@Root() goalHistory: GoalHistory): Promise<UserAccount | null> {
    if (goalHistory.createdBy)
      return prisma.userAccount.findUnique({
        where: {
          id: goalHistory.createdBy,
        },
      });
    return null;
  }

  @FieldResolver(() => MonitoringRecord, { nullable: true })
  async monitoringRecord(@Root() goalHistory: GoalHistory): Promise<MonitoringRecord | null> {
    if (goalHistory.monitoringRecordId)
      return MonitoringRecordService.instance.getMonitoringRecord({
        id: goalHistory.monitoringRecordId,
      });
    return null;
  }

  @Query(() => [GoalHistory], { nullable: true })
  async getGoalHistory(@Arg("goalId", () => Int) goalId: number): Promise<GoalHistory[] | null> {
    return await prisma.goalHistory.findMany({ where: { goalId } });
  }

  @Mutation(() => GoalHistory)
  async createGoalHistory(
    @Arg("data") data: CreateGoalHistory,
    @Ctx() ctx: Context,
  ): Promise<GoalHistory> {
    return await prisma.goalHistory.create({
      data: {
        ...data,
        createdBy: this.getContextUserId(ctx),
      },
    });
  }
}
