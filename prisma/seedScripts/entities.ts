import { data } from "../seedData";
import { PrismaClient } from "@prisma/client";
import { getTenantByKey } from "./utils";

const prisma = new PrismaClient();

async function seedEntities(tenantKey: string) {
  const dbTenant = await getTenantByKey(tenantKey);
  if (!dbTenant) return;
  const dbEntities = await prisma.entity.findMany({
    where: {
      tenantId: dbTenant.id,
    },
  });
  console.log(
    `[seedEntities] Current number of entities for tenant key ${tenantKey}: ${dbEntities.length}`,
  );
  if (!dbEntities.length && Array.isArray(data[tenantKey].entities)) {
    const result = await prisma.entity.createMany({
      data: (data[tenantKey].entities as Array<any>)
        .filter((entity) => !!entity.name)
        .map((entity) => {
          const { tenantKey: _, id, ...entityData } = entity;
          return {
            ...entityData,
            originId: id,
            tenantId: dbTenant.id,
          };
        }),
    });
    console.log(
      `[seedEntities] Number of entities for tenant key ${tenantKey} created: ${result.count}`,
    );
  }
}

export { seedEntities };
