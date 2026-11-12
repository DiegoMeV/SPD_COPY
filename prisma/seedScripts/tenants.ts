import { PrismaClient } from "@prisma/client";
import { data } from "../seedData";

const prisma = new PrismaClient();

async function seedTenants() {
  if (Array.isArray(data.common.tenants)) {
    // current tenants
    const currentTenants = await prisma.tenant.findMany();
    // new tenants
    const newTenants = data.common.tenants.filter(
      (tenant) => !currentTenants.find((currentTenant) => currentTenant.key === tenant.key),
    );
    console.log(`[seedTenants] Number of tenants to create: ${newTenants.length}`);
    if (newTenants.length > 0) {
      const result = await prisma.tenant.createMany({
        data: newTenants,
      });
      console.log(`[seedTenants] Number of tenants crated: ${result.count}`);
    }
  }
}

export { seedTenants };
