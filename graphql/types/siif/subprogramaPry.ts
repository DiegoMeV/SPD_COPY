import { ObjectType, Field, Int } from "type-graphql";

@ObjectType()
export class SubprogramaPry {
  @Field(() => Int)
  plan!: number;

  @Field(() => Int)
  eje!: number;

  @Field(() => Int)
  sector!: number;

  @Field(() => String)
  nitCompania!: string;

  @Field(() => Int)
  programa!: number;

  @Field(() => String)
  nombre!: string;

  @Field(() => Int)
  subprogramaPry!: number;

  @Field(() => Int, { nullable: true })
  id?: number | null;

  @Field(() => Int, { nullable: true })
  subprograma?: number | null;

  @Field(() => String, { nullable: true })
  codigo?: string | null;

  @Field(() => String, { nullable: true })
  codigoAlt?: string | null;

  @Field(() => String, { nullable: true })
  activo?: string | null;

  @Field(() => Int, { nullable: true })
  idSectorFut?: number | null;
}
