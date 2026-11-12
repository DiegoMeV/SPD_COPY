import { Field, ObjectType, InputType, Int, Float, registerEnumType } from "type-graphql";
import { DbModel } from "./common";
import { MonitoringRecord as DbMonitoringRecord, MonitoringRecordStatus } from "@prisma/client";
import { SaveLinkedMonitoringRecordResource } from "./monitoringRecordResource";
import { GoalMonitoringRecordStatus } from "../../shared/const";
import { GraphQLJSON } from "graphql-scalars";
import type { JsonObject, JsonValue } from "./common";

registerEnumType(MonitoringRecordStatus, {
  name: "MonitoringRecordStatus",
  description: "Status for each monitoring record",
});

registerEnumType(GoalMonitoringRecordStatus, {
  name: "GoalMonitoringRecordStatus",
  description: "Goal status for each Monitoring Record",
});

@ObjectType()
export class MonitoringRecord extends DbModel implements Partial<DbMonitoringRecord> {
  @Field(() => Int)
  monitoringConfigId!: number;

  @Field(() => Int)
  goalId!: number;

  @Field(() => Int)
  period!: number;

  @Field(() => Float, { nullable: true })
  goalValue?: number | null | undefined;

  @Field(() => Float, { nullable: true })
  piGoalValue?: number | null;

  @Field(() => Int, { defaultValue: 1 })
  fromMonth!: number;

  @Field(() => Int, { defaultValue: 12 })
  toMonth!: number;

  @Field(() => Float, { nullable: true })
  goalAchievedValue?: number | null;

  @Field(() => Float, { nullable: true })
  piGoalAchievedValue?: number | null;

  @Field(() => MonitoringRecordStatus)
  recordStatus!: MonitoringRecordStatus;

  @Field(() => Float, { nullable: true })
  weighting?: number | null | undefined;

  @Field(() => String, { nullable: true })
  notes?: string | null | undefined;

  @Field(() => String, { nullable: true })
  questionHow?: string | null | undefined;

  @Field(() => String, { nullable: true })
  questionResult?: string | null | undefined;

  @Field(() => String, { nullable: true })
  questionEvidence?: string | null | undefined;

  @Field(() => String, { nullable: true })
  questionProblem?: string | null | undefined;

  @Field(() => Float, { nullable: true })
  physicalIndicator?: number | null | undefined;

  @Field(() => Int, { nullable: true })
  createdBy?: number | null | undefined;

  @Field(() => Int, { nullable: true })
  updatedBy?: number | null | undefined;

  @Field(() => Int, { nullable: true })
  totalPeople?: number | null;

  @Field(() => GraphQLJSON, { nullable: true })
  targetMatrix?: JsonValue;
}

@ObjectType()
export class MonitoringRecordWithStatus extends MonitoringRecord {
  @Field(() => GoalMonitoringRecordStatus)
  goalStatus!: GoalMonitoringRecordStatus;
}

@InputType()
export class CreateMonitoringRecord extends DbModel implements Partial<DbMonitoringRecord> {
  @Field(() => Int)
  monitoringConfigId!: number;

  @Field(() => Int)
  goalId!: number;

  @Field(() => MonitoringRecordStatus, { defaultValue: MonitoringRecordStatus.PLANNED })
  recordStatus!: MonitoringRecordStatus;

  @Field(() => Int)
  period!: number;

  @Field(() => Float, { nullable: true })
  goalValue?: number | null | undefined;

  @Field(() => Float, { nullable: true })
  piGoalValue?: number | undefined;

  @Field(() => Int, { defaultValue: 1 })
  fromMonth!: number;

  @Field(() => Int, { defaultValue: 12 })
  toMonth!: number;

  @Field(() => Float, { nullable: true })
  goalAchievedValue?: number | null;

  @Field(() => Float, { nullable: true })
  piGoalAchievedValue?: number | null;

  @Field(() => Int, { nullable: true })
  totalPeople?: number | null;

  @Field(() => GraphQLJSON, { nullable: true })
  targetMatrix?: JsonObject;

  @Field(() => String, { nullable: true })
  historyDescription?: string | null | undefined;
}

@InputType()
export class UpdateMonitoringRecord extends DbModel implements Partial<DbMonitoringRecord> {
  @Field(() => Int)
  id!: number;

  @Field(() => Float, { nullable: true })
  goalValue?: number | null | undefined;

  @Field(() => Float, { nullable: true })
  piGoalValue?: number | undefined;

  @Field(() => Int, { nullable: true })
  fromMonth?: number | undefined;

  @Field(() => Int, { nullable: true })
  toMonth?: number | undefined;

  @Field(() => Float, { nullable: true })
  goalAchievedValue?: number | null;

  @Field(() => Float, { nullable: true })
  piGoalAchievedValue?: number | null;

  @Field(() => MonitoringRecordStatus)
  recordStatus?: MonitoringRecordStatus;

  @Field(() => Float, { nullable: true })
  weighting?: number | null | undefined;

  @Field(() => String, { nullable: true })
  notes?: string | null | undefined;

  @Field(() => String, { nullable: true })
  questionHow?: string | null | undefined;

  @Field(() => String, { nullable: true })
  questionResult?: string | null | undefined;

  @Field(() => String, { nullable: true })
  questionEvidence?: string | null | undefined;

  @Field(() => String, { nullable: true })
  questionProblem?: string | null | undefined;

  @Field(() => Int, { nullable: true })
  totalPeople?: number | null;

  @Field(() => GraphQLJSON, { nullable: true })
  targetMatrix?: JsonObject;

  @Field(() => String, { nullable: true })
  reviewNotes?: string | null | undefined;

  @Field(() => String, { nullable: true })
  historyDescription?: string | null | undefined;
}

@InputType()
export class SavePlannedMonitoringRecord implements Partial<DbMonitoringRecord> {
  @Field(() => Int, { nullable: true })
  id?: number | undefined;

  @Field(() => Int)
  monitoringConfigId!: number;

  @Field(() => Int)
  goalId!: number;

  @Field(() => Int)
  period!: number;

  @Field(() => Float, { nullable: true })
  goalValue?: number | null | undefined;

  @Field(() => Float, { nullable: true })
  piGoalValue?: number | undefined;

  @Field(() => Int, { defaultValue: 1 })
  fromMonth!: number;

  @Field(() => Int, { defaultValue: 12 })
  toMonth!: number;

  @Field(() => Float, { nullable: true })
  weighting?: number | null | undefined;

  @Field(() => [SaveLinkedMonitoringRecordResource], { nullable: true })
  monitoringResources?: SaveLinkedMonitoringRecordResource[];
}

@InputType()
export class SaveTrackingMonitoringRecord implements Partial<DbMonitoringRecord> {
  @Field(() => Int, { nullable: true })
  id?: number | undefined;

  @Field(() => Int)
  monitoringConfigId!: number;

  @Field(() => Int)
  period!: number;

  @Field(() => Float)
  goalAchievedValue!: number;

  @Field(() => Float, { nullable: true })
  piGoalAchievedValue?: number | undefined;

  @Field(() => String, { nullable: true })
  notes?: string | null | undefined;

  @Field(() => String, { nullable: true })
  questionHow?: string | null | undefined;

  @Field(() => String, { nullable: true })
  questionResult?: string | null | undefined;

  @Field(() => String, { nullable: true })
  questionEvidence?: string | null | undefined;

  @Field(() => String, { nullable: true })
  questionProblem?: string | null | undefined;

  @Field(() => [SaveLinkedMonitoringRecordResource], { nullable: true })
  monitoringResources?: SaveLinkedMonitoringRecordResource[];

  @Field(() => MonitoringRecordStatus, { nullable: true })
  recordStatus?: MonitoringRecordStatus | undefined;

  @Field(() => GraphQLJSON, { nullable: true })
  targetMatrix?: JsonObject;

  @Field(() => String, { nullable: true })
  reviewNotes?: string | null | undefined;
}

@InputType()
export class GetMonitoringRecord {
  @Field(() => Int, { nullable: true })
  id?: number | undefined;

  @Field(() => Int, { nullable: true })
  goalId?: number | undefined;

  @Field(() => Int, { nullable: true })
  monitoringConfigId?: number | undefined;
}
