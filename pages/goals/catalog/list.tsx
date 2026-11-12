import React from "react";
import { GoalsCatalogListLoader } from "../../../client/components/Goals/GoalsCatalogList/GoalsCatalogListLoader";
import { useArrayRouteParam } from "../../../client/hooks/useParam";

const GoalCatalogListPage: React.FC = () => {
  const filters = {
    entityId: useArrayRouteParam("goalsEntityId") || [],
    goalType: useArrayRouteParam("goalsGoalType") || [],
    goalsText: useArrayRouteParam("goalsText") || [],
    devPlanLevelIds: useArrayRouteParam("goalsDevPlanLevelIds") || [],
  };

  return <GoalsCatalogListLoader id="goals" filters={filters} />;
};

export default GoalCatalogListPage;
