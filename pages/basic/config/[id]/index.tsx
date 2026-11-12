import React from "react";
import { MonitoringConfigDetails } from "../../../../client/components/MonitoringConfig";
import { useRouteParam } from "../../../../client/hooks/useParam";

const MonitoringConfigDetailsPage: React.FC = () => {
  const id = parseInt(useRouteParam("id") || "0");

  if (id) {
    return <MonitoringConfigDetails id={id} />;
  }
  return <></>;
};

export default MonitoringConfigDetailsPage;
