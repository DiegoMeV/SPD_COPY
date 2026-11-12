import { Field, ObjectType, Int } from "type-graphql";
import { Unit as DbUnit } from "@prisma/client";

@ObjectType()
export class Unit implements Partial<DbUnit> {
    @Field(() => Int)
    id!: number;

    @Field()
    name!: string;

    @Field(() => String, { nullable: true })
    initials?: string | null | undefined;
}
