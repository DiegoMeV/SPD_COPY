import { ObjectType, Field, Int, Float } from "type-graphql";

@ObjectType()
export class VValorFisicoActividad {
  @Field(() => String)
  nitCompania!: string;

  @Field(() => String)
  proyecto!: string;

  @Field(() => Int)
  codigoAct!: number;

  @Field(() => String)
  descripcion!: string;

  @Field(() => String)
  etapa!: string;

  @Field(() => String)
  componente!: string;

  @Field(() => Int, { nullable: true })
  codigoUnd?: number | null;

  @Field(() => Int, { nullable: true })
  cantidad?: number | null;

  @Field(() => String, { nullable: true })
  activa?: string | null;

  @Field(() => Int)
  id!: number;

  @Field(() => Int, { nullable: true })
  idMeta?: number | null;

  @Field(() => Int, { nullable: true })
  idProducto?: number | null;

  @Field(() => String, { nullable: true })
  vigencia?: string | null;

  @Field(() => Int, { nullable: true })
  trimestre?: number | null;

  @Field(() => Float, { nullable: true })
  valorAct?: number | null;

  @Field(() => Float, { nullable: true })
  cantidadAct?: number | null;

  @Field(() => String, { nullable: true })
  nombreUnidad?: string | null;

  @Field(() => String, { nullable: true })
  sigla?: string | null;
}
