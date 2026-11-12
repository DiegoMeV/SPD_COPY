import { ObjectType, Field, Int } from "type-graphql";

@ObjectType()
export class EjeEstructurante {
  @Field(() => Int)
  plan!: number;

  @Field(() => String)
  nitCompania!: string;

  @Field(() => Int)
  eje!: number;

  @Field(() => String)
  nombre!: string;

  @Field(() => Int, { nullable: true })
  id?: number | null;

  @Field(() => String, { nullable: true })
  codigo?: string | null;

  @Field(() => String, { nullable: true })
  activo?: string | null;
}
