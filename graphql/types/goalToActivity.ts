import { Field, ObjectType, Int, InputType } from "type-graphql";
import { DbModel } from "./common";
import { GoalToActivity as DbGoalToActivity } from "@prisma/client";

@ObjectType()
export class GoalToActivity extends DbModel implements Partial<DbGoalToActivity> {
  @Field(() => Int)
  goalId!: number;

  @Field(() => Int)
  activityId!: number;
}

@InputType()
export class LinkGoalToActivity implements Partial<DbGoalToActivity> {
  @Field(() => Int, { nullable: true })
  id?: number;

  @Field(() => Int)
  goalId!: number;

  @Field(() => Int)
  activityId!: number;
}
