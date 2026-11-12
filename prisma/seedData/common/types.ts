import { Goal, MonitoringRecord, MonitoringRecordResource } from "@prisma/client";

export type GoalRow = Pick<
  Goal,
  | "isActive"
  | "devPlanLevelId"
  | "devPlanId"
  | "entityId"
  | "goalType"
  | "code"
  | "name"
  | "indicator"
  | "description"
  | "accumulationType"
  | "baseValue"
  | "goalValue"
  | "unitsFactor"
  | "unitsName"
  | "isBaseValueNotAvailable"
  | "weighting"
  | "originId"
>;

// New type using all fields from MonitoringRecord, except for id, createdAt, updatedAt
export type MonitoringRecordRow = Omit<
  MonitoringRecord,
  "id" | "createdAt" | "createdBy" | "updatedAt" | "updatedBy" | "targetMatrix"
> & {
  resources: Array<
    Pick<
      MonitoringRecordResource,
      | "capital"
      | "cd"
      | "cn"
      | "credit"
      | "management"
      | "operation"
      | "others"
      | "rp"
      | "sgp"
      | "sgr"
      | "resourceType"
    >
  >;
};
