import { Button, Space } from "antd";
import React from "react";
import { useGoal } from "../hooks";
import { Goal } from "../../../types/goal";
import { GoalMonitoringRecordStatus, MonitoringStatus } from "../../../../graphql/gen/schema";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { ButtonEye, ButtonReview } from "../../Buttons";
import { useStoreState } from "../../../store";
import { SPDRole } from "@prisma/client";

type Props = {
  goal: Goal;
  stage: MonitoringStatus;
  onSelectRow?: () => void;
};

const GoalsReviewTableActions: React.FC<Props> = ({ goal, stage, onSelectRow }) => {
  const { setCurrentGoal, getGoalStatus } = useGoal();
  const currentUser = useStoreState((state) => state.user.data);
  const { currentMonitoring, isReviewDateEnabled } = useMonitoringConfig();
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

  const MonitoringReviewButton = () => {
    if (isReviewDateEnabled()) {
      return <ButtonReview title="Revisar" onClick={onClick} disabled={disabled} />;
    }
    return <ButtonEye title="Ver" onClick={onClick} disabled={disabled} />;
  };

  return <MonitoringReviewButton />;
};

export { GoalsReviewTableActions };
