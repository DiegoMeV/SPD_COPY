import { ObjectType, Field, Int, Float } from "type-graphql";

@ObjectType()
export class ActividadesPry {
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

  @Field(() => Float)
  id!: number;

  @Field(() => Float, { nullable: true })
  idMeta?: number | null;

  @Field(() => Float, { nullable: true })
  idProducto?: number | null;
}
