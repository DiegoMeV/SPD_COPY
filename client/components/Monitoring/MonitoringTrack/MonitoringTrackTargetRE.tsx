import React from "react";
import { MonitoringTrackByLocalization } from "./MonitoringTrackByLocalization";

type Props = {
  disabled?: boolean;
};

const MonitoringTrackTargetRE: React.FC<Props> = ({ disabled = false }) => {
  return (
    <MonitoringTrackByLocalization
      formItemPath={["targetMatrix", "re"]}
      tabChildrenComponent={"MonitoringTrackTargetREForm"}
      description="focalización por recurso ecosistémico"
      disabled={disabled}
    />
  );
};

export { MonitoringTrackTargetRE };
