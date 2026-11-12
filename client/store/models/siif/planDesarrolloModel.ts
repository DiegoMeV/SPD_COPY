import { Action, action, Computed, computed } from "easy-peasy";
import { GetPlanesDesarrolloQuery } from "../../../../graphql/gen/ops";

export type PlanDesarrollo = GetPlanesDesarrolloQuery["getPlanesDesarrollo"][number];

type LoadingMap = {
  planesDesarrollo: boolean;
  planDesarrollo: boolean;
};

export type PlanDesarrolloModel = {
  data: PlanDesarrollo[] | undefined;
  selectedPlanDesarrolloCode: number | undefined;
  loading: LoadingMap;
  setLoading: Action<PlanDesarrolloModel, Partial<LoadingMap>>;
  setData: Action<PlanDesarrolloModel, PlanDesarrollo[] | undefined>;
  setSelectedDevPlanCode: Action<PlanDesarrolloModel, number | undefined>;
  selectedPlanDesarrollo: Computed<PlanDesarrolloModel, PlanDesarrollo | undefined>;
};

export const planDesarrolloModel: PlanDesarrolloModel = {
  data: undefined,
  selectedPlanDesarrolloCode: undefined,
  loading: {
    planesDesarrollo: false,
    planDesarrollo: false,
  },
  setLoading: action((state, loading) => {
    state.loading = { ...state.loading, ...loading };
  }),
  setData: action((state, planesDesarrollo) => {
    state.data = planesDesarrollo;
  }),
  setSelectedDevPlanCode: action((state, planDesarrolloCode) => {
    state.selectedPlanDesarrolloCode = planDesarrolloCode;
  }),
  selectedPlanDesarrollo: computed((state) => {
    return state.data?.find(
      (planDesarrollo) => planDesarrollo.plan === state.selectedPlanDesarrolloCode,
    );
  }),
};
