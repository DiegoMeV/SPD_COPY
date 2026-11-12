import { Field, ObjectType, InputType, Int, Float } from "type-graphql";
import { DbModel } from "./common";
import { SiifActividadMeta as DbSiifActividadMeta } from "@prisma/client";

@ObjectType()
export class SiifActividadMeta extends DbModel implements Partial<DbSiifActividadMeta> {
    @Field()
    id!: number;

    @Field()
    nitCompania!: string;

    @Field()
    proyecto!: string;

    @Field(() => Int)
    codigoAct!: number;

    @Field(() => Int)
    goalId!: number;

    @Field(() => Float)
    weighting!: number;
}

@InputType()
export class CreateSiifActividadMeta implements Partial<DbSiifActividadMeta> {
    @Field(() => Int, { nullable: true })
    id?: number;

    @Field()
    nitCompania!: string;

    @Field()
    proyecto!: string;

    @Field(() => Int)
    codigoAct!: number;

    @Field(() => Int)
    goalId!: number;

    @Field(() => Float)
    weighting!: number;
}

@InputType()
export class DeleteSiifActividadMetas implements Partial<DbSiifActividadMeta> {
    @Field()
    nitCompania!: string;

    @Field()
    proyecto!: string;

    @Field(() => Int)
    codigoAct!: number;
}
