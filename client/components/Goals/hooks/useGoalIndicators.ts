import { Goal } from "../../../types/goal";
import { MonitoringResourceType } from "../../../../graphql/gen/schema";
import { ColorsConfigType, MonitoringConfig } from "../../../types/monitoringConfig";
import { round2dp } from "../../../utils/formatUtils";

export type UseGetParentLevelGoalsProps = {
  devPlanLevelId: number;
};

export type UseSearchGoalsByCodeProps = {
  devPlanId: number;
  code: string;
};

export type UseGetGoalsProps = {
  devPlanLevelId: number;
};

const useGoalIndicators = () => {
  const getFinancialIndicator = (
    goal: Goal,
    monitoringConfig: MonitoringConfig,
    spentDoc: MonitoringResourceType,
  ) => {
    if (!monitoringConfig) return {};
    const resourceRecord = goal.tracking
      ?.find((monitoringRecord) => monitoringRecord.monitoringConfigId === monitoringConfig?.id)
      ?.resources?.find((resource) => resource.resourceType === spentDoc);
    const percent = round2dp((resourceRecord?.financialIndicator ?? 0) * 100);
    const colorsConfig: ColorsConfigType = monitoringConfig?.colorsConfig ?? [];
    const color =
      colorsConfig?.find(
        (color) =>
          percent >= (color.fromValue * monitoringConfig.subperiod) / 4 &&
          percent <= (color.toValue * monitoringConfig.subperiod) / 4,
      )?.color ?? colorsConfig?.[colorsConfig?.length - 1]?.color;
    return { percent, color };
  };

  const getPhysicalIndicator = (goal: Goal, monitoringConfig: MonitoringConfig) => {
    if (!monitoringConfig) return {};
    const monitoringRecord = goal.monitoringRecords?.find(
      (monitoringRecord) => monitoringRecord.monitoringConfigId === monitoringConfig?.id,
    );
    const percent = round2dp((monitoringRecord?.physicalIndicator ?? 0) * 100);
    const colorsConfig: ColorsConfigType = monitoringConfig?.colorsConfig ?? [];
    const color =
      colorsConfig?.find(
        (color) =>
          percent >= (color.fromValue * monitoringConfig.subperiod) / 4 &&
          percent <= (color.toValue * monitoringConfig.subperiod) / 4,
      )?.color ?? colorsConfig?.[colorsConfig?.length - 1]?.color;
    return { percent, color };
  };

  return { getFinancialIndicator, getPhysicalIndicator };
};

export default useGoalIndicators;
