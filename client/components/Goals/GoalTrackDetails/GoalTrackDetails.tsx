import React from "react";
import { Card, Col, Form, Row } from "antd";
import { GoalSummary } from "../../Goals/GoalSummary";
import { useGoal, useGoalTracking } from "../../Goals/hooks";
import { GoalActivities } from "../../Goals";
import { MonitoringTrackTabs } from "../../Monitoring/MonitoringTrack/MonitoringTrackTabs";
import { useMonitoring } from "../../../hooks/useMonitoring";

const GoalTrackDetails: React.FC = () => {
  const { currentGoal } = useGoal();
  const [form] = Form.useForm();
  const { isGoalMonitoring } = useMonitoring();

  // The hook initializes form data
  useGoalTracking({ form });

  return (
    <Form form={form} layout="horizontal" disabled>
      <Card title={`Ejecución meta`}>
        {currentGoal && (
          <>
            <Row gutter={[8, 8]}>
              <Col span={24}>
                <GoalSummary goal={currentGoal} />
              </Col>
              {isGoalMonitoring([currentGoal.goalType]) && (
                <Col span={24}>
                  <GoalActivities goal={currentGoal} />
                </Col>
              )}
            </Row>
            <MonitoringTrackTabs disabled />
          </>
        )}
      </Card>
    </Form>
  );
};

export { GoalTrackDetails };
