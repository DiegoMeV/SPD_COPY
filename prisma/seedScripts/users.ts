import { PrismaClient, UserAccount } from "@prisma/client";
import { data } from "../seedData";
import sha256 from "crypto-js/sha256";

const prisma = new PrismaClient();
const INITIAL_PASSWORD = "spd";

async function seedUsers() {
  const dbTenants = await prisma.tenant.findMany();
  if (Array.isArray(data.common.users) && dbTenants.length > 0) {
    await Promise.all(
      dbTenants.map(async (tenant) => {
        const currentUsers = await prisma.userAccount.findMany({
          where: { tenantId: tenant.id },
        });
        if (currentUsers.length > 0) {
          return;
        }
        const users = data.common.users as Array<
          Pick<UserAccount, "docNumber" | "email" | "firstName" | "lastName" | "phone">
        >;
        console.log(
          `[seedUsers] Number of users for tenant key ${tenant.key} to create: ${users.length}`,
        );
        const result = await prisma.userAccount.createMany({
          data: users.map((user) => ({
            ...user,
            tenantId: tenant.id,
            password: sha256(INITIAL_PASSWORD).toString(),
            isActive: true,
          })),
        });
        console.log(
          `[seedUsers] Number of users for tenant key ${tenant.key} created: ${result.count}`,
        );
        return result;
      }),
    );
  }
}

export { seedUsers };
