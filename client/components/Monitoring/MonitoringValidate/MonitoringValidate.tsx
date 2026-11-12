import React from "react";
import { Card, Col, Form, Row, Switch } from "antd";
import { GoalSummary } from "../../Goals/GoalSummary";
import { useGoal, useGoalValidating } from "../../Goals/hooks";
import { useCurrentUser } from "../../Users/hooks";
import { FormSubmitButtons } from "../../Buttons/FormSubmitButtons";
import { GoalActivities } from "../../Goals";
import {
  GoalMonitoringRecordStatus,
  GoalType,
  MonitoringStatus,
} from "../../../../graphql/gen/schema";
import { ButtonBack } from "../../Buttons";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { useMonitoring } from "../../../hooks/useMonitoring";
import { GoalsValidateList } from "../../Goals/GoalsValidateList/GoalsValidateList";
import { MonitoringTrackIndicatorsSummary } from "../MonitoringTrack/MonitoringTrackIndicatorsSummary";
import { MonitoringTrackTabs } from "../MonitoringTrack/MonitoringTrackTabs";

type Props = {
  goalTypes?: GoalType[];
};

const MonitoringValidate: React.FC<Props> = ({ goalTypes }) => {
  const [form] = Form.useForm();
  const { saveValidation, onValidateFormChange, saveLoading } = useGoalValidating({ form });
  const { currentMonitoring, isValidateDateEnabled } = useMonitoringConfig();
  const { currentGoal, setCurrentGoal, getGoalStatus } = useGoal();
  const { user } = useCurrentUser();
  const { isGoalMonitoring } = useMonitoring({ goalTypes });

  const goalStatus = getGoalStatus({
    goal: currentGoal,
    monitoringConfig: currentMonitoring,
    stage: MonitoringStatus.Reporting,
  });

  const disableValidate =
    [GoalMonitoringRecordStatus.Reviewed].includes(goalStatus) || !isValidateDateEnabled();

  return (
    <Form
      form={form}
      onFinish={saveValidation}
      onValuesChange={onValidateFormChange}
      layout="horizontal"
      disabled={disableValidate}
    >
      {user?.entityId && (
        <Row gutter={[8, 8]}>
          <Col span={!currentGoal ? 16 : 6}>
            <GoalsValidateList goalTypes={goalTypes} />
          </Col>
          <Col span={currentGoal ? 18 : 0}>
            <Card
              title={`Ejecución meta`}
              extra={
                goalStatus !== GoalMonitoringRecordStatus.Reviewed ? (
                  <FormSubmitButtons
                    type="icons"
                    loading={saveLoading}
                    returnAction={() => setCurrentGoal(undefined)}
                  />
                ) : (
                  <ButtonBack title="Volver" onClick={() => setCurrentGoal(undefined)} />
                )
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
                      <Form.Item name="isValidated" valuePropName="checked">
                        <Switch
                          checkedChildren="Validada"
                          unCheckedChildren="Sin Validar"
                          defaultChecked
                        />
                      </Form.Item>
                    </Col>
                  </Row>

                  <MonitoringTrackTabs goalStatus={goalStatus} disabled={disableValidate} />
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

export { MonitoringValidate };
