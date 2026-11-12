import { DevPlan } from "../../graphql/types";
import prisma from "../prisma";

export class DevPlanService {
  private static _instance: DevPlanService | undefined;

  private constructor() {}

  static get instance() {
    if (this._instance === undefined) {
      this._instance = new this();
    }
    return this._instance;
  }

  async getDevPlan({
    id,
    tenantKey,
    code,
  }: {
    id?: number;
    tenantKey?: string;
    code?: string;
  }): Promise<DevPlan | null> {
    if (id) {
      return prisma.devPlan.findUnique({
        where: {
          id,
        },
      });
    }
    if (tenantKey && code) {
      return prisma.devPlan.findFirst({
        where: {
          tenant: {
            key: tenantKey,
          },
          code,
        },
      });
    }
    return null;
  }
}
