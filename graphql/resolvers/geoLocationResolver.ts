import { Resolver, Query, Arg, Int, FieldResolver, Root, Ctx } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import { GeoLocation } from "../types/";
import prisma from "../../lib/prisma";
import type { Context } from "../types/common";

@Resolver(() => GeoLocation)
export class GeoLocationResolver extends SPDResolver {
  @FieldResolver(() => String)
  key(@Root() geoLocation: GeoLocation): string {
    return `${geoLocation.id}`;
  }

  @FieldResolver(() => [GeoLocation])
  async children(@Root() geoLocation: GeoLocation): Promise<GeoLocation[] | null> {
    return prisma.geoLocation
      .findUnique({
        where: {
          id: geoLocation.id,
        },
      })
      .childrenLocations({ orderBy: { name: "asc" } });
  }

  @FieldResolver(() => GeoLocation, { nullable: true })
  async parent(@Root() geoLocation: GeoLocation): Promise<GeoLocation | null> {
    if (geoLocation.parentLocationId)
      return prisma.geoLocation.findUnique({ where: { id: geoLocation.parentLocationId } });
    return null;
  }

  @Query(() => [GeoLocation])
  async getGeoLocations(@Ctx() ctx: Context): Promise<GeoLocation[]> {
    const result = await prisma.geoLocation.findMany({
      where: {
        tenantId: this.getContextTenantId(ctx),
      },
    });
    return result;
  }

  @Query(() => [GeoLocation])
  async getGeoLocationsTree(@Ctx() ctx: Context): Promise<GeoLocation[]> {
    let result: GeoLocation[] = [];

    result = await prisma.geoLocation.findMany({
      where: {
        tenantId: this.getContextTenantId(ctx),
        parentLocationId: null,
      },
      orderBy: {
        name: "asc",
      },
    });

    return result;
  }

  @Query(() => GeoLocation, { nullable: true })
  async getGeoLocation(@Arg("id", () => Int) id: number): Promise<GeoLocation | null> {
    const result = await prisma.geoLocation.findUnique({ where: { id } });
    return result;
  }
}
