import { Field, ObjectType, InputType, Int, registerEnumType } from "type-graphql";
import { DbModel } from "./common";
import {
  MonitoringConfig as DbMonitoringConfig,
  MonitoringStatus,
  SpentDoc,
  WeightingType,
  MonitoringResourcesOrigin,
  MonitoringConfigUsedFor,
  GoalType,
} from "@prisma/client";
import { GraphQLJSON } from "graphql-scalars";
import type { JsonObject, JsonValue, JsonArray } from "./common";

registerEnumType(MonitoringStatus, {
  name: "MonitoringStatus",
  description: "Current monitoring status",
});

registerEnumType(SpentDoc, {
  name: "SpentDoc",
  description: "Document used as spent source for calculating the spent budget",
});

registerEnumType(WeightingType, {
  name: "WeightingType",
  description: "To weighting each goal of the development plan",
});

registerEnumType(MonitoringResourcesOrigin, {
  name: "MonitoringResourcesOrigin",
  description: "Where financial data come from",
});

registerEnumType(MonitoringConfigUsedFor, {
  name: "MonitoringConfigUsedFor",
  description: "The use of Monitoring, like development plan or public politics",
});

@ObjectType()
export class MonitoringConfig extends DbModel implements Partial<DbMonitoringConfig> {
  @Field(() => Int, { nullable: true })
  devPlanId?: number | null;

  @Field()
  isActive!: boolean;

  @Field(() => Int)
  period!: number;

  @Field(() => Int)
  subperiod!: number;

  @Field(() => Int, { defaultValue: 3 })
  periodicity!: number;

  @Field(() => [SpentDoc])
  spentDocs?: SpentDoc[] | undefined;

  @Field(() => WeightingType, { nullable: true })
  weightingType?: WeightingType | null;

  @Field(() => GraphQLJSON, { nullable: true })
  datesConfig?: JsonValue;

  @Field(() => GraphQLJSON, { nullable: true })
  colorsConfig?: JsonValue;

  @Field(() => MonitoringStatus)
  status!: MonitoringStatus;

  @Field(() => MonitoringResourcesOrigin, { nullable: true })
  monitoringResourcesOrigin?: MonitoringResourcesOrigin | null;

  @Field(() => Boolean, { defaultValue: false, nullable: true })
  supportProductMonitoring?: boolean | null;

  @Field(() => Boolean, { defaultValue: false, nullable: true })
  sgpDiscriminated?: boolean | null;

  @Field(() => MonitoringConfigUsedFor, { nullable: true })
  usedFor?: MonitoringConfigUsedFor | null;

  @Field(() => [GoalType])
  goalTypes?: GoalType[] | undefined;
}

@InputType()
export class CreateMonitoringConfig extends DbModel implements Partial<DbMonitoringConfig> {
  @Field(() => Int, { nullable: true })
  devPlanId?: number | null;

  @Field(() => Int)
  period!: number;

  @Field(() => Int)
  subperiod!: number;

  @Field(() => Int, { defaultValue: 3 })
  periodicity!: number;

  @Field(() => [SpentDoc], { nullable: true })
  spentDocs?: SpentDoc[] | undefined;

  @Field(() => WeightingType, { nullable: true })
  weightingType?: WeightingType;

  @Field(() => GraphQLJSON, { nullable: true })
  datesConfig?: JsonObject;

  @Field(() => GraphQLJSON, { nullable: true })
  colorsConfig?: JsonArray;

  @Field(() => Boolean, { defaultValue: false })
  isActive!: boolean;

  @Field(() => MonitoringResourcesOrigin, { nullable: true })
  monitoringResourcesOrigin?: MonitoringResourcesOrigin | null;

  @Field(() => Boolean, { nullable: true, defaultValue: false })
  supportProductMonitoring?: boolean;

  @Field(() => Boolean, { nullable: true, defaultValue: false })
  sgpDiscriminated?: boolean;

  @Field(() => Boolean, { nullable: true, defaultValue: false })
  copyGoals?: boolean;

  @Field(() => MonitoringConfigUsedFor)
  usedFor!: MonitoringConfigUsedFor;

  @Field(() => [GoalType], { nullable: true })
  goalTypes?: GoalType[] | undefined;
}

@InputType()
export class UpdateMonitoringConfig extends DbModel implements Partial<DbMonitoringConfig> {
  @Field(() => Int)
  id!: number;

  @Field(() => Int, { nullable: true })
  devPlanId?: number;

  @Field(() => Int, { nullable: true })
  period?: number;

  @Field(() => Int, { nullable: true })
  subperiod?: number;

  @Field(() => Int, { nullable: true })
  periodicity?: number;

  @Field(() => [SpentDoc], { nullable: true })
  spentDocs?: SpentDoc[] | undefined;

  @Field(() => WeightingType, { nullable: true })
  weightingType?: WeightingType;

  @Field(() => GraphQLJSON, { nullable: true })
  datesConfig?: JsonObject;

  @Field(() => GraphQLJSON, { nullable: true })
  colorsConfig?: JsonArray;

  @Field(() => MonitoringStatus, { nullable: true })
  status?: MonitoringStatus | undefined;

  @Field(() => Boolean, { nullable: true })
  isActive?: boolean | undefined;

  @Field(() => MonitoringResourcesOrigin, { nullable: true })
  monitoringResourcesOrigin?: MonitoringResourcesOrigin | null;

  @Field(() => Boolean, { nullable: true })
  supportProductMonitoring?: boolean | undefined;

  @Field(() => Boolean, { nullable: true })
  sgpDiscriminated?: boolean | undefined;

  @Field(() => MonitoringConfigUsedFor, { nullable: true })
  usedFor?: MonitoringConfigUsedFor | null;

  @Field(() => [GoalType], { nullable: true })
  goalTypes?: GoalType[] | undefined;
}

@InputType()
export class SetActiveMonitoringConfig extends DbModel implements Partial<DbMonitoringConfig> {
  @Field(() => Int)
  id!: number;
}

@InputType()
export class GetMonitoringConfig implements Partial<DbMonitoringConfig> {
  @Field(() => Int, { nullable: true })
  devPlanId?: number;

  @Field(() => MonitoringConfigUsedFor, { nullable: true })
  usedFor?: MonitoringConfigUsedFor | null;
}

@InputType()
export class CopyMonitoringConfigPreviousSchedule implements Partial<DbMonitoringConfig> {
  @Field(() => Int)
  id!: number;
}

@InputType()
export class CopyMonitoringConfigFromPeriod extends DbModel implements Partial<DbMonitoringConfig> {
  @Field(() => Int)
  id!: number;

  @Field(() => Int)
  period!: number;

  @Field(() => Int)
  subperiod!: number;

  @Field(() => Boolean, { defaultValue: false })
  copyPhysical!: boolean;

  @Field(() => Boolean, { defaultValue: false })
  copyFinancial!: boolean;
}
