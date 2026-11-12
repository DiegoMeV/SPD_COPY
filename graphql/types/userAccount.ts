import { Field, ObjectType, InputType, Int, registerEnumType } from "type-graphql";
import { DbModel, SearchInput, SearchResponse } from "./common";
import { UserAccount as DbUserAccount, SPDRole } from "@prisma/client";

registerEnumType(SPDRole, {
  name: "SPDRole",
  description: "User role for SPD accounts",
});

@ObjectType()
export class UserAccount extends DbModel implements Partial<DbUserAccount> {
  @Field()
  tenantId!: number;

  @Field(() => String)
  email!: string;

  @Field(() => String)
  docNumber!: string;

  @Field(() => String)
  firstName!: string;

  @Field(() => String, { nullable: true })
  lastName?: string | null | undefined;

  @Field(() => String, { nullable: true })
  phone?: string | null | undefined;

  @Field()
  isActive!: boolean;

  @Field(() => Int, { nullable: true })
  entityId?: number | undefined | null;

  @Field(() => SPDRole, { nullable: true })
  role!: SPDRole | undefined | null;
}

@InputType()
export class CreateUserAccount implements Partial<DbUserAccount> {
  @Field()
  tenantId!: number;

  @Field(() => String)
  email!: string;

  @Field(() => String)
  docNumber!: string;

  @Field(() => String)
  firstName!: string;

  @Field(() => String, { nullable: true })
  lastName?: string | null | undefined;

  @Field(() => String, { nullable: true })
  phone?: string | null | undefined;

  @Field(() => String)
  password!: string;

  @Field(() => Int, { nullable: true })
  entityId?: number | undefined | null;

  @Field(() => SPDRole, { nullable: true })
  role!: SPDRole | undefined | null;
}

@InputType()
export class UpdateUserAccount implements Partial<DbUserAccount> {
  @Field(() => Int)
  id!: number;

  @Field(() => String, { nullable: true })
  email?: string | undefined;

  @Field(() => String, { nullable: true })
  docNumber?: string | undefined;

  @Field(() => String, { nullable: true })
  firstName?: string | undefined;

  @Field(() => String, { nullable: true })
  lastName?: string | null | undefined;

  @Field(() => String, { nullable: true })
  phone?: string | null | undefined;

  @Field(() => Int, { nullable: true })
  entityId?: number | undefined | null;

  @Field(() => SPDRole, { nullable: true })
  role!: SPDRole | undefined | null;

  @Field(() => Boolean, { nullable: true })
  isActive?: boolean;
}

@InputType()
export class LoginUserAccount implements Partial<DbUserAccount> {
  @Field()
  tenantId!: number;

  @Field(() => String)
  email!: string;

  @Field(() => String)
  password!: string;
}

@InputType()
export class ChangeUserAccountPassword implements Partial<DbUserAccount> {
  @Field(() => Int)
  id!: number;

  @Field(() => String)
  currentPassword!: string;

  @Field(() => String)
  newPassword!: string;
}

@InputType()
export class AdminChangeUserAccountPassword implements Partial<DbUserAccount> {
  @Field(() => Int)
  id!: number;

  @Field(() => String)
  newPassword!: string;
}

@InputType()
export class SearchUserAccount extends SearchInput implements Partial<DbUserAccount> {
  @Field(() => Int, { nullable: true })
  id?: number | undefined;

  @Field(() => Boolean, { nullable: true })
  isActive?: boolean;

  @Field(() => [Boolean], { nullable: true })
  active?: boolean[];

  @Field(() => String, { nullable: true })
  email?: string | undefined;

  @Field(() => String, { nullable: true })
  docNumber?: string | undefined;

  @Field(() => String, { nullable: true })
  firstName?: string | undefined;

  @Field(() => String, { nullable: true })
  lastName?: string | null | undefined;

  @Field(() => String, { nullable: true })
  phone?: string | null | undefined;

  @Field(() => String, { nullable: true })
  entityName?: string | undefined | null;

  @Field(() => String, { nullable: true })
  text?: string | undefined | null;

  @Field(() => [SPDRole], { nullable: true })
  roles?: SPDRole[];

  @Field(() => [Int], { nullable: true })
  entityIds?: number[];
}

@ObjectType()
export class SearchUserAccountResponse extends SearchResponse {
  @Field(() => [UserAccount])
  items!: UserAccount[];
}

@ObjectType()
export class UserLoggedIn extends UserAccount {
  @Field(() => String)
  token?: string;
}
