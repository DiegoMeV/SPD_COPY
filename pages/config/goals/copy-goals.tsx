import React from "react";
import { useRouteParam } from "../../../client/hooks/useParam";
import { GoalsCopyWizard } from "../../../client/components/Goals/GoalsCopy";

const CopyGoalsPage: React.FC = () => {
  const devPlanId = parseInt(useRouteParam("devPlanId") || "0");

  return <GoalsCopyWizard {...(devPlanId ? { devPlanId } : {})} />;
};

export default CopyGoalsPage;
