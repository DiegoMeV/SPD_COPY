import React, { useEffect } from "react";
import { GoalsTrackList } from "./GoalsTrackList";
import { useStoreActions } from "../../../store";

type Props = {
  entityId?: number;
  monitoringConfigId?: number | null;
};

const GoalsTrackListLoader: React.FC<Props> = ({ entityId, monitoringConfigId }) => {
  const fetchGoalsForTracking = useStoreActions((actions) => actions.goal.fetchGoalsForTracking);

  useEffect(() => {
    if (monitoringConfigId && entityId) fetchGoalsForTracking({ entityId, monitoringConfigId });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [monitoringConfigId, entityId]);

  return <GoalsTrackList />;
};

export { GoalsTrackListLoader };
