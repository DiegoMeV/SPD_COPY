import { Field, ObjectType, InputType, Int } from "type-graphql";
import { DbModel } from "./common";
import { SiifActividadMetaAccion as DbSiifActividadMetaAccion } from "@prisma/client";

@ObjectType()
export class SiifActividadMetaAccion extends DbModel implements Partial<DbSiifActividadMetaAccion> {
    @Field()
    id!: number;

    @Field(() => Int)
    actividadMetaId!: number;

    @Field()
    descripcion!: string;
}

@InputType()
export class CreateSiifActividadMetaAccion implements Partial<DbSiifActividadMetaAccion> {
    @Field(() => Int, { nullable: true })
    id?: number;

    @Field(() => Int)
    actividadMetaId!: number;

    @Field(() => String)
    descripcion!: string;
}

@InputType()
export class UpdateSiifActividadMetaAccion implements Partial<DbSiifActividadMetaAccion> {
    @Field(() => Int)
    id!: number;

    @Field(() => String)
    descripcion!: string;
}

@InputType()
export class DeleteSiifActividadMetaAcciones implements Partial<DbSiifActividadMetaAccion> {
    @Field(() => Int)
    actividadMetaId!: number;
}
