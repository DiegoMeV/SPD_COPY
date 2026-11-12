import { ObjectType, Field, Int, Float, InputType } from "type-graphql";

@ObjectType()
export class VSpdMeta {
  @Field(() => Int)
  id!: number;

  @Field(() => String)
  nitCompania!: string;

  @Field(() => Int, { nullable: true })
  idPlan?: number | null;

  @Field(() => Int, { nullable: true })
  idEntidad?: number | null;

  @Field(() => String, { nullable: true })
  codigo?: string | null;

  @Field(() => String, { nullable: true })
  tipo?: string | null;

  @Field(() => String, { nullable: true })
  nombre?: string | null;

  @Field(() => String, { nullable: true })
  descripcion?: string | null;

  @Field(() => Float, { nullable: true })
  ponderacion?: number | null;

  @Field(() => String, { nullable: true })
  indicador?: string | null;

  @Field(() => String, { nullable: true })
  unidad?: string | null;

  @Field(() => String, { nullable: true })
  periodo?: string | null;

  @Field(() => Float, { nullable: true })
  valorBase?: number | null;

  @Field(() => Int, { nullable: true })
  factorBase?: number | null;

  @Field(() => String, { nullable: true })
  comparador?: string | null;

  @Field(() => Float, { nullable: true })
  valorMeta?: number | null;

  @Field(() => Int, { nullable: true })
  factorMeta?: number | null;

  @Field(() => Float, { nullable: true })
  valorProgramado?: number | null;

  @Field(() => String, { nullable: true })
  mesInicio?: string | null;

  @Field(() => String, { nullable: true })
  mesFin?: string | null;

  @Field(() => String, { nullable: true })
  accion?: string | null;

  @Field(() => Int, { nullable: true })
  idFut?: number | null;

  @Field(() => Int, { nullable: true })
  idPlanAccion?: number | null;

  @Field(() => Int, { nullable: true })
  proyecto?: number | null;

  @Field(() => Int, { nullable: true })
  idPadre?: number | null;

  @Field(() => Int, { nullable: true })
  idPlanDesarrollo?: number | null;

  @Field(() => Int)
  codigoPlanDesarrollo!: number;

  @Field(() => String, { nullable: true })
  codigoNivelPlan?: string | null;

  @Field(() => String, { nullable: true })
  nombreNivelPlan?: string | null;

  @Field(() => String)
  codigoEntidad!: string;

  @Field(() => String, { nullable: true })
  nombreEntidad?: string | null;
}

@InputType()
export class SearchSpdMeta {
  @Field(() => Int, { nullable: true })
  codigoPlanDesarrollo?: number;

  @Field(() => [String], { nullable: true })
  tipos?: string[];
}
