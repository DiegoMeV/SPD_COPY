import React from "react";
import { MonitoringConfigNew } from "../../../client/components/MonitoringConfig";
import { MonitoringConfigUsedFor } from "../../../graphql/gen/schema";

const MonitoringConfigNewPage: React.FC = () => {
  return <MonitoringConfigNew usedFor={MonitoringConfigUsedFor.DevelopmentPlans} />;
};

export default MonitoringConfigNewPage;
