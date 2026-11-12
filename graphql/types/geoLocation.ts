import { Field, Int, ObjectType, registerEnumType } from "type-graphql";
import { DbModel } from "./common";
import { GeoLocation as DbGeoLocation, LocationType } from "@prisma/client";

registerEnumType(LocationType, {
  name: "LocationType",
  description: "Type of the location",
});

@ObjectType()
export class GeoLocation extends DbModel implements Partial<DbGeoLocation> {
  @Field(() => String, { nullable: true })
  code?: string | null;

  @Field(() => String)
  name!: string;

  @Field(() => LocationType)
  locationType!: LocationType;

  @Field(() => Int, { nullable: true })
  parentLocationId?: number | null | undefined;
}
