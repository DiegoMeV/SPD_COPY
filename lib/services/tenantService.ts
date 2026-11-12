import { Tenant } from "../../graphql/types";
import prisma from "../prisma";

export class TenantService {
  private static _instance: TenantService | undefined;

  private constructor() {}

  static get instance() {
    if (this._instance === undefined) {
      this._instance = new this();
    }
    return this._instance;
  }

  async getTenantById({ id }: { id: number }): Promise<Tenant> {
    return prisma.tenant.findUniqueOrThrow({
      where: {
        id,
      },
    });
  }

  async getTenant({ key }: { key: string }): Promise<Tenant> {
    const tenant = await prisma.tenant.findFirst({
      where: {
        key,
      },
    });
    if (!tenant) throw new Error(`Tenant with key ${key} not found`);

    return tenant;
  }
}
