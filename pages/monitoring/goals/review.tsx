import { Result } from "antd";
import React, { useEffect } from "react";
import { useStoreActions } from "../../../client/store";
import { useCurrentUser } from "../../../client/components/Users/hooks";
import { AppContent } from "../../../client/components/Utils";
import { MonitoringReview } from "../../../client/components/Monitoring/MonitoringReview/MonitoringReview";
import { GoalType } from "../../../graphql/gen/schema";
import { useMonitoringConfig } from "../../../client/components/MonitoringConfig/hooks";

const MonitoringTrackPage: React.FC = () => {
  const { hasValidatePermission } = useCurrentUser();
  const { currentMonitoring } = useMonitoringConfig();
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);

  useEffect(() => {
    setCurrentGoal(undefined);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  if (hasValidatePermission())
    return (
      <AppContent title="Revisión de Avance de Metas">
        <MonitoringReview
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
      subTitle="Lo sentimos! Requiere tener una entidad asignada y contar con los permisos necesarios para revisar el seguimiento."
    />
  );
};

export default MonitoringTrackPage;
