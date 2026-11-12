import { Action, action, Computed, computed } from "easy-peasy";

export type WizardStep = {
  title: string;
  completed: boolean;
};

export type WizardStepContent = Record<
  string,
  {
    steps: WizardStep[];
    current: number;
  }
>;

export type WizardModel = {
  data: WizardStepContent;
  startWizard: Action<WizardModel, { id: string; steps?: WizardStep[]; current?: number }>;
  setSteps: Action<WizardModel, { id: string; steps: WizardStep[] }>;
  setCurrent: Action<WizardModel, { id: string; current: number }>;
  nextStep: Action<WizardModel, string>;
  prevStep: Action<WizardModel, string>;
  isCompleted: Computed<WizardModel, (id: string) => boolean>;
  setCompleted: Action<WizardModel, { id: string; completed: boolean }>;
};

export const wizardModel: WizardModel = {
  data: {} as WizardStepContent,
  startWizard: action((state, config) => {
    state.data[config.id] = {
      steps: config.steps ?? [],
      current: config.current ?? 0,
    };
  }),
  setSteps: action((state, config) => {
    state.data[config.id].steps = [...config.steps];
  }),
  setCurrent: action((state, config) => {
    state.data[config.id].current = config.current;
  }),
  nextStep: action((state, id) => {
    const currentStepIndex = state.data[id].current;
    const isStepCompleted = state.data[id].steps[currentStepIndex].completed;
    if (isStepCompleted && currentStepIndex < state.data[id].steps.length - 1)
      state.data[id].current += 1;
  }),
  prevStep: action((state, id) => {
    if (state.data[id].current > 0) state.data[id].current -= 1;
  }),
  isCompleted: computed(
    (state) => (id: string) => state.data[id]?.steps[state.data[id].current]?.completed,
  ),
  setCompleted: action((state, config) => {
    const currentStepIndex = state.data[config.id].current;
    if (state.data[config.id].steps[currentStepIndex])
      state.data[config.id].steps[currentStepIndex].completed = config.completed;
  }),
};
