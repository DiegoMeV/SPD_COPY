import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function getTenantByKey(tenantKey: string) {
  const dbTenant = await prisma.tenant.findFirst({
    where: {
      key: tenantKey,
    },
  });
  return dbTenant;
}

export { getTenantByKey };
