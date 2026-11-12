import { TenantModel, tenantModel } from "./tenantModel";
import { NotificationsModel, notificationsModel } from "./notificationsModel";
import { UserAccountModel, userAccountModel } from "./userAccountModel";
import { persist } from "easy-peasy";
import { GoalModel, goalModel } from "./goalModel";
import { DevPlanModel, devPlanModel } from "./devPlanModel";
import { DevPlanTreeModel, devPlanTreeModel } from "./devPlanTree";
import { EntityModel, entityModel } from "./entityModel";
import { CommonDataModel, commonDataModel } from "./commonDataModel";
import { MonitoringConfigModel, monitoringConfigModel } from "./monitoringConfigModel";
import { SiifProyectoModel, siifProyectoModel } from "./siifProyecto";
import { publicPoliticModel, PublicPoliticModel } from "./publicPolitic";
import { proyectoModel, ProyectoModel } from "./proyecto";
import { wizardModel, WizardModel } from "./wizardModel";
import { planDesarrolloModel, PlanDesarrolloModel } from "./siif";
import { appModel, AppModel } from "./appModel";

export type RootModel = {
  app: AppModel;
  tenant: TenantModel;
  notifications: NotificationsModel;
  user: UserAccountModel;
  goal: GoalModel;
  devPlan: DevPlanModel;
  devPlanTree: DevPlanTreeModel;
  entity: EntityModel;
  common: CommonDataModel;
  monitoringConfig: MonitoringConfigModel;
  siifProyecto: SiifProyectoModel;
  publicPolitic: PublicPoliticModel;
  proyecto: ProyectoModel;
  wizard: WizardModel;
  planDesarrollo: PlanDesarrolloModel;
};

export const rootModel: RootModel = {
  app: appModel,
  notifications: notificationsModel,
  tenant: persist(tenantModel, { storage: "localStorage" }),
  user: persist(userAccountModel, { storage: "localStorage" }),
  goal: goalModel,
  devPlan: devPlanModel,
  devPlanTree: devPlanTreeModel,
  entity: entityModel,
  common: commonDataModel,
  monitoringConfig: monitoringConfigModel,
  siifProyecto: siifProyectoModel,
  publicPolitic: publicPoliticModel,
  proyecto: proyectoModel,
  wizard: wizardModel,
  planDesarrollo: planDesarrolloModel,
};
