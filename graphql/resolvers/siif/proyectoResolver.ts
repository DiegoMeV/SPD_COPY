import { Resolver, Query, Arg, Ctx, FieldResolver, Root, Float } from "type-graphql";
import { SPDResolver } from "../spdResolver";
import type { Context } from "../../types/common";
import proyecto from "../proyectoData";
import {
  Proyecto,
  Entity,
  SearchProyectoResponse,
  SearchProyecto,
  DevPlan,
  SearchProyectoForSchedule,
  VActividadesPry,
  Goal,
  VActividadesPryWithGoals,
} from "../../types";
import {
  ActividadService,
  DevPlanService,
  EntityService,
  GoalService,
  ProyectoService,
} from "../../../lib/services";

@Resolver(() => Proyecto)
export class ProyectoResolver extends SPDResolver {
  @FieldResolver(() => Entity, { nullable: true })
  async entity(@Root() proyecto: Proyecto): Promise<Entity | null> {
    if (proyecto.codigoEntPry)
      return EntityService.instance.getEntity({
        tenantKey: proyecto.nitCompania,
        code: proyecto.codigoEntPry,
      });
    return null;
  }

  @FieldResolver(() => [VActividadesPryWithGoals], { nullable: true })
  async actividades(@Root() proyecto: Proyecto): Promise<VActividadesPryWithGoals[] | null> {
    const tenantKey = proyecto.nitCompania;
    // Get actividades from SIIF
    const actividades = await ActividadService.instance.getActividadesWithGoals({
      tenantKey,
      proyecto: proyecto.proyecto,
    });

    return actividades;
  }

  @FieldResolver(() => DevPlan, { nullable: true })
  async devPlan(@Root() proyecto: Proyecto): Promise<DevPlan | null> {
    return DevPlanService.instance.getDevPlan({
      tenantKey: proyecto.nitCompania,
      code: `${proyecto.plan}`,
    });
  }

  @FieldResolver(() => Goal, { nullable: true })
  async goal(@Root() proyecto: Proyecto): Promise<Goal | null> {
    return GoalService.instance.getGoal({
      tenantKey: proyecto.nitCompania,
      projectCode: proyecto.proyecto,
    });
  }
  @Query(() => Proyecto, { nullable: true })
  async getProyecto(
    @Arg("codigo", () => String) codigo: string,
    @Ctx() ctx: Context,
  ): Promise<Proyecto | null> {
    return ProyectoService.instance.getProyecto({
      tenantKey: this.getContextTenantKey(ctx),
      code: codigo,
    });
  }

  @Query(() => SearchProyectoResponse, { nullable: true })
  async searchProyectos(
    @Arg("data", () => SearchProyecto) data: SearchProyecto,
    @Ctx() ctx: Context,
  ): Promise<SearchProyectoResponse> {
    return ProyectoService.instance.searchProyectos({
      tenantKey: this.getContextTenantKey(ctx),
      data,
    });
  }

  @Query(() => SearchProyectoResponse, { nullable: true })
  async getProyectosForSchedule(
    @Arg("data", () => SearchProyectoForSchedule) data: SearchProyectoForSchedule,
    @Ctx() ctx: Context,
  ): Promise<SearchProyectoResponse> {
    return ProyectoService.instance.getProyectosForSchedule({
      tenantKey: this.getContextTenantKey(ctx),
      data,
    });
  }
}
