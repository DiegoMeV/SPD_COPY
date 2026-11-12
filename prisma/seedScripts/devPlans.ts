import { DateTime } from "luxon";
import { data } from "../seedData";
import { PrismaClient } from "@prisma/client";
import { getTenantByKey } from "./utils";

const prisma = new PrismaClient();

async function seedDevPlans(tenantKey: string) {
  const dbTenant = await getTenantByKey(tenantKey);
  if (!dbTenant) return;
  const dbDevPlans = await prisma.devPlan.findMany({
    where: {
      tenantId: dbTenant.id,
    },
  });
  console.log(
    `[seedDevPlans] Current number of dev plans for tenant key ${tenantKey}: ${dbDevPlans.length}`,
  );
  if (!dbDevPlans.length && Array.isArray(data[tenantKey].devPlans)) {
    const devPlansForInsert = (data[tenantKey].devPlans as Array<any>).map((devPlan) => {
      return {
        tenantId: dbTenant?.id || 0,
        code: devPlan.code,
        name: devPlan.name,
        startDate: DateTime.fromFormat(devPlan.startDate, "dd/MM/yy").toJSDate(),
        endDate: DateTime.fromFormat(devPlan.endDate, "dd/MM/yy").toJSDate(),
        governmentName: devPlan.governmentName,
        governmentStartDate: DateTime.fromFormat(
          devPlan.governmentStartDate,
          "dd/MM/yy",
        ).toJSDate(),
        governmentEndDate: DateTime.fromFormat(devPlan.governmentEndDate, "dd/MM/yy").toJSDate(),
        createdBy: 1,
        isActive: true,
        config: {
          levels: devPlan.levels,
        },
      };
    });
    console.log(
      `[seedDevPlans] Number of dev plans for tenant key ${tenantKey} to create: ${devPlansForInsert.length}`,
    );
    const result = await prisma.devPlan.createMany({
      data: devPlansForInsert,
    });
    console.log(
      `[seedDevPlans] Number of dev plans for tenant key ${tenantKey} created: ${result.count}`,
    );
  }
}

export { seedDevPlans };
