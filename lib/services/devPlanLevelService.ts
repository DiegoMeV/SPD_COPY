import { DevPlanLevel, Goal } from "../../graphql/types";
import prisma from "../prisma";

export class DevPlanLevelService {
  private static _instance: DevPlanLevelService | undefined;

  private constructor() {}

  static get instance() {
    if (this._instance === undefined) {
      this._instance = new this();
    }
    return this._instance;
  }

  getDevPlanLevel = async ({
    devPlanId,
    code,
    parentId,
    goal,
  }: {
    devPlanId?: number;
    code?: string;
    parentId?: number | null;
    goal?: Goal;
  }): Promise<DevPlanLevel | null> => {
    if (devPlanId && code) {
      return prisma.devPlanLevel.findFirst({
        where: {
          devPlanId,
          parentId,
          code,
        },
      });
    }
    if (goal?.devPlanLevelId) {
      return prisma.goal
        .findUnique({
          where: {
            id: goal.id,
          },
        })
        .devPlanLevel();
    }

    return null;
  };

  getDevPlanLevels = async ({
    devPlanId,
    codes,
    parentId,
  }: {
    devPlanId: number;
    codes?: string[];
    parentId?: number | null;
  }): Promise<DevPlanLevel[]> => {
    return prisma.devPlanLevel.findMany({
      where: {
        devPlanId,
        parentId,
        ...(codes ? { code: { in: codes } } : {}),
      },
    });
  };
}
