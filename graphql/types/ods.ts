import { Field, ObjectType, Int } from "type-graphql";
import { Ods as DbOds } from "@prisma/client";

@ObjectType()
export class Ods implements Partial<DbOds> {
    @Field(() => Int)
    id!: number;

    @Field()
    name!: string;
}
