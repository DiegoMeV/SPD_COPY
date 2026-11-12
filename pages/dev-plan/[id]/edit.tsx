import React from "react";
import { useRouteParam } from "../../../client/hooks/useParam";
import { DevPlanEdit } from "../../../client/components/DevPlan";

const DevPlanEditPage: React.FC = () => {
  const id = parseInt(useRouteParam("id") || "0");

  if (!id) return <></>;
  return <DevPlanEdit id={id} />;
};

export default DevPlanEditPage;
