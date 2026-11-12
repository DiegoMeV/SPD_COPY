import { ObjectType, Field, Int, Float, InputType } from "type-graphql";
import { SearchInput, SearchResponse } from "../common";
import { Goal } from "../goal";

@ObjectType()
export class Proyecto {
  @Field(() => Int, { nullable: true })
  item?: number | null;

  @Field(() => Int)
  plan!: number;

  @Field(() => Int)
  programa!: number;

  @Field(() => Int)
  sector!: number;

  @Field(() => Int)
  eje!: number;

  @Field(() => String)
  nitCompania!: string;

  @Field(() => String)
  proyecto!: string;

  @Field(() => String)
  nombre!: string;

  @Field(() => Float, { nullable: true })
  avanceCualitativo?: number | null;

  @Field(() => String, { nullable: true })
  rubroFut?: string | null;

  @Field(() => Int, { nullable: true })
  ano?: number | null;

  @Field(() => String, { nullable: true })
  codigo?: string | null;

  @Field(() => Date, { nullable: true })
  fechaRegistro?: Date | null;

  @Field(() => String, { nullable: true })
  objetivos?: string | null;

  @Field(() => String, { nullable: true })
  descripcion?: string | null;

  @Field(() => String, { nullable: true })
  presentadoPor?: string | null;

  @Field(() => String, { nullable: true })
  formuladoPor?: string | null;

  @Field(() => Date, { nullable: true })
  fechaEvaluacion?: Date | null;

  @Field(() => String, { nullable: true })
  evaluadoPor?: string | null;

  @Field(() => Float, { nullable: true })
  valor?: number | null;

  @Field(() => Float, { nullable: true })
  verDesde?: number | null;

  @Field(() => String, { nullable: true })
  estado?: string | null;

  @Field(() => String, { nullable: true })
  codigoEntPry?: string | null;

  @Field(() => Int, { nullable: true })
  codPrograma?: number | null;

  @Field(() => Int, { nullable: true })
  codSector?: number | null;

  @Field(() => Int, { nullable: true })
  subprogramaPry?: number | null;

  @Field(() => String, { nullable: true })
  migrado?: string | null;

  @Field(() => String, { nullable: true })
  codigoEntPryPresen?: string | null;

  @Field(() => String, { nullable: true })
  recurso1?: string | null;

  @Field(() => String, { nullable: true })
  recurso2?: string | null;

  @Field(() => Float, { nullable: true })
  valRec1?: number | null;

  @Field(() => Float, { nullable: true })
  valRec2?: number | null;

  @Field(() => String, { nullable: true })
  metaProducto?: string | null;

  @Field(() => String, { nullable: true })
  recurso3?: string | null;

  @Field(() => Float, { nullable: true })
  valRec3?: number | null;

  @Field(() => String, { nullable: true })
  ficticio?: string | null;

  @Field(() => String, { nullable: true })
  estadoProceso?: string | null;

  @Field(() => String, { nullable: true })
  usuario?: string | null;

  @Field(() => Date, { nullable: true })
  fechaCreacion?: Date | null;

  @Field(() => String, { nullable: true })
  observacion?: string | null;

  @Field(() => Int, { nullable: true })
  subprograma?: number | null;

  @Field(() => Date, { nullable: true })
  fechaViabilidad?: Date | null;

  @Field(() => String, { nullable: true })
  viabilizadoPor?: string | null;

  @Field(() => String, { nullable: true })
  idSesion?: string | null;

  @Field(() => Int, { nullable: true })
  idEntidadPresenta?: number | null;

  @Field(() => String, { nullable: true })
  viableTecnicamente?: string | null;

  @Field(() => String, { nullable: true })
  viableEconomicamente?: string | null;

  @Field(() => String, { nullable: true })
  viableFinancieramente?: string | null;

  @Field(() => String, { nullable: true })
  viableInstitucionalmente?: string | null;

  @Field(() => String, { nullable: true })
  viableAmbientalmente?: string | null;

  @Field(() => String, { nullable: true })
  viableSostenibilidad?: string | null;

  @Field(() => String)
  nombreProyecto!: string;

  @Field(() => Int, { nullable: true })
  idPlan?: number | null;

  @Field(() => String)
  descPlan!: string;

  @Field(() => String, { nullable: true })
  diaRegistro?: string | null;

  @Field(() => String, { nullable: true })
  mesRegistro?: string | null;

  @Field(() => String, { nullable: true })
  txtMesRegistro?: string | null;

  @Field(() => String, { nullable: true })
  nombreMesRegistro?: string | null;

  @Field(() => String, { nullable: true })
  anoRegistro?: string | null;

  @Field(() => Int, { nullable: true })
  vigencia?: number | null;

  @Field(() => String, { nullable: true })
  fechaRadicacion?: string | null;

  @Field(() => String, { nullable: true })
  fechaRadicacionFmt?: string | null;

  @Field(() => Int, { nullable: true })
  idSubprograma?: number | null;

  @Field(() => String, { nullable: true })
  descSubprograma?: string | null;

  @Field(() => String, { nullable: true })
  descSubprogramaCap?: string | null;

  @Field(() => String, { nullable: true })
  nombreSubprograma?: string | null;

  @Field(() => String, { nullable: true })
  descPrograma?: string | null;

  @Field(() => String, { nullable: true })
  descProgramaCap?: string | null;

  @Field(() => String)
  nombrePrograma!: string;

  @Field(() => String)
  nombreSector!: string;

  @Field(() => String, { nullable: true })
  descSector?: string | null;

  @Field(() => String, { nullable: true })
  descSectorCap?: string | null;

  @Field(() => String, { nullable: true })
  codigoSectorFut?: string | null;

  @Field(() => String, { nullable: true })
  nombreSectorFut?: string | null;

  @Field(() => String, { nullable: true })
  descSectorFut?: string | null;

  @Field(() => String, { nullable: true })
  descSectorFutCap?: string | null;

  @Field(() => String, { nullable: true })
  descEje?: string | null;

  @Field(() => String)
  nombreEje!: string;

  @Field(() => String, { nullable: true })
  descEjeCap?: string | null;

  @Field(() => Float, { nullable: true })
  valorProyecto?: number | null;

  @Field(() => String, { nullable: true })
  valorProyectoFmt?: string | null;

  @Field(() => Float, { nullable: true })
  valorVigencia?: number | null;

  @Field(() => String, { nullable: true })
  valorVigenciaFmt?: string | null;

  @Field(() => Int, { nullable: true })
  idEntidad?: number | null;

  @Field(() => String, { nullable: true })
  nombreEntPry?: string | null;

  @Field(() => String, { nullable: true })
  nombreentidad?: string | null;

  @Field(() => String, { nullable: true })
  nombreEntidad?: string | null;

  @Field(() => String, { nullable: true })
  nombresecretaria?: string | null;

  @Field(() => String, { nullable: true })
  nombreSecretaria?: string | null;

  @Field(() => Date, { nullable: true })
  fechaDev?: Date | null;

  @Field(() => Date, { nullable: true })
  fechaAct?: Date | null;

  @Field(() => Int, { nullable: true })
  presupuestoDef?: number | null;

  @Field(() => String, { nullable: true })
  presupuestoDefFmt?: string | null;

  @Field(() => Int, { nullable: true })
  solicitudAcum?: number | null;

  @Field(() => String, { nullable: true })
  solicitudAcumFmt?: string | null;

  @Field(() => Int, { nullable: true })
  saldoPpto?: number | null;

  @Field(() => String, { nullable: true })
  saldoPptoFmt?: string | null;

  @Field(() => String, { nullable: true })
  viableTecnicamenteTxt?: string | null;

  @Field(() => String, { nullable: true })
  viableEconomicamenteTxt?: string | null;

  @Field(() => String, { nullable: true })
  viableFinancieramenteTxt?: string | null;

  @Field(() => String, { nullable: true })
  viableInstitucionalmenteTxt?: string | null;

  @Field(() => String, { nullable: true })
  viableAmbientalmenteTxt?: string | null;

  @Field(() => String, { nullable: true })
  viableSostenibilidadTxt?: string | null;

  @Field(() => String, { nullable: true })
  firmaUsuario?: string | null;

  @Field(() => String, { nullable: true })
  codigoEntidadPresenta?: string | null;

  @Field(() => String, { nullable: true })
  nombreEntidadPresenta?: string | null;

  @Field(() => String, { nullable: true })
  vigenciaInicial?: string | null;

  @Field(() => String, { nullable: true })
  vigenciaFinal?: string | null;

  @Field(() => String, { nullable: true })
  emailDestinatarios?: string | null;
}

@InputType()
export class SearchProyecto extends SearchInput {
  @Field(() => String, { nullable: true })
  proyecto?: string | undefined;

  @Field(() => String, { nullable: true })
  nombre?: string | undefined;

  @Field(() => Int, { nullable: true })
  plan?: number | undefined;

  @Field(() => [String], { nullable: true })
  codigosEntPry?: string[];
}

@InputType()
export class SearchProyectoForSchedule extends SearchProyecto {
  @Field(() => Int)
  monitoringConfigId!: number;

  @Field(() => Boolean, { defaultValue: true })
  updateSchedule?: boolean;
}

@ObjectType()
export class SearchProyectoResponse extends SearchResponse {
  @Field(() => [Proyecto])
  items!: Proyecto[];
}

@ObjectType()
export class ProyectoWithGoals extends Proyecto {
  @Field(() => Goal, { nullable: true })
  goal?: Goal | null;
}
