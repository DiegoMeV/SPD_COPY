import React from "react";
import { useRouteParam } from "../../../../client/hooks/useParam";
import { MonitoringConfigEdit } from "../../../../client/components/MonitoringConfig";
import { MonitoringConfigUsedFor } from "../../../../graphql/gen/schema";

const MonitoringConfigEditPage: React.FC = () => {
  const id = parseInt(useRouteParam("id") || "0");

  if (!id) return <></>;
  return <MonitoringConfigEdit id={id} usedFor={MonitoringConfigUsedFor.DevelopmentPlans} />;
};

export default MonitoringConfigEditPage;
