import { ObjectType, Field, Int } from "type-graphql";

@ObjectType()
export class Sector {
  @Field(() => Int)
  plan!: number;

  @Field(() => Int)
  eje!: number;

  @Field(() => String)
  nitCompania!: string;

  @Field(() => Int)
  sector!: number;

  @Field(() => String)
  nombre!: string;

  @Field(() => Int, { nullable: true })
  id?: number | null;

  @Field(() => String, { nullable: true })
  codigo?: string | null;

  @Field(() => String, { nullable: true })
  activo?: string | null;

  @Field(() => String, { nullable: true })
  sectorDnp?: string | null;
}
