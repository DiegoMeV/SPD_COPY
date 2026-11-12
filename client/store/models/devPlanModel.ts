import { Action, action, Computed, computed } from "easy-peasy";
import { DevPlan, DevPlanConfigLevel } from "../../types/devPlan";

type LoadingMap = {
  devPlans: boolean;
  devPlan: boolean;
  copyDevPlan: boolean;
};

export type DevPlanModel = {
  data: DevPlan[] | undefined;
  selectedDevPlanId: number | undefined | null;
  loading: LoadingMap;
  setLoading: Action<DevPlanModel, Partial<LoadingMap>>;
  setData: Action<DevPlanModel, DevPlan[] | undefined>;
  setSelectedDevPlanId: Action<DevPlanModel, number | undefined | null>;
  selectedDevPlan: Computed<DevPlanModel, DevPlan | undefined>;
  selectedDevPlanCode: Computed<DevPlanModel, string | undefined>;
  monitoringLevelNumbers: Computed<DevPlanModel, number[]>;
};

export const devPlanModel: DevPlanModel = {
  data: undefined,
  selectedDevPlanId: undefined,
  loading: {
    devPlans: false,
    devPlan: false,
    copyDevPlan: false,
  },
  setLoading: action((state, loading) => {
    state.loading = { ...state.loading, ...loading };
  }),
  setData: action((state, devPlans) => {
    state.data = devPlans;
  }),
  setSelectedDevPlanId: action((state, devPlanId) => {
    if (state.selectedDevPlanId !== devPlanId) {
      state.selectedDevPlanId = devPlanId;
    }
  }),
  selectedDevPlan: computed((state) => {
    return state.data?.find((devPlan) => devPlan.id === state.selectedDevPlanId);
  }),
  selectedDevPlanCode: computed((state) => {
    return state.data?.find((devPlan) => devPlan.id === state.selectedDevPlanId)?.code;
  }),
  monitoringLevelNumbers: computed((state) => {
    const devPlan = state.selectedDevPlan;
    return (
      devPlan?.config?.levels
        ?.filter((devPlanConfigLevel: DevPlanConfigLevel) => !!devPlanConfigLevel.goalType)
        .map((devPlanConfigLevel: DevPlanConfigLevel) => devPlanConfigLevel.number) ?? []
    );
  }),
};
