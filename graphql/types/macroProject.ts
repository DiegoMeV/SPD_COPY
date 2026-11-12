import { Field, ObjectType, InputType, Int } from "type-graphql";
import { DbModel } from "./common";
import { MacroProject as DbMacroProject } from "@prisma/client";

@ObjectType()
export class MacroProject extends DbModel implements Partial<DbMacroProject> {
    @Field(() => String, { nullable: true })
    code?: string | undefined | null;

    @Field()
    name!: string;

    @Field(() => String, { nullable: true })
    description?: string | undefined | null;

    @Field()
    isActive!: boolean;
}

@InputType()
export class CreateMacroProject implements Partial<DbMacroProject> {
    @Field(() => String, { nullable: true })
    code?: string | undefined;

    @Field()
    name!: string;

    @Field(() => String, { nullable: true })
    description?: string | undefined;

    @Field({ defaultValue: true })
    isActive!: boolean;
}

@InputType()
export class UpdateMacroProject implements Partial<DbMacroProject> {
    @Field(() => Int)
    id!: number;

    @Field(() => String, { nullable: true })
    code?: string | undefined;

    @Field(() => String, { nullable: true })
    name?: string | undefined;

    @Field(() => String, { nullable: true })
    description?: string | undefined;

    @Field(() => Boolean, { nullable: true })
    isActive?: boolean | undefined;
}
