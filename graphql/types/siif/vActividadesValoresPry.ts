import { ObjectType, Field, Int, Float } from "type-graphql";

@ObjectType()
export class VActividadesValoresPrySIIF {
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
  nombreMeta?: string | null;

  @Field(() => String, { nullable: true })
  codigoMeta?: string | null;

  @Field(() => String, { nullable: true })
  nombreProducto?: string | null;

  @Field(() => String, { nullable: true })
  codigoProducto?: string | null;

  @Field(() => Float, { nullable: true })
  recursos2016?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2016?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2016?: number | null;

  @Field(() => Float, { nullable: true })
  recursos2017?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2017?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2017?: number | null;

  @Field(() => Float, { nullable: true })
  recursos2018?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2018?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2018?: number | null;

  @Field(() => Float, { nullable: true })
  recursos2019?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2019?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2019?: number | null;

  @Field(() => Float, { nullable: true })
  recursos2020?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2020?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2020?: number | null;

  @Field(() => Float, { nullable: true })
  recursos2021?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2021?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2021?: number | null;

  @Field(() => Float, { nullable: true })
  recursos2022?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2022?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2022?: number | null;

  @Field(() => Float, { nullable: true })
  recursos2023?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2023?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2023?: number | null;

  @Field(() => Float, { nullable: true })
  recursos2024?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2024?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2024?: number | null;

  @Field(() => Float, { nullable: true })
  recursos2025?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2025?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2025?: number | null;

  @Field(() => Float, { nullable: true })
  recursos2026?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2026?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2026?: number | null;

  @Field(() => Float, { nullable: true })
  recursos2027?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2027?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2027?: number | null;

  @Field(() => Float, { nullable: true })
  recursos2028?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2028?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2028?: number | null;

  @Field(() => Float, { nullable: true })
  recursos2029?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2029?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2029?: number | null;

  @Field(() => Float, { nullable: true })
  recursos2030?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionComp2030?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucion2030?: number | null;

  @Field(() => String, { nullable: true })
  descripcionTxt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2016Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2016Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2016Fmt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2017Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2017Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2017Fmt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2018Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2018Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2018Fmt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2019Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2019Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2019Fmt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2020Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2020Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2020Fmt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2021Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2021Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2021Fmt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2022Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2022Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2022Fmt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2023Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2023Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2023Fmt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2024Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2024Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2024Fmt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2025Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2025Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2025Fmt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2026Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2026Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2026Fmt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2027Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2027Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2027Fmt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2028Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2028Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2028Fmt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2029Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2029Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2029Fmt?: string | null;

  @Field(() => String, { nullable: true })
  recursos2030Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucion2030Fmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionComp2030Fmt?: string | null;

  @Field(() => Float, { nullable: true })
  recursosTotal?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionTotal?: number | null;

  @Field(() => Float, { nullable: true })
  ejecucionCompTotal?: number | null;

  @Field(() => Float, { nullable: true })
  saldoTotal?: number | null;

  @Field(() => Float, { nullable: true })
  saldoCompTotal?: number | null;

  @Field(() => String, { nullable: true })
  recursosTotalFmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionTotalFmt?: string | null;

  @Field(() => String, { nullable: true })
  ejecucionCompTotalFmt?: string | null;

  @Field(() => String, { nullable: true })
  saldoTotalFmt?: string | null;

  @Field(() => String, { nullable: true })
  saldoCompTotalFmt?: string | null;
}

@ObjectType()
export class VActividadesValoresPry extends VActividadesValoresPrySIIF {
  @Field(() => Int, { nullable: true })
  goalId?: number | null;
}
