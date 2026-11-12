import { Field, ObjectType, InputType, Int, Float } from "type-graphql";
import { DbModel } from './common';
import { DevPlanLevel as DbDevPlanLevel } from "@prisma/client";

@ObjectType()
export class DevPlanLevel extends DbModel implements Partial<DbDevPlanLevel> {
    @Field(() => Int)
    devPlanId!: number;

    @Field(() => String)
    code!: string;

    @Field(() => String)
    name!: string;

    @Field(() => Boolean)
    isActive!: boolean;

    @Field(() => Int, { nullable: true })
    parentId?: number | null | undefined;

    @Field(() => Float, { nullable: true })
    weighting?: number | null | undefined;

    @Field(() => Int, { nullable: true })
    level?: number | null | undefined;

    @Field(() => Int, { nullable: true })
    productCatalogId?: number | null;
}

@InputType()
export class CreateDevPlanLevel implements Partial<DbDevPlanLevel> {
    @Field(() => Int)
    devPlanId!: number;

    @Field(() => String)
    code!: string;

    @Field(() => String)
    name!: string;

    @Field(() => Int, { nullable: true })
    parentId?: number | null | undefined;

    @Field(() => Float, { nullable: true })
    weighting?: number | null | undefined;

    @Field(() => Int, { nullable: true })
    level?: number | null | undefined;

    @Field(() => Int, { nullable: true })
    productCatalogId?: number | null;
}

@InputType()
export class UpdateDevPlanLevel implements Partial<DbDevPlanLevel> {
    @Field(() => Int)
    id!: number;

    @Field(() => Int, { nullable: true })
    devPlanId?: number | undefined;

    @Field(() => String, { nullable: true })
    code?: string | undefined;

    @Field(() => String, { nullable: true })
    name?: string | undefined;

    @Field({ nullable: true })
    isActive?: boolean;

    @Field(() => Int, { nullable: true })
    parentId?: number | null | undefined;

    @Field(() => Float, { nullable: true })
    weighting?: number | null | undefined;

    @Field(() => Int, { nullable: true })
    level?: number | null | undefined;

    @Field(() => Int, { nullable: true })
    productCatalogId?: number | null;
}

@InputType()
export class SearchDevPlanLevel implements Partial<DbDevPlanLevel> {
    @Field(() => Int, { nullable: true })
    devPlanId?: number | undefined;

    @Field(() => Int, { nullable: true })
    id?: number | undefined;

    @Field(() => String, { nullable: true })
    code?: string | undefined;

    @Field(() => String, { nullable: true })
    name?: string | undefined;

    @Field({ nullable: true })
    isActive?: boolean;

    @Field(() => Int, { nullable: true })
    parentId?: number | null | undefined;

    @Field(() => Int, { nullable: true })
    level?: number | null | undefined;

    @Field(() => Int, { nullable: true })
    productCatalogId?: number | null;
}