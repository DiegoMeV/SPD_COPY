import { ObjectType, Field, Int } from "type-graphql";

@ObjectType()
export class PlanDesarrollo {
  @Field(() => String)
  nitCompania!: string;

  @Field(() => Int)
  plan!: number;

  @Field(() => String)
  nombre!: string;

  @Field(() => Date)
  fechaInicio!: Date;

  @Field(() => Date)
  fechaFin!: Date;

  @Field(() => String, { nullable: true })
  objetivo?: string | null;

  @Field(() => String, { nullable: true })
  gobernante?: string | null;

  @Field(() => Int, { nullable: true })
  id?: number | null;

  @Field(() => String, { nullable: true })
  etiquetaEjeSingular?: string | null;

  @Field(() => String, { nullable: true })
  etiquetaEjePlural?: string | null;

  @Field(() => String, { nullable: true })
  etiquetaSectorSingular?: string | null;

  @Field(() => String, { nullable: true })
  etiquetaSectorPlural?: string | null;

  @Field(() => String, { nullable: true })
  etiquetaProgramaSingular?: string | null;

  @Field(() => String, { nullable: true })
  etiquetaProgramaPlural?: string | null;

  @Field(() => String, { nullable: true })
  etiquetaSubprogramaSingular?: string | null;

  @Field(() => String, { nullable: true })
  etiquetaSubprogramaPlural?: string | null;

  @Field(() => String, { nullable: true })
  manejaSector?: string | null;

  @Field(() => Int, { nullable: true })
  nivelMr?: number | null;

  @Field(() => Int, { nullable: true })
  nivelMp?: number | null;
}
