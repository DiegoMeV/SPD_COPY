import React from "react";
import { AppContent } from "../../../client/components/Utils";
import { useMonitoringConfig } from "../../../client/components/MonitoringConfig/hooks";
import { GoalsCatalog } from "../../../client/components/Goals/GoalsCatalog/GoalsCatalog";
import { GoalType, MonitoringStatus } from "../../../graphql/gen/schema";

const ActionPlansPage = () => {
  const { currentMonitoring } = useMonitoringConfig();
  return (
    <AppContent title="Planes de Acción">
      <GoalsCatalog
        stage={MonitoringStatus.Created}
        goalTypes={[GoalType.ActionPlan].filter((goalType) =>
          currentMonitoring?.goalTypes.includes(goalType),
        )}
      />
    </AppContent>
  );
};

export default ActionPlansPage;
