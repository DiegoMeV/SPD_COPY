import React from "react";
import { GoalsCatalog } from "../../../client/components/Goals/GoalsCatalog/GoalsCatalog";
import { GoalType, MonitoringStatus } from "../../../graphql/gen/schema";

const GoalsCatalogPage = () => {
  return (
    <GoalsCatalog
      goalTypes={[GoalType.Impact, GoalType.Product, GoalType.Result, GoalType.WellBeing]}
      stage={MonitoringStatus.Created}
    />
  );
};

export default GoalsCatalogPage;
