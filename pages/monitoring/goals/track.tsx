import { Result } from "antd";
import React, { useEffect } from "react";
import { MonitoringTrack } from "../../../client/components/Monitoring/MonitoringTrack/MonitoringTrack";
import { useStoreActions } from "../../../client/store";
import { useCurrentUser } from "../../../client/components/Users/hooks";

const MonitoringTrackPage: React.FC = () => {
  const { hasTrackPermission } = useCurrentUser();
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);

  useEffect(() => {
    setCurrentGoal(undefined);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  if (hasTrackPermission()) return <MonitoringTrack />;

  return (
    <Result
      status="403"
      title="Permisos"
      subTitle="Lo sentimos! Requiere tener una entidad asignada y contar con los permisos necesarios para reportar el seguimiento."
    />
  );
};

export default MonitoringTrackPage;
