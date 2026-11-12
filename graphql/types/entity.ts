import { Field, ObjectType, InputType, Int } from "type-graphql";
import { DbModel, SearchInput, SearchResponse } from "./common";
import { Entity as DbEntity } from "@prisma/client";

@ObjectType()
export class Entity extends DbModel implements Partial<DbEntity> {
  @Field()
  code!: string;

  @Field()
  name!: string;

  @Field()
  isActive!: boolean;

  @Field(() => Boolean, { nullable: true, defaultValue: false })
  hasManualBudget?: boolean | null;

  @Field(() => Date, { nullable: true })
  startDate?: Date | null;

  @Field(() => Date, { nullable: true })
  endDate?: Date | null;

  @Field(() => Int, { nullable: true })
  parentId?: number | null | undefined;
}

@InputType()
export class CreateEntity implements Partial<DbEntity> {
  @Field()
  code!: string;

  @Field()
  name!: string;

  @Field(() => Boolean, { nullable: true, defaultValue: false })
  hasManualBudget?: boolean;

  @Field(() => Date, { nullable: true })
  startDate?: Date | null;

  @Field(() => Date, { nullable: true })
  endDate?: Date | null;

  @Field(() => Int, { nullable: true })
  parentId?: number | null | undefined;
}

@InputType()
export class UpdateEntity implements Partial<DbEntity> {
  @Field(() => Int)
  id!: number;

  @Field({ nullable: true })
  code?: string;

  @Field(() => Boolean, { nullable: true })
  hasManualBudget?: boolean;

  @Field({ nullable: true })
  name?: string;

  @Field(() => Date, { nullable: true })
  startDate?: Date | null;

  @Field(() => Date, { nullable: true })
  endDate?: Date | null;

  @Field(() => Int, { nullable: true })
  parentId?: number | null | undefined;

  @Field(() => Boolean, { nullable: true })
  isActive?: boolean;
}

@InputType()
export class SearchEntity extends SearchInput implements Partial<DbEntity> {
  @Field(() => Int, { nullable: true })
  id?: number | undefined;

  @Field({ nullable: true })
  code?: string;

  @Field(() => Boolean, { nullable: true })
  hasManualBudget?: boolean;

  @Field({ nullable: true })
  name?: string;

  @Field(() => Date, { nullable: true })
  startDate?: Date | null;

  @Field(() => Date, { nullable: true })
  endDate?: Date | null;

  @Field(() => Int, { nullable: true })
  parentId?: number | null | undefined;

  @Field(() => [Boolean], { nullable: true })
  active?: boolean[];

  @Field(() => String, { nullable: true })
  text?: string | undefined | null;
}

@ObjectType()
export class SearchEntityResponse extends SearchResponse {
  @Field(() => [Entity])
  items!: Entity[];
}
