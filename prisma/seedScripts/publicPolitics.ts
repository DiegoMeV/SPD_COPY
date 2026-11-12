import { PrismaClient, PublicPoliticCategory } from "@prisma/client";
import { data } from "../seedData";
import { getTenantByKey } from "./utils";

const prisma = new PrismaClient();

async function seedPublicPolitics(tenantKey: string) {
  const dbTenant = await getTenantByKey(tenantKey);
  if (!dbTenant) return;
  const dbPublicPolitics = await prisma.publicPolitic.findMany({
    where: {
      tenantId: dbTenant.id,
      category: { in: [PublicPoliticCategory.PEACE, PublicPoliticCategory.VICTIMS] },
    },
  });
  console.log(
    `[seedPublicPolitics] Current number of public politics for tenant key ${tenantKey}: ${dbPublicPolitics.length}`,
  );
  if (Array.isArray(data[tenantKey].publicPolitics)) {
    if (!dbPublicPolitics.length) {
      const result = await prisma.publicPolitic.createMany({
        data: (data[tenantKey].publicPolitics as Array<any>).map((publicPolitic) => {
          // eslint-disable-next-line @typescript-eslint/no-unused-vars
          const { tenantKey, ...publicPoliticData } = publicPolitic;
          return {
            ...publicPoliticData,
            tenantId: dbTenant.id,
          };
        }),
      });
      console.log(
        `[seedPublicPolitics] Number of public politics for tenant key ${tenantKey} created: ${result.count}`,
      );
    }
  }
}

export { seedPublicPolitics };
