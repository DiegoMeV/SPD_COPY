import { GoalType } from "../../graphql/gen/schema";
import { monitoringLabelMap } from "../utils/uiUtils";

type UseMonitoringProps = {
  goalTypes?: GoalType[];
};

const useMonitoring = (config?: UseMonitoringProps) => {
  const isProjectMonitoring = (goalTypes?: GoalType[]) =>
    Boolean(
      (goalTypes ?? config?.goalTypes)?.includes(GoalType.Project) ||
        (goalTypes ?? config?.goalTypes)?.includes(GoalType.Activity),
    );
  const isActivityMonitoring = (goalTypes?: GoalType[]) =>
    Boolean((goalTypes ?? config?.goalTypes)?.includes(GoalType.Activity));
  const isActionPlanMonitoring = (goalTypes?: GoalType[]) =>
    Boolean((goalTypes ?? config?.goalTypes)?.includes(GoalType.ActionPlan));
  const isActionPlanActivityMonitoring = (goalTypes?: GoalType[]) =>
    Boolean((goalTypes ?? config?.goalTypes)?.includes(GoalType.ActionPlanActivity));
  const isPublicPoliticMonitoring = (goalTypes?: GoalType[]) =>
    Boolean((goalTypes ?? config?.goalTypes)?.includes(GoalType.PublicPolitic));
  const isGoalMonitoring = (goalTypes?: GoalType[]) =>
    Boolean(
      (goalTypes ?? config?.goalTypes)?.includes(GoalType.Impact) ||
        (goalTypes ?? config?.goalTypes)?.includes(GoalType.Product) ||
        (goalTypes ?? config?.goalTypes)?.includes(GoalType.Result) ||
        (goalTypes ?? config?.goalTypes)?.includes(GoalType.WellBeing),
    );

  const getMonitoringLabels = (goalTypes?: GoalType[]) => {
    return (goalTypes ?? config?.goalTypes)
      ? monitoringLabelMap[(goalTypes ?? config?.goalTypes)![0]]
      : { plural: "", singular: "" };
  };

  return {
    isProjectMonitoring,
    isActivityMonitoring,
    isActionPlanMonitoring,
    isActionPlanActivityMonitoring,
    isPublicPoliticMonitoring,
    isGoalMonitoring,
    getMonitoringLabels,
  };
};

export { useMonitoring };
