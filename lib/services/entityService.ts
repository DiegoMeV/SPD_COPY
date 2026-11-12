import { Entity, Goal } from "../../graphql/types";
import prisma from "../prisma";

export class EntityService {
  private static _instance: EntityService | undefined;

  private constructor() {}

  static get instance() {
    if (this._instance === undefined) {
      this._instance = new this();
    }
    return this._instance;
  }

  async getEntity({
    tenantKey,
    code,
    goal,
  }: {
    tenantKey?: string;
    code?: string;
    goal?: Goal;
  }): Promise<Entity | null> {
    if (tenantKey && code) {
      return prisma.entity.findFirst({
        where: {
          tenant: {
            key: tenantKey,
          },
          code,
        },
      });
    }
    if (goal?.entityId) {
      return prisma.goal
        .findUnique({
          where: {
            id: goal.id,
          },
        })
        .entity();
    }

    return null;
  }

  async getEntities({
    tenantKey,
    codes,
  }: {
    tenantKey: string;
    codes?: string[];
  }): Promise<Entity[]> {
    return prisma.entity.findMany({
      where: {
        tenant: {
          key: tenantKey,
        },
        ...(codes ? { code: { in: codes } } : {}),
      },
      orderBy: {
        name: "asc",
      },
    });
  }
}
