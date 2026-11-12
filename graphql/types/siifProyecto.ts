import { Field, ObjectType, InputType, Int, Float } from "type-graphql";
import { DbModel, SearchInput, SearchResponse } from "./common";
import { SiifProyecto as DbSiifProyecto } from "@prisma/client";

@ObjectType()
export class SiifProyecto extends DbModel implements Partial<DbSiifProyecto> {
    @Field()
    plan!: number;

    @Field()
    programa!: number;

    @Field()
    sector!: number;

    @Field()
    eje!: number;

    @Field()
    nitCompania!: string;

    @Field()
    proyecto!: string;

    @Field()
    nombre!: string;

    @Field(() => Date, { nullable: true })
    fechaRegistro?: Date | null;

    @Field(() => String, { nullable: true })
    objetivos?: string | null;

    @Field(() => String, { nullable: true })
    descripcion?: string | null;

    @Field(() => String, { nullable: true })
    presentadoPor?: string | null;

    @Field(() => Date, { nullable: true })
    fechaEvaluacion?: Date | null;

    @Field(() => String, { nullable: true })
    evaluadoPor?: string | null;

    @Field(() => Float, { nullable: true })
    valor?: number | null;

    @Field(() => Int, { nullable: true })
    verDesde?: number | null;

    @Field(() => String, { nullable: true })
    estado?: string | null;

    @Field(() => String, { nullable: true })
    codigoEntPry?: string | null;

    @Field(() => String, { nullable: true })
    vialibilizadoPor?: string | null;

    @Field(() => Date, { nullable: true })
    fechaViabilidad?: Date | null;

    @Field(() => String, { nullable: true })
    estadoProceso?: string | null;

    @Field(() => String, { nullable: true })
    usuario?: string | null;

    @Field(() => Date, { nullable: true })
    fechaCreacion?: Date | null;

    @Field(() => String, { nullable: true })
    observacion?: string | null;

    @Field(() => Int, { nullable: true })
    subprograma?: number | null;

    @Field(() => Int, { nullable: true })
    idEntidadPresenta?: number | null;
}

@InputType()
export class CreateSiifProyecto implements Partial<DbSiifProyecto> {
    @Field()
    plan!: number;

    @Field()
    programa!: number;

    @Field()
    sector!: number;

    @Field()
    eje!: number;

    @Field()
    nitCompania!: string;

    @Field()
    proyecto!: string;

    @Field()
    nombre!: string;

    @Field(() => Date, { nullable: true })
    fechaRegistro?: Date | null;

    @Field(() => String, { nullable: true })
    objetivos?: string | null;

    @Field(() => String, { nullable: true })
    descripcion?: string | null;

    @Field(() => String, { nullable: true })
    presentadoPor?: string | null;

    @Field(() => Date, { nullable: true })
    fechaEvaluacion?: Date | null;

    @Field(() => String, { nullable: true })
    evaluadoPor?: string | null;

    @Field(() => Float, { nullable: true })
    valor?: number | null;

    @Field(() => Int, { nullable: true })
    verDesde?: number | null;

    @Field(() => String, { nullable: true })
    estado?: string | null;

    @Field(() => String, { nullable: true })
    codigoEntPry?: string | null;

    @Field(() => String, { nullable: true })
    vialibilizadoPor?: string | null;

    @Field(() => Date, { nullable: true })
    fechaViabilidad?: Date | null;

    @Field(() => String, { nullable: true })
    estadoProceso?: string | null;

    @Field(() => String, { nullable: true })
    usuario?: string | null;

    @Field(() => Date, { nullable: true })
    fechaCreacion?: Date | null;

    @Field(() => String, { nullable: true })
    observacion?: string | null;

    @Field(() => Int, { nullable: true })
    subprograma?: number | null;

    @Field(() => Int, { nullable: true })
    idEntidadPresenta?: number | null;
}

@InputType()
export class UpdateSiifProyecto implements Partial<DbSiifProyecto> {
    @Field(() => Int, { nullable: true })
    id?: number | undefined;

    @Field(() => Int, { nullable: true })
    plan?: number | undefined;

    @Field(() => Int, { nullable: true })
    programa?: number | undefined;

    @Field(() => Int, { nullable: true })
    sector?: number | undefined;

    @Field(() => Int, { nullable: true })
    eje?: number | undefined;

    @Field()
    nitCompania!: string;

    @Field()
    proyecto!: string;

    @Field()
    nombre?: string;

    @Field(() => Date, { nullable: true })
    fechaRegistro?: Date | null;

    @Field(() => String, { nullable: true })
    objetivos?: string | null;

    @Field(() => String, { nullable: true })
    descripcion?: string | null;

    @Field(() => String, { nullable: true })
    presentadoPor?: string | null;

    @Field(() => Date, { nullable: true })
    fechaEvaluacion?: Date | null;

    @Field(() => String, { nullable: true })
    evaluadoPor?: string | null;

    @Field(() => Float, { nullable: true })
    valor?: number | null;

    @Field(() => Int, { nullable: true })
    verDesde?: number | null;

    @Field(() => String, { nullable: true })
    estado?: string | null;

    @Field(() => String, { nullable: true })
    codigoEntPry?: string | null;

    @Field(() => String, { nullable: true })
    vialibilizadoPor?: string | null;

    @Field(() => Date, { nullable: true })
    fechaViabilidad?: Date | null;

    @Field(() => String, { nullable: true })
    estadoProceso?: string | null;

    @Field(() => String, { nullable: true })
    usuario?: string | null;

    @Field(() => Date, { nullable: true })
    fechaCreacion?: Date | null;

    @Field(() => String, { nullable: true })
    observacion?: string | null;

    @Field(() => Int, { nullable: true })
    subprograma?: number | null;

    @Field(() => Int, { nullable: true })
    idEntidadPresenta?: number | null;
}


@InputType()
export class DeleteSiifProyecto implements Partial<DbSiifProyecto> {
    @Field()
    nitCompania!: string;

    @Field()
    proyecto!: string;
}

@ObjectType()
export class SearchSiifProyectoResponse extends SearchResponse {
    @Field(() => [SiifProyecto])
    items!: SiifProyecto[];
}

@InputType()
export class SearchSiifProyecto extends SearchInput implements Partial<DbSiifProyecto> {
    @Field(() => String, { nullable: true })
    proyecto?: string | undefined;

    @Field(() => String, { nullable: true })
    nombre?: string | undefined;

    @Field(() => Int, { nullable: true })
    plan?: number | undefined;

    @Field(() => [String], { nullable: true })
    codigosEntPry?: string[];
}