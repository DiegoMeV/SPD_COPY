import { Button, Space } from "antd";
import React from "react";
import { useGoal } from "../hooks";
import { Goal } from "../../../types/goal";
import { GoalMonitoringRecordStatus, MonitoringStatus } from "../../../../graphql/gen/schema";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { ButtonEye, ButtonTrack } from "../../Buttons";
import { useStoreState } from "../../../store";
import { SPDRole } from "@prisma/client";

type Props = {
  goal: Goal;
  stage: MonitoringStatus;
  onSelectRow?: () => void;
};

const GoalsTrackTableActions: React.FC<Props> = ({ goal, stage, onSelectRow }) => {
  const { setCurrentGoal, getGoalStatus } = useGoal();
  const currentUser = useStoreState((state) => state.user.data);
  const { currentMonitoring, isReportDateEnabled } = useMonitoringConfig();
  const goalStatus = getGoalStatus({
    goal: goal,
    monitoringConfig: currentMonitoring,
    stage,
  });

  const onClick = () => {
    setCurrentGoal(goal);
    onSelectRow?.();
  };

  const disabled = !(
    currentUser?.entityId === goal.entityId ||
    currentUser?.role === SPDRole.AUDITOR ||
    currentUser?.role === SPDRole.ADMIN
  );

  const MonitoringTrackButton = () => {
    if (
      isReportDateEnabled() &&
      ![GoalMonitoringRecordStatus.Validated, GoalMonitoringRecordStatus.Reviewed].includes(
        goalStatus,
      )
    ) {
      return <ButtonTrack title="Reportar" onClick={onClick} disabled={disabled} />;
    }
    return <ButtonEye title="Ver" onClick={onClick} disabled={disabled} />;
  };

  return <MonitoringTrackButton />;
};

export { GoalsTrackTableActions };
