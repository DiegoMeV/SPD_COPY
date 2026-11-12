import {
  GoalFragment,
  MonitoringRecordFragment,
  GetGoalQuery,
  SearchGoalsQuery,
} from "../../graphql/gen/ops";
// import { CreateMonitoringRecord } from "../../graphql/gen/schema";

export type ScheduleRecordsType = Record<string, Record<string, any>>;
// export type TrackingRecordsType = Record<Partial<MonitoringRecordType>, Record<string, Partial<CreateMonitoringRecord> & { id?: number | undefined }>>;
// export type TrackingTotal = Record<Partial<MonitoringRecordType>, Record<string, number>>;
export type GoalSummary = Pick<GoalFragment, "id" | "code" | "name" | "indicator"> & {
  schedule?: MonitoringRecordFragment[] | null;
};
export type SchedulingGoal = GoalFragment & {
  children?: GoalFragment[] | null;
  schedule?: MonitoringRecordFragment[] | null;
};
export type TrackingGoal = GoalFragment & {
  children?: GoalFragment[] | null;
  schedule?: MonitoringRecordFragment[] | null;
};

export type Goal = NonNullable<GetGoalQuery["getGoal"]>;
export type SiifActividadMeta = NonNullable<Goal["activities"]>[number];

export type SearchGoalItem = Omit<
  NonNullable<SearchGoalsQuery["searchGoals"]>["items"][number],
  "children"
>;
export type SearchGoal = SearchGoalItem & { children?: SearchGoalItem[] | null };
