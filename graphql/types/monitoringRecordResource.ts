import { Field, ObjectType, InputType, Int, Float, registerEnumType } from "type-graphql";
import { DbModel } from "./common";
import {
  MonitoringRecordResource as DbMonitoringRecordResource,
  MonitoringResourceType,
} from "@prisma/client";

registerEnumType(MonitoringResourceType, {
  name: "MonitoringResourceType",
  description: "Type for each monitoring resource",
});

@ObjectType()
export class MonitoringRecordResource
  extends DbModel
  implements Partial<DbMonitoringRecordResource>
{
  @Field(() => Int)
  monitoringRecordId!: number;

  @Field(() => MonitoringResourceType)
  resourceType!: MonitoringResourceType;

  @Field(() => Float, { defaultValue: 0 })
  capital!: number;

  @Field(() => Float, { defaultValue: 0 })
  cd!: number;

  @Field(() => Float, { defaultValue: 0 })
  cn!: number;

  @Field(() => Float, { defaultValue: 0 })
  credit!: number;

  @Field(() => Float, { defaultValue: 0 })
  de!: number;

  @Field(() => Float, { defaultValue: 0 })
  operation!: number;

  @Field(() => Float, { defaultValue: 0 })
  management!: number;

  @Field(() => Float, { defaultValue: 0 })
  monopoly!: number;

  @Field(() => Float, { defaultValue: 0 })
  others!: number;

  @Field(() => Float, { defaultValue: 0 })
  rp!: number;

  @Field(() => Float, { defaultValue: 0 })
  sgp!: number;

  @Field(() => Float, { defaultValue: 0 })
  sgpEducation?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpHealt?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpWater?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpCulture?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpSport?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpFreeInvestment?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpFreeDestination?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpSchoolFeeding?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpMagdalenaRiver?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpEarlyChildhood?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgr!: number;

  @Field(() => Float, { nullable: true })
  financialIndicator?: number | null | undefined;

  @Field(() => Int, { nullable: true })
  createdBy?: number | null | undefined;

  @Field(() => Int, { nullable: true })
  updatedBy?: number | null | undefined;
}

@InputType()
export class CreateMonitoringRecordResource
  extends DbModel
  implements Partial<DbMonitoringRecordResource>
{
  @Field(() => Int)
  monitoringRecordId!: number;

  @Field(() => MonitoringResourceType)
  resourceType!: MonitoringResourceType;

  @Field(() => Float, { defaultValue: 0 })
  capital!: number;

  @Field(() => Float, { defaultValue: 0 })
  cd!: number;

  @Field(() => Float, { defaultValue: 0 })
  cn!: number;

  @Field(() => Float, { defaultValue: 0 })
  credit!: number;

  @Field(() => Float, { defaultValue: 0 })
  de!: number;

  @Field(() => Float, { defaultValue: 0 })
  operation!: number;

  @Field(() => Float, { defaultValue: 0 })
  management!: number;

  @Field(() => Float, { defaultValue: 0 })
  monopoly!: number;

  @Field(() => Float, { defaultValue: 0 })
  others!: number;

  @Field(() => Float, { defaultValue: 0 })
  rp!: number;

  @Field(() => Float, { defaultValue: 0 })
  sgp!: number;

  @Field(() => Float, { defaultValue: 0 })
  sgpEducation?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpHealt?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpWater?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpCulture?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpSport?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpFreeInvestment?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpFreeDestination?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpSchoolFeeding?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpMagdalenaRiver?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpEarlyChildhood?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgr!: number;

  @Field(() => String, { nullable: true })
  historyDescription?: string | null | undefined;
}

@InputType()
export class UpdateMonitoringRecordResource
  extends DbModel
  implements Partial<DbMonitoringRecordResource>
{
  @Field(() => Int)
  id!: number;

  @Field(() => Float, { defaultValue: 0 })
  capital!: number;

  @Field(() => Float, { defaultValue: 0 })
  cd!: number;

  @Field(() => Float, { defaultValue: 0 })
  cn!: number;

  @Field(() => Float, { defaultValue: 0 })
  credit!: number;

  @Field(() => Float, { defaultValue: 0 })
  de!: number;

  @Field(() => Float, { defaultValue: 0 })
  operation!: number;

  @Field(() => Float, { defaultValue: 0 })
  management!: number;

  @Field(() => Float, { defaultValue: 0 })
  monopoly!: number;

  @Field(() => Float, { defaultValue: 0 })
  others!: number;

  @Field(() => Float, { defaultValue: 0 })
  rp!: number;

  @Field(() => Float, { defaultValue: 0 })
  sgp!: number;

  @Field(() => Float, { defaultValue: 0 })
  sgpEducation?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpHealt?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpWater?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpCulture?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpSport?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpFreeInvestment?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpFreeDestination?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpSchoolFeeding?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpMagdalenaRiver?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgpEarlyChildhood?: number | null;

  @Field(() => Float, { defaultValue: 0 })
  sgr!: number;

  @Field(() => String, { nullable: true })
  historyDescription?: string | null | undefined;
}

@InputType()
export class UpdateMonitoringRecordResources
  extends DbModel
  implements Partial<DbMonitoringRecordResource>
{
  @Field(() => [UpdateMonitoringRecordResource])
  records!: UpdateMonitoringRecordResources[];
}

@InputType()
export class SaveLinkedMonitoringRecordResource implements Partial<DbMonitoringRecordResource> {
  @Field(() => Int, { nullable: true })
  id?: number | undefined;

  @Field(() => Int, { nullable: true })
  monitoringRecordId?: number | undefined;

  @Field(() => MonitoringResourceType)
  resourceType!: MonitoringResourceType;

  @Field(() => Float, { defaultValue: 0 })
  capital!: number;

  @Field(() => Float, { defaultValue: 0 })
  cd!: number;

  @Field(() => Float, { defaultValue: 0 })
  cn!: number;

  @Field(() => Float, { defaultValue: 0 })
  credit!: number;

  @Field(() => Float, { defaultValue: 0 })
  de!: number;

  @Field(() => Float, { defaultValue: 0 })
  operation!: number;

  @Field(() => Float, { defaultValue: 0 })
  management!: number;

  @Field(() => Float, { defaultValue: 0 })
  monopoly!: number;

  @Field(() => Float, { defaultValue: 0 })
  others!: number;

  @Field(() => Float, { defaultValue: 0 })
  rp!: number;

  @Field(() => Float, { defaultValue: 0 })
  sgp!: number;

  @Field(() => Float, { defaultValue: 0 })
  sgpEducation?: number;

  @Field(() => Float, { defaultValue: 0 })
  sgpHealt?: number;

  @Field(() => Float, { defaultValue: 0 })
  sgpWater?: number;

  @Field(() => Float, { defaultValue: 0 })
  sgpCulture?: number;

  @Field(() => Float, { defaultValue: 0 })
  sgpSport?: number;

  @Field(() => Float, { defaultValue: 0 })
  sgpFreeInvestment?: number;

  @Field(() => Float, { defaultValue: 0 })
  sgpFreeDestination?: number;

  @Field(() => Float, { defaultValue: 0 })
  sgpSchoolFeeding?: number;

  @Field(() => Float, { defaultValue: 0 })
  sgpMagdalenaRiver?: number;

  @Field(() => Float, { defaultValue: 0 })
  sgpEarlyChildhood?: number;

  @Field(() => Float, { defaultValue: 0 })
  sgr!: number;
}

@InputType()
export class GetGoalResources {
  @Field(() => Int)
  id!: number;

  @Field(() => Int)
  period!: number;

  @Field(() => String)
  cutoffDate!: string;

  @Field(() => [MonitoringResourceType])
  resourceTypes!: MonitoringResourceType[];
}

@ObjectType()
export class GetGoalResourcesResponse implements Partial<DbMonitoringRecordResource> {
  @Field(() => MonitoringResourceType)
  resourceType!: MonitoringResourceType;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  capital?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  cd?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  cn?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  credit?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  de?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  operation?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  management?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  monopoly?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  others?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  rp?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  sgp?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  sgpEducation?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  sgpHealt?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  sgpWater?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  sgpCulture?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  sgpSport?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  sgpFreeInvestment?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  sgpFreeDestination?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  sgpSchoolFeeding?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  sgpMagdalenaRiver?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  sgpEarlyChildhood?: number | undefined;

  @Field(() => Float, { defaultValue: 0, nullable: true })
  sgr?: number | undefined;

  @Field(() => Float, { nullable: true })
  financialIndicator?: number | null | undefined;
}
