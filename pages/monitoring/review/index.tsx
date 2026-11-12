import { Result } from "antd";
import React, { useEffect } from "react";
import { useStoreActions, useStoreState } from "../../../client/store";
import { SPDRole } from "@prisma/client";
import { MonitoringReview } from "../../../client/components/Monitoring/MonitoringReview/MonitoringReview";

const MonitoringReviewPage: React.FC = () => {
  const user = useStoreState((state) => state.user.data);
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);

  useEffect(() => {
    setCurrentGoal(undefined);
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  if (
    user?.entityId &&
    user?.role &&
    (user?.role === SPDRole.AUDITOR || user?.role === SPDRole.ADMIN)
  )
    return <MonitoringReview />;

  return (
    <Result
      status="403"
      title="Permisos"
      subTitle="Lo sentimos! Requiere tener una entidad asignada y contar con los permisos necesarios para revisar el seguimiento."
    />
  );
};

export default MonitoringReviewPage;
