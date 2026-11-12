import React from "react";
import { useArrayRouteParam, useRouteParam } from "../../../client/hooks/useParam";
import { DashboardGoalsLoader } from "../../../client/components/Dashboard/DashboardGoals/DashboardGoalsLoader";
import { useStoreState } from "../../../client/store";
import { Result } from "antd";
import { AppContent } from "../../../client/components/Utils";
import { GoalType, SpentDoc } from "../../../graphql/gen/schema";
import { useMonitoringConfig } from "../../../client/components/MonitoringConfig/hooks";

const DashboardGoalsPage: React.FC = () => {
  const user = useStoreState((state) => state.user.data);
  const { currentMonitoring } = useMonitoringConfig();

  const goalTypes =
    [GoalType.Product, GoalType.Result, GoalType.Impact, GoalType.WellBeing].filter((goalType) =>
      currentMonitoring?.goalTypes.includes(goalType),
    ) || [];

  const filters = {
    entityId: useArrayRouteParam("goalsEntityId") || [`${user?.entityId}`],
    goalType: useArrayRouteParam("goalsGoalType") || goalTypes,
    goalsText: useArrayRouteParam("goalsText") || [],
    devPlanLevelIds: useArrayRouteParam("goalsDevPlanLevelIds") || [],
    spentDoc: [
      useRouteParam("spentDoc") ?? currentMonitoring?.spentDocs?.[0] ?? SpentDoc.Commitment,
    ],
  };

  if (!user?.entityId)
    return (
      <Result
        status="403"
        title="Permisos"
        subTitle="Lo sentimos! Requiere tener una entidad asignada."
      />
    );

  return (
    <AppContent title="Tableros de Control">
      <DashboardGoalsLoader id="goals" filters={filters} />
    </AppContent>
  );
};

export default DashboardGoalsPage;
