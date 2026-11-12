import { MonitoringConfig, PrismaClient, Prisma } from "@prisma/client";
import { data } from "../seedData";
import { getTenantByKey } from "./utils";

const prisma = new PrismaClient();

async function seedMonitoringConfigs(tenantKey: string) {
  const monitoringConfigs = data[tenantKey].monitoringConfigs;
  const tenant = await getTenantByKey(tenantKey);

  if (!tenant) {
    console.error(`[seedMonitoringConfigs] Tenant ${tenantKey} not found`);
    return;
  }

  if (typeof monitoringConfigs === "function") {
    const monitoringConfigsData = await monitoringConfigs();
    console.log(
      `[seedMonitoringConfigs] Number of monitoringConfigs to create: ${monitoringConfigsData.length}`,
    );
    const result = (
      await Promise.all(
        monitoringConfigsData.map(async (monitoringConfig: Partial<MonitoringConfig>) => {
          const existingMonitoringConfig = await prisma.monitoringConfig.findFirst({
            where: {
              devPlanId: monitoringConfig.devPlanId,
              period: monitoringConfig.period,
              subperiod: monitoringConfig.subperiod,
            },
          });
          if (!existingMonitoringConfig) {
            const result = await prisma.monitoringConfig.create({
              data: {
                ...monitoringConfig,
                tenantId: tenant.id,
              } as Prisma.MonitoringConfigCreateInput,
            });
            return result.id;
          }
          return undefined;
        }),
      )
    ).filter((id) => id !== undefined);
    console.log(`[seedMonitoringConfigs] Number of monitoringConfigs created: ${result.length}`);
  }
}

export { seedMonitoringConfigs };
