import { Field, ObjectType, InputType, Int, registerEnumType } from "type-graphql";
import { DbModel } from "./common";
import { GoalHistory as DbGoalHistory, GoalHistoryEvent } from "@prisma/client";

registerEnumType(GoalHistoryEvent, {
  name: "GoalHistoryEvent",
  description: "Event type for Goal History",
});

@ObjectType()
export class GoalHistory extends DbModel implements Partial<DbGoalHistory> {
  @Field(() => Int, { nullable: true })
  goalId?: number | null | undefined;

  @Field(() => Int, { nullable: true })
  monitoringRecordId?: number | null | undefined;

  @Field(() => GoalHistoryEvent)
  event!: GoalHistoryEvent;

  @Field(() => String, { nullable: true })
  description?: string | null;

  @Field(() => Int, { nullable: true })
  createdBy?: number | null | undefined;
}

@InputType()
export class CreateGoalHistory implements Partial<DbGoalHistory> {
  @Field(() => Int, { nullable: true })
  goalId?: number | null | undefined;

  @Field(() => Int, { nullable: true })
  monitoringRecordId?: number | null | undefined;

  @Field(() => GoalHistoryEvent)
  event!: GoalHistoryEvent;

  @Field(() => String, { nullable: true })
  description?: string | null;

  @Field(() => Int, { nullable: true })
  createdBy?: number | null | undefined;
}
