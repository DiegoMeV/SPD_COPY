import React from "react";
import { MonitoringConfigNew } from "../../../../client/components/MonitoringConfig";
import { MonitoringConfigUsedFor } from "../../../../graphql/gen/schema";

const PublicPoliticMonitoringConfigNewPage: React.FC = () => {
    return <MonitoringConfigNew usedFor={MonitoringConfigUsedFor.PublicPolitics} />;
};

export default PublicPoliticMonitoringConfigNewPage;
