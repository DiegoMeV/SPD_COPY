import React from "react";
import { MonitoringTrackByLocalization } from "./MonitoringTrackByLocalization";

type Props = {
  disabled?: boolean;
};

const MonitoringTrackTargetED: React.FC<Props> = ({ disabled = false }) => {
  return (
    <MonitoringTrackByLocalization
      formItemPath={["targetMatrix", "ed"]}
      tabChildrenComponent={"MonitoringTrackTargetEDForm"}
      description="focalización por enfoque diferencial"
      disabled={disabled}
    />
  );
};

export { MonitoringTrackTargetED };
