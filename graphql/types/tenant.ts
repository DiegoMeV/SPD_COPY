import { Field, ObjectType, InputType, Int, ID } from "type-graphql";
import { DbModel } from "./common";
import { Tenant as DbTenant } from "@prisma/client";

@ObjectType()
export class Tenant extends DbModel implements Partial<DbTenant> {
  @Field()
  key!: string;

  @Field()
  name!: string;

  @Field()
  isActive!: boolean;
}

@InputType()
export class CreateTenant implements Partial<DbTenant> {
  @Field()
  key!: string;

  @Field()
  name!: string;
}

@InputType()
export class UpdateTenant implements Partial<DbTenant> {
  @Field(() => Int)
  id!: number;

  @Field({ nullable: true })
  key?: string;

  @Field({ nullable: true })
  name?: string;

  @Field(() => Boolean, { nullable: true })
  isActive?: boolean;
}
