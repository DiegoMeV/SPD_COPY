import React, { useEffect } from "react";
import { useStoreActions } from "../../../client/store";
import { AppContent } from "../../../client/components/Utils";
import { GoalType } from "../../../graphql/gen/schema";
import { MonitoringReview } from "../../../client/components/Monitoring/MonitoringReview/MonitoringReview";

const ProjectsSchedulePage: React.FC = () => {
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);

  useEffect(() => {
    setCurrentGoal(undefined);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <AppContent title="Revisar Seguimiento de Proyectos">
      <MonitoringReview goalTypes={[GoalType.Project]} />
    </AppContent>
  );
};

export default ProjectsSchedulePage;
