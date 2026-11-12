import { FormInstance } from "antd";
import { useEffect } from "react";
import { useStoreState } from "../../store";
import { DevPlanConfigLevel } from "../../types/devPlan";
import { useMonitoringConfig } from "../MonitoringConfig/hooks";
import { useCurrentUser } from "../Users/hooks";
import { GoalType } from "../../../graphql/gen/schema";
import { ColorsConfigItem } from "../../types/monitoringConfig";
import { useGetGoalTypeStatsQuery } from "../../../graphql/gen/hooks";

const useDashboard = (form?: FormInstance<any>) => {
  const { user } = useCurrentUser();
  const { currentMonitoring } = useMonitoringConfig();

  useEffect(() => {
    form?.setFieldValue("selectedEntityId", user?.entityId);
  }, [user]);

  const goalTypeLevels = (): DevPlanConfigLevel[] => {
    return (
      currentMonitoring?.devPlan?.config?.levels?.filter(
        (level: DevPlanConfigLevel) => !!level.goalType,
      ) ?? []
    );
  };

  const goalTypes = (): GoalType[] => {
    return goalTypeLevels()?.map((level: DevPlanConfigLevel) => level.goalType as GoalType) ?? [];
  };

  const colorForPercent = (percent: number): string => {
    const value = percent * 100;
    const monitoringConfigRecord: ColorsConfigItem | undefined =
      currentMonitoring?.colorsConfig?.find((colorConfig: ColorsConfigItem) => {
        return (
          ((colorConfig.fromValue <= value && colorConfig.includeFromValue) ||
            (colorConfig.fromValue < value && !colorConfig.includeFromValue)) &&
          ((colorConfig.toValue >= value && colorConfig.includeToValue) ||
            (colorConfig.toValue > value && !colorConfig.includeToValue))
        );
      });
    return monitoringConfigRecord?.color ?? "blue";
  };

  return { goalTypeLevels: goalTypeLevels(), goalTypes: goalTypes(), colorForPercent };
};

const useGetGoalTypeStats = () => {
  const { data, loading, error } = useGetGoalTypeStatsQuery({
    variables: {
      data: {
        monitoringConfigId: 5,
        entityId: 21,
      },
    },
  });

  return { data: data?.getGoalTypeStats, loading, error };
};

export { useDashboard, useGetGoalTypeStats };
