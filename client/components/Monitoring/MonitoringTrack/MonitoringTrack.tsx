import React from "react";
import { Card, Col, Form, Row } from "antd";
import { GoalSummary } from "../../Goals/GoalSummary";
import { useGoal, useGoalTracking } from "../../Goals/hooks";
import { useCurrentUser } from "../../Users/hooks";
import { FormSubmitButtons } from "../../Buttons/FormSubmitButtons";
import { GoalsTrackList } from "../../Goals/GoalsTrackList/GoalsTrackList";
import { MonitoringTrackTabs } from "./MonitoringTrackTabs";
import { GoalActivities } from "../../Goals";
import {
  GoalMonitoringRecordStatus,
  GoalType,
  MonitoringStatus,
} from "../../../../graphql/gen/schema";
import { ButtonBack } from "../../Buttons";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { useMonitoring } from "../../../hooks/useMonitoring";
import { MonitoringTrackIndicatorsSummary } from "./MonitoringTrackIndicatorsSummary";

type Props = {
  goalTypes?: GoalType[];
};

const MonitoringTrack: React.FC<Props> = ({ goalTypes }) => {
  const [form] = Form.useForm();
  const { saveTracking, onTrackFormChange, saveLoading } = useGoalTracking({ form });
  const { currentMonitoring, isReportDateEnabled } = useMonitoringConfig();
  const { currentGoal, setCurrentGoal, getGoalStatus } = useGoal();
  const { user } = useCurrentUser();
  const { isGoalMonitoring } = useMonitoring({ goalTypes });

  const goalStatus = getGoalStatus({
    goal: currentGoal,
    monitoringConfig: currentMonitoring,
    stage: MonitoringStatus.Reporting,
  });

  const disableReport =
    [GoalMonitoringRecordStatus.Validated, GoalMonitoringRecordStatus.Reviewed].includes(
      goalStatus,
    ) || !isReportDateEnabled();

  return (
    <Form
      form={form}
      onFinish={saveTracking}
      onValuesChange={onTrackFormChange}
      layout="horizontal"
      disabled={disableReport}
    >
      {user?.entityId && (
        <Row gutter={[8, 8]}>
          <Col span={currentGoal ? 6 : 16}>
            <GoalsTrackList goalTypes={goalTypes} stage={MonitoringStatus.Reporting} />
          </Col>
          <Col span={currentGoal ? 18 : 0}>
            <Card
              title={`Ejecución meta`}
              extra={
                disableReport ? (
                  <ButtonBack
                    title="Volver"
                    onClick={() => setCurrentGoal(undefined)}
                    disabled={false}
                  />
                ) : (
                  <FormSubmitButtons
                    type="icons"
                    loading={saveLoading}
                    returnAction={() => setCurrentGoal(undefined)}
                  />
                )
              }
            >
              {currentGoal && (
                <>
                  <Row gutter={[8, 8]}>
                    <Col span={24}>
                      <GoalSummary goal={currentGoal} />
                    </Col>
                    <Col span={24}>
                      <MonitoringTrackIndicatorsSummary />
                    </Col>
                    {isGoalMonitoring() && (
                      <Col span={24}>
                        <GoalActivities goal={currentGoal} />
                      </Col>
                    )}
                  </Row>
                  <MonitoringTrackTabs goalStatus={goalStatus} disabled={disableReport} />
                </>
              )}
              <div style={{ marginTop: "10px" }} />
              {goalStatus !== GoalMonitoringRecordStatus.Reviewed && (
                <Row justify="center" gutter={8}>
                  <Col>
                    <FormSubmitButtons
                      type="text"
                      loading={saveLoading}
                      returnAction={() => setCurrentGoal(undefined)}
                    />
                  </Col>
                </Row>
              )}
            </Card>
          </Col>
        </Row>
      )}
    </Form>
  );
};

export { MonitoringTrack };
