import { SearchGoalsDocument } from "../../../../graphql/gen/hooks";
import { apolloClient } from "../../../lib/apollo";
import { useStoreState, useStoreActions } from "../../../store";
import { SearchGoalsQuery } from "../../../../graphql/gen/ops";
import { Goal } from "../../../types/goal";
import { DevPlanConfigLevel } from "../../../types/devPlan";
import {
  MonitoringRecordStatus,
  GoalMonitoringRecordStatus,
  GoalType,
  MonitoringStatus,
} from "../../../../graphql/gen/schema";
import { useDevPlan } from "../../DevPlan/hooks";
import _ from "lodash";
import { MonitoringConfig } from "../../../types/monitoringConfig";

const useGoal = () => {
  const { selectedDevPlanId } = useDevPlan();
  const currentGoal = useStoreState((state) => state.goal.currentGoal);
  const selectedSchedulingGoal = useStoreState((state) => state.goal.selectedSchedulingGoal);
  const selectedMonitoringGoal = useStoreState((state) => state.goal.selectedSchedulingGoal);
  const setSelectedSchedulingGoal = useStoreActions(
    (actions) => actions.goal.setSelectedSchedulingGoal,
  );
  const setSelectedTrackingGoal = useStoreActions(
    (actions) => actions.goal.setSelectedTrackingGoal,
  );
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);

  const getGoalLevelLabel = (goal: Goal) => {
    const devPlanLevels: DevPlanConfigLevel[] = goal?.devPlanLevel?.devPlan?.config?.levels ?? [];
    const goalLevel = goal?.devPlanLevel?.level;
    return devPlanLevels?.find((devPlanLevel) => devPlanLevel.number === goalLevel)?.singularName;
  };

  const searchGoalsByCode = async (code: string) => {
    const query = await apolloClient.query<SearchGoalsQuery>({
      query: SearchGoalsDocument,
      variables: {
        data: {
          devPlanId: selectedDevPlanId,
          code,
        },
      },
      fetchPolicy: "network-only",
    });
    return query?.data?.searchGoals?.items;
  };

  const searchActionPlanGoalsByCode = async (actionPlanId: number | undefined, code: string) => {
    const query = await apolloClient.query<SearchGoalsQuery>({
      query: SearchGoalsDocument,
      variables: {
        data: {
          devPlanId: selectedDevPlanId,
          parentGoalId: actionPlanId,
          code,
        },
      },
      fetchPolicy: "network-only",
    });
    return query?.data?.searchGoals?.items;
  };

  const getGoalStatus = ({
    goal,
    monitoringConfig,
    stage,
  }: {
    goal?: Goal;
    monitoringConfig?: MonitoringConfig;
    stage: MonitoringStatus;
  }) => {
    if (goal && monitoringConfig) {
      const monitoringRecord = goal.monitoringRecords?.find(
        (monitoringRecord) => monitoringRecord.monitoringConfigId === monitoringConfig.id,
      );
      if (!monitoringRecord) return GoalMonitoringRecordStatus.New;

      if (
        stage === MonitoringStatus.Reporting &&
        monitoringRecord.goalStatus === GoalMonitoringRecordStatus.Scheduled
      )
        return GoalMonitoringRecordStatus.NoReported;
      if (
        stage === MonitoringStatus.Validating &&
        monitoringRecord.goalStatus === GoalMonitoringRecordStatus.Reported
      )
        return GoalMonitoringRecordStatus.NoValidated;
      if (
        stage === MonitoringStatus.Reviewing &&
        monitoringRecord.goalStatus === GoalMonitoringRecordStatus.Validated
      )
        return GoalMonitoringRecordStatus.NoReviewed;
      if (monitoringRecord.recordStatus === MonitoringRecordStatus.Rejected)
        return GoalMonitoringRecordStatus.Rejected;

      return monitoringRecord.goalStatus;
    }
    return GoalMonitoringRecordStatus.New;
  };

  return {
    selectedSchedulingGoal,
    selectedMonitoringGoal,
    setSelectedSchedulingGoal,
    setSelectedTrackingGoal,
    currentGoal,
    setCurrentGoal,
    searchGoalsByCode,
    searchActionPlanGoalsByCode,
    getGoalLevelLabel,
    getGoalStatus,
  };
};

const useCurrentGoal = () => {
  const currentGoal = useStoreState((state) => state.goal.currentGoal);

  const isProjectGoal = () => currentGoal?.goalType === GoalType.Project;
  const isActivityGoal = () => currentGoal?.goalType === GoalType.Activity;
  const isActionPlanGoal = () => currentGoal?.goalType === GoalType.ActionPlan;
  const isPublicPoliticGoal = () => currentGoal?.goalType === GoalType.PublicPolitic;
  const isDevPlanGoal = () =>
    currentGoal?.goalType === GoalType.Impact ||
    currentGoal?.goalType === GoalType.Product ||
    currentGoal?.goalType === GoalType.Result ||
    currentGoal?.goalType === GoalType.WellBeing;

  return {
    currentGoal,
    isProjectGoal,
    isActivityGoal,
    isActionPlanGoal,
    isPublicPoliticGoal,
    isDevPlanGoal,
  };
};

export default useGoal;

export { useCurrentGoal };
