import React from "react";
import { DevPlanCopyWizard } from "../../../client/components/DevPlan";
import { useRouteParam } from "../../../client/hooks/useParam";

const CopyLevelsPage: React.FC = () => {
  const devPlanId = parseInt(useRouteParam("devPlanId") || "0");

  return <DevPlanCopyWizard {...(devPlanId ? { devPlanId } : {})} />;
};

export default CopyLevelsPage;
