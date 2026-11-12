import React from "react";
import { useArrayRouteParam } from "../../../client/hooks/useParam";
import { DashboardGoalsLoader } from "../../../client/components/Dashboard/DashboardGoals/DashboardGoalsLoader";
import { useStoreState } from "../../../client/store";
import { Result } from "antd";

const DashboardGoalsPage: React.FC = () => {
  const user = useStoreState((state) => state.user.data);
  const filters = {
    entityId: useArrayRouteParam("goalsEntityId") || [`${user?.entityId}`],
    goalType: useArrayRouteParam("goalsGoalType") || [],
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

  return <DashboardGoalsLoader id="goals" filters={filters} />;
};

export default DashboardGoalsPage;
