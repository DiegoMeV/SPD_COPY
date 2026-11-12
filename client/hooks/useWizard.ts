import { use, useEffect } from "react";
import { useStoreActions, useStoreState } from "../store";
import { WizardStep } from "../store/models/wizardModel";

export type WizardConfig = {
  id: string;
  steps?: WizardStep[];
  initialStep?: number;
};

export const useWizard = ({ id, steps, initialStep }: WizardConfig) => {
  const data = useStoreState((state) => state.wizard.data);
  const isCompleted = useStoreState((state) => state.wizard.isCompleted);
  const startWizard = useStoreActions((actions) => actions.wizard.startWizard);
  const setSteps = useStoreActions((actions) => actions.wizard.setSteps);
  const setCurrent = useStoreActions((actions) => actions.wizard.setCurrent);
  const nextStep = useStoreActions((actions) => actions.wizard.nextStep);
  const prevStep = useStoreActions((actions) => actions.wizard.prevStep);
  const setCompleted = useStoreActions((actions) => actions.wizard.setCompleted);

  useEffect(() => {
    startWizard({ id, steps, current: initialStep });
  }, []);

  return {
    data: data[id],
    current: data[id]?.current,
    isCompleted: isCompleted(id),
    nextStep: () => nextStep(id),
    prevStep: () => prevStep(id),
    setCompleted: (completed: boolean) => setCompleted({ id, completed }),
    setSteps: (steps: WizardStep[]) => setSteps({ id, steps }),
    setCurrent: (current: number) => setCurrent({ id, current }),
  };
};

export const useWizardStep = ({ id }: { id: string }) => {
  const data = useStoreState((state) => state.wizard.data);
  const isCompleted = useStoreState((state) => state.wizard.isCompleted);
  const setCurrent = useStoreActions((actions) => actions.wizard.setCurrent);
  const nextStep = useStoreActions((actions) => actions.wizard.nextStep);
  const prevStep = useStoreActions((actions) => actions.wizard.prevStep);
  const setCompleted = useStoreActions((actions) => actions.wizard.setCompleted);

  return {
    current: data[id]?.current,
    isCompleted: isCompleted(id),
    nextStep: () => nextStep(id),
    prevStep: () => prevStep(id),
    setCompleted: (completed: boolean) => setCompleted({ id, completed }),
    setCurrent: (current: number) => setCurrent({ id, current }),
  };
};
