import React, { useEffect } from "react";
import { useStoreActions } from "../../../client/store";
import { AppContent } from "../../../client/components/Utils";
import { GoalType } from "../../../graphql/gen/schema";
import { MonitoringTrack } from "../../../client/components/Monitoring/MonitoringTrack/MonitoringTrack";

const ActionPlansTrackPage: React.FC = () => {
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);

  useEffect(() => {
    setCurrentGoal(undefined);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <AppContent title="Reportar Seguimiento de Planes de Acción">
      <MonitoringTrack goalTypes={[GoalType.ActionPlan]} />
    </AppContent>
  );
};

export default ActionPlansTrackPage;
