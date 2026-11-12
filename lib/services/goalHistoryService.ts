import { CreateGoalHistory, GoalHistory } from "../../graphql/types";
import prisma from "../prisma";

export class GoalHistoryService {
  private static _instance: GoalHistoryService | undefined;

  private constructor() {}

  static get instance() {
    if (this._instance === undefined) {
      this._instance = new this();
    }
    return this._instance;
  }

  async createGoalHistory(data: CreateGoalHistory): Promise<GoalHistory> {
    return prisma.goalHistory.create({
      data,
    });
  }
}
