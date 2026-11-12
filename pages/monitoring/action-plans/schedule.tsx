import React, { useEffect } from "react";
import { useStoreActions } from "../../../client/store";
import { GoalsCatalog } from "../../../client/components/Goals/GoalsCatalog/GoalsCatalog";
import { AppContent } from "../../../client/components/Utils";
import { GoalType, MonitoringStatus } from "../../../graphql/gen/schema";

const ActionPlansSchedulePage: React.FC = () => {
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);

  useEffect(() => {
    setCurrentGoal(undefined);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <AppContent title="Programación de Planes de Acción">
      <GoalsCatalog stage={MonitoringStatus.Scheduling} goalTypes={[GoalType.ActionPlan]} />
    </AppContent>
  );
};

export default ActionPlansSchedulePage;
