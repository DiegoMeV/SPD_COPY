import { Field, ObjectType, InputType, Int, Float, registerEnumType } from "type-graphql";
import { DbModel, ExportFormat, SearchInput, SearchResponse } from "./common";
import { AccumulationType, Goal as DbGoal, GoalType, MonitoringStatus } from "@prisma/client";
import { GraphQLJSON } from "graphql-scalars";
import type { JsonObject, JsonValue } from "./common";
import { VSpdMeta } from "./siif";

registerEnumType(AccumulationType, {
  name: "AccumulationType",
  description: "Accumulation subtype for INCREASE, REDUCTION and MAINTENANCE goals",
});

registerEnumType(GoalType, {
  name: "GoalType",
  description: "Classification of goals in the monitoring process",
});

@ObjectType()
export class Goal extends DbModel implements Partial<DbGoal> {
  @Field(() => Int, { nullable: true })
  devPlanLevelId?: number | null;

  @Field(() => Int, { nullable: true })
  parentGoalId?: number | null | undefined;

  @Field(() => String)
  code!: string;

  @Field(() => String, { nullable: true })
  name?: string | null;

  @Field(() => Boolean)
  isActive!: boolean;

  @Field(() => Int)
  entityId!: number;

  @Field(() => GraphQLJSON, { nullable: true })
  extraEntityIds?: JsonValue;

  @Field(() => GoalType)
  goalType!: GoalType;

  @Field(() => String, { nullable: true })
  indicator?: string | null | undefined;

  @Field(() => String, { nullable: true })
  description?: string | null | undefined;

  @Field(() => AccumulationType)
  accumulationType!: AccumulationType;

  @Field(() => Float, { nullable: true })
  baseValue?: number | null | undefined;

  @Field(() => Float, { nullable: true })
  goalValue?: number | null | undefined;

  @Field(() => Int)
  unitsFactor!: number;

  @Field(() => String, { nullable: true })
  unitsName?: string | null | undefined;

  @Field(() => Float, { nullable: true })
  piBaseValue?: number | null | undefined;

  @Field(() => Float, { nullable: true })
  piGoalValue?: number | undefined | null;

  @Field(() => Int, { nullable: true })
  piUnitsFactor?: number | undefined | null;

  @Field(() => String, { nullable: true })
  piUnitsName?: string | null | undefined;

  @Field(() => Boolean)
  isBaseValueNotAvailable!: boolean;

  @Field(() => GraphQLJSON, { nullable: true })
  odsIds?: JsonValue;

  @Field(() => Date, { nullable: true })
  startDate?: Date | null;

  @Field(() => Date, { nullable: true })
  endDate?: Date | null;

  @Field(() => Int, { nullable: true })
  publicPoliticId?: number | null;

  @Field(() => Int, { nullable: true })
  publicPoliticComponentId?: number | null;

  @Field(() => Int, { nullable: true })
  peacePoliticId?: number | null;

  @Field(() => Int, { nullable: true })
  victimsPoliticId?: number | null;

  @Field(() => Int, { nullable: true })
  productCatalogId?: number | null;

  @Field(() => Float, { nullable: true })
  weighting?: number | null | undefined;

  @Field(() => Int, { nullable: true })
  macroProjectId?: number | null;

  @Field(() => String, { nullable: true })
  formula?: string | null | undefined;

  @Field(() => Int, { nullable: true })
  tenantId?: number | null;

  @Field(() => Int, { nullable: true })
  activityId?: number | null;

  @Field(() => String, { nullable: true })
  projectCode?: string | null;
}

@InputType()
export class CreateGoal implements Partial<DbGoal> {
  @Field(() => Int, { nullable: true })
  devPlanLevelId?: number | null;

  @Field(() => Int, { nullable: true })
  parentGoalId?: number | null | undefined;

  @Field(() => String)
  code!: string;

  @Field(() => String, { nullable: true })
  name?: string | null;

  @Field(() => Boolean, { defaultValue: true })
  isActive?: boolean;

  @Field(() => Int)
  entityId!: number;

  @Field(() => GraphQLJSON, { nullable: true })
  extraEntityIds?: JsonObject;

  @Field(() => GoalType)
  goalType!: GoalType;

  @Field(() => String, { nullable: true })
  indicator?: string | null | undefined;

  @Field(() => String, { nullable: true })
  description?: string | null | undefined;

  @Field(() => AccumulationType)
  accumulationType!: AccumulationType;

  @Field(() => Float, { nullable: true })
  baseValue?: number | null | undefined;

  @Field(() => Float, { nullable: true })
  goalValue?: number | null | undefined;

  @Field(() => Int, { defaultValue: 1 })
  unitsFactor!: number;

  @Field(() => String, { nullable: true })
  unitsName?: string | null | undefined;

  @Field(() => Float, { nullable: true })
  piBaseValue?: number | null | undefined;

  @Field(() => Float, { nullable: true })
  piGoalValue?: number | undefined | null;

  @Field(() => Int, { nullable: true })
  piUnitsFactor?: number | undefined | null;

  @Field(() => String, { nullable: true })
  piUnitsName?: string | null | undefined;

  @Field(() => Boolean, { nullable: true, defaultValue: false })
  isBaseValueNotAvailable?: boolean;

  @Field(() => GraphQLJSON, { nullable: true })
  odsIds?: JsonObject;

  @Field(() => Date, { nullable: true })
  startDate?: Date | null;

  @Field(() => Date, { nullable: true })
  endDate?: Date | null;

  @Field(() => Int, { nullable: true })
  publicPoliticId?: number;

  @Field(() => Int, { nullable: true })
  publicPoliticComponentId?: number;

  @Field(() => Int, { nullable: true })
  peacePoliticId?: number | null;

  @Field(() => Int, { nullable: true })
  victimsPoliticId?: number | null;

  @Field(() => Int, { nullable: true })
  productCatalogId?: number;

  @Field(() => Float, { nullable: true })
  weighting?: number | null | undefined;

  @Field(() => Int, { nullable: true })
  macroProjectId?: number | null;

  @Field(() => String, { nullable: true })
  formula?: string | null | undefined;

  @Field(() => Int, { nullable: true })
  tenantId?: number;

  @Field(() => Int, { nullable: true })
  activityId?: number;

  @Field(() => String, { nullable: true })
  projectCode?: string | null;

  @Field(() => Int, { nullable: true })
  userId?: number | null | undefined;

  @Field(() => String, { nullable: true })
  historyDescription?: string | null | undefined;
}

@InputType()
export class UpdateGoal implements Partial<DbGoal> {
  @Field(() => Int)
  id!: number;

  @Field(() => Int, { nullable: true })
  devPlanLevelId?: number | undefined;

  @Field(() => Int, { nullable: true })
  parentGoalId?: number | null | undefined;

  @Field(() => String)
  code?: string | undefined;

  @Field(() => String, { nullable: true })
  name?: string | undefined | null;

  @Field(() => Boolean, { nullable: true })
  isActive?: boolean | undefined;

  @Field(() => Int, { nullable: true })
  entityId?: number | undefined;

  @Field(() => GraphQLJSON, { nullable: true })
  extraEntityIds?: JsonObject;

  @Field(() => GoalType, { nullable: true })
  goalType?: GoalType | undefined;

  @Field(() => String, { nullable: true })
  indicator?: string | null | undefined;

  @Field(() => String, { nullable: true })
  description?: string | null | undefined;

  @Field(() => AccumulationType, { nullable: true })
  accumulationType?: AccumulationType | undefined;

  @Field(() => Float, { nullable: true })
  baseValue?: number | null | undefined;

  @Field(() => Float, { nullable: true })
  goalValue?: number | null | undefined;

  @Field(() => Int, { defaultValue: 1 })
  unitsFactor?: number | undefined;

  @Field(() => String, { nullable: true })
  unitsName?: string | null | undefined;

  @Field(() => Float, { nullable: true })
  piBaseValue?: number | null | undefined;

  @Field(() => Float, { nullable: true })
  piGoalValue?: number | undefined | null;

  @Field(() => Int, { nullable: true })
  piUnitsFactor?: number | undefined | null;

  @Field(() => String, { nullable: true })
  piUnitsName?: string | null | undefined;

  @Field(() => Boolean, { nullable: true })
  isBaseValueNotAvailable?: boolean | undefined;

  @Field(() => GraphQLJSON, { nullable: true })
  odsIds?: JsonObject;

  @Field(() => Date, { nullable: true })
  startDate?: Date | null;

  @Field(() => Date, { nullable: true })
  endDate?: Date | null;

  @Field(() => Int, { nullable: true })
  publicPoliticId?: number;

  @Field(() => Int, { nullable: true })
  publicPoliticComponentId?: number;

  @Field(() => Int, { nullable: true })
  peacePoliticId?: number | null;

  @Field(() => Int, { nullable: true })
  victimsPoliticId?: number | null;

  @Field(() => Int, { nullable: true })
  productCatalogId?: number;

  @Field(() => Float, { nullable: true })
  weighting?: number | null | undefined;

  @Field(() => Int, { nullable: true })
  macroProjectId?: number | null;

  @Field(() => String, { nullable: true })
  formula?: string | null | undefined;

  @Field(() => Int, { nullable: true })
  tenantId?: number;

  @Field(() => Int, { nullable: true })
  activityId?: number;

  @Field(() => String, { nullable: true })
  projectCode?: string | null;

  @Field(() => Int, { nullable: true })
  userId?: number | null | undefined;

  @Field(() => String, { nullable: true })
  historyDescription?: string | null | undefined;
}

@InputType()
export class SearchGoals extends SearchInput implements Partial<DbGoal> {
  @Field(() => Int, { nullable: true })
  id?: number | undefined;

  @Field(() => [Int], { nullable: true })
  ids?: number[] | undefined;

  @Field(() => Int, { nullable: true })
  devPlanId?: number | undefined;

  @Field(() => Int, { nullable: true })
  devPlanLevelId?: number | undefined;

  @Field(() => [Int], { nullable: true })
  devPlanLevelIds?: number[] | undefined;

  @Field(() => Int, { nullable: true })
  parentGoalId?: number | null | undefined;

  @Field(() => Int, { nullable: true })
  monitoringConfigId?: number | null | undefined;

  @Field(() => String, { nullable: true })
  code?: string | undefined;

  @Field(() => String, { nullable: true })
  name?: string | undefined | null;

  @Field(() => Boolean, { nullable: true })
  isActive!: boolean;

  @Field(() => Int, { nullable: true })
  entityId?: number | undefined;

  @Field(() => [Int], { nullable: true })
  entityIds?: number[] | undefined;

  @Field(() => GoalType, { nullable: true })
  goalType?: GoalType | undefined;

  @Field(() => [GoalType], { nullable: true })
  goalTypes?: GoalType[] | undefined;

  @Field(() => String, { nullable: true })
  indicator?: string | null | undefined;

  @Field(() => String, { nullable: true })
  description?: string | null | undefined;

  @Field(() => AccumulationType, { nullable: true })
  accumulationType?: AccumulationType | undefined;

  @Field(() => Float, { nullable: true })
  baseValue?: number | null | undefined;

  @Field(() => Float, { nullable: true })
  goalValue?: number | null | undefined;

  @Field(() => Int, { nullable: true })
  unitsFactor?: number | undefined;

  @Field(() => String, { nullable: true })
  unitsName?: string | null | undefined;

  @Field(() => Boolean, { nullable: true })
  isBaseValueNotAvailable?: boolean | undefined;

  @Field(() => GraphQLJSON, { nullable: true })
  odsIds?: JsonObject;

  @Field(() => Date, { nullable: true })
  startDate?: Date | null;

  @Field(() => Date, { nullable: true })
  endDate?: Date | null;

  @Field(() => Int, { nullable: true })
  publicPoliticId?: number;

  @Field(() => Int, { nullable: true })
  publicPoliticComponentId?: number;

  @Field(() => Int, { nullable: true })
  peacePoliticId?: number | null;

  @Field(() => Int, { nullable: true })
  victimsPoliticId?: number | null;

  @Field(() => Int, { nullable: true })
  productCatalogId?: number;

  @Field(() => String, { nullable: true })
  text?: string | undefined | null;

  @Field(() => Boolean, { nullable: true })
  isScheduled?: boolean | undefined;

  @Field(() => Boolean, { nullable: true })
  isReported?: boolean | undefined;

  @Field(() => Boolean, { nullable: true })
  isValidated?: boolean | undefined;

  @Field(() => Boolean, { nullable: true })
  isReviewed?: boolean | undefined;

  @Field(() => Int, { nullable: true })
  macroProjectId?: number | null;

  @Field(() => String, { nullable: true })
  formula?: string | null | undefined;

  @Field(() => MonitoringStatus, { nullable: true })
  stage?: MonitoringStatus | undefined | null;
}

@InputType()
export class SearchGoalsFormat extends SearchGoals {
  @Field(() => ExportFormat, { defaultValue: ExportFormat.NONE })
  format!: ExportFormat;
}

@ObjectType()
export class SearchGoalsResponse extends SearchResponse {
  @Field(() => [Goal])
  items!: Goal[];

  @Field(() => [GoalTypeCount])
  countByType!: GoalTypeCount[];
}

@ObjectType()
export class GoalTypeCount {
  @Field(() => GoalType)
  goalType!: GoalType;

  @Field(() => Int)
  count!: number;
}

@ObjectType()
export class GetGoalsToCopyFromSIIFResponse {
  @Field(() => Int)
  countGoalsSIIF!: number;

  @Field(() => Int)
  countGoalsSPD!: number;

  @Field(() => [VSpdMeta])
  goalstoCopyFromSIIF!: VSpdMeta[];
}
