import React, { useEffect } from "react";
import { useStoreActions } from "../../../client/store";
import { AppContent } from "../../../client/components/Utils";
import { GoalType } from "../../../graphql/gen/schema";
import { MonitoringValidate } from "../../../client/components/Monitoring/MonitoringValidate/MonitoringValidate";

const ActionPlansValidatePage: React.FC = () => {
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);

  useEffect(() => {
    setCurrentGoal(undefined);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <AppContent title="Validar Seguimiento de Planes de Acción">
      <MonitoringValidate goalTypes={[GoalType.ActionPlan]} />
    </AppContent>
  );
};

export default ActionPlansValidatePage;
