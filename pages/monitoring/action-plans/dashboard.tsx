import React from "react";
import { useArrayRouteParam } from "../../../client/hooks/useParam";
import { DashboardGoalsLoader } from "../../../client/components/Dashboard/DashboardGoals/DashboardGoalsLoader";
import { useStoreState } from "../../../client/store";
import { Result } from "antd";
import { AppContent } from "../../../client/components/Utils";
import { GoalType } from "../../../graphql/gen/schema";

const DashboardActionPlansPage: React.FC = () => {
  const user = useStoreState((state) => state.user.data);

  const filters = {
    entityId: useArrayRouteParam("goalsEntityId") || [`${user?.entityId}`],
    goalType: useArrayRouteParam("goalsGoalType") || [GoalType.ActionPlan],
    goalsText: useArrayRouteParam("goalsText") || [],
    devPlanLevelIds: useArrayRouteParam("goalsDevPlanLevelIds") || [],
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

export default DashboardActionPlansPage;
