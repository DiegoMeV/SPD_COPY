import React from "react";
import { DevPlanLevels } from "../../../../client/components/DevPlan";
import { useRouteParam } from "../../../../client/hooks/useParam";

const DevPlanLevelsPage: React.FC = () => {
  const id = parseInt(useRouteParam("id") || "0");

  if (id) {
    return <DevPlanLevels id={id} />;
  }
  return <></>;
};

export default DevPlanLevelsPage;
