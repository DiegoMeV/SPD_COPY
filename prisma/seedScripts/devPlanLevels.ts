import { data } from "../seedData";
import { PrismaClient, Prisma } from "@prisma/client";
import { getTenantByKey } from "./utils";

const prisma = new PrismaClient();

async function seedDevPlanLevel({
  level,
  tenantKey,
  data,
}: {
  level: number;
  tenantKey: string;
  data: Array<any>;
}) {
  // Tenant
  const dbTenant = await getTenantByKey(tenantKey);
  if (!dbTenant) {
    console.log("[seedDevPlanLevels] No tenant found", tenantKey);
    return;
  }

  // Dev Plans
  const dbDevPlans = await prisma.devPlan.findMany({
    where: {
      tenantId: dbTenant.id,
    },
  });
  const getDevPlanId = (code: string) =>
    dbDevPlans?.find((devPlan) => devPlan.code === `${code}`)?.id ?? 0;
  if (!dbDevPlans.length) {
    console.log("[seedDevPlanLevels] No dev plans found", tenantKey);
    return;
  }

  // Dev Plan Levels
  const previousLevelRecords = await prisma.devPlanLevel.findMany({
    where: {
      devPlan: {
        tenantId: dbTenant.id,
      },
      level: level - 1,
    },
  });

  const getParentId = (devPlanId: number, code: string) => {
    const parentCode = code.split(".").slice(0, -1).join(".");
    const parentRecord = previousLevelRecords.find(
      (previousLevelRecord) =>
        previousLevelRecord.devPlanId === devPlanId && previousLevelRecord.code === parentCode,
    );
    return parentRecord?.id ?? null;
  };

  const devPlanLevelsForInsert: Prisma.DevPlanLevelCreateManyInput[] = data
    .filter((devPlanLevel) => devPlanLevel.level === level)
    .map((devPlanLevel) => {
      const devPlanId = getDevPlanId(devPlanLevel.devPlanCode);
      const code = devPlanLevel.fullCode ?? `${devPlanLevel.code}`;
      return {
        originId: devPlanLevel.id,
        devPlanId,
        code,
        name: devPlanLevel.name,
        parentId: getParentId(devPlanId, code),
        isActive: true,
        level,
      };
    })
    .filter((devPlanLevel) => devPlanLevel.devPlanId);
  console.log(
    `[seedDevPlanLevels] Number of dev plan records on level ${level} for tenant key ${tenantKey} to create: ${devPlanLevelsForInsert.length}`,
  );
  const result = await prisma.devPlanLevel.createMany({
    data: devPlanLevelsForInsert,
  });
  console.log(
    `[seedDevPlanLevels] Number of dev plan records on level ${level} for tenant key ${tenantKey} created: ${result.count}`,
  );
}

async function seedDevPlanLevels(tenantKey: string) {
  const dbTenant = await getTenantByKey(tenantKey);
  if (!dbTenant) {
    console.log("[seedDevPlanLevels] No tenant found", tenantKey);
    return;
  }

  const dbDevPlanLevels = await prisma.devPlanLevel.findMany({
    where: {
      devPlan: {
        tenantId: dbTenant.id,
      },
    },
  });
  console.log(
    "[seedDevPlanLevels] Current number of dev plan levels found",
    dbDevPlanLevels.length,
  );
  if (!dbDevPlanLevels.length && Array.isArray(data[tenantKey].devPlanLevels)) {
    // Insert dev plan levels starting with smallest level
    for (let level = 1; level <= 4; level++) {
      await seedDevPlanLevel({
        level,
        tenantKey,
        data: data[tenantKey].devPlanLevels as Array<any>,
      });
    }
  }
}

export { seedDevPlanLevels };
