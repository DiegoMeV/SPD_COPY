import React from "react";
import { MonitoringTrackByLocalization } from "./MonitoringTrackByLocalization";

type Props = {
  disabled?: boolean;
};

const MonitoringTrackTargetOrg: React.FC<Props> = ({ disabled = false }) => {
  return (
    <MonitoringTrackByLocalization
      formItemPath={["targetMatrix", "org"]}
      tabChildrenComponent={"MonitoringTrackTargetOrgForm"}
      description="focalización por enfoque organizacional"
      disabled={disabled}
    />
  );
};

export { MonitoringTrackTargetOrg };
