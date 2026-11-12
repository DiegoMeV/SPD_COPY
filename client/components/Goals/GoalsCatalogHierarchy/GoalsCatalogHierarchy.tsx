import React from "react";
import { Card, Col, Form, Row } from "antd";
import { DevPlanTreeLoader } from "../../DevPlanTree/DevPlanTreeLoader";
import { useDevPlan } from "../../DevPlan/hooks";
import { useDevPlanTree } from "../../DevPlanTree/hooks";
import { GoalsForLevel } from "../GoalsForLevel/GoalsForLevel";
import { GoalType, MonitoringStatus } from "../../../../graphql/gen/schema";
import { useGoal } from "../hooks";
import { useMonitoring } from "../../../hooks/useMonitoring";
import ActionPlanGoals from "../../ActionPlans/ActionPlanGoals";

type GoalsCatalogHierarchyProps = {
  stage: MonitoringStatus;
  goalTypes?: GoalType[];
};

const GoalsCatalogHierarchy: React.FC<GoalsCatalogHierarchyProps> = ({ stage, goalTypes }) => {
  const [form] = Form.useForm();
  const { selectedDevPlanId } = useDevPlan();
  const { isGoalLevel } = useDevPlanTree();
  const { currentGoal } = useGoal();
  const { isActionPlanMonitoring, isGoalMonitoring } = useMonitoring({ goalTypes });

  console.log("GoalsCatalogHierarchy", {
    stage,
    goalTypes,
    isGoalLevel,
    isActionPlanMonitoring: isActionPlanMonitoring(),
    isGoalMonitoring: isGoalMonitoring(),
    selectedDevPlanId,
  });
  return (
    <>
      <Row gutter={{ xs: 4, sm: 8, md: 12 }}>
        {!currentGoal && (
          <Col span={12}>
            <Card title="Estructura del Plan de Desarrollo">
              <Form form={form}>
                {selectedDevPlanId && (
                  <DevPlanTreeLoader devPlanId={selectedDevPlanId} goalTypes={goalTypes ?? []} />
                )}
              </Form>
            </Card>
          </Col>
        )}
        {isGoalLevel && selectedDevPlanId && (
          <Col span={isGoalLevel && currentGoal ? 10 : 12}>
            <GoalsForLevel
              supportScheduling={stage === MonitoringStatus.Scheduling}
              goalTypes={goalTypes}
              stage={stage}
            />
          </Col>
        )}
        {isActionPlanMonitoring() && currentGoal && (
          <Col span={14}>
            <ActionPlanGoals />
          </Col>
        )}
      </Row>
    </>
  );
};

export { GoalsCatalogHierarchy };
