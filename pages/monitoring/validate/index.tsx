import { Result } from "antd";
import React, { useEffect } from "react";
import { useStoreActions, useStoreState } from "../../../client/store";
import { SPDRole } from "@prisma/client";
import { MonitoringValidate } from "../../../client/components/Monitoring/MonitoringValidate/MonitoringValidate";

const MonitoringValidatePage: React.FC = () => {
  const user = useStoreState((state) => state.user.data);
  const setCurrentGoal = useStoreActions((actions) => actions.goal.setCurrentGoal);

  useEffect(() => {
    setCurrentGoal(undefined);
  }, []);

  if (
    user?.entityId &&
    user?.role &&
    (user?.role === SPDRole.VALIDATOR ||
      user?.role === SPDRole.AUDITOR ||
      user?.role === SPDRole.ADMIN)
  )
    return <MonitoringValidate />;

  return (
    <Result
      status="403"
      title="Permisos"
      subTitle="Lo sentimos! Requiere tener una entidad asignada y contar con los permisos necesarios para validar el seguimiento."
    />
  );
};

export default MonitoringValidatePage;
