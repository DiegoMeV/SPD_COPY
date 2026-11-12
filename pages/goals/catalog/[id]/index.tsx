import React from "react";
import { GoalDetails } from "../../../../client/components/Goals";
import { useRouteParam } from "../../../../client/hooks/useParam";

const GoalDetailsPage: React.FC = () => {
  const id = parseInt(useRouteParam("id") || "0");

  if (id) {
    return <GoalDetails id={id} />;
  }
  return <></>;
};

export default GoalDetailsPage;
