import React from "react";
import { GoalsCatalog } from "../../../client/components/Goals/GoalsCatalog/GoalsCatalog";
import { AppContent } from "../../../client/components/Utils";
import { GoalType, MonitoringStatus } from "../../../graphql/gen/schema";
import { useMonitoringConfig } from "../../../client/components/MonitoringConfig/hooks";

const GoalsCatalogPage = () => {
  const { currentMonitoring } = useMonitoringConfig();
  return (
    <AppContent title="Catálogo de Metas">
      <GoalsCatalog
        stage={MonitoringStatus.Created}
        goalTypes={[GoalType.Product, GoalType.Result, GoalType.Impact, GoalType.WellBeing].filter(
          (goalType) => currentMonitoring?.goalTypes.includes(goalType),
        )}
      />
    </AppContent>
  );
};

export default GoalsCatalogPage;
