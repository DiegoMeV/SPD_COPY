import { GoalToActivity } from "../../graphql/types";
import prisma from "../prisma";

export class GoalActivityService {
  private static _instance: GoalActivityService | undefined;

  private constructor() {}

  static get instance() {
    if (this._instance === undefined) {
      this._instance = new this();
    }
    return this._instance;
  }

  async getGoalsToActivities({
    tenantKey,
    goalIds,
    activityIds,
  }: {
    tenantKey: string;
    goalIds?: number[];
    activityIds?: number[];
  }): Promise<GoalToActivity[]> {
    return prisma.goalToActivity.findMany({
      where: {
        tenant: {
          key: tenantKey,
        },
        ...(goalIds ? { id: { in: goalIds } } : {}),
        ...(activityIds ? { activityId: { in: activityIds } } : {}),
      },
    });
  }
}
