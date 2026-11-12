import { InputType, Field, Int, ObjectType } from "type-graphql";
import { GoalType } from "@prisma/client";

@InputType()
export class GetGoalTypeStats {
  @Field(() => Int, { nullable: true })
  entityId?: number;

  @Field(() => Int)
  monitoringConfigId!: number;
}

@ObjectType()
export class GetGoalTypeStatsResponse {
  @Field(() => GoalType)
  goalType!: GoalType;

  @Field(() => Int, { defaultValue: 0 })
  total!: number;

  @Field(() => Int, { defaultValue: 0 })
  scheduled!: number;

  @Field(() => Int, { defaultValue: 0 })
  noScheduled!: number;

  @Field(() => Int, { defaultValue: 0 })
  reported!: number;

  @Field(() => Int, { defaultValue: 0 })
  noReported!: number;
}

@InputType()
export class GetSupersetGuestTokenParams {
  @Field(() => String)
  dashboardId!: string;
}
