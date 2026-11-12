import React from "react";
import { Card, Col, Form, Row, TabsProps, Tabs, FormInstance } from "antd";
import { GoalScheduleCol } from "./GoalScheduleCol";
import { GoalSummary } from "../GoalSummary";
import { FormSubmitButtons } from "../../Buttons/FormSubmitButtons";
import { useGoal, useGoalSchedule } from "../hooks";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { GoalsScheduleLabels } from "./GoalScheduleLabels";
import { GoalScheduleResourcesCol } from "./GoalScheduleResourcesCol";
import {
  GoalMonitoringRecordStatus,
  GoalType,
  MonitoringResourcesOrigin,
  MonitoringStatus,
} from "../../../../graphql/gen/schema";
import { GoalActivities } from "../GoalActivities";
import { useCurrentUser } from "../../Users/hooks";
import { useMonitoring } from "../../../hooks/useMonitoring";

type Props = {
  goalTypes?: GoalType[];
  stage: MonitoringStatus;
  showReturnButton?: boolean;
  form: FormInstance;
};

const GoalScheduleForm: React.FC<Props> = ({ goalTypes, stage, showReturnButton = true, form }) => {
  const { saveSchedule, onScheduleFormChange, saveLoading } = useGoalSchedule(form);
  const { currentGoal, setCurrentGoal, getGoalStatus } = useGoal();
  const { currentMonitoring, isScheduleDateEnabled } = useMonitoringConfig();
  const { user } = useCurrentUser();
  const { isGoalMonitoring } = useMonitoring({ goalTypes });

  const hasFinancialResources =
    currentMonitoring?.monitoringResourcesOrigin &&
    [MonitoringResourcesOrigin.Financial, MonitoringResourcesOrigin.UserAndFinancial].includes(
      currentMonitoring?.monitoringResourcesOrigin,
    );

  if (!currentGoal) return null;

  const goalStatus = getGoalStatus({
    goal: currentGoal,
    monitoringConfig: currentMonitoring,
    stage,
  });

  const disableSchedule =
    [GoalMonitoringRecordStatus.Validated, GoalMonitoringRecordStatus.Reviewed].includes(
      goalStatus,
    ) ||
    !isScheduleDateEnabled() ||
    currentGoal?.goalType === GoalType.ActionPlan;

  return (
    <Form
      form={form}
      onFinish={saveSchedule}
      onValuesChange={onScheduleFormChange}
      disabled={disableSchedule}
    >
      <Row gutter={[0, 10]}>
        {currentGoal && (
          <>
            <Col span={24}>
              <GoalSummary goal={currentGoal} />
            </Col>
            {isGoalMonitoring() && (
              <Col span={24}>
                <GoalActivities goal={currentGoal} />
              </Col>
            )}
          </>
        )}
        <Col span={24}></Col>
      </Row>
      <Row gutter={4}>
        <Col span={8}>
          <GoalsScheduleLabels />
        </Col>
        <Col span={16}>
          <Row gutter={[10, 0]}>
            <Col span={12}>
              <GoalScheduleCol disabled={disableSchedule} />
            </Col>
          </Row>
          <Row gutter={[10, 0]}>
            {currentMonitoring?.monitoringResourcesOrigin &&
              [MonitoringResourcesOrigin.User, MonitoringResourcesOrigin.UserAndFinancial].includes(
                currentMonitoring?.monitoringResourcesOrigin,
              ) && (
                <Col span={12}>
                  <GoalScheduleResourcesCol
                    origin={MonitoringResourcesOrigin.User}
                    disabled={disableSchedule}
                  />
                </Col>
              )}
            {hasFinancialResources && (
              <Col span={12}>
                <GoalScheduleResourcesCol
                  origin={MonitoringResourcesOrigin.Financial}
                  disabled={!user?.entity?.hasManualBudget || disableSchedule}
                />
              </Col>
            )}
          </Row>
        </Col>
      </Row>
      <Row></Row>
      <Row justify="center" gutter={8}>
        <Col>
          <FormSubmitButtons
            type="text"
            loading={saveLoading}
            returnAction={() => setCurrentGoal(undefined)}
            showReturnButton={showReturnButton}
          />
        </Col>
      </Row>
    </Form>
  );
};

export { GoalScheduleForm };
