import { Button, Space, Typography } from "antd";
import React, { useState, useEffect } from "react";
import { ButtonDelete, ButtonDetails, ButtonEye, ButtonMoney, ButtonSchedule } from "../../Buttons";
import { useDeleteGoal, useGoal } from "../hooks";
import { Goal, SchedulingGoal } from "../../../types/goal";
import { GoalEdit } from "../GoalEdit";
import { SPDRole } from "@prisma/client";
import { useStoreState } from "../../../store";
import { ButtonTrack } from "../../Buttons/ButtonTrack";
import {
  GoalMonitoringRecordStatus,
  GoalType,
  MonitoringRecordStatus,
  MonitoringStatus,
} from "../../../../graphql/gen/schema";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { useMonitoring } from "../../../hooks/useMonitoring";
import { GoalNew } from "../GoalNew";

type Props = {
  goal: Goal;
  stage: MonitoringStatus;
  onSelectRow?: () => void;
};

const { Title } = Typography;

const GoalsTableActions: React.FC<Props> = ({ goal, stage, onSelectRow }) => {
  const { deleteGoal, loading } = useDeleteGoal();
  const { setCurrentGoal, getGoalStatus } = useGoal();
  const currentUser = useStoreState((state) => state.user.data);
  const { currentMonitoring, isScheduleDateEnabled } = useMonitoringConfig();
  const goalStatus = getGoalStatus({
    goal: goal,
    monitoringConfig: currentMonitoring,
    stage,
  });
  const { isGoalMonitoring, isActionPlanMonitoring } = useMonitoring({
    goalTypes: [goal.goalType],
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

  const MonitoringScheduleButton = () => {
    if (
      isScheduleDateEnabled() &&
      ![GoalMonitoringRecordStatus.Validated, GoalMonitoringRecordStatus.Reviewed].includes(
        goalStatus,
      )
    ) {
      return <ButtonSchedule title="Programar" onClick={onClick} disabled={disabled} />;
    }
    return <ButtonEye title="Ver" onClick={onClick} disabled={disabled} />;
  };

  return (
    <Space size="middle" direction="horizontal" style={{ width: "100%", justifyContent: "center" }}>
      {stage === MonitoringStatus.Created && goal.goalType === GoalType.ActionPlan && (
        <ButtonDetails title="Metas del plan de acción" onClick={onClick} />
      )}
      {stage === MonitoringStatus.Scheduling && <MonitoringScheduleButton />}
      {stage === MonitoringStatus.Reporting && (
        <ButtonTrack title="Reportar" onClick={onClick} disabled={disabled} />
      )}
    </Space>
  );
};

export { GoalsTableActions };
