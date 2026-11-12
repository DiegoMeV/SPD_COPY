import { Result } from "antd";
import React, { useEffect } from "react";
import { MonitoringTrack } from "../../../client/components/Monitoring/MonitoringTrack/MonitoringTrack";
import { useStoreActions } from "../../../client/store";
import { useCurrentUser } from "../../../client/components/Users/hooks";
import { AppContent } from "../../../client/components/Utils";
import { useMonitoringConfig } from "../../../client/components/MonitoringConfig/hooks";
import { GoalType } from "../../../graphql/gen/schema";

const MonitoringTrackPage: React.FC = () => {
  const { hasTrackPermission } = useCurrentUser();
  const { currentMonitoring } = useMonitoringConfig();
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);

  useEffect(() => {
    setCurrentGoal(undefined);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  if (hasTrackPermission())
    return (
      <AppContent title="Reporte de Avance de Metas">
        <MonitoringTrack
          goalTypes={[
            GoalType.Product,
            GoalType.Result,
            GoalType.Impact,
            GoalType.WellBeing,
          ].filter((goalType) => currentMonitoring?.goalTypes.includes(goalType))}
        />
      </AppContent>
    );

  return (
    <Result
      status="403"
      title="Permisos"
      subTitle="Lo sentimos! Requiere tener una entidad asignada y contar con los permisos necesarios para reportar el seguimiento."
    />
  );
};

export default MonitoringTrackPage;
