import { DevPlan, MonitoringConfig } from "../../graphql/types";
import prisma from "../prisma";
import { MonitoringResourcesOrigin, Prisma } from "@prisma/client";

export class MonitoringConfigService {
  private static _instance: MonitoringConfigService | undefined;

  private constructor() {}

  static get instance() {
    if (this._instance === undefined) {
      this._instance = new this();
    }
    return this._instance;
  }

  async getMonitoringConfigById({
    id,
    include,
  }: {
    id: number;
    include?: Prisma.MonitoringConfigFindUniqueOrThrowArgs["include"];
  }): Promise<MonitoringConfig & { devPlan?: DevPlan | null }> {
    const monitoringConfig = await prisma.monitoringConfig.findUniqueOrThrow({
      where: {
        id,
      },
      include,
    });
    return monitoringConfig;
  }

  supportUserResources(monitoringConfig: MonitoringConfig): boolean {
    return (
      monitoringConfig.monitoringResourcesOrigin === MonitoringResourcesOrigin.USER ||
      monitoringConfig.monitoringResourcesOrigin === MonitoringResourcesOrigin.USER_AND_FINANCIAL
    );
  }

  supportFinancialResources(monitoringConfig: MonitoringConfig): boolean {
    return (
      monitoringConfig.monitoringResourcesOrigin === MonitoringResourcesOrigin.FINANCIAL ||
      monitoringConfig.monitoringResourcesOrigin === MonitoringResourcesOrigin.USER_AND_FINANCIAL
    );
  }
}
