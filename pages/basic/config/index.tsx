import React from "react";
import { MonitoringConfigLoader } from "../../../client/components/MonitoringConfig/MonitoringConfigLoader";
import { MonitoringConfigUsedFor } from "../../../graphql/gen/schema";

const MonitoringConfigPage: React.FC = () => {
  return <MonitoringConfigLoader usedFor={MonitoringConfigUsedFor.DevelopmentPlans} />;
};

export default MonitoringConfigPage;
