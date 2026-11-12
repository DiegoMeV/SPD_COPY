interface UserAccountRecord {
  id: number;
  tenantId: number;
  email: string;
  firstName: string;
  lastName: string;
  docNumber: string;
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
}

export type { UserAccountRecord };
