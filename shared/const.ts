import { MonitoringResourceType, SpentDoc } from "../graphql/gen/schema";

export const RESOURCES_FIELDS = [
  "rp",
  "sgp",
  "cn",
  "cd",
  "sgr",
  "credit",
  "others",
  "management",
  "operation",
];

export const SGP_RESOURCES_FIELDS = [
  "sgpEducation",
  "sgpHealt",
  "sgpWater",
  "sgpCulture",
  "sgpSport",
  "sgpFreeInvestment",
  "sgpFreeDestination",
  "sgpSchoolFeeding",
  "sgpMagdalenaRiver",
  "sgpEarlyChildhood",
];

export const SPENT_DOC_TO_RESOURCE_TYPE = {
  [SpentDoc.Commitment]: MonitoringResourceType.Commitment,
  [SpentDoc.Obligation]: MonitoringResourceType.Obligation,
  [SpentDoc.Payment]: MonitoringResourceType.Payment,
};

// Goal status for each Monitoring Record
export enum GoalMonitoringRecordStatus {
  NEW,
  SCHEDULED,
  PARTIALLY_SCHEDULED,
  REPORTED,
  NO_REPORTED,
  VALIDATED,
  NO_VALIDATED,
  REVIEWED,
  NO_REVIEWED,
  REJECTED,
}

// SPD User
const SPD_USER = {
  user: "spd",
  name: "Seguimiento Plan Desarrollo",
};
