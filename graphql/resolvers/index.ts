import { TenantResolver } from "./tenantResolver";
import { DevPlanResolver } from "./devPlanResolver";
import { EntityResolver } from "./entityResolver";
import { UserAccountResolver } from "./userAccount";
import { DevPlanLevelResolver } from "./devPlanLevelResolver";
import { MonitoringConfigResolver } from "./monitoringConfigResolver";
import { OdsResolver } from "./OdsResolver";
import { UnitResolver } from "./unitResolver";
import { GoalResolver } from "./goalResolver";
import { GoalHistoryResolver } from "./goalHistoryResolver";
import { PublicPoliticResolver } from "./publicPoliticResolver";
import { PublicPoliticComponentResolver } from "./publicPoliticComponentResolver";
import { ProductCatalogResolver } from "./productCatalogResolver";
import { MonitoringRecordResolver } from "./monitoringRecordResolver";
import { MonitoringRecordResourceResolver } from "./monitoringRecordResourceResolver";
import { DashboardResolver } from "./dashboardResolver";
import { SiifProyectoResolver } from "./siifProyectoResolver";
import { SiifActividadResolver } from "./siifActividadResolver";
import { SiifActividadMetaResolver } from "./siifActividadMetaResolver";
import { SiifActividadMetaAccionResolver } from "./siifActividadMetaAccionResolver";
import { MacroProjectResolver } from "./macroProject";
import { GeoLocationResolver } from "./geoLocationResolver";
import { MonitoringRecordAttachmentResolver } from "./monitoringRecordAttachmentResolver";
import { NonEmptyArray } from "type-graphql";
import { TestResolver } from "./testResolver";
import {
  EjeEstructuranteResolver,
  PlanDesarrolloResolver,
  ProgramaPryResolver,
  SectorResolver,
  ProyectoResolver,
  ActividadesPryResolver,
  VActividadesPryResolver,
  VActividadesPryWithGoalsResolver,
  VSpdMetaResolver,
} from "./siif";
import { GoalActivityResolver } from "./goalActivityResolver";

// eslint-disable-next-line @typescript-eslint/ban-types
const resolvers: NonEmptyArray<Function> = [
  TenantResolver,
  UserAccountResolver,
  DevPlanResolver,
  DevPlanLevelResolver,
  EntityResolver,
  MonitoringConfigResolver,
  OdsResolver,
  UnitResolver,
  GoalResolver,
  GoalHistoryResolver,
  PublicPoliticResolver,
  PublicPoliticComponentResolver,
  ProductCatalogResolver,
  MonitoringRecordResolver,
  MonitoringRecordResourceResolver,
  DashboardResolver,
  SiifProyectoResolver,
  SiifActividadResolver,
  SiifActividadMetaResolver,
  SiifActividadMetaAccionResolver,
  MacroProjectResolver,
  GeoLocationResolver,
  MonitoringRecordAttachmentResolver,
  TestResolver,
  PlanDesarrolloResolver,
  EjeEstructuranteResolver,
  SectorResolver,
  ProgramaPryResolver,
  ProyectoResolver,
  ActividadesPryResolver,
  VActividadesPryResolver,
  VActividadesPryWithGoalsResolver,
  VSpdMetaResolver,
  GoalActivityResolver,
];

export { resolvers };
