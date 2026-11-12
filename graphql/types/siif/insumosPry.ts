import { ObjectType, Field, Int, Float } from "type-graphql";

@ObjectType()
export class InsumosPry {
  @Field(() => String)
  nitCompania!: string;

  @Field(() => String)
  proyecto!: string;

  @Field(() => Int)
  codigoAct!: number;

  @Field(() => Int)
  codigoIns!: number;

  @Field(() => String)
  tipoInsumo!: string;

  @Field(() => String)
  subtipoInsumo!: string;

  @Field(() => String)
  nombreSubtipo!: string;

  @Field(() => Int, { nullable: true })
  codigoUnd?: number | null;

  @Field(() => Float, { nullable: true })
  valor1995?: number | null;

  @Field(() => Float, { nullable: true })
  valor1996?: number | null;

  @Field(() => Float, { nullable: true })
  valor1997?: number | null;

  @Field(() => Float, { nullable: true })
  valor1998?: number | null;

  @Field(() => Float, { nullable: true })
  valor1999?: number | null;

  @Field(() => Float, { nullable: true })
  valor2000?: number | null;

  @Field(() => Float, { nullable: true })
  valor2001?: number | null;

  @Field(() => Float, { nullable: true })
  valor2002?: number | null;

  @Field(() => Float, { nullable: true })
  valor2003?: number | null;

  @Field(() => Float, { nullable: true })
  valor2004?: number | null;

  @Field(() => Float, { nullable: true })
  valor2005?: number | null;

  @Field(() => Float, { nullable: true })
  valor2006?: number | null;

  @Field(() => Float, { nullable: true })
  valor2007?: number | null;

  @Field(() => Float, { nullable: true })
  valor2008?: number | null;

  @Field(() => Float, { nullable: true })
  valor2009?: number | null;

  @Field(() => Float, { nullable: true })
  valor2010?: number | null;

  @Field(() => Float, { nullable: true })
  valor2011?: number | null;

  @Field(() => Float, { nullable: true })
  valor2012?: number | null;

  @Field(() => Float, { nullable: true })
  valor2013?: number | null;

  @Field(() => Float, { nullable: true })
  valor2014?: number | null;

  @Field(() => Float, { nullable: true })
  valor2015?: number | null;

  @Field(() => Float, { nullable: true })
  valor2016?: number | null;

  @Field(() => Float, { nullable: true })
  valor2017?: number | null;

  @Field(() => Float, { nullable: true })
  valor2018?: number | null;

  @Field(() => Float, { nullable: true })
  valor2019?: number | null;

  @Field(() => Float, { nullable: true })
  valor2020?: number | null;

  @Field(() => Float, { nullable: true })
  valor2021?: number | null;

  @Field(() => Float, { nullable: true })
  valor2022?: number | null;

  @Field(() => Float, { nullable: true })
  valor2023?: number | null;

  @Field(() => Float, { nullable: true })
  valor2024?: number | null;

  @Field(() => Float, { nullable: true })
  valor2025?: number | null;

  @Field(() => Float, { nullable: true })
  valor2026?: number | null;

  @Field(() => Float, { nullable: true })
  valor2027?: number | null;

  @Field(() => Float, { nullable: true })
  valor2028?: number | null;

  @Field(() => Float, { nullable: true })
  valor2029?: number | null;

  @Field(() => Float, { nullable: true })
  valor2030?: number | null;

  @Field(() => Float, { nullable: true })
  valorTotal?: number | null;

  @Field(() => Float)
  id!: number;

  @Field(() => Float, { nullable: true })
  idTipoinsumoMgaweb?: number | null;
}
