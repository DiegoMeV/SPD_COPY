import { MonitoringConfigFragment, DevPlanFragment } from "../../graphql/gen/ops";
import { MonitoringStatus } from "../../graphql/gen/schema";

export type ColorsConfigItem = {
  color: string;
  toValue: number;
  fromValue: number;
  label: string;
  includeToValue: boolean;
  includeFromValue: boolean;
};

export type ColorsConfigType = ColorsConfigItem[];

export type MonitoringConfig = MonitoringConfigFragment & { devPlan?: DevPlanFragment | null };
