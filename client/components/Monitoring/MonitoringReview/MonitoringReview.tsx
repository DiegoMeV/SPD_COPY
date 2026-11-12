import React from "react";
import { Button, Card, Checkbox, Col, Divider, Form, Row, Switch, Typography } from "antd";
import { GoalSummary } from "../../Goals/GoalSummary";
import { useGoal, useGoalReview } from "../../Goals/hooks";
import { useCurrentUser } from "../../Users/hooks";
import { FormSubmitButtons } from "../../Buttons/FormSubmitButtons";
import { MonitoringConfigSelectInput } from "../../MonitoringConfig/MonitoringConfigSelectInput";
import { MonitoringTrackTabs } from "../MonitoringTrack/MonitoringTrackTabs";
import { GoalActivities } from "../../Goals";
import { GoalsReviewList } from "../../Goals/GoalsReviewList/GoalsReviewList";
import { MonitoringReviewDialog } from "./MonitoringReviewDialog";
import { useMonitoring } from "../../../hooks/useMonitoring";
import {
  GoalMonitoringRecordStatus,
  GoalType,
  MonitoringStatus,
} from "../../../../graphql/gen/schema";
import { MonitoringTrackIndicatorsSummary } from "../MonitoringTrack/MonitoringTrackIndicatorsSummary";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import TextArea from "antd/es/input/TextArea";
import { ButtonBack } from "../../Buttons";

const { Title } = Typography;

type Props = {
  goalTypes?: GoalType[];
};

const MonitoringReview: React.FC<Props> = ({ goalTypes }) => {
  const [form] = Form.useForm();
  const { saveReview, onReviewFormChange, saveLoading } = useGoalReview({ form });
  const { currentMonitoring, isReviewDateEnabled } = useMonitoringConfig();

  const { currentGoal, setCurrentGoal, getGoalStatus } = useGoal();
  const { user } = useCurrentUser();
  const { isGoalMonitoring } = useMonitoring({ goalTypes });

  const goalStatus = getGoalStatus({
    goal: currentGoal,
    monitoringConfig: currentMonitoring,
    stage: MonitoringStatus.Reporting,
  });

  const disableReview = !isReviewDateEnabled();

  return (
    <Form
      form={form}
      onFinish={saveReview}
      onValuesChange={onReviewFormChange}
      layout="horizontal"
      disabled={disableReview}
    >
      {user?.entityId && (
        <Row gutter={[8, 8]}>
          <Col span={!currentGoal ? 16 : 6}>
            <GoalsReviewList goalTypes={goalTypes} />
          </Col>
          <Col span={currentGoal ? 18 : 0}>
            <Card
              title={`Ejecución meta`}
              extra={
                <>
                  <FormSubmitButtons
                    type="icons"
                    loading={saveLoading}
                    returnAction={() => setCurrentGoal(undefined)}
                  />
                </>
              }
            >
              {currentGoal && (
                <>
                  <Row gutter={[8, 8]}>
                    <Col span={20}>
                      <Row gutter={[8, 8]}>
                        <Col span={24}>
                          <GoalSummary goal={currentGoal} />
                        </Col>
                        {isGoalMonitoring() && (
                          <Col span={24}>
                            <GoalActivities goal={currentGoal} />
                          </Col>
                        )}
                        <Col span={24}>
                          <MonitoringTrackIndicatorsSummary />
                        </Col>
                      </Row>
                    </Col>
                    <Col span={4} style={{ textAlign: "center", alignContent: "center" }}>
                      <Card className="monitoring-review">
                        <Form.Item name="reviewStatus" valuePropName="checked">
                          <Switch
                            checkedChildren="Aprobada"
                            unCheckedChildren="Rechazada"
                            defaultChecked
                          />
                        </Form.Item>
                        <Form.Item name={"reviewNotes"} style={{ marginTop: 10, marginBottom: 0 }}>
                          <TextArea rows={5} placeholder="Ingrese una observación si lo requiere" />
                        </Form.Item>
                      </Card>
                    </Col>
                  </Row>

                  <MonitoringTrackTabs goalStatus={goalStatus} disabled={disableReview} />
                </>
              )}
              <div style={{ marginTop: "10px" }} />
            </Card>
          </Col>
        </Row>
      )}
    </Form>
  );
};

export { MonitoringReview };
