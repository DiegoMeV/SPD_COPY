import React from "react";
import { DevPlanDetails } from "../../../../client/components/DevPlan";
import { useRouteParam } from "../../../../client/hooks/useParam";

const DevPlanDetailsPage: React.FC = () => {
  const id = parseInt(useRouteParam("id") || "0");

  if (id) {
    return <DevPlanDetails id={id} />;
  }
  return null;
};

export default DevPlanDetailsPage;
