import { Action, action, computed, Computed, Thunk, thunk } from "easy-peasy";
import { GetGoalsWithScheduleDocument, SearchGoalsDocument } from "../../../graphql/gen/hooks";
import {
  MonitoringConfigFragment,
  GoalFragment,
  DevPlanFragment,
  SearchGoalsQuery,
  SearchGoalsQueryVariables,
  GetGoalsWithScheduleQuery,
  GetGoalsWithScheduleQueryVariables,
} from "../../../graphql/gen/ops";
import { apolloClient } from "../../lib/apollo";
import { Goal } from "../../types/goal";

type LoadingMap = {
  goals: boolean;
  trackingGoals: boolean;
  monitoringConfigs: boolean;
};

type MonitoringConfig = MonitoringConfigFragment & { devPlan: DevPlanFragment };

export type GoalModel = {
  goals: Goal[] | undefined;
  trackingGoals: Goal[] | undefined;
  monitoringConfigs: MonitoringConfig[] | undefined;
  selectedMonitoringConfigId: number | undefined;
  selectedTrackingGoal: Goal | undefined;
  selectedSchedulingGoal: Goal | undefined;
  currentGoal: Goal | undefined;
  loading: LoadingMap;
  setLoading: Action<GoalModel, Partial<LoadingMap>>;
  setGoals: Action<GoalModel, Goal[] | undefined>;
  setTrackingGoals: Action<GoalModel, Goal[] | undefined>;
  setMonitoringConfigs: Action<GoalModel, MonitoringConfig[] | undefined>;
  addGoal: Action<GoalModel, GoalFragment>;
  removeGoal: Action<GoalModel, GoalFragment>;
  replaceGoal: Action<GoalModel, GoalFragment>;
  fetchGoalsForLevel: Thunk<GoalModel, number>;
  fetchGoalsForTracking: Thunk<GoalModel, { entityId: number; monitoringConfigId: number }>;
  setSelectedMonitoringConfigId: Action<GoalModel, number | undefined>;
  setSelectedTrackingGoal: Action<GoalModel, Goal | undefined>;
  setSelectedSchedulingGoal: Action<GoalModel, Goal | undefined>;
  selectedMonitoring: Computed<GoalModel, MonitoringConfig | undefined>;
  setCurrentGoal: Action<GoalModel, Goal | undefined>;
  setCurrentGoalSchedule: Action<GoalModel, NonNullable<Goal["schedule"]>[number] | undefined>;
  setCurrentGoalTracking: Action<GoalModel, NonNullable<Goal["tracking"]>[number] | undefined>;
  hasSchedule: Computed<GoalModel, boolean>;
  hasTracking: Computed<GoalModel, boolean>;
};

export const goalModel: GoalModel = {
  goals: undefined,
  trackingGoals: undefined,
  monitoringConfigs: undefined,
  selectedMonitoringConfigId: undefined,
  selectedSchedulingGoal: undefined,
  selectedTrackingGoal: undefined,
  currentGoal: undefined,
  loading: {
    goals: false,
    trackingGoals: false,
    monitoringConfigs: false,
  },
  setLoading: action((state, loading) => {
    state.loading = { ...state.loading, ...loading };
  }),
  setGoals: action((state, goals) => {
    state.goals = goals;
  }),
  setTrackingGoals: action((state, goals) => {
    state.trackingGoals = goals;
  }),
  setMonitoringConfigs: action((state, monitoringConfigs) => {
    state.monitoringConfigs = monitoringConfigs;
  }),
  addGoal: action((state, goal) => {
    if (state.goals) state.goals?.push(goal);
    else state.goals = [goal];
  }),
  removeGoal: action((state, removedGoal) => {
    state.goals = state.goals?.filter((goal) => goal.id !== removedGoal.id);
  }),
  replaceGoal: action((state, updatedGoal) => {
    const goalIndex = state.goals?.findIndex((goal) => goal.id === updatedGoal.id);
    if (goalIndex !== undefined && goalIndex >= 0) state.goals?.splice(goalIndex, 1, updatedGoal);
  }),
  fetchGoalsForLevel: thunk(async (actions, devPlanLevelId) => {
    actions.setLoading({ goals: true });
    const query = await apolloClient.query<
      GetGoalsWithScheduleQuery,
      GetGoalsWithScheduleQueryVariables
    >({
      query: GetGoalsWithScheduleDocument,
      variables: { devPlanLevelId },
      fetchPolicy: "network-only",
    });
    if (query.data) actions.setGoals(query.data.getGoals);
    actions.setLoading({ goals: false });
    return query.data;
  }),
  fetchGoalsForTracking: thunk(async (actions, { entityId, monitoringConfigId }) => {
    actions.setLoading({ trackingGoals: true });
    const query = await apolloClient.query<SearchGoalsQuery, SearchGoalsQueryVariables>({
      query: SearchGoalsDocument,
      variables: { data: { entityId, monitoringConfigId } },
      fetchPolicy: "network-only",
    });
    if (query?.data?.searchGoals?.count) actions.setTrackingGoals(query.data.searchGoals?.items);
    actions.setLoading({ trackingGoals: false });
    return query.data;
  }),
  setSelectedMonitoringConfigId: action((state, selectedMonitoringConfigId) => {
    state.selectedMonitoringConfigId = selectedMonitoringConfigId;
  }),
  setSelectedTrackingGoal: action((state, goal) => {
    state.selectedTrackingGoal = goal;
  }),
  setSelectedSchedulingGoal: action((state, goal) => {
    state.selectedSchedulingGoal = goal;
  }),
  selectedMonitoring: computed((state) => {
    return state.monitoringConfigs?.find(
      (monitoringConfig) => monitoringConfig.id === state.selectedMonitoringConfigId,
    );
  }),
  setCurrentGoal: action((state, goal) => {
    state.currentGoal = goal;
  }),
  setCurrentGoalSchedule: action((state, newSchedule) => {
    if (state.currentGoal?.schedule && newSchedule) {
      const scheduleIndex = state.currentGoal?.schedule?.findIndex(
        (currentSchedule) => currentSchedule.monitoringConfigId === newSchedule.monitoringConfigId,
      );
      if (scheduleIndex > -1) {
        state.currentGoal.schedule = [
          ...state.currentGoal.schedule.slice(0, scheduleIndex),
          newSchedule,
          ...state.currentGoal.schedule.slice(0, scheduleIndex + 1),
        ];
      }
    }
  }),
  setCurrentGoalTracking: action((state, newTracking) => {
    if (state.currentGoal?.tracking && newTracking) {
      const trackingIndex = state.currentGoal?.tracking?.findIndex(
        (currentTracking) => currentTracking.monitoringConfigId === newTracking.monitoringConfigId,
      );
      if (trackingIndex > -1) {
        state.currentGoal.tracking = [
          ...state.currentGoal.tracking.slice(0, trackingIndex),
          newTracking,
          ...state.currentGoal.tracking.slice(0, trackingIndex + 1),
        ];
      }
    } else {
      if (state.currentGoal && newTracking) {
        state.currentGoal["tracking"] = [newTracking];
      }
    }
  }),
  hasSchedule: computed((state) => {
    if (state.currentGoal && state.selectedMonitoring) {
      return !!state.currentGoal?.schedule?.find(
        (scheduleRecord) => scheduleRecord.monitoringConfigId === state.selectedMonitoringConfigId,
      );
    }
    return false;
  }),
  hasTracking: computed((state) => {
    if (state.currentGoal && state.selectedMonitoring) {
      return !!state.currentGoal?.tracking?.find(
        (trackingRecord) => trackingRecord.monitoringConfigId === state.selectedMonitoringConfigId,
      );
    }
    return false;
  }),
};
