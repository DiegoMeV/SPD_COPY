import { ObjectType, Field, Int, Float } from "type-graphql";

@ObjectType()
export class VSaldopptalEgrActividadWp {
  @Field(() => String)
  nitCompania!: string;

  @Field(() => Int)
  vigencia!: number;

  @Field(() => String)
  proyecto!: string;

  @Field(() => String)
  nombreProyecto!: string;

  @Field(() => Int)
  idActividad!: number;

  @Field(() => Int)
  codigoActividad!: number;

  @Field(() => String)
  nombreActividad!: string;

  @Field(() => Int)
  trimestre!: number;

  @Field(() => Int)
  mesInicial!: number;

  @Field(() => Float, { nullable: true })
  apropiadoRp?: number | null;

  @Field(() => Float, { nullable: true })
  apropiadoSgp?: number | null;

  @Field(() => Float, { nullable: true })
  apropiadoCn?: number | null;

  @Field(() => Float, { nullable: true })
  apropiadoCd?: number | null;

  @Field(() => Float, { nullable: true })
  apropiadoSgr?: number | null;

  @Field(() => Float, { nullable: true })
  apropiadoGestion?: number | null;

  @Field(() => Float, { nullable: true })
  apropiadoFuncionamiento?: number | null;

  @Field(() => Float, { nullable: true })
  apropiadoCredito?: number | null;

  @Field(() => Float, { nullable: true })
  apropiadoOtros?: number | null;

  @Field(() => Float, { nullable: true })
  compromisoRp?: number | null;

  @Field(() => Float, { nullable: true })
  compromisoSgp?: number | null;

  @Field(() => Float, { nullable: true })
  compromisoCn?: number | null;

  @Field(() => Float, { nullable: true })
  compromisoCd?: number | null;

  @Field(() => Float, { nullable: true })
  compromisoSgr?: number | null;

  @Field(() => Float, { nullable: true })
  compromisoGestion?: number | null;

  @Field(() => Float, { nullable: true })
  compromisoFuncionamiento?: number | null;

  @Field(() => Float, { nullable: true })
  compromisoCredito?: number | null;

  @Field(() => Float, { nullable: true })
  compromisoOtros?: number | null;

  @Field(() => Float, { nullable: true })
  obligacionRp?: number | null;

  @Field(() => Float, { nullable: true })
  obligacionSgp?: number | null;

  @Field(() => Float, { nullable: true })
  obligacionCn?: number | null;

  @Field(() => Float, { nullable: true })
  obligacionCd?: number | null;

  @Field(() => Float, { nullable: true })
  obligacionSgr?: number | null;

  @Field(() => Float, { nullable: true })
  obligacionGestion?: number | null;

  @Field(() => Float, { nullable: true })
  obligacionFuncionamiento?: number | null;

  @Field(() => Float, { nullable: true })
  obligacionCredito?: number | null;

  @Field(() => Float, { nullable: true })
  obligacionOtros?: number | null;
}
