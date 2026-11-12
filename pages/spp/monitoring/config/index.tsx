import React from 'react';
import { MonitoringConfigLoader } from "../../../../client/components/MonitoringConfig/MonitoringConfigLoader";
import { MonitoringConfigUsedFor } from '../../../../graphql/gen/schema';

const PublicPoliticMonitoringConfigPage: React.FC = () => {
  return <MonitoringConfigLoader usedFor={MonitoringConfigUsedFor.PublicPolitics} />;
};

export default PublicPoliticMonitoringConfigPage;