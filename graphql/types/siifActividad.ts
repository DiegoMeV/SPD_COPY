import { Field, ObjectType, InputType, Int, Float } from "type-graphql";
import { DbModel } from "./common";
import { SiifActividad as DbSiifActividad } from "@prisma/client";

@ObjectType()
export class SiifActividad extends DbModel implements Partial<DbSiifActividad> {
    @Field()
    id!: number;

    @Field()
    nitCompania!: string;

    @Field()
    proyecto!: string;

    @Field()
    codigoAct!: number;

    @Field()
    descripcion!: string;

    @Field()
    etapa!: string;

    @Field()
    componente!: string;

    @Field(() => Int, { nullable: true })
    codigoUnd?: number | null;

    @Field(() => Int, { nullable: true })
    cantidad?: number | null;

    @Field(() => Int, { nullable: true })
    codSubact?: number | null;

    @Field(() => String, { nullable: true })
    activa?: string | null;

    @Field(() => String, { nullable: true })
    codigo?: string | null;

    @Field(() => Int, { nullable: true })
    idMeta?: number | null;

    @Field(() => Int, { nullable: true })
    idProducto?: number | null;
}

@InputType()
export class CreateSiifActividad implements Partial<DbSiifActividad> {
    @Field()
    id!: number;

    @Field()
    nitCompania!: string;

    @Field()
    proyecto!: string;

    @Field()
    codigoAct!: number;

    @Field()
    descripcion!: string;

    @Field()
    etapa!: string;

    @Field()
    componente!: string;

    @Field(() => Int, { nullable: true })
    codigoUnd?: number | null;

    @Field(() => Int, { nullable: true })
    cantidad?: number | null;

    @Field(() => Int, { nullable: true })
    codSubact?: number | null;

    @Field(() => String, { nullable: true })
    activa?: string | null;

    @Field(() => String, { nullable: true })
    codigo?: string | null;

    @Field(() => Int, { nullable: true })
    idMeta?: number | null;

    @Field(() => Int, { nullable: true })
    idProducto?: number | null;
}

@InputType()
export class UpdateSiifActividad implements Partial<DbSiifActividad> {
    @Field(() => Int)
    id!: number;

    @Field(() => String)
    nitCompania!: string;

    @Field(() => String)
    proyecto!: string;

    @Field(() => Int)
    codigoAct!: number;

    @Field()
    descripcion?: string;

    @Field()
    etapa?: string;

    @Field()
    componente?: string;

    @Field(() => Int, { nullable: true })
    codigoUnd?: number | null;

    @Field(() => Int, { nullable: true })
    cantidad?: number | null;

    @Field(() => Int, { nullable: true })
    codSubact?: number | null;

    @Field(() => String, { nullable: true })
    activa?: string | null;

    @Field(() => String, { nullable: true })
    codigo?: string | null;

    @Field(() => Int, { nullable: true })
    idMeta?: number | null;

    @Field(() => Int, { nullable: true })
    idProducto?: number | null;
}


@InputType()
export class DeleteSiifActividad implements Partial<DbSiifActividad> {
    @Field()
    nitCompania!: string;

    @Field()
    proyecto!: string;

    @Field(() => Int)
    codigoAct!: number;
}