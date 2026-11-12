import React from "react";
import { Card, Form, TabsProps, Tabs } from "antd";
import { FormSubmitButtons } from "../../Buttons/FormSubmitButtons";
import { useGoal, useGoalSchedule } from "../hooks";
import {
  GoalMonitoringRecordStatus,
  GoalType,
  MonitoringStatus,
} from "../../../../graphql/gen/schema";
import { GoalHistory } from "../GoalHistory/GoalHistory";
import { GoalScheduleForm } from "./GoalScheduleForm";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";

type Props = {
  goalTypes?: GoalType[];
  stage: MonitoringStatus;
  showReturnButton?: boolean;
};

const GoalSchedule: React.FC<Props> = ({ goalTypes, stage, showReturnButton = true }) => {
  const [form] = Form.useForm();
  const { saveSchedule, saveLoading } = useGoalSchedule(form);
  const { currentGoal, setCurrentGoal, getGoalStatus } = useGoal();
  const { currentMonitoring, isScheduleDateEnabled } = useMonitoringConfig();

  const tabs: TabsProps["items"] = [
    {
      key: "schedule",
      label: "Datos Programación",
      children: (
        <GoalScheduleForm
          goalTypes={goalTypes}
          stage={stage}
          showReturnButton={showReturnButton}
          form={form}
        />
      ),
    },

    {
      key: "history",
      label: "Historial",
      children: <GoalHistory />,
    },
  ];

  if (!currentGoal || !currentMonitoring) return null;

  const goalStatus = getGoalStatus({
    goal: currentGoal,
    monitoringConfig: currentMonitoring,
    stage,
  });

  const disableSchedule =
    [
      GoalMonitoringRecordStatus.Validated,
      GoalMonitoringRecordStatus.Validated,
      GoalMonitoringRecordStatus.Reviewed,
    ].includes(goalStatus) || !isScheduleDateEnabled();

  return (
    <Card
      title="Programación"
      extra={
        <FormSubmitButtons
          type="icons"
          submitAction={saveSchedule}
          loading={saveLoading}
          returnAction={() => setCurrentGoal(undefined)}
          showReturnButton={showReturnButton}
          showSubmitButton={!disableSchedule}
        />
      }
      styles={{ body: { paddingTop: "6px" } }}
    >
      <Tabs
        defaultActiveKey="schedule"
        items={tabs}
        size="small"
        style={{ margin: 0, padding: 0 }}
      />
    </Card>
  );
};

export { GoalSchedule };
