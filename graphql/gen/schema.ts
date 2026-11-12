export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
export type MakeEmpty<T extends { [key: string]: unknown }, K extends keyof T> = {
  [_ in K]?: never;
};
export type Incremental<T> =
  | T
  | { [P in keyof T]?: P extends " $fragmentName" | "__typename" ? T[P] : never };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: { input: string; output: string };
  String: { input: string; output: string };
  Boolean: { input: boolean; output: boolean };
  Int: { input: number; output: number };
  Float: { input: number; output: number };
  DateTimeISO: { input: any; output: any };
  JSON: { input: any; output: any };
};

/** Accumulation subtype for INCREASE, REDUCTION and MAINTENANCE goals */
export enum AccumulationType {
  Accumulated = "ACCUMULATED",
  AnnualReduction = "ANNUAL_REDUCTION",
  Capacity = "CAPACITY",
  Flow = "FLOW",
  NoAccumulated = "NO_ACCUMULATED",
  Reduction = "REDUCTION",
  Stock = "STOCK",
}

export type AdminChangeUserAccountPassword = {
  id: Scalars["Int"]["input"];
  newPassword: Scalars["String"]["input"];
};

export type ChangeUserAccountPassword = {
  currentPassword: Scalars["String"]["input"];
  id: Scalars["Int"]["input"];
  newPassword: Scalars["String"]["input"];
};

export type CopyDevPlan = {
  fromCode: Scalars["Int"]["input"];
  toId: Scalars["Int"]["input"];
};

export type CopyMonitoringConfigFromPeriod = {
  copyFinancial?: Scalars["Boolean"]["input"];
  copyPhysical?: Scalars["Boolean"]["input"];
  id: Scalars["Int"]["input"];
  period: Scalars["Int"]["input"];
  subperiod: Scalars["Int"]["input"];
};

export type CopyMonitoringConfigPreviousSchedule = {
  id: Scalars["Int"]["input"];
};

export type CreateDevPlan = {
  code: Scalars["String"]["input"];
  config?: InputMaybe<Scalars["JSON"]["input"]>;
  endDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  goalActivitySource?: InputMaybe<GoalActivitySource>;
  governmentEndDate: Scalars["DateTimeISO"]["input"];
  governmentName: Scalars["String"]["input"];
  governmentStartDate: Scalars["DateTimeISO"]["input"];
  name: Scalars["String"]["input"];
  startDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
};

export type CreateDevPlanLevel = {
  code: Scalars["String"]["input"];
  devPlanId: Scalars["Int"]["input"];
  level?: InputMaybe<Scalars["Int"]["input"]>;
  name: Scalars["String"]["input"];
  parentId?: InputMaybe<Scalars["Int"]["input"]>;
  productCatalogId?: InputMaybe<Scalars["Int"]["input"]>;
  weighting?: InputMaybe<Scalars["Float"]["input"]>;
};

export type CreateEntity = {
  code: Scalars["String"]["input"];
  endDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  hasManualBudget?: InputMaybe<Scalars["Boolean"]["input"]>;
  name: Scalars["String"]["input"];
  parentId?: InputMaybe<Scalars["Int"]["input"]>;
  startDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
};

export type CreateGoal = {
  accumulationType: AccumulationType;
  activityId?: InputMaybe<Scalars["Int"]["input"]>;
  baseValue?: InputMaybe<Scalars["Float"]["input"]>;
  code: Scalars["String"]["input"];
  description?: InputMaybe<Scalars["String"]["input"]>;
  devPlanLevelId?: InputMaybe<Scalars["Int"]["input"]>;
  endDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  entityId: Scalars["Int"]["input"];
  extraEntityIds?: InputMaybe<Scalars["JSON"]["input"]>;
  formula?: InputMaybe<Scalars["String"]["input"]>;
  goalType: GoalType;
  goalValue?: InputMaybe<Scalars["Float"]["input"]>;
  historyDescription?: InputMaybe<Scalars["String"]["input"]>;
  indicator?: InputMaybe<Scalars["String"]["input"]>;
  isActive?: Scalars["Boolean"]["input"];
  isBaseValueNotAvailable?: InputMaybe<Scalars["Boolean"]["input"]>;
  macroProjectId?: InputMaybe<Scalars["Int"]["input"]>;
  name?: InputMaybe<Scalars["String"]["input"]>;
  odsIds?: InputMaybe<Scalars["JSON"]["input"]>;
  parentGoalId?: InputMaybe<Scalars["Int"]["input"]>;
  peacePoliticId?: InputMaybe<Scalars["Int"]["input"]>;
  piBaseValue?: InputMaybe<Scalars["Float"]["input"]>;
  piGoalValue?: InputMaybe<Scalars["Float"]["input"]>;
  piUnitsFactor?: InputMaybe<Scalars["Int"]["input"]>;
  piUnitsName?: InputMaybe<Scalars["String"]["input"]>;
  productCatalogId?: InputMaybe<Scalars["Int"]["input"]>;
  projectCode?: InputMaybe<Scalars["String"]["input"]>;
  publicPoliticComponentId?: InputMaybe<Scalars["Int"]["input"]>;
  publicPoliticId?: InputMaybe<Scalars["Int"]["input"]>;
  startDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  tenantId?: InputMaybe<Scalars["Int"]["input"]>;
  unitsFactor?: Scalars["Int"]["input"];
  unitsName?: InputMaybe<Scalars["String"]["input"]>;
  userId?: InputMaybe<Scalars["Int"]["input"]>;
  victimsPoliticId?: InputMaybe<Scalars["Int"]["input"]>;
  weighting?: InputMaybe<Scalars["Float"]["input"]>;
};

export type CreateGoalHistory = {
  createdBy?: InputMaybe<Scalars["Int"]["input"]>;
  description?: InputMaybe<Scalars["String"]["input"]>;
  event: GoalHistoryEvent;
  goalId?: InputMaybe<Scalars["Int"]["input"]>;
  monitoringRecordId?: InputMaybe<Scalars["Int"]["input"]>;
};

export type CreateMacroProject = {
  code?: InputMaybe<Scalars["String"]["input"]>;
  description?: InputMaybe<Scalars["String"]["input"]>;
  isActive?: Scalars["Boolean"]["input"];
  name: Scalars["String"]["input"];
};

export type CreateMonitoringConfig = {
  colorsConfig?: InputMaybe<Scalars["JSON"]["input"]>;
  copyGoals?: InputMaybe<Scalars["Boolean"]["input"]>;
  datesConfig?: InputMaybe<Scalars["JSON"]["input"]>;
  devPlanId?: InputMaybe<Scalars["Int"]["input"]>;
  goalTypes?: InputMaybe<Array<GoalType>>;
  isActive?: Scalars["Boolean"]["input"];
  monitoringResourcesOrigin?: InputMaybe<MonitoringResourcesOrigin>;
  period: Scalars["Int"]["input"];
  periodicity?: Scalars["Int"]["input"];
  sgpDiscriminated?: InputMaybe<Scalars["Boolean"]["input"]>;
  spentDocs?: InputMaybe<Array<SpentDoc>>;
  subperiod: Scalars["Int"]["input"];
  supportProductMonitoring?: InputMaybe<Scalars["Boolean"]["input"]>;
  usedFor: MonitoringConfigUsedFor;
  weightingType?: InputMaybe<WeightingType>;
};

export type CreateMonitoringRecord = {
  fromMonth?: Scalars["Int"]["input"];
  goalAchievedValue?: InputMaybe<Scalars["Float"]["input"]>;
  goalId: Scalars["Int"]["input"];
  goalValue?: InputMaybe<Scalars["Float"]["input"]>;
  historyDescription?: InputMaybe<Scalars["String"]["input"]>;
  monitoringConfigId: Scalars["Int"]["input"];
  period: Scalars["Int"]["input"];
  piGoalAchievedValue?: InputMaybe<Scalars["Float"]["input"]>;
  piGoalValue?: InputMaybe<Scalars["Float"]["input"]>;
  recordStatus?: MonitoringRecordStatus;
  targetMatrix?: InputMaybe<Scalars["JSON"]["input"]>;
  toMonth?: Scalars["Int"]["input"];
  totalPeople?: InputMaybe<Scalars["Int"]["input"]>;
};

export type CreateMonitoringRecordAttachmentLink = {
  description?: InputMaybe<Scalars["String"]["input"]>;
  monitoringRecordId: Scalars["Int"]["input"];
  name: Scalars["String"]["input"];
};

export type CreateMonitoringRecordAttachmentLinkResponse = {
  __typename?: "CreateMonitoringRecordAttachmentLinkResponse";
  createdAt: Scalars["DateTimeISO"]["output"];
  createdBy?: Maybe<Scalars["Int"]["output"]>;
  description?: Maybe<Scalars["String"]["output"]>;
  downloadLink: Scalars["String"]["output"];
  id: Scalars["Int"]["output"];
  monitoringRecordId: Scalars["Int"]["output"];
  name: Scalars["String"]["output"];
  s3Path: Scalars["String"]["output"];
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
  updatedBy?: Maybe<Scalars["Int"]["output"]>;
  uploadURL: Scalars["String"]["output"];
};

export type CreatePublicPolitic = {
  category?: InputMaybe<PublicPoliticCategory>;
  code?: InputMaybe<Scalars["String"]["input"]>;
  componentIds?: InputMaybe<Array<Scalars["Int"]["input"]>>;
  description?: InputMaybe<Scalars["String"]["input"]>;
  fromYear?: InputMaybe<Scalars["Int"]["input"]>;
  isActive?: Scalars["Boolean"]["input"];
  name: Scalars["String"]["input"];
  toYear?: InputMaybe<Scalars["Int"]["input"]>;
};

export type CreatePublicPoliticComponent = {
  code?: InputMaybe<Scalars["String"]["input"]>;
  description?: InputMaybe<Scalars["String"]["input"]>;
  isActive?: Scalars["Boolean"]["input"];
  name: Scalars["String"]["input"];
};

export type CreateSiifActividad = {
  activa?: InputMaybe<Scalars["String"]["input"]>;
  cantidad?: InputMaybe<Scalars["Int"]["input"]>;
  codSubact?: InputMaybe<Scalars["Int"]["input"]>;
  codigo?: InputMaybe<Scalars["String"]["input"]>;
  codigoAct: Scalars["Float"]["input"];
  codigoUnd?: InputMaybe<Scalars["Int"]["input"]>;
  componente: Scalars["String"]["input"];
  descripcion: Scalars["String"]["input"];
  etapa: Scalars["String"]["input"];
  id: Scalars["Float"]["input"];
  idMeta?: InputMaybe<Scalars["Int"]["input"]>;
  idProducto?: InputMaybe<Scalars["Int"]["input"]>;
  nitCompania: Scalars["String"]["input"];
  proyecto: Scalars["String"]["input"];
};

export type CreateSiifActividadMeta = {
  codigoAct: Scalars["Int"]["input"];
  goalId: Scalars["Int"]["input"];
  id?: InputMaybe<Scalars["Int"]["input"]>;
  nitCompania: Scalars["String"]["input"];
  proyecto: Scalars["String"]["input"];
  weighting: Scalars["Float"]["input"];
};

export type CreateSiifActividadMetaAccion = {
  actividadMetaId: Scalars["Int"]["input"];
  descripcion: Scalars["String"]["input"];
  id?: InputMaybe<Scalars["Int"]["input"]>;
};

export type CreateSiifProyecto = {
  codigoEntPry?: InputMaybe<Scalars["String"]["input"]>;
  descripcion?: InputMaybe<Scalars["String"]["input"]>;
  eje: Scalars["Float"]["input"];
  estado?: InputMaybe<Scalars["String"]["input"]>;
  estadoProceso?: InputMaybe<Scalars["String"]["input"]>;
  evaluadoPor?: InputMaybe<Scalars["String"]["input"]>;
  fechaCreacion?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  fechaEvaluacion?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  fechaRegistro?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  fechaViabilidad?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  idEntidadPresenta?: InputMaybe<Scalars["Int"]["input"]>;
  nitCompania: Scalars["String"]["input"];
  nombre: Scalars["String"]["input"];
  objetivos?: InputMaybe<Scalars["String"]["input"]>;
  observacion?: InputMaybe<Scalars["String"]["input"]>;
  plan: Scalars["Float"]["input"];
  presentadoPor?: InputMaybe<Scalars["String"]["input"]>;
  programa: Scalars["Float"]["input"];
  proyecto: Scalars["String"]["input"];
  sector: Scalars["Float"]["input"];
  subprograma?: InputMaybe<Scalars["Int"]["input"]>;
  usuario?: InputMaybe<Scalars["String"]["input"]>;
  valor?: InputMaybe<Scalars["Float"]["input"]>;
  verDesde?: InputMaybe<Scalars["Int"]["input"]>;
  vialibilizadoPor?: InputMaybe<Scalars["String"]["input"]>;
};

export type CreateTenant = {
  key: Scalars["String"]["input"];
  name: Scalars["String"]["input"];
};

export type CreateUserAccount = {
  docNumber: Scalars["String"]["input"];
  email: Scalars["String"]["input"];
  entityId?: InputMaybe<Scalars["Int"]["input"]>;
  firstName: Scalars["String"]["input"];
  lastName?: InputMaybe<Scalars["String"]["input"]>;
  password: Scalars["String"]["input"];
  phone?: InputMaybe<Scalars["String"]["input"]>;
  role?: InputMaybe<SpdRole>;
  tenantId: Scalars["Float"]["input"];
};

export type DeleteSiifActividad = {
  codigoAct: Scalars["Int"]["input"];
  nitCompania: Scalars["String"]["input"];
  proyecto: Scalars["String"]["input"];
};

export type DeleteSiifActividadMetaAcciones = {
  actividadMetaId: Scalars["Int"]["input"];
};

export type DeleteSiifActividadMetas = {
  codigoAct: Scalars["Int"]["input"];
  nitCompania: Scalars["String"]["input"];
  proyecto: Scalars["String"]["input"];
};

export type DeleteSiifProyecto = {
  nitCompania: Scalars["String"]["input"];
  proyecto: Scalars["String"]["input"];
};

export type DevPlan = {
  __typename?: "DevPlan";
  code: Scalars["String"]["output"];
  config?: Maybe<Scalars["JSON"]["output"]>;
  createdAt: Scalars["DateTimeISO"]["output"];
  endDate?: Maybe<Scalars["DateTimeISO"]["output"]>;
  goalActivitySource?: Maybe<GoalActivitySource>;
  governmentEndDate: Scalars["DateTimeISO"]["output"];
  governmentName: Scalars["String"]["output"];
  governmentStartDate: Scalars["DateTimeISO"]["output"];
  id: Scalars["Int"]["output"];
  isActive: Scalars["Boolean"]["output"];
  levels?: Maybe<Array<DevPlanLevel>>;
  name: Scalars["String"]["output"];
  startDate?: Maybe<Scalars["DateTimeISO"]["output"]>;
  tenantId: Scalars["Int"]["output"];
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
};

export type DevPlanLevel = {
  __typename?: "DevPlanLevel";
  children: Array<DevPlanLevel>;
  code: Scalars["String"]["output"];
  createdAt: Scalars["DateTimeISO"]["output"];
  devPlan?: Maybe<DevPlan>;
  devPlanId: Scalars["Int"]["output"];
  goalCount: Array<GoalTypeCount>;
  id: Scalars["Int"]["output"];
  isActive: Scalars["Boolean"]["output"];
  key: Scalars["String"]["output"];
  level?: Maybe<Scalars["Int"]["output"]>;
  name: Scalars["String"]["output"];
  parent?: Maybe<DevPlanLevel>;
  parentId?: Maybe<Scalars["Int"]["output"]>;
  productCatalogId?: Maybe<Scalars["Int"]["output"]>;
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
  weighting?: Maybe<Scalars["Float"]["output"]>;
};

export type EjeEstructurante = {
  __typename?: "EjeEstructurante";
  activo?: Maybe<Scalars["String"]["output"]>;
  codigo?: Maybe<Scalars["String"]["output"]>;
  eje: Scalars["Int"]["output"];
  id?: Maybe<Scalars["Int"]["output"]>;
  nitCompania: Scalars["String"]["output"];
  nombre: Scalars["String"]["output"];
  plan: Scalars["Int"]["output"];
  sectores?: Maybe<Array<Sector>>;
};

export type Entity = {
  __typename?: "Entity";
  code: Scalars["String"]["output"];
  createdAt: Scalars["DateTimeISO"]["output"];
  endDate?: Maybe<Scalars["DateTimeISO"]["output"]>;
  hasManualBudget?: Maybe<Scalars["Boolean"]["output"]>;
  id: Scalars["Int"]["output"];
  isActive: Scalars["Boolean"]["output"];
  name: Scalars["String"]["output"];
  parentId?: Maybe<Scalars["Int"]["output"]>;
  startDate?: Maybe<Scalars["DateTimeISO"]["output"]>;
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
};

/** Format used for exporting GraphQL response data */
export enum ExportFormat {
  Excel = "EXCEL",
  None = "NONE",
}

export type GeoLocation = {
  __typename?: "GeoLocation";
  children: Array<GeoLocation>;
  code?: Maybe<Scalars["String"]["output"]>;
  createdAt: Scalars["DateTimeISO"]["output"];
  id: Scalars["Int"]["output"];
  key: Scalars["String"]["output"];
  locationType: LocationType;
  name: Scalars["String"]["output"];
  parent?: Maybe<GeoLocation>;
  parentLocationId?: Maybe<Scalars["Int"]["output"]>;
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
};

export type GetGoalResources = {
  cutoffDate: Scalars["String"]["input"];
  id: Scalars["Int"]["input"];
  period: Scalars["Int"]["input"];
  resourceTypes: Array<MonitoringResourceType>;
};

export type GetGoalResourcesResponse = {
  __typename?: "GetGoalResourcesResponse";
  capital?: Maybe<Scalars["Float"]["output"]>;
  cd?: Maybe<Scalars["Float"]["output"]>;
  cn?: Maybe<Scalars["Float"]["output"]>;
  credit?: Maybe<Scalars["Float"]["output"]>;
  de?: Maybe<Scalars["Float"]["output"]>;
  financialIndicator?: Maybe<Scalars["Float"]["output"]>;
  management?: Maybe<Scalars["Float"]["output"]>;
  monopoly?: Maybe<Scalars["Float"]["output"]>;
  operation?: Maybe<Scalars["Float"]["output"]>;
  others?: Maybe<Scalars["Float"]["output"]>;
  resourceType: MonitoringResourceType;
  rp?: Maybe<Scalars["Float"]["output"]>;
  sgp?: Maybe<Scalars["Float"]["output"]>;
  sgpCulture?: Maybe<Scalars["Float"]["output"]>;
  sgpEarlyChildhood?: Maybe<Scalars["Float"]["output"]>;
  sgpEducation?: Maybe<Scalars["Float"]["output"]>;
  sgpFreeDestination?: Maybe<Scalars["Float"]["output"]>;
  sgpFreeInvestment?: Maybe<Scalars["Float"]["output"]>;
  sgpHealt?: Maybe<Scalars["Float"]["output"]>;
  sgpMagdalenaRiver?: Maybe<Scalars["Float"]["output"]>;
  sgpSchoolFeeding?: Maybe<Scalars["Float"]["output"]>;
  sgpSport?: Maybe<Scalars["Float"]["output"]>;
  sgpWater?: Maybe<Scalars["Float"]["output"]>;
  sgr?: Maybe<Scalars["Float"]["output"]>;
};

export type GetGoalTypeStats = {
  entityId?: InputMaybe<Scalars["Int"]["input"]>;
  monitoringConfigId: Scalars["Int"]["input"];
};

export type GetGoalTypeStatsResponse = {
  __typename?: "GetGoalTypeStatsResponse";
  goalType: GoalType;
  noReported: Scalars["Int"]["output"];
  noScheduled: Scalars["Int"]["output"];
  reported: Scalars["Int"]["output"];
  scheduled: Scalars["Int"]["output"];
  total: Scalars["Int"]["output"];
};

export type GetGoalsToCopyFromSiifResponse = {
  __typename?: "GetGoalsToCopyFromSIIFResponse";
  countGoalsSIIF: Scalars["Int"]["output"];
  countGoalsSPD: Scalars["Int"]["output"];
  goalstoCopyFromSIIF: Array<VSpdMeta>;
};

export type GetMonitoringConfig = {
  devPlanId?: InputMaybe<Scalars["Int"]["input"]>;
  usedFor?: InputMaybe<MonitoringConfigUsedFor>;
};

export type GetMonitoringRecord = {
  goalId?: InputMaybe<Scalars["Int"]["input"]>;
  id?: InputMaybe<Scalars["Int"]["input"]>;
  monitoringConfigId?: InputMaybe<Scalars["Int"]["input"]>;
};

export type GetSupersetGuestTokenParams = {
  dashboardId: Scalars["String"]["input"];
};

export type Goal = {
  __typename?: "Goal";
  accumulationType: AccumulationType;
  actividad?: Maybe<VActividadesPry>;
  activities?: Maybe<Array<SiifActividadMeta>>;
  activityId?: Maybe<Scalars["Int"]["output"]>;
  baseValue?: Maybe<Scalars["Float"]["output"]>;
  children?: Maybe<Array<Goal>>;
  code: Scalars["String"]["output"];
  createdAt: Scalars["DateTimeISO"]["output"];
  description?: Maybe<Scalars["String"]["output"]>;
  devPlanLevel?: Maybe<DevPlanLevel>;
  devPlanLevelId?: Maybe<Scalars["Int"]["output"]>;
  endDate?: Maybe<Scalars["DateTimeISO"]["output"]>;
  entity?: Maybe<Entity>;
  entityId: Scalars["Int"]["output"];
  extraEntityIds?: Maybe<Scalars["JSON"]["output"]>;
  formula?: Maybe<Scalars["String"]["output"]>;
  goalType: GoalType;
  goalValue?: Maybe<Scalars["Float"]["output"]>;
  history?: Maybe<Array<GoalHistory>>;
  id: Scalars["Int"]["output"];
  indicator?: Maybe<Scalars["String"]["output"]>;
  isActive: Scalars["Boolean"]["output"];
  isBaseValueNotAvailable: Scalars["Boolean"]["output"];
  macroProject?: Maybe<MacroProject>;
  macroProjectId?: Maybe<Scalars["Int"]["output"]>;
  monitoringRecords?: Maybe<Array<MonitoringRecordWithStatus>>;
  name?: Maybe<Scalars["String"]["output"]>;
  ods?: Maybe<Array<Ods>>;
  odsIds?: Maybe<Scalars["JSON"]["output"]>;
  parentGoalId?: Maybe<Scalars["Int"]["output"]>;
  peacePolitic?: Maybe<PublicPolitic>;
  peacePoliticId?: Maybe<Scalars["Int"]["output"]>;
  piBaseValue?: Maybe<Scalars["Float"]["output"]>;
  piGoalValue?: Maybe<Scalars["Float"]["output"]>;
  piUnitsFactor?: Maybe<Scalars["Int"]["output"]>;
  piUnitsName?: Maybe<Scalars["String"]["output"]>;
  productCatalog?: Maybe<ProductCatalog>;
  productCatalogId?: Maybe<Scalars["Int"]["output"]>;
  projectCode?: Maybe<Scalars["String"]["output"]>;
  proyecto?: Maybe<Proyecto>;
  publicPolitic?: Maybe<PublicPolitic>;
  publicPoliticComponent?: Maybe<PublicPoliticComponent>;
  publicPoliticComponentId?: Maybe<Scalars["Int"]["output"]>;
  publicPoliticId?: Maybe<Scalars["Int"]["output"]>;
  schedule?: Maybe<Array<MonitoringRecord>>;
  startDate?: Maybe<Scalars["DateTimeISO"]["output"]>;
  tenantId?: Maybe<Scalars["Int"]["output"]>;
  tracking?: Maybe<Array<MonitoringRecord>>;
  unitsFactor: Scalars["Int"]["output"];
  unitsName?: Maybe<Scalars["String"]["output"]>;
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
  victimsPolitic?: Maybe<PublicPolitic>;
  victimsPoliticId?: Maybe<Scalars["Int"]["output"]>;
  weighting?: Maybe<Scalars["Float"]["output"]>;
};

/** Where are goals and activities linked? SIIF or MANUAL (SPD) */
export enum GoalActivitySource {
  Manual = "MANUAL",
  Siif = "SIIF",
}

export type GoalHistory = {
  __typename?: "GoalHistory";
  createdAt: Scalars["DateTimeISO"]["output"];
  createdBy?: Maybe<Scalars["Int"]["output"]>;
  createdByAccount?: Maybe<UserAccount>;
  description?: Maybe<Scalars["String"]["output"]>;
  event: GoalHistoryEvent;
  goalId?: Maybe<Scalars["Int"]["output"]>;
  id: Scalars["Int"]["output"];
  monitoringRecord?: Maybe<MonitoringRecord>;
  monitoringRecordId?: Maybe<Scalars["Int"]["output"]>;
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
};

/** Event type for Goal History */
export enum GoalHistoryEvent {
  Created = "CREATED",
  Monitored = "MONITORED",
  Rejected = "REJECTED",
  Reviewed = "REVIEWED",
  Scheduled = "SCHEDULED",
  Updated = "UPDATED",
  Validated = "VALIDATED",
}

/** Goal status for each Monitoring Record */
export enum GoalMonitoringRecordStatus {
  New = "NEW",
  NoReported = "NO_REPORTED",
  NoReviewed = "NO_REVIEWED",
  NoValidated = "NO_VALIDATED",
  PartiallyScheduled = "PARTIALLY_SCHEDULED",
  Rejected = "REJECTED",
  Reported = "REPORTED",
  Reviewed = "REVIEWED",
  Scheduled = "SCHEDULED",
  Validated = "VALIDATED",
}

export type GoalToActivity = {
  __typename?: "GoalToActivity";
  activityId: Scalars["Int"]["output"];
  createdAt: Scalars["DateTimeISO"]["output"];
  goal: Goal;
  goalId: Scalars["Int"]["output"];
  id: Scalars["Int"]["output"];
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
};

/** Classification of goals in the monitoring process */
export enum GoalType {
  ActionPlan = "ACTION_PLAN",
  ActionPlanActivity = "ACTION_PLAN_ACTIVITY",
  Activity = "ACTIVITY",
  Impact = "IMPACT",
  Product = "PRODUCT",
  Project = "PROJECT",
  PublicPolitic = "PUBLIC_POLITIC",
  Result = "RESULT",
  WellBeing = "WELL_BEING",
}

export type GoalTypeCount = {
  __typename?: "GoalTypeCount";
  count: Scalars["Int"]["output"];
  goalType: GoalType;
};

export type InsumosPry = {
  __typename?: "InsumosPry";
  codigoAct: Scalars["Int"]["output"];
  codigoIns: Scalars["Int"]["output"];
  codigoUnd?: Maybe<Scalars["Int"]["output"]>;
  id: Scalars["Float"]["output"];
  idTipoinsumoMgaweb?: Maybe<Scalars["Float"]["output"]>;
  nitCompania: Scalars["String"]["output"];
  nombreSubtipo: Scalars["String"]["output"];
  proyecto: Scalars["String"]["output"];
  subtipoInsumo: Scalars["String"]["output"];
  tipoInsumo: Scalars["String"]["output"];
  valor1995?: Maybe<Scalars["Float"]["output"]>;
  valor1996?: Maybe<Scalars["Float"]["output"]>;
  valor1997?: Maybe<Scalars["Float"]["output"]>;
  valor1998?: Maybe<Scalars["Float"]["output"]>;
  valor1999?: Maybe<Scalars["Float"]["output"]>;
  valor2000?: Maybe<Scalars["Float"]["output"]>;
  valor2001?: Maybe<Scalars["Float"]["output"]>;
  valor2002?: Maybe<Scalars["Float"]["output"]>;
  valor2003?: Maybe<Scalars["Float"]["output"]>;
  valor2004?: Maybe<Scalars["Float"]["output"]>;
  valor2005?: Maybe<Scalars["Float"]["output"]>;
  valor2006?: Maybe<Scalars["Float"]["output"]>;
  valor2007?: Maybe<Scalars["Float"]["output"]>;
  valor2008?: Maybe<Scalars["Float"]["output"]>;
  valor2009?: Maybe<Scalars["Float"]["output"]>;
  valor2010?: Maybe<Scalars["Float"]["output"]>;
  valor2011?: Maybe<Scalars["Float"]["output"]>;
  valor2012?: Maybe<Scalars["Float"]["output"]>;
  valor2013?: Maybe<Scalars["Float"]["output"]>;
  valor2014?: Maybe<Scalars["Float"]["output"]>;
  valor2015?: Maybe<Scalars["Float"]["output"]>;
  valor2016?: Maybe<Scalars["Float"]["output"]>;
  valor2017?: Maybe<Scalars["Float"]["output"]>;
  valor2018?: Maybe<Scalars["Float"]["output"]>;
  valor2019?: Maybe<Scalars["Float"]["output"]>;
  valor2020?: Maybe<Scalars["Float"]["output"]>;
  valor2021?: Maybe<Scalars["Float"]["output"]>;
  valor2022?: Maybe<Scalars["Float"]["output"]>;
  valor2023?: Maybe<Scalars["Float"]["output"]>;
  valor2024?: Maybe<Scalars["Float"]["output"]>;
  valor2025?: Maybe<Scalars["Float"]["output"]>;
  valor2026?: Maybe<Scalars["Float"]["output"]>;
  valor2027?: Maybe<Scalars["Float"]["output"]>;
  valor2028?: Maybe<Scalars["Float"]["output"]>;
  valor2029?: Maybe<Scalars["Float"]["output"]>;
  valor2030?: Maybe<Scalars["Float"]["output"]>;
  valorTotal?: Maybe<Scalars["Float"]["output"]>;
};

export type LinkGoalToActivity = {
  activityId: Scalars["Int"]["input"];
  goalId: Scalars["Int"]["input"];
  id?: InputMaybe<Scalars["Int"]["input"]>;
};

/** Type of the location */
export enum LocationType {
  Department = "DEPARTMENT",
  District = "DISTRICT",
  Municipality = "MUNICIPALITY",
  Neighborhood = "NEIGHBORHOOD",
  Other = "OTHER",
  RuralSettlement = "RURAL_SETTLEMENT",
  Township = "TOWNSHIP",
}

export type LoginUserAccount = {
  email: Scalars["String"]["input"];
  password: Scalars["String"]["input"];
  tenantId: Scalars["Float"]["input"];
};

export type MacroProject = {
  __typename?: "MacroProject";
  code?: Maybe<Scalars["String"]["output"]>;
  createdAt: Scalars["DateTimeISO"]["output"];
  description?: Maybe<Scalars["String"]["output"]>;
  id: Scalars["Int"]["output"];
  isActive: Scalars["Boolean"]["output"];
  name: Scalars["String"]["output"];
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
};

export type MonitoringConfig = {
  __typename?: "MonitoringConfig";
  colorsConfig?: Maybe<Scalars["JSON"]["output"]>;
  createdAt: Scalars["DateTimeISO"]["output"];
  datesConfig?: Maybe<Scalars["JSON"]["output"]>;
  devPlan?: Maybe<DevPlan>;
  devPlanId?: Maybe<Scalars["Int"]["output"]>;
  goalTypes: Array<GoalType>;
  id: Scalars["Int"]["output"];
  isActive: Scalars["Boolean"]["output"];
  monitoringResourcesOrigin?: Maybe<MonitoringResourcesOrigin>;
  period: Scalars["Int"]["output"];
  periodicity: Scalars["Int"]["output"];
  sgpDiscriminated?: Maybe<Scalars["Boolean"]["output"]>;
  spentDocs: Array<SpentDoc>;
  status: MonitoringStatus;
  statusDates: Array<Scalars["String"]["output"]>;
  subperiod: Scalars["Int"]["output"];
  supportProductMonitoring?: Maybe<Scalars["Boolean"]["output"]>;
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
  usedFor?: Maybe<MonitoringConfigUsedFor>;
  weightingType?: Maybe<WeightingType>;
};

/** The use of Monitoring, like development plan or public politics */
export enum MonitoringConfigUsedFor {
  DevelopmentPlans = "DEVELOPMENT_PLANS",
  PublicPolitics = "PUBLIC_POLITICS",
}

export type MonitoringRecord = {
  __typename?: "MonitoringRecord";
  attachments?: Maybe<Array<MonitoringRecordAttachment>>;
  createdAt: Scalars["DateTimeISO"]["output"];
  createdBy?: Maybe<Scalars["Int"]["output"]>;
  fromMonth: Scalars["Int"]["output"];
  goal: Goal;
  goalAchievedValue?: Maybe<Scalars["Float"]["output"]>;
  goalId: Scalars["Int"]["output"];
  goalValue?: Maybe<Scalars["Float"]["output"]>;
  id: Scalars["Int"]["output"];
  monitoringConfigId: Scalars["Int"]["output"];
  notes?: Maybe<Scalars["String"]["output"]>;
  period: Scalars["Int"]["output"];
  physicalIndicator?: Maybe<Scalars["Float"]["output"]>;
  piGoalAchievedValue?: Maybe<Scalars["Float"]["output"]>;
  piGoalValue?: Maybe<Scalars["Float"]["output"]>;
  questionEvidence?: Maybe<Scalars["String"]["output"]>;
  questionHow?: Maybe<Scalars["String"]["output"]>;
  questionProblem?: Maybe<Scalars["String"]["output"]>;
  questionResult?: Maybe<Scalars["String"]["output"]>;
  recordStatus: MonitoringRecordStatus;
  resources?: Maybe<Array<MonitoringRecordResource>>;
  targetMatrix?: Maybe<Scalars["JSON"]["output"]>;
  toMonth: Scalars["Int"]["output"];
  totalPeople?: Maybe<Scalars["Int"]["output"]>;
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
  updatedBy?: Maybe<Scalars["Int"]["output"]>;
  weighting?: Maybe<Scalars["Float"]["output"]>;
};

export type MonitoringRecordAttachment = {
  __typename?: "MonitoringRecordAttachment";
  createdAt: Scalars["DateTimeISO"]["output"];
  createdBy?: Maybe<Scalars["Int"]["output"]>;
  description?: Maybe<Scalars["String"]["output"]>;
  downloadLink: Scalars["String"]["output"];
  id: Scalars["Int"]["output"];
  monitoringRecordId: Scalars["Int"]["output"];
  name: Scalars["String"]["output"];
  s3Path: Scalars["String"]["output"];
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
  updatedBy?: Maybe<Scalars["Int"]["output"]>;
};

export type MonitoringRecordResource = {
  __typename?: "MonitoringRecordResource";
  capital: Scalars["Float"]["output"];
  cd: Scalars["Float"]["output"];
  cn: Scalars["Float"]["output"];
  createdAt: Scalars["DateTimeISO"]["output"];
  createdBy?: Maybe<Scalars["Int"]["output"]>;
  credit: Scalars["Float"]["output"];
  de: Scalars["Float"]["output"];
  financialIndicator?: Maybe<Scalars["Float"]["output"]>;
  id: Scalars["Int"]["output"];
  management: Scalars["Float"]["output"];
  monitoringRecordId: Scalars["Int"]["output"];
  monopoly: Scalars["Float"]["output"];
  operation: Scalars["Float"]["output"];
  others: Scalars["Float"]["output"];
  resourceType: MonitoringResourceType;
  resourcesTotal: Scalars["Float"]["output"];
  rp: Scalars["Float"]["output"];
  sgp: Scalars["Float"]["output"];
  sgpCulture: Scalars["Float"]["output"];
  sgpEarlyChildhood: Scalars["Float"]["output"];
  sgpEducation: Scalars["Float"]["output"];
  sgpFreeDestination: Scalars["Float"]["output"];
  sgpFreeInvestment: Scalars["Float"]["output"];
  sgpHealt: Scalars["Float"]["output"];
  sgpMagdalenaRiver: Scalars["Float"]["output"];
  sgpSchoolFeeding: Scalars["Float"]["output"];
  sgpSport: Scalars["Float"]["output"];
  sgpWater: Scalars["Float"]["output"];
  sgr: Scalars["Float"]["output"];
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
  updatedBy?: Maybe<Scalars["Int"]["output"]>;
};

/** Status for each monitoring record */
export enum MonitoringRecordStatus {
  Approved = "APPROVED",
  Copied = "COPIED",
  Planned = "PLANNED",
  Rejected = "REJECTED",
  Reported = "REPORTED",
  Reviewed = "REVIEWED",
  Validated = "VALIDATED",
}

export type MonitoringRecordWithStatus = {
  __typename?: "MonitoringRecordWithStatus";
  attachments?: Maybe<Array<MonitoringRecordAttachment>>;
  createdAt: Scalars["DateTimeISO"]["output"];
  createdBy?: Maybe<Scalars["Int"]["output"]>;
  fromMonth: Scalars["Int"]["output"];
  goal: Goal;
  goalAchievedValue?: Maybe<Scalars["Float"]["output"]>;
  goalId: Scalars["Int"]["output"];
  goalStatus: GoalMonitoringRecordStatus;
  goalValue?: Maybe<Scalars["Float"]["output"]>;
  id: Scalars["Int"]["output"];
  monitoringConfigId: Scalars["Int"]["output"];
  notes?: Maybe<Scalars["String"]["output"]>;
  period: Scalars["Int"]["output"];
  physicalIndicator?: Maybe<Scalars["Float"]["output"]>;
  piGoalAchievedValue?: Maybe<Scalars["Float"]["output"]>;
  piGoalValue?: Maybe<Scalars["Float"]["output"]>;
  questionEvidence?: Maybe<Scalars["String"]["output"]>;
  questionHow?: Maybe<Scalars["String"]["output"]>;
  questionProblem?: Maybe<Scalars["String"]["output"]>;
  questionResult?: Maybe<Scalars["String"]["output"]>;
  recordStatus: MonitoringRecordStatus;
  resources?: Maybe<Array<MonitoringRecordResource>>;
  targetMatrix?: Maybe<Scalars["JSON"]["output"]>;
  toMonth: Scalars["Int"]["output"];
  totalPeople?: Maybe<Scalars["Int"]["output"]>;
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
  updatedBy?: Maybe<Scalars["Int"]["output"]>;
  weighting?: Maybe<Scalars["Float"]["output"]>;
};

/** Type for each monitoring resource */
export enum MonitoringResourceType {
  Commitment = "COMMITMENT",
  Definitive = "DEFINITIVE",
  Manual = "MANUAL",
  Obligation = "OBLIGATION",
  Payment = "PAYMENT",
}

/** Where financial data come from */
export enum MonitoringResourcesOrigin {
  Financial = "FINANCIAL",
  User = "USER",
  UserAndFinancial = "USER_AND_FINANCIAL",
}

/** Current monitoring status */
export enum MonitoringStatus {
  Closed = "CLOSED",
  Created = "CREATED",
  Reporting = "REPORTING",
  Reviewing = "REVIEWING",
  Scheduling = "SCHEDULING",
  Validating = "VALIDATING",
}

export type Mutation = {
  __typename?: "Mutation";
  adminChangeUserAccountPassword: UserAccount;
  changeUserAccountPassword: UserAccount;
  copyDevPlan?: Maybe<DevPlan>;
  copyGoalsFromSIIF: Array<Goal>;
  copyMonitoringConfigFromPeriod?: Maybe<Array<MonitoringRecord>>;
  copyMonitoringConfigPreviousSchedule?: Maybe<Array<MonitoringRecord>>;
  createDevPlan: DevPlan;
  createDevPlanLevel: DevPlanLevel;
  createEntity: Entity;
  createGoal: Goal;
  createGoalHistory: GoalHistory;
  createMacroProject: MacroProject;
  createMonitoringConfig: MonitoringConfig;
  createMonitoringRecord: MonitoringRecord;
  createMonitoringRecordAttachmentLink: CreateMonitoringRecordAttachmentLinkResponse;
  createPublicPolitic: PublicPolitic;
  createPublicPoliticComponent: PublicPoliticComponent;
  createSiifActividad: SiifActividad;
  createSiifProyecto: SiifProyecto;
  createTenant: Tenant;
  createUserAccount: UserAccount;
  deleteDevPlan: DevPlan;
  deleteDevPlanLevel: DevPlanLevel;
  deleteDevPlanLevels: Scalars["Int"]["output"];
  deleteEntity: Scalars["Int"]["output"];
  deleteGoal: Goal;
  deleteMacroProject: MacroProject;
  deleteMonitoringConfig: MonitoringConfig;
  deleteMonitoringRecordAttachment: MonitoringRecordAttachment;
  deletePublicPolitic: PublicPolitic;
  deletePublicPoliticComponent: PublicPoliticComponent;
  deleteSiifActividad: SiifActividad;
  deleteSiifActividadMetaAcciones: Array<SiifActividadMetaAccion>;
  deleteSiifActividadMetas: Array<SiifActividadMeta>;
  deleteSiifProyecto: SiifProyecto;
  deleteTenant: Tenant;
  deleteUserAccount: Scalars["Int"]["output"];
  getSupersetGuestToken?: Maybe<Scalars["String"]["output"]>;
  linkGoalToActivity: GoalToActivity;
  savePlannedMonitoringRecord: MonitoringRecord;
  saveSiifActividadMeta: Array<SiifActividadMeta>;
  saveSiifActividadMetaAccion: Array<SiifActividadMetaAccion>;
  saveTrackingMonitoringRecord: MonitoringRecord;
  setActiveMonitoringConfig: MonitoringConfig;
  updateDevPlan: DevPlan;
  updateDevPlanLevel: DevPlanLevel;
  updateEntity: Entity;
  updateGoal: Goal;
  updateMacroProject: MacroProject;
  updateMonitoringConfig: MonitoringConfig;
  updateMonitoringRecord: MonitoringRecord;
  updatePublicPolitic: PublicPolitic;
  updatePublicPoliticComponent: PublicPoliticComponent;
  updateSiifActividad: SiifActividad;
  updateSiifProyecto: SiifProyecto;
  updateTenant: Tenant;
  updateUserAccount: UserAccount;
};

export type MutationAdminChangeUserAccountPasswordArgs = {
  data: AdminChangeUserAccountPassword;
};

export type MutationChangeUserAccountPasswordArgs = {
  data: ChangeUserAccountPassword;
};

export type MutationCopyDevPlanArgs = {
  data: CopyDevPlan;
};

export type MutationCopyGoalsFromSiifArgs = {
  devPlanId: Scalars["Float"]["input"];
};

export type MutationCopyMonitoringConfigFromPeriodArgs = {
  data: CopyMonitoringConfigFromPeriod;
};

export type MutationCopyMonitoringConfigPreviousScheduleArgs = {
  data: CopyMonitoringConfigPreviousSchedule;
};

export type MutationCreateDevPlanArgs = {
  data: CreateDevPlan;
};

export type MutationCreateDevPlanLevelArgs = {
  data: CreateDevPlanLevel;
};

export type MutationCreateEntityArgs = {
  data: CreateEntity;
};

export type MutationCreateGoalArgs = {
  data: CreateGoal;
};

export type MutationCreateGoalHistoryArgs = {
  data: CreateGoalHistory;
};

export type MutationCreateMacroProjectArgs = {
  data: CreateMacroProject;
};

export type MutationCreateMonitoringConfigArgs = {
  data: CreateMonitoringConfig;
};

export type MutationCreateMonitoringRecordArgs = {
  data: CreateMonitoringRecord;
};

export type MutationCreateMonitoringRecordAttachmentLinkArgs = {
  data: CreateMonitoringRecordAttachmentLink;
};

export type MutationCreatePublicPoliticArgs = {
  data: CreatePublicPolitic;
};

export type MutationCreatePublicPoliticComponentArgs = {
  data: CreatePublicPoliticComponent;
};

export type MutationCreateSiifActividadArgs = {
  data: CreateSiifActividad;
};

export type MutationCreateSiifProyectoArgs = {
  data: CreateSiifProyecto;
};

export type MutationCreateTenantArgs = {
  data: CreateTenant;
};

export type MutationCreateUserAccountArgs = {
  data: CreateUserAccount;
};

export type MutationDeleteDevPlanArgs = {
  id: Scalars["Int"]["input"];
};

export type MutationDeleteDevPlanLevelArgs = {
  id: Scalars["Int"]["input"];
};

export type MutationDeleteDevPlanLevelsArgs = {
  ids: Array<Scalars["Int"]["input"]>;
};

export type MutationDeleteEntityArgs = {
  id: Scalars["Int"]["input"];
};

export type MutationDeleteGoalArgs = {
  id: Scalars["Int"]["input"];
};

export type MutationDeleteMacroProjectArgs = {
  id: Scalars["Int"]["input"];
};

export type MutationDeleteMonitoringConfigArgs = {
  id: Scalars["Int"]["input"];
};

export type MutationDeleteMonitoringRecordAttachmentArgs = {
  id: Scalars["Int"]["input"];
};

export type MutationDeletePublicPoliticArgs = {
  id: Scalars["Int"]["input"];
};

export type MutationDeletePublicPoliticComponentArgs = {
  id: Scalars["Int"]["input"];
};

export type MutationDeleteSiifActividadArgs = {
  data: DeleteSiifActividad;
};

export type MutationDeleteSiifActividadMetaAccionesArgs = {
  data: DeleteSiifActividadMetaAcciones;
};

export type MutationDeleteSiifActividadMetasArgs = {
  data: DeleteSiifActividadMetas;
};

export type MutationDeleteSiifProyectoArgs = {
  data: DeleteSiifProyecto;
};

export type MutationDeleteTenantArgs = {
  id: Scalars["Int"]["input"];
};

export type MutationDeleteUserAccountArgs = {
  id: Scalars["Int"]["input"];
};

export type MutationGetSupersetGuestTokenArgs = {
  data: GetSupersetGuestTokenParams;
};

export type MutationLinkGoalToActivityArgs = {
  data: LinkGoalToActivity;
};

export type MutationSavePlannedMonitoringRecordArgs = {
  data: SavePlannedMonitoringRecord;
};

export type MutationSaveSiifActividadMetaArgs = {
  data: Array<CreateSiifActividadMeta>;
};

export type MutationSaveSiifActividadMetaAccionArgs = {
  data: Array<CreateSiifActividadMetaAccion>;
};

export type MutationSaveTrackingMonitoringRecordArgs = {
  data: SaveTrackingMonitoringRecord;
};

export type MutationSetActiveMonitoringConfigArgs = {
  data: SetActiveMonitoringConfig;
};

export type MutationUpdateDevPlanArgs = {
  data: UpdateDevPlan;
};

export type MutationUpdateDevPlanLevelArgs = {
  data: UpdateDevPlanLevel;
};

export type MutationUpdateEntityArgs = {
  data: UpdateEntity;
};

export type MutationUpdateGoalArgs = {
  data: UpdateGoal;
};

export type MutationUpdateMacroProjectArgs = {
  data: UpdateMacroProject;
};

export type MutationUpdateMonitoringConfigArgs = {
  data: UpdateMonitoringConfig;
};

export type MutationUpdateMonitoringRecordArgs = {
  data: UpdateMonitoringRecord;
};

export type MutationUpdatePublicPoliticArgs = {
  data: UpdatePublicPolitic;
};

export type MutationUpdatePublicPoliticComponentArgs = {
  data: UpdatePublicPoliticComponent;
};

export type MutationUpdateSiifActividadArgs = {
  data: UpdateSiifActividad;
};

export type MutationUpdateSiifProyectoArgs = {
  data: UpdateSiifProyecto;
};

export type MutationUpdateTenantArgs = {
  data: UpdateTenant;
};

export type MutationUpdateUserAccountArgs = {
  data: UpdateUserAccount;
};

export type Ods = {
  __typename?: "Ods";
  id: Scalars["Int"]["output"];
  name: Scalars["String"]["output"];
};

export type PlanDesarrollo = {
  __typename?: "PlanDesarrollo";
  ejes?: Maybe<Array<EjeEstructurante>>;
  etiquetaEjePlural?: Maybe<Scalars["String"]["output"]>;
  etiquetaEjeSingular?: Maybe<Scalars["String"]["output"]>;
  etiquetaProgramaPlural?: Maybe<Scalars["String"]["output"]>;
  etiquetaProgramaSingular?: Maybe<Scalars["String"]["output"]>;
  etiquetaSectorPlural?: Maybe<Scalars["String"]["output"]>;
  etiquetaSectorSingular?: Maybe<Scalars["String"]["output"]>;
  etiquetaSubprogramaPlural?: Maybe<Scalars["String"]["output"]>;
  etiquetaSubprogramaSingular?: Maybe<Scalars["String"]["output"]>;
  fechaFin: Scalars["DateTimeISO"]["output"];
  fechaInicio: Scalars["DateTimeISO"]["output"];
  gobernante?: Maybe<Scalars["String"]["output"]>;
  id?: Maybe<Scalars["Int"]["output"]>;
  manejaSector?: Maybe<Scalars["String"]["output"]>;
  nitCompania: Scalars["String"]["output"];
  nivelMp?: Maybe<Scalars["Int"]["output"]>;
  nivelMr?: Maybe<Scalars["Int"]["output"]>;
  nombre: Scalars["String"]["output"];
  objetivo?: Maybe<Scalars["String"]["output"]>;
  plan: Scalars["Int"]["output"];
};

export type ProductCatalog = {
  __typename?: "ProductCatalog";
  code: Scalars["String"]["output"];
  createdAt: Scalars["DateTimeISO"]["output"];
  description?: Maybe<Scalars["String"]["output"]>;
  id: Scalars["Int"]["output"];
  isActive: Scalars["Boolean"]["output"];
  isLeaf?: Maybe<Scalars["Boolean"]["output"]>;
  isNational?: Maybe<Scalars["Boolean"]["output"]>;
  isPrincipal?: Maybe<Scalars["Boolean"]["output"]>;
  isTerritorial?: Maybe<Scalars["Boolean"]["output"]>;
  name: Scalars["String"]["output"];
  parentId?: Maybe<Scalars["Int"]["output"]>;
  product: ProductCatalog;
  program: ProductCatalog;
  sector: ProductCatalog;
  unitsName?: Maybe<Scalars["String"]["output"]>;
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
};

export type ProductCatalogResponse = {
  __typename?: "ProductCatalogResponse";
  count: Scalars["Int"]["output"];
  filters?: Maybe<Scalars["JSON"]["output"]>;
  items: Array<ProductCatalog>;
};

export type ProgramaPry = {
  __typename?: "ProgramaPry";
  activo?: Maybe<Scalars["String"]["output"]>;
  codigo?: Maybe<Scalars["String"]["output"]>;
  eje: Scalars["Int"]["output"];
  id?: Maybe<Scalars["Int"]["output"]>;
  nitCompania: Scalars["String"]["output"];
  nombre: Scalars["String"]["output"];
  plan: Scalars["Int"]["output"];
  programa: Scalars["Int"]["output"];
  sector: Scalars["Int"]["output"];
  subprogramas?: Maybe<Array<SubprogramaPry>>;
};

export type Proyecto = {
  __typename?: "Proyecto";
  actividades?: Maybe<Array<VActividadesPryWithGoals>>;
  ano?: Maybe<Scalars["Int"]["output"]>;
  anoRegistro?: Maybe<Scalars["String"]["output"]>;
  avanceCualitativo?: Maybe<Scalars["Float"]["output"]>;
  codPrograma?: Maybe<Scalars["Int"]["output"]>;
  codSector?: Maybe<Scalars["Int"]["output"]>;
  codigo?: Maybe<Scalars["String"]["output"]>;
  codigoEntPry?: Maybe<Scalars["String"]["output"]>;
  codigoEntPryPresen?: Maybe<Scalars["String"]["output"]>;
  codigoEntidadPresenta?: Maybe<Scalars["String"]["output"]>;
  codigoSectorFut?: Maybe<Scalars["String"]["output"]>;
  descEje?: Maybe<Scalars["String"]["output"]>;
  descEjeCap?: Maybe<Scalars["String"]["output"]>;
  descPlan: Scalars["String"]["output"];
  descPrograma?: Maybe<Scalars["String"]["output"]>;
  descProgramaCap?: Maybe<Scalars["String"]["output"]>;
  descSector?: Maybe<Scalars["String"]["output"]>;
  descSectorCap?: Maybe<Scalars["String"]["output"]>;
  descSectorFut?: Maybe<Scalars["String"]["output"]>;
  descSectorFutCap?: Maybe<Scalars["String"]["output"]>;
  descSubprograma?: Maybe<Scalars["String"]["output"]>;
  descSubprogramaCap?: Maybe<Scalars["String"]["output"]>;
  descripcion?: Maybe<Scalars["String"]["output"]>;
  devPlan?: Maybe<DevPlan>;
  diaRegistro?: Maybe<Scalars["String"]["output"]>;
  eje: Scalars["Int"]["output"];
  emailDestinatarios?: Maybe<Scalars["String"]["output"]>;
  entity?: Maybe<Entity>;
  estado?: Maybe<Scalars["String"]["output"]>;
  estadoProceso?: Maybe<Scalars["String"]["output"]>;
  evaluadoPor?: Maybe<Scalars["String"]["output"]>;
  fechaAct?: Maybe<Scalars["DateTimeISO"]["output"]>;
  fechaCreacion?: Maybe<Scalars["DateTimeISO"]["output"]>;
  fechaDev?: Maybe<Scalars["DateTimeISO"]["output"]>;
  fechaEvaluacion?: Maybe<Scalars["DateTimeISO"]["output"]>;
  fechaRadicacion?: Maybe<Scalars["String"]["output"]>;
  fechaRadicacionFmt?: Maybe<Scalars["String"]["output"]>;
  fechaRegistro?: Maybe<Scalars["DateTimeISO"]["output"]>;
  fechaViabilidad?: Maybe<Scalars["DateTimeISO"]["output"]>;
  ficticio?: Maybe<Scalars["String"]["output"]>;
  firmaUsuario?: Maybe<Scalars["String"]["output"]>;
  formuladoPor?: Maybe<Scalars["String"]["output"]>;
  goal?: Maybe<Goal>;
  idEntidad?: Maybe<Scalars["Int"]["output"]>;
  idEntidadPresenta?: Maybe<Scalars["Int"]["output"]>;
  idPlan?: Maybe<Scalars["Int"]["output"]>;
  idSesion?: Maybe<Scalars["String"]["output"]>;
  idSubprograma?: Maybe<Scalars["Int"]["output"]>;
  item?: Maybe<Scalars["Int"]["output"]>;
  mesRegistro?: Maybe<Scalars["String"]["output"]>;
  metaProducto?: Maybe<Scalars["String"]["output"]>;
  migrado?: Maybe<Scalars["String"]["output"]>;
  nitCompania: Scalars["String"]["output"];
  nombre: Scalars["String"]["output"];
  nombreEje: Scalars["String"]["output"];
  nombreEntPry?: Maybe<Scalars["String"]["output"]>;
  nombreEntidad?: Maybe<Scalars["String"]["output"]>;
  nombreEntidadPresenta?: Maybe<Scalars["String"]["output"]>;
  nombreMesRegistro?: Maybe<Scalars["String"]["output"]>;
  nombrePrograma: Scalars["String"]["output"];
  nombreProyecto: Scalars["String"]["output"];
  nombreSecretaria?: Maybe<Scalars["String"]["output"]>;
  nombreSector: Scalars["String"]["output"];
  nombreSectorFut?: Maybe<Scalars["String"]["output"]>;
  nombreSubprograma?: Maybe<Scalars["String"]["output"]>;
  nombreentidad?: Maybe<Scalars["String"]["output"]>;
  nombresecretaria?: Maybe<Scalars["String"]["output"]>;
  objetivos?: Maybe<Scalars["String"]["output"]>;
  observacion?: Maybe<Scalars["String"]["output"]>;
  plan: Scalars["Int"]["output"];
  presentadoPor?: Maybe<Scalars["String"]["output"]>;
  presupuestoDef?: Maybe<Scalars["Int"]["output"]>;
  presupuestoDefFmt?: Maybe<Scalars["String"]["output"]>;
  programa: Scalars["Int"]["output"];
  proyecto: Scalars["String"]["output"];
  recurso1?: Maybe<Scalars["String"]["output"]>;
  recurso2?: Maybe<Scalars["String"]["output"]>;
  recurso3?: Maybe<Scalars["String"]["output"]>;
  rubroFut?: Maybe<Scalars["String"]["output"]>;
  saldoPpto?: Maybe<Scalars["Int"]["output"]>;
  saldoPptoFmt?: Maybe<Scalars["String"]["output"]>;
  sector: Scalars["Int"]["output"];
  solicitudAcum?: Maybe<Scalars["Int"]["output"]>;
  solicitudAcumFmt?: Maybe<Scalars["String"]["output"]>;
  subprograma?: Maybe<Scalars["Int"]["output"]>;
  subprogramaPry?: Maybe<Scalars["Int"]["output"]>;
  txtMesRegistro?: Maybe<Scalars["String"]["output"]>;
  usuario?: Maybe<Scalars["String"]["output"]>;
  valRec1?: Maybe<Scalars["Float"]["output"]>;
  valRec2?: Maybe<Scalars["Float"]["output"]>;
  valRec3?: Maybe<Scalars["Float"]["output"]>;
  valor?: Maybe<Scalars["Float"]["output"]>;
  valorProyecto?: Maybe<Scalars["Float"]["output"]>;
  valorProyectoFmt?: Maybe<Scalars["String"]["output"]>;
  valorVigencia?: Maybe<Scalars["Float"]["output"]>;
  valorVigenciaFmt?: Maybe<Scalars["String"]["output"]>;
  verDesde?: Maybe<Scalars["Float"]["output"]>;
  viabilizadoPor?: Maybe<Scalars["String"]["output"]>;
  viableAmbientalmente?: Maybe<Scalars["String"]["output"]>;
  viableAmbientalmenteTxt?: Maybe<Scalars["String"]["output"]>;
  viableEconomicamente?: Maybe<Scalars["String"]["output"]>;
  viableEconomicamenteTxt?: Maybe<Scalars["String"]["output"]>;
  viableFinancieramente?: Maybe<Scalars["String"]["output"]>;
  viableFinancieramenteTxt?: Maybe<Scalars["String"]["output"]>;
  viableInstitucionalmente?: Maybe<Scalars["String"]["output"]>;
  viableInstitucionalmenteTxt?: Maybe<Scalars["String"]["output"]>;
  viableSostenibilidad?: Maybe<Scalars["String"]["output"]>;
  viableSostenibilidadTxt?: Maybe<Scalars["String"]["output"]>;
  viableTecnicamente?: Maybe<Scalars["String"]["output"]>;
  viableTecnicamenteTxt?: Maybe<Scalars["String"]["output"]>;
  vigencia?: Maybe<Scalars["Int"]["output"]>;
  vigenciaFinal?: Maybe<Scalars["String"]["output"]>;
  vigenciaInicial?: Maybe<Scalars["String"]["output"]>;
};

export type PublicPolitic = {
  __typename?: "PublicPolitic";
  category: PublicPoliticCategory;
  code?: Maybe<Scalars["String"]["output"]>;
  components?: Maybe<Array<PublicPoliticComponent>>;
  createdAt: Scalars["DateTimeISO"]["output"];
  description?: Maybe<Scalars["String"]["output"]>;
  fromYear?: Maybe<Scalars["Int"]["output"]>;
  goalCount: Scalars["Int"]["output"];
  goals?: Maybe<Array<Goal>>;
  id: Scalars["Int"]["output"];
  isActive: Scalars["Boolean"]["output"];
  name: Scalars["String"]["output"];
  toYear?: Maybe<Scalars["Int"]["output"]>;
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
};

/** Category for public politics */
export enum PublicPoliticCategory {
  Peace = "PEACE",
  Territory = "TERRITORY",
  Victims = "VICTIMS",
}

export type PublicPoliticComponent = {
  __typename?: "PublicPoliticComponent";
  code?: Maybe<Scalars["String"]["output"]>;
  createdAt: Scalars["DateTimeISO"]["output"];
  description?: Maybe<Scalars["String"]["output"]>;
  id: Scalars["Int"]["output"];
  isActive: Scalars["Boolean"]["output"];
  name: Scalars["String"]["output"];
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
};

export type Query = {
  __typename?: "Query";
  GetGoalResources?: Maybe<Array<GetGoalResourcesResponse>>;
  dashboardGoalsFormat?: Maybe<Scalars["String"]["output"]>;
  getActiveMonitoringConfig?: Maybe<MonitoringConfig>;
  getActividades?: Maybe<Array<VActividadesPry>>;
  getDevPlan?: Maybe<DevPlan>;
  getDevPlanByCode?: Maybe<DevPlan>;
  getDevPlanLevel?: Maybe<DevPlanLevel>;
  getDevPlanLevels: Array<DevPlanLevel>;
  getDevPlanLevelsTree: Array<DevPlanLevel>;
  getDevPlans: Array<DevPlan>;
  getEjes: Array<EjeEstructurante>;
  getEntities: Array<Entity>;
  getEntity?: Maybe<Entity>;
  getGeoLocation?: Maybe<GeoLocation>;
  getGeoLocations: Array<GeoLocation>;
  getGeoLocationsTree: Array<GeoLocation>;
  getGoal?: Maybe<Goal>;
  getGoalHistory?: Maybe<Array<GoalHistory>>;
  getGoalTypeStats?: Maybe<Array<GetGoalTypeStatsResponse>>;
  getGoals: Array<Goal>;
  getGoalsToCopyFromSIIF: GetGoalsToCopyFromSiifResponse;
  getMacroProject?: Maybe<MacroProject>;
  getMacroProjects: Array<MacroProject>;
  getMetas?: Maybe<Array<VSpdMeta>>;
  getMonitoringConfig?: Maybe<MonitoringConfig>;
  getMonitoringConfigs: Array<MonitoringConfig>;
  getMonitoringRecord?: Maybe<MonitoringRecord>;
  getMonitoringRecordAttachment?: Maybe<MonitoringRecordAttachment>;
  getMonitoringRecordAttachments?: Maybe<Array<MonitoringRecordAttachment>>;
  getOds?: Maybe<Ods>;
  getOdss: Array<Ods>;
  getParentLevelGoals: Array<Goal>;
  getPlanDesarrollo?: Maybe<PlanDesarrollo>;
  getPlanDesarrolloByCode?: Maybe<PlanDesarrollo>;
  getPlanesDesarrollo: Array<PlanDesarrollo>;
  getProductIndicators?: Maybe<ProductCatalogResponse>;
  getProductSectors?: Maybe<ProductCatalogResponse>;
  getProgramas: Array<ProgramaPry>;
  getProyecto?: Maybe<Proyecto>;
  getProyectosForSchedule?: Maybe<SearchProyectoResponse>;
  getPublicPolitic?: Maybe<PublicPolitic>;
  getPublicPoliticComponent?: Maybe<PublicPoliticComponent>;
  getPublicPoliticComponents: Array<PublicPoliticComponent>;
  getPublicPoliticGoals: Array<Goal>;
  getPublicPolitics: Array<PublicPolitic>;
  getSectores: Array<Sector>;
  getSiifActividadByCode?: Maybe<SiifActividad>;
  getSiifActividadById?: Maybe<SiifActividad>;
  getSiifActividadMetaAcciones: Array<SiifActividadMetaAccion>;
  getSiifActividadMetas: Array<SiifActividadMeta>;
  getSiifActividades: Array<SiifActividad>;
  getSiifProyecto?: Maybe<SiifProyecto>;
  getSiifProyectos: Array<SiifProyecto>;
  getTenant?: Maybe<Tenant>;
  getTenantByKey?: Maybe<Tenant>;
  getTenants: Array<Tenant>;
  getUnit?: Maybe<Unit>;
  getUnits: Array<Unit>;
  getUserAccount?: Maybe<UserAccount>;
  getUserAccounts: Array<UserAccount>;
  oracleTest: Scalars["JSON"]["output"];
  refreshToken?: Maybe<UserLoggedIn>;
  s3UploadTest?: Maybe<Scalars["String"]["output"]>;
  searchDevPlanLevels?: Maybe<Array<DevPlanLevel>>;
  searchEntities?: Maybe<SearchEntityResponse>;
  searchGoals?: Maybe<SearchGoalsResponse>;
  searchGoalsFormat?: Maybe<Scalars["String"]["output"]>;
  searchProductIndicators?: Maybe<ProductCatalogResponse>;
  searchProyectos?: Maybe<SearchProyectoResponse>;
  searchPublicPolitics: SearchPublicPoliticResponse;
  searchSiifProyectos?: Maybe<SearchSiifProyectoResponse>;
  searchUserAccounts?: Maybe<SearchUserAccountResponse>;
  userLogin?: Maybe<UserLoggedIn>;
};

export type QueryGetGoalResourcesArgs = {
  data: GetGoalResources;
};

export type QueryDashboardGoalsFormatArgs = {
  data: SearchGoalsFormat;
};

export type QueryGetActiveMonitoringConfigArgs = {
  data?: InputMaybe<GetMonitoringConfig>;
};

export type QueryGetActividadesArgs = {
  proyecto: Scalars["String"]["input"];
};

export type QueryGetDevPlanArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetDevPlanByCodeArgs = {
  code: Scalars["String"]["input"];
};

export type QueryGetDevPlanLevelArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetDevPlanLevelsArgs = {
  devPlanId: Scalars["Int"]["input"];
};

export type QueryGetDevPlanLevelsTreeArgs = {
  devPlanId: Scalars["Int"]["input"];
  getRootAsNode?: Scalars["Boolean"]["input"];
};

export type QueryGetEjesArgs = {
  plan: Scalars["Int"]["input"];
};

export type QueryGetEntityArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetGeoLocationArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetGoalArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetGoalHistoryArgs = {
  goalId: Scalars["Int"]["input"];
};

export type QueryGetGoalTypeStatsArgs = {
  data: GetGoalTypeStats;
};

export type QueryGetGoalsArgs = {
  devPlanLevelId: Scalars["Int"]["input"];
  goalTypes?: InputMaybe<Array<GoalType>>;
};

export type QueryGetGoalsToCopyFromSiifArgs = {
  devPlanId: Scalars["Float"]["input"];
};

export type QueryGetMacroProjectArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetMetasArgs = {
  data: SearchSpdMeta;
};

export type QueryGetMonitoringConfigArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetMonitoringConfigsArgs = {
  data?: InputMaybe<GetMonitoringConfig>;
};

export type QueryGetMonitoringRecordArgs = {
  data: GetMonitoringRecord;
};

export type QueryGetMonitoringRecordAttachmentArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetMonitoringRecordAttachmentsArgs = {
  monitoringRecordId: Scalars["Int"]["input"];
};

export type QueryGetOdsArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetParentLevelGoalsArgs = {
  devPlanLevelId: Scalars["Int"]["input"];
};

export type QueryGetPlanDesarrolloArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetPlanDesarrolloByCodeArgs = {
  code: Scalars["String"]["input"];
};

export type QueryGetProgramasArgs = {
  eje: Scalars["Int"]["input"];
  plan: Scalars["Int"]["input"];
  sector: Scalars["Int"]["input"];
};

export type QueryGetProyectoArgs = {
  codigo: Scalars["String"]["input"];
};

export type QueryGetProyectosForScheduleArgs = {
  data: SearchProyectoForSchedule;
};

export type QueryGetPublicPoliticArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetPublicPoliticComponentArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetPublicPoliticGoalsArgs = {
  publicPoliticId: Scalars["Int"]["input"];
};

export type QueryGetSectoresArgs = {
  eje: Scalars["Int"]["input"];
  plan: Scalars["Int"]["input"];
};

export type QueryGetSiifActividadByCodeArgs = {
  codigoAct: Scalars["Int"]["input"];
  proyecto: Scalars["String"]["input"];
};

export type QueryGetSiifActividadByIdArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetSiifActividadMetaAccionesArgs = {
  actividadMetaId: Scalars["Int"]["input"];
};

export type QueryGetSiifActividadMetasArgs = {
  codigoAct: Scalars["Int"]["input"];
  proyecto: Scalars["String"]["input"];
};

export type QueryGetSiifActividadesArgs = {
  proyecto: Scalars["String"]["input"];
};

export type QueryGetSiifProyectoArgs = {
  proyecto: Scalars["String"]["input"];
};

export type QueryGetTenantArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetTenantByKeyArgs = {
  key: Scalars["String"]["input"];
};

export type QueryGetUnitArgs = {
  id: Scalars["Int"]["input"];
};

export type QueryGetUserAccountArgs = {
  id: Scalars["Int"]["input"];
};

export type QuerySearchDevPlanLevelsArgs = {
  data: SearchDevPlanLevel;
};

export type QuerySearchEntitiesArgs = {
  data: SearchEntity;
};

export type QuerySearchGoalsArgs = {
  data: SearchGoals;
};

export type QuerySearchGoalsFormatArgs = {
  data: SearchGoalsFormat;
};

export type QuerySearchProductIndicatorsArgs = {
  data: SearchProductCatalog;
};

export type QuerySearchProyectosArgs = {
  data: SearchProyecto;
};

export type QuerySearchPublicPoliticsArgs = {
  data: SearchPublicPolitic;
};

export type QuerySearchSiifProyectosArgs = {
  data: SearchSiifProyecto;
};

export type QuerySearchUserAccountsArgs = {
  data: SearchUserAccount;
};

export type QueryUserLoginArgs = {
  data: LoginUserAccount;
};

/** User role for SPD accounts */
export enum SpdRole {
  Admin = "ADMIN",
  Auditor = "AUDITOR",
  Operator = "OPERATOR",
  Validator = "VALIDATOR",
}

export type SaveLinkedMonitoringRecordResource = {
  capital?: Scalars["Float"]["input"];
  cd?: Scalars["Float"]["input"];
  cn?: Scalars["Float"]["input"];
  credit?: Scalars["Float"]["input"];
  de?: Scalars["Float"]["input"];
  id?: InputMaybe<Scalars["Int"]["input"]>;
  management?: Scalars["Float"]["input"];
  monitoringRecordId?: InputMaybe<Scalars["Int"]["input"]>;
  monopoly?: Scalars["Float"]["input"];
  operation?: Scalars["Float"]["input"];
  others?: Scalars["Float"]["input"];
  resourceType: MonitoringResourceType;
  rp?: Scalars["Float"]["input"];
  sgp?: Scalars["Float"]["input"];
  sgpCulture?: Scalars["Float"]["input"];
  sgpEarlyChildhood?: Scalars["Float"]["input"];
  sgpEducation?: Scalars["Float"]["input"];
  sgpFreeDestination?: Scalars["Float"]["input"];
  sgpFreeInvestment?: Scalars["Float"]["input"];
  sgpHealt?: Scalars["Float"]["input"];
  sgpMagdalenaRiver?: Scalars["Float"]["input"];
  sgpSchoolFeeding?: Scalars["Float"]["input"];
  sgpSport?: Scalars["Float"]["input"];
  sgpWater?: Scalars["Float"]["input"];
  sgr?: Scalars["Float"]["input"];
};

export type SavePlannedMonitoringRecord = {
  fromMonth?: Scalars["Int"]["input"];
  goalId: Scalars["Int"]["input"];
  goalValue?: InputMaybe<Scalars["Float"]["input"]>;
  id?: InputMaybe<Scalars["Int"]["input"]>;
  monitoringConfigId: Scalars["Int"]["input"];
  monitoringResources?: InputMaybe<Array<SaveLinkedMonitoringRecordResource>>;
  period: Scalars["Int"]["input"];
  piGoalValue?: InputMaybe<Scalars["Float"]["input"]>;
  toMonth?: Scalars["Int"]["input"];
  weighting?: InputMaybe<Scalars["Float"]["input"]>;
};

export type SaveTrackingMonitoringRecord = {
  goalAchievedValue: Scalars["Float"]["input"];
  id?: InputMaybe<Scalars["Int"]["input"]>;
  monitoringConfigId: Scalars["Int"]["input"];
  monitoringResources?: InputMaybe<Array<SaveLinkedMonitoringRecordResource>>;
  notes?: InputMaybe<Scalars["String"]["input"]>;
  period: Scalars["Int"]["input"];
  piGoalAchievedValue?: InputMaybe<Scalars["Float"]["input"]>;
  questionEvidence?: InputMaybe<Scalars["String"]["input"]>;
  questionHow?: InputMaybe<Scalars["String"]["input"]>;
  questionProblem?: InputMaybe<Scalars["String"]["input"]>;
  questionResult?: InputMaybe<Scalars["String"]["input"]>;
  recordStatus?: InputMaybe<MonitoringRecordStatus>;
  reviewNotes?: InputMaybe<Scalars["String"]["input"]>;
  targetMatrix?: InputMaybe<Scalars["JSON"]["input"]>;
};

export type SearchDevPlanLevel = {
  code?: InputMaybe<Scalars["String"]["input"]>;
  devPlanId?: InputMaybe<Scalars["Int"]["input"]>;
  id?: InputMaybe<Scalars["Int"]["input"]>;
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  level?: InputMaybe<Scalars["Int"]["input"]>;
  name?: InputMaybe<Scalars["String"]["input"]>;
  parentId?: InputMaybe<Scalars["Int"]["input"]>;
  productCatalogId?: InputMaybe<Scalars["Int"]["input"]>;
};

export type SearchEntity = {
  active?: InputMaybe<Array<Scalars["Boolean"]["input"]>>;
  code?: InputMaybe<Scalars["String"]["input"]>;
  endDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  hasManualBudget?: InputMaybe<Scalars["Boolean"]["input"]>;
  id?: InputMaybe<Scalars["Int"]["input"]>;
  limit?: InputMaybe<Scalars["Int"]["input"]>;
  name?: InputMaybe<Scalars["String"]["input"]>;
  offset?: InputMaybe<Scalars["Int"]["input"]>;
  parentId?: InputMaybe<Scalars["Int"]["input"]>;
  sort?: InputMaybe<SortInput>;
  startDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  text?: InputMaybe<Scalars["String"]["input"]>;
};

export type SearchEntityResponse = {
  __typename?: "SearchEntityResponse";
  count: Scalars["Int"]["output"];
  filters?: Maybe<Scalars["JSON"]["output"]>;
  items: Array<Entity>;
};

export type SearchGoals = {
  accumulationType?: InputMaybe<AccumulationType>;
  baseValue?: InputMaybe<Scalars["Float"]["input"]>;
  code?: InputMaybe<Scalars["String"]["input"]>;
  description?: InputMaybe<Scalars["String"]["input"]>;
  devPlanId?: InputMaybe<Scalars["Int"]["input"]>;
  devPlanLevelId?: InputMaybe<Scalars["Int"]["input"]>;
  devPlanLevelIds?: InputMaybe<Array<Scalars["Int"]["input"]>>;
  endDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  entityId?: InputMaybe<Scalars["Int"]["input"]>;
  entityIds?: InputMaybe<Array<Scalars["Int"]["input"]>>;
  formula?: InputMaybe<Scalars["String"]["input"]>;
  goalType?: InputMaybe<GoalType>;
  goalTypes?: InputMaybe<Array<GoalType>>;
  goalValue?: InputMaybe<Scalars["Float"]["input"]>;
  id?: InputMaybe<Scalars["Int"]["input"]>;
  ids?: InputMaybe<Array<Scalars["Int"]["input"]>>;
  indicator?: InputMaybe<Scalars["String"]["input"]>;
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  isBaseValueNotAvailable?: InputMaybe<Scalars["Boolean"]["input"]>;
  isReported?: InputMaybe<Scalars["Boolean"]["input"]>;
  isReviewed?: InputMaybe<Scalars["Boolean"]["input"]>;
  isScheduled?: InputMaybe<Scalars["Boolean"]["input"]>;
  isValidated?: InputMaybe<Scalars["Boolean"]["input"]>;
  limit?: InputMaybe<Scalars["Int"]["input"]>;
  macroProjectId?: InputMaybe<Scalars["Int"]["input"]>;
  monitoringConfigId?: InputMaybe<Scalars["Int"]["input"]>;
  name?: InputMaybe<Scalars["String"]["input"]>;
  odsIds?: InputMaybe<Scalars["JSON"]["input"]>;
  offset?: InputMaybe<Scalars["Int"]["input"]>;
  parentGoalId?: InputMaybe<Scalars["Int"]["input"]>;
  peacePoliticId?: InputMaybe<Scalars["Int"]["input"]>;
  productCatalogId?: InputMaybe<Scalars["Int"]["input"]>;
  publicPoliticComponentId?: InputMaybe<Scalars["Int"]["input"]>;
  publicPoliticId?: InputMaybe<Scalars["Int"]["input"]>;
  sort?: InputMaybe<SortInput>;
  stage?: InputMaybe<MonitoringStatus>;
  startDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  text?: InputMaybe<Scalars["String"]["input"]>;
  unitsFactor?: InputMaybe<Scalars["Int"]["input"]>;
  unitsName?: InputMaybe<Scalars["String"]["input"]>;
  victimsPoliticId?: InputMaybe<Scalars["Int"]["input"]>;
};

export type SearchGoalsFormat = {
  accumulationType?: InputMaybe<AccumulationType>;
  baseValue?: InputMaybe<Scalars["Float"]["input"]>;
  code?: InputMaybe<Scalars["String"]["input"]>;
  description?: InputMaybe<Scalars["String"]["input"]>;
  devPlanId?: InputMaybe<Scalars["Int"]["input"]>;
  devPlanLevelId?: InputMaybe<Scalars["Int"]["input"]>;
  devPlanLevelIds?: InputMaybe<Array<Scalars["Int"]["input"]>>;
  endDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  entityId?: InputMaybe<Scalars["Int"]["input"]>;
  entityIds?: InputMaybe<Array<Scalars["Int"]["input"]>>;
  format?: ExportFormat;
  formula?: InputMaybe<Scalars["String"]["input"]>;
  goalType?: InputMaybe<GoalType>;
  goalTypes?: InputMaybe<Array<GoalType>>;
  goalValue?: InputMaybe<Scalars["Float"]["input"]>;
  id?: InputMaybe<Scalars["Int"]["input"]>;
  ids?: InputMaybe<Array<Scalars["Int"]["input"]>>;
  indicator?: InputMaybe<Scalars["String"]["input"]>;
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  isBaseValueNotAvailable?: InputMaybe<Scalars["Boolean"]["input"]>;
  isReported?: InputMaybe<Scalars["Boolean"]["input"]>;
  isReviewed?: InputMaybe<Scalars["Boolean"]["input"]>;
  isScheduled?: InputMaybe<Scalars["Boolean"]["input"]>;
  isValidated?: InputMaybe<Scalars["Boolean"]["input"]>;
  limit?: InputMaybe<Scalars["Int"]["input"]>;
  macroProjectId?: InputMaybe<Scalars["Int"]["input"]>;
  monitoringConfigId?: InputMaybe<Scalars["Int"]["input"]>;
  name?: InputMaybe<Scalars["String"]["input"]>;
  odsIds?: InputMaybe<Scalars["JSON"]["input"]>;
  offset?: InputMaybe<Scalars["Int"]["input"]>;
  parentGoalId?: InputMaybe<Scalars["Int"]["input"]>;
  peacePoliticId?: InputMaybe<Scalars["Int"]["input"]>;
  productCatalogId?: InputMaybe<Scalars["Int"]["input"]>;
  publicPoliticComponentId?: InputMaybe<Scalars["Int"]["input"]>;
  publicPoliticId?: InputMaybe<Scalars["Int"]["input"]>;
  sort?: InputMaybe<SortInput>;
  stage?: InputMaybe<MonitoringStatus>;
  startDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  text?: InputMaybe<Scalars["String"]["input"]>;
  unitsFactor?: InputMaybe<Scalars["Int"]["input"]>;
  unitsName?: InputMaybe<Scalars["String"]["input"]>;
  victimsPoliticId?: InputMaybe<Scalars["Int"]["input"]>;
};

export type SearchGoalsResponse = {
  __typename?: "SearchGoalsResponse";
  count: Scalars["Int"]["output"];
  countByType: Array<GoalTypeCount>;
  filters?: Maybe<Scalars["JSON"]["output"]>;
  items: Array<Goal>;
};

export type SearchProductCatalog = {
  code?: InputMaybe<Scalars["String"]["input"]>;
  description?: InputMaybe<Scalars["String"]["input"]>;
  id?: InputMaybe<Scalars["Int"]["input"]>;
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  isLeaf?: InputMaybe<Scalars["Boolean"]["input"]>;
  isNational?: InputMaybe<Scalars["Boolean"]["input"]>;
  isPrincipal?: InputMaybe<Scalars["Boolean"]["input"]>;
  isTerritorial?: InputMaybe<Scalars["Boolean"]["input"]>;
  limit?: InputMaybe<Scalars["Int"]["input"]>;
  name?: InputMaybe<Scalars["String"]["input"]>;
  offset?: InputMaybe<Scalars["Int"]["input"]>;
  parentId?: InputMaybe<Scalars["Int"]["input"]>;
  sort?: InputMaybe<SortInput>;
  text?: InputMaybe<Scalars["String"]["input"]>;
  unitsName?: InputMaybe<Scalars["String"]["input"]>;
};

export type SearchProyecto = {
  codigosEntPry?: InputMaybe<Array<Scalars["String"]["input"]>>;
  limit?: InputMaybe<Scalars["Int"]["input"]>;
  nombre?: InputMaybe<Scalars["String"]["input"]>;
  offset?: InputMaybe<Scalars["Int"]["input"]>;
  plan?: InputMaybe<Scalars["Int"]["input"]>;
  proyecto?: InputMaybe<Scalars["String"]["input"]>;
  sort?: InputMaybe<SortInput>;
};

export type SearchProyectoForSchedule = {
  codigosEntPry?: InputMaybe<Array<Scalars["String"]["input"]>>;
  limit?: InputMaybe<Scalars["Int"]["input"]>;
  monitoringConfigId: Scalars["Int"]["input"];
  nombre?: InputMaybe<Scalars["String"]["input"]>;
  offset?: InputMaybe<Scalars["Int"]["input"]>;
  plan?: InputMaybe<Scalars["Int"]["input"]>;
  proyecto?: InputMaybe<Scalars["String"]["input"]>;
  sort?: InputMaybe<SortInput>;
  updateSchedule?: Scalars["Boolean"]["input"];
};

export type SearchProyectoResponse = {
  __typename?: "SearchProyectoResponse";
  count: Scalars["Int"]["output"];
  filters?: Maybe<Scalars["JSON"]["output"]>;
  items: Array<Proyecto>;
};

export type SearchPublicPolitic = {
  categories?: InputMaybe<Array<PublicPoliticCategory>>;
  id?: InputMaybe<Scalars["Int"]["input"]>;
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  limit?: InputMaybe<Scalars["Int"]["input"]>;
  offset?: InputMaybe<Scalars["Int"]["input"]>;
  sort?: InputMaybe<SortInput>;
  text?: InputMaybe<Scalars["String"]["input"]>;
};

export type SearchPublicPoliticResponse = {
  __typename?: "SearchPublicPoliticResponse";
  count: Scalars["Int"]["output"];
  filters?: Maybe<Scalars["JSON"]["output"]>;
  items: Array<PublicPolitic>;
};

export type SearchSiifProyecto = {
  codigosEntPry?: InputMaybe<Array<Scalars["String"]["input"]>>;
  limit?: InputMaybe<Scalars["Int"]["input"]>;
  nombre?: InputMaybe<Scalars["String"]["input"]>;
  offset?: InputMaybe<Scalars["Int"]["input"]>;
  plan?: InputMaybe<Scalars["Int"]["input"]>;
  proyecto?: InputMaybe<Scalars["String"]["input"]>;
  sort?: InputMaybe<SortInput>;
};

export type SearchSiifProyectoResponse = {
  __typename?: "SearchSiifProyectoResponse";
  count: Scalars["Int"]["output"];
  filters?: Maybe<Scalars["JSON"]["output"]>;
  items: Array<SiifProyecto>;
};

export type SearchSpdMeta = {
  codigoPlanDesarrollo?: InputMaybe<Scalars["Int"]["input"]>;
  tipos?: InputMaybe<Array<Scalars["String"]["input"]>>;
};

export type SearchUserAccount = {
  active?: InputMaybe<Array<Scalars["Boolean"]["input"]>>;
  docNumber?: InputMaybe<Scalars["String"]["input"]>;
  email?: InputMaybe<Scalars["String"]["input"]>;
  entityIds?: InputMaybe<Array<Scalars["Int"]["input"]>>;
  entityName?: InputMaybe<Scalars["String"]["input"]>;
  firstName?: InputMaybe<Scalars["String"]["input"]>;
  id?: InputMaybe<Scalars["Int"]["input"]>;
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  lastName?: InputMaybe<Scalars["String"]["input"]>;
  limit?: InputMaybe<Scalars["Int"]["input"]>;
  offset?: InputMaybe<Scalars["Int"]["input"]>;
  phone?: InputMaybe<Scalars["String"]["input"]>;
  roles?: InputMaybe<Array<SpdRole>>;
  sort?: InputMaybe<SortInput>;
  text?: InputMaybe<Scalars["String"]["input"]>;
};

export type SearchUserAccountResponse = {
  __typename?: "SearchUserAccountResponse";
  count: Scalars["Int"]["output"];
  filters?: Maybe<Scalars["JSON"]["output"]>;
  items: Array<UserAccount>;
};

export type Sector = {
  __typename?: "Sector";
  activo?: Maybe<Scalars["String"]["output"]>;
  codigo?: Maybe<Scalars["String"]["output"]>;
  eje: Scalars["Int"]["output"];
  id?: Maybe<Scalars["Int"]["output"]>;
  nitCompania: Scalars["String"]["output"];
  nombre: Scalars["String"]["output"];
  plan: Scalars["Int"]["output"];
  programas?: Maybe<Array<ProgramaPry>>;
  sector: Scalars["Int"]["output"];
  sectorDnp?: Maybe<Scalars["String"]["output"]>;
};

export type SetActiveMonitoringConfig = {
  id: Scalars["Int"]["input"];
};

export type SiifActividad = {
  __typename?: "SiifActividad";
  activa?: Maybe<Scalars["String"]["output"]>;
  cantidad?: Maybe<Scalars["Int"]["output"]>;
  codSubact?: Maybe<Scalars["Int"]["output"]>;
  codigo?: Maybe<Scalars["String"]["output"]>;
  codigoAct: Scalars["Float"]["output"];
  codigoUnd?: Maybe<Scalars["Int"]["output"]>;
  componente: Scalars["String"]["output"];
  createdAt: Scalars["DateTimeISO"]["output"];
  descripcion: Scalars["String"]["output"];
  etapa: Scalars["String"]["output"];
  id: Scalars["Float"]["output"];
  idMeta?: Maybe<Scalars["Int"]["output"]>;
  idProducto?: Maybe<Scalars["Int"]["output"]>;
  nitCompania: Scalars["String"]["output"];
  proyecto: Scalars["String"]["output"];
  siifActividadMetas?: Maybe<Array<SiifActividadMeta>>;
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
};

export type SiifActividadMeta = {
  __typename?: "SiifActividadMeta";
  acciones?: Maybe<Array<SiifActividadMetaAccion>>;
  codigoAct: Scalars["Int"]["output"];
  createdAt: Scalars["DateTimeISO"]["output"];
  goalId: Scalars["Int"]["output"];
  id: Scalars["Float"]["output"];
  nitCompania: Scalars["String"]["output"];
  proyecto: Scalars["String"]["output"];
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
  weighting: Scalars["Float"]["output"];
};

export type SiifActividadMetaAccion = {
  __typename?: "SiifActividadMetaAccion";
  actividadMetaId: Scalars["Int"]["output"];
  createdAt: Scalars["DateTimeISO"]["output"];
  descripcion: Scalars["String"]["output"];
  id: Scalars["Float"]["output"];
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
};

export type SiifProyecto = {
  __typename?: "SiifProyecto";
  actividades?: Maybe<Array<SiifActividad>>;
  codigoEntPry?: Maybe<Scalars["String"]["output"]>;
  createdAt: Scalars["DateTimeISO"]["output"];
  descripcion?: Maybe<Scalars["String"]["output"]>;
  eje: Scalars["Float"]["output"];
  entity?: Maybe<Entity>;
  estado?: Maybe<Scalars["String"]["output"]>;
  estadoProceso?: Maybe<Scalars["String"]["output"]>;
  evaluadoPor?: Maybe<Scalars["String"]["output"]>;
  fechaCreacion?: Maybe<Scalars["DateTimeISO"]["output"]>;
  fechaEvaluacion?: Maybe<Scalars["DateTimeISO"]["output"]>;
  fechaRegistro?: Maybe<Scalars["DateTimeISO"]["output"]>;
  fechaViabilidad?: Maybe<Scalars["DateTimeISO"]["output"]>;
  id: Scalars["Int"]["output"];
  idEntidadPresenta?: Maybe<Scalars["Int"]["output"]>;
  nitCompania: Scalars["String"]["output"];
  nombre: Scalars["String"]["output"];
  objetivos?: Maybe<Scalars["String"]["output"]>;
  observacion?: Maybe<Scalars["String"]["output"]>;
  plan: Scalars["Float"]["output"];
  presentadoPor?: Maybe<Scalars["String"]["output"]>;
  programa: Scalars["Float"]["output"];
  proyecto: Scalars["String"]["output"];
  sector: Scalars["Float"]["output"];
  subprograma?: Maybe<Scalars["Int"]["output"]>;
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
  usuario?: Maybe<Scalars["String"]["output"]>;
  valor?: Maybe<Scalars["Float"]["output"]>;
  verDesde?: Maybe<Scalars["Int"]["output"]>;
  vialibilizadoPor?: Maybe<Scalars["String"]["output"]>;
};

export type SortInput = {
  field?: InputMaybe<Scalars["String"]["input"]>;
  order?: InputMaybe<Scalars["String"]["input"]>;
};

/** Document used as spent source for calculating the spent budget */
export enum SpentDoc {
  Commitment = "COMMITMENT",
  Obligation = "OBLIGATION",
  Payment = "PAYMENT",
}

export type SubprogramaPry = {
  __typename?: "SubprogramaPry";
  activo?: Maybe<Scalars["String"]["output"]>;
  codigo?: Maybe<Scalars["String"]["output"]>;
  codigoAlt?: Maybe<Scalars["String"]["output"]>;
  eje: Scalars["Int"]["output"];
  id?: Maybe<Scalars["Int"]["output"]>;
  idSectorFut?: Maybe<Scalars["Int"]["output"]>;
  nitCompania: Scalars["String"]["output"];
  nombre: Scalars["String"]["output"];
  plan: Scalars["Int"]["output"];
  programa: Scalars["Int"]["output"];
  sector: Scalars["Int"]["output"];
  subprograma?: Maybe<Scalars["Int"]["output"]>;
  subprogramaPry: Scalars["Int"]["output"];
};

export type Tenant = {
  __typename?: "Tenant";
  createdAt: Scalars["DateTimeISO"]["output"];
  id: Scalars["Int"]["output"];
  isActive: Scalars["Boolean"]["output"];
  key: Scalars["String"]["output"];
  name: Scalars["String"]["output"];
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
};

export type Unit = {
  __typename?: "Unit";
  id: Scalars["Int"]["output"];
  initials?: Maybe<Scalars["String"]["output"]>;
  name: Scalars["String"]["output"];
};

export type UpdateDevPlan = {
  code?: InputMaybe<Scalars["String"]["input"]>;
  config?: InputMaybe<Scalars["JSON"]["input"]>;
  endDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  goalActivitySource?: InputMaybe<GoalActivitySource>;
  governmentEndDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  governmentName?: InputMaybe<Scalars["String"]["input"]>;
  governmentStartDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  id: Scalars["Int"]["input"];
  name?: InputMaybe<Scalars["String"]["input"]>;
  startDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
};

export type UpdateDevPlanLevel = {
  code?: InputMaybe<Scalars["String"]["input"]>;
  devPlanId?: InputMaybe<Scalars["Int"]["input"]>;
  id: Scalars["Int"]["input"];
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  level?: InputMaybe<Scalars["Int"]["input"]>;
  name?: InputMaybe<Scalars["String"]["input"]>;
  parentId?: InputMaybe<Scalars["Int"]["input"]>;
  productCatalogId?: InputMaybe<Scalars["Int"]["input"]>;
  weighting?: InputMaybe<Scalars["Float"]["input"]>;
};

export type UpdateEntity = {
  code?: InputMaybe<Scalars["String"]["input"]>;
  endDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  hasManualBudget?: InputMaybe<Scalars["Boolean"]["input"]>;
  id: Scalars["Int"]["input"];
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  name?: InputMaybe<Scalars["String"]["input"]>;
  parentId?: InputMaybe<Scalars["Int"]["input"]>;
  startDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
};

export type UpdateGoal = {
  accumulationType?: InputMaybe<AccumulationType>;
  activityId?: InputMaybe<Scalars["Int"]["input"]>;
  baseValue?: InputMaybe<Scalars["Float"]["input"]>;
  code: Scalars["String"]["input"];
  description?: InputMaybe<Scalars["String"]["input"]>;
  devPlanLevelId?: InputMaybe<Scalars["Int"]["input"]>;
  endDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  entityId?: InputMaybe<Scalars["Int"]["input"]>;
  extraEntityIds?: InputMaybe<Scalars["JSON"]["input"]>;
  formula?: InputMaybe<Scalars["String"]["input"]>;
  goalType?: InputMaybe<GoalType>;
  goalValue?: InputMaybe<Scalars["Float"]["input"]>;
  historyDescription?: InputMaybe<Scalars["String"]["input"]>;
  id: Scalars["Int"]["input"];
  indicator?: InputMaybe<Scalars["String"]["input"]>;
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  isBaseValueNotAvailable?: InputMaybe<Scalars["Boolean"]["input"]>;
  macroProjectId?: InputMaybe<Scalars["Int"]["input"]>;
  name?: InputMaybe<Scalars["String"]["input"]>;
  odsIds?: InputMaybe<Scalars["JSON"]["input"]>;
  parentGoalId?: InputMaybe<Scalars["Int"]["input"]>;
  peacePoliticId?: InputMaybe<Scalars["Int"]["input"]>;
  piBaseValue?: InputMaybe<Scalars["Float"]["input"]>;
  piGoalValue?: InputMaybe<Scalars["Float"]["input"]>;
  piUnitsFactor?: InputMaybe<Scalars["Int"]["input"]>;
  piUnitsName?: InputMaybe<Scalars["String"]["input"]>;
  productCatalogId?: InputMaybe<Scalars["Int"]["input"]>;
  projectCode?: InputMaybe<Scalars["String"]["input"]>;
  publicPoliticComponentId?: InputMaybe<Scalars["Int"]["input"]>;
  publicPoliticId?: InputMaybe<Scalars["Int"]["input"]>;
  startDate?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  tenantId?: InputMaybe<Scalars["Int"]["input"]>;
  unitsFactor?: Scalars["Int"]["input"];
  unitsName?: InputMaybe<Scalars["String"]["input"]>;
  userId?: InputMaybe<Scalars["Int"]["input"]>;
  victimsPoliticId?: InputMaybe<Scalars["Int"]["input"]>;
  weighting?: InputMaybe<Scalars["Float"]["input"]>;
};

export type UpdateMacroProject = {
  code?: InputMaybe<Scalars["String"]["input"]>;
  description?: InputMaybe<Scalars["String"]["input"]>;
  id: Scalars["Int"]["input"];
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  name?: InputMaybe<Scalars["String"]["input"]>;
};

export type UpdateMonitoringConfig = {
  colorsConfig?: InputMaybe<Scalars["JSON"]["input"]>;
  datesConfig?: InputMaybe<Scalars["JSON"]["input"]>;
  devPlanId?: InputMaybe<Scalars["Int"]["input"]>;
  goalTypes?: InputMaybe<Array<GoalType>>;
  id: Scalars["Int"]["input"];
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  monitoringResourcesOrigin?: InputMaybe<MonitoringResourcesOrigin>;
  period?: InputMaybe<Scalars["Int"]["input"]>;
  periodicity?: InputMaybe<Scalars["Int"]["input"]>;
  sgpDiscriminated?: InputMaybe<Scalars["Boolean"]["input"]>;
  spentDocs?: InputMaybe<Array<SpentDoc>>;
  status?: InputMaybe<MonitoringStatus>;
  subperiod?: InputMaybe<Scalars["Int"]["input"]>;
  supportProductMonitoring?: InputMaybe<Scalars["Boolean"]["input"]>;
  usedFor?: InputMaybe<MonitoringConfigUsedFor>;
  weightingType?: InputMaybe<WeightingType>;
};

export type UpdateMonitoringRecord = {
  fromMonth?: InputMaybe<Scalars["Int"]["input"]>;
  goalAchievedValue?: InputMaybe<Scalars["Float"]["input"]>;
  goalValue?: InputMaybe<Scalars["Float"]["input"]>;
  historyDescription?: InputMaybe<Scalars["String"]["input"]>;
  id: Scalars["Int"]["input"];
  notes?: InputMaybe<Scalars["String"]["input"]>;
  piGoalAchievedValue?: InputMaybe<Scalars["Float"]["input"]>;
  piGoalValue?: InputMaybe<Scalars["Float"]["input"]>;
  questionEvidence?: InputMaybe<Scalars["String"]["input"]>;
  questionHow?: InputMaybe<Scalars["String"]["input"]>;
  questionProblem?: InputMaybe<Scalars["String"]["input"]>;
  questionResult?: InputMaybe<Scalars["String"]["input"]>;
  recordStatus: MonitoringRecordStatus;
  reviewNotes?: InputMaybe<Scalars["String"]["input"]>;
  targetMatrix?: InputMaybe<Scalars["JSON"]["input"]>;
  toMonth?: InputMaybe<Scalars["Int"]["input"]>;
  totalPeople?: InputMaybe<Scalars["Int"]["input"]>;
  weighting?: InputMaybe<Scalars["Float"]["input"]>;
};

export type UpdatePublicPolitic = {
  category?: InputMaybe<PublicPoliticCategory>;
  code?: InputMaybe<Scalars["String"]["input"]>;
  componentIds?: InputMaybe<Array<Scalars["Int"]["input"]>>;
  description?: InputMaybe<Scalars["String"]["input"]>;
  fromYear?: InputMaybe<Scalars["Int"]["input"]>;
  id: Scalars["Int"]["input"];
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  name?: InputMaybe<Scalars["String"]["input"]>;
  toYear?: InputMaybe<Scalars["Int"]["input"]>;
};

export type UpdatePublicPoliticComponent = {
  code?: InputMaybe<Scalars["String"]["input"]>;
  description?: InputMaybe<Scalars["String"]["input"]>;
  id: Scalars["Int"]["input"];
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  name?: InputMaybe<Scalars["String"]["input"]>;
};

export type UpdateSiifActividad = {
  activa?: InputMaybe<Scalars["String"]["input"]>;
  cantidad?: InputMaybe<Scalars["Int"]["input"]>;
  codSubact?: InputMaybe<Scalars["Int"]["input"]>;
  codigo?: InputMaybe<Scalars["String"]["input"]>;
  codigoAct: Scalars["Int"]["input"];
  codigoUnd?: InputMaybe<Scalars["Int"]["input"]>;
  componente: Scalars["String"]["input"];
  descripcion: Scalars["String"]["input"];
  etapa: Scalars["String"]["input"];
  id: Scalars["Int"]["input"];
  idMeta?: InputMaybe<Scalars["Int"]["input"]>;
  idProducto?: InputMaybe<Scalars["Int"]["input"]>;
  nitCompania: Scalars["String"]["input"];
  proyecto: Scalars["String"]["input"];
};

export type UpdateSiifProyecto = {
  codigoEntPry?: InputMaybe<Scalars["String"]["input"]>;
  descripcion?: InputMaybe<Scalars["String"]["input"]>;
  eje?: InputMaybe<Scalars["Int"]["input"]>;
  estado?: InputMaybe<Scalars["String"]["input"]>;
  estadoProceso?: InputMaybe<Scalars["String"]["input"]>;
  evaluadoPor?: InputMaybe<Scalars["String"]["input"]>;
  fechaCreacion?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  fechaEvaluacion?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  fechaRegistro?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  fechaViabilidad?: InputMaybe<Scalars["DateTimeISO"]["input"]>;
  id?: InputMaybe<Scalars["Int"]["input"]>;
  idEntidadPresenta?: InputMaybe<Scalars["Int"]["input"]>;
  nitCompania: Scalars["String"]["input"];
  nombre: Scalars["String"]["input"];
  objetivos?: InputMaybe<Scalars["String"]["input"]>;
  observacion?: InputMaybe<Scalars["String"]["input"]>;
  plan?: InputMaybe<Scalars["Int"]["input"]>;
  presentadoPor?: InputMaybe<Scalars["String"]["input"]>;
  programa?: InputMaybe<Scalars["Int"]["input"]>;
  proyecto: Scalars["String"]["input"];
  sector?: InputMaybe<Scalars["Int"]["input"]>;
  subprograma?: InputMaybe<Scalars["Int"]["input"]>;
  usuario?: InputMaybe<Scalars["String"]["input"]>;
  valor?: InputMaybe<Scalars["Float"]["input"]>;
  verDesde?: InputMaybe<Scalars["Int"]["input"]>;
  vialibilizadoPor?: InputMaybe<Scalars["String"]["input"]>;
};

export type UpdateTenant = {
  id: Scalars["Int"]["input"];
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  key?: InputMaybe<Scalars["String"]["input"]>;
  name?: InputMaybe<Scalars["String"]["input"]>;
};

export type UpdateUserAccount = {
  docNumber?: InputMaybe<Scalars["String"]["input"]>;
  email?: InputMaybe<Scalars["String"]["input"]>;
  entityId?: InputMaybe<Scalars["Int"]["input"]>;
  firstName?: InputMaybe<Scalars["String"]["input"]>;
  id: Scalars["Int"]["input"];
  isActive?: InputMaybe<Scalars["Boolean"]["input"]>;
  lastName?: InputMaybe<Scalars["String"]["input"]>;
  phone?: InputMaybe<Scalars["String"]["input"]>;
  role?: InputMaybe<SpdRole>;
};

export type UserAccount = {
  __typename?: "UserAccount";
  createdAt: Scalars["DateTimeISO"]["output"];
  docNumber: Scalars["String"]["output"];
  email: Scalars["String"]["output"];
  entity?: Maybe<Entity>;
  entityId?: Maybe<Scalars["Int"]["output"]>;
  firstName: Scalars["String"]["output"];
  id: Scalars["Int"]["output"];
  isActive: Scalars["Boolean"]["output"];
  lastName?: Maybe<Scalars["String"]["output"]>;
  phone?: Maybe<Scalars["String"]["output"]>;
  role?: Maybe<SpdRole>;
  tenant: Tenant;
  tenantId: Scalars["Float"]["output"];
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
};

export type UserLoggedIn = {
  __typename?: "UserLoggedIn";
  createdAt: Scalars["DateTimeISO"]["output"];
  docNumber: Scalars["String"]["output"];
  email: Scalars["String"]["output"];
  entity?: Maybe<Entity>;
  entityId?: Maybe<Scalars["Int"]["output"]>;
  firstName: Scalars["String"]["output"];
  id: Scalars["Int"]["output"];
  isActive: Scalars["Boolean"]["output"];
  lastName?: Maybe<Scalars["String"]["output"]>;
  phone?: Maybe<Scalars["String"]["output"]>;
  role?: Maybe<SpdRole>;
  tenant: Tenant;
  tenantId: Scalars["Float"]["output"];
  token: Scalars["String"]["output"];
  updatedAt?: Maybe<Scalars["DateTimeISO"]["output"]>;
};

export type VActividadesPry = {
  __typename?: "VActividadesPry";
  activa?: Maybe<Scalars["String"]["output"]>;
  cantidad?: Maybe<Scalars["Int"]["output"]>;
  codigoAct: Scalars["Int"]["output"];
  codigoMeta?: Maybe<Scalars["String"]["output"]>;
  codigoProducto?: Maybe<Scalars["String"]["output"]>;
  codigoUnd?: Maybe<Scalars["Int"]["output"]>;
  componente: Scalars["String"]["output"];
  descripcion: Scalars["String"]["output"];
  descripcionTxt?: Maybe<Scalars["String"]["output"]>;
  etapa: Scalars["String"]["output"];
  goal?: Maybe<Goal>;
  id: Scalars["Float"]["output"];
  idMeta?: Maybe<Scalars["Float"]["output"]>;
  idProducto?: Maybe<Scalars["Float"]["output"]>;
  insumos?: Maybe<Array<InsumosPry>>;
  nitCompania: Scalars["String"]["output"];
  nombreMeta?: Maybe<Scalars["String"]["output"]>;
  nombreProducto?: Maybe<Scalars["String"]["output"]>;
  nombreProyecto: Scalars["String"]["output"];
  plan: Scalars["Int"]["output"];
  proyecto: Scalars["String"]["output"];
};

export type VActividadesPryWithGoals = {
  __typename?: "VActividadesPryWithGoals";
  activa?: Maybe<Scalars["String"]["output"]>;
  cantidad?: Maybe<Scalars["Int"]["output"]>;
  codigoAct: Scalars["Int"]["output"];
  codigoMeta?: Maybe<Scalars["String"]["output"]>;
  codigoProducto?: Maybe<Scalars["String"]["output"]>;
  codigoUnd?: Maybe<Scalars["Int"]["output"]>;
  componente: Scalars["String"]["output"];
  descripcion: Scalars["String"]["output"];
  descripcionTxt?: Maybe<Scalars["String"]["output"]>;
  etapa: Scalars["String"]["output"];
  goal?: Maybe<Goal>;
  id: Scalars["Float"]["output"];
  idMeta?: Maybe<Scalars["Float"]["output"]>;
  idProducto?: Maybe<Scalars["Float"]["output"]>;
  insumos?: Maybe<Array<InsumosPry>>;
  linkedGoal?: Maybe<Goal>;
  linkedGoalId?: Maybe<Scalars["Int"]["output"]>;
  nitCompania: Scalars["String"]["output"];
  nombreMeta?: Maybe<Scalars["String"]["output"]>;
  nombreProducto?: Maybe<Scalars["String"]["output"]>;
  nombreProyecto: Scalars["String"]["output"];
  plan: Scalars["Int"]["output"];
  proyecto: Scalars["String"]["output"];
};

export type VSpdMeta = {
  __typename?: "VSpdMeta";
  accion?: Maybe<Scalars["String"]["output"]>;
  codigo?: Maybe<Scalars["String"]["output"]>;
  codigoEntidad: Scalars["String"]["output"];
  codigoNivelPlan?: Maybe<Scalars["String"]["output"]>;
  codigoPlanDesarrollo: Scalars["Int"]["output"];
  comparador?: Maybe<Scalars["String"]["output"]>;
  descripcion?: Maybe<Scalars["String"]["output"]>;
  factorBase?: Maybe<Scalars["Int"]["output"]>;
  factorMeta?: Maybe<Scalars["Int"]["output"]>;
  id: Scalars["Int"]["output"];
  idEntidad?: Maybe<Scalars["Int"]["output"]>;
  idFut?: Maybe<Scalars["Int"]["output"]>;
  idPadre?: Maybe<Scalars["Int"]["output"]>;
  idPlan?: Maybe<Scalars["Int"]["output"]>;
  idPlanAccion?: Maybe<Scalars["Int"]["output"]>;
  idPlanDesarrollo?: Maybe<Scalars["Int"]["output"]>;
  indicador?: Maybe<Scalars["String"]["output"]>;
  mesFin?: Maybe<Scalars["String"]["output"]>;
  mesInicio?: Maybe<Scalars["String"]["output"]>;
  nitCompania: Scalars["String"]["output"];
  nombre?: Maybe<Scalars["String"]["output"]>;
  nombreEntidad?: Maybe<Scalars["String"]["output"]>;
  nombreNivelPlan?: Maybe<Scalars["String"]["output"]>;
  periodo?: Maybe<Scalars["String"]["output"]>;
  ponderacion?: Maybe<Scalars["Float"]["output"]>;
  proyecto?: Maybe<Scalars["Int"]["output"]>;
  tipo?: Maybe<Scalars["String"]["output"]>;
  unidad?: Maybe<Scalars["String"]["output"]>;
  valorBase?: Maybe<Scalars["Float"]["output"]>;
  valorMeta?: Maybe<Scalars["Float"]["output"]>;
  valorProgramado?: Maybe<Scalars["Float"]["output"]>;
};

/** To weighting each goal of the development plan */
export enum WeightingType {
  Financial = "FINANCIAL",
  Hierarchy = "HIERARCHY",
  Manual = "MANUAL",
}
