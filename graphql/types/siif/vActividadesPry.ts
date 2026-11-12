import { ObjectType, Field, Int, Float } from "type-graphql";
import { Goal } from "../goal";

@ObjectType()
export class VActividadesPry {
  @Field(() => String)
  nitCompania!: string;

  @Field(() => Int)
  plan!: number;

  @Field(() => String)
  proyecto!: string;

  @Field(() => String)
  nombreProyecto!: string;

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

  @Field(() => String, { nullable: true })
  descripcionTxt?: string | null;

  @Field(() => String, { nullable: true })
  nombreMeta?: string | null;

  @Field(() => String, { nullable: true })
  codigoMeta?: string | null;

  @Field(() => String, { nullable: true })
  nombreProducto?: string | null;

  @Field(() => String, { nullable: true })
  codigoProducto?: string | null;
}

// @ObjectType()
// export class VActividadesPry extends VActividadesPrySIIF {
//   @Field(() => Int, { nullable: true })
//   goalId?: number | null;

//   @Field(() => Int, { nullable: true })
//   goalToActivityId?: number | null;
// }

@ObjectType()
export class VActividadesPryWithGoals extends VActividadesPry {
  @Field(() => Goal, { nullable: true })
  goal?: Goal | null;

  @Field(() => Int, { nullable: true })
  linkedGoalId?: number | null;

  @Field(() => Goal, { nullable: true })
  linkedGoal?: Goal | null;
}
