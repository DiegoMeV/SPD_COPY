import { Field, ObjectType, InputType, Int, registerEnumType } from "type-graphql";
import { DbModel } from "./common";
import { DevPlan as DbDevPlan } from "@prisma/client";
import { GraphQLJSON } from "graphql-scalars";
import type { JsonObject, JsonValue } from "./common";
import { GoalActivitySource } from "@prisma/client";

registerEnumType(GoalActivitySource, {
  name: "GoalActivitySource",
  description: "Where are goals and activities linked? SIIF or MANUAL (SPD)",
});

@ObjectType()
export class DevPlan extends DbModel implements Partial<DbDevPlan> {
  @Field(() => Int)
  tenantId!: number;

  @Field()
  code!: string;

  @Field()
  name!: string;

  @Field()
  isActive!: boolean;

  @Field(() => Date, { nullable: true })
  startDate?: Date | null;

  @Field(() => Date, { nullable: true })
  endDate?: Date | null;

  @Field(() => String)
  governmentName!: string;

  @Field(() => Date)
  governmentStartDate!: Date;

  @Field(() => Date)
  governmentEndDate!: Date;

  @Field(() => GraphQLJSON, { nullable: true })
  config?: JsonValue;

  @Field(() => GoalActivitySource, { nullable: true })
  goalActivitySource?: GoalActivitySource | null;
}

@InputType()
export class CreateDevPlan implements Partial<DbDevPlan> {
  @Field()
  code!: string;

  @Field()
  name!: string;

  @Field(() => Date, { nullable: true })
  startDate?: Date | null;

  @Field(() => Date, { nullable: true })
  endDate?: Date | null;

  @Field(() => String)
  governmentName!: string;

  @Field(() => Date)
  governmentStartDate!: Date;

  @Field(() => Date)
  governmentEndDate!: Date;

  @Field(() => GraphQLJSON, { nullable: true })
  config?: JsonObject;

  @Field(() => GoalActivitySource, { nullable: true })
  goalActivitySource?: GoalActivitySource | null;
}

@InputType()
export class UpdateDevPlan implements Partial<DbDevPlan> {
  @Field(() => Int)
  id!: number;

  @Field({ nullable: true })
  code?: string;

  @Field({ nullable: true })
  name?: string;

  @Field(() => Date, { nullable: true })
  startDate?: Date | null;

  @Field(() => Date, { nullable: true })
  endDate?: Date | null;

  @Field(() => String, { nullable: true })
  governmentName?: string;

  @Field(() => Date, { nullable: true })
  governmentStartDate?: Date;

  @Field(() => Date, { nullable: true })
  governmentEndDate?: Date;

  @Field(() => GraphQLJSON, { nullable: true })
  config?: JsonObject;

  @Field(() => GoalActivitySource, { nullable: true })
  goalActivitySource?: GoalActivitySource | null;
}

@InputType()
export class CopyDevPlan {
  @Field(() => Int)
  fromCode!: number;

  @Field(() => Int)
  toId!: number;
}
