import React, { useEffect } from "react";
import { Card, Col, Row } from "antd";
import { DevPlanTreeLoader } from "../../DevPlanTree/DevPlanTreeLoader";
import { useDevPlan } from "../../DevPlan/hooks";
import { GoalsForLevel } from "../GoalsForLevel/GoalsForLevel";
import { useGoal } from "../hooks";
import { GoalSchedule } from "./GoalSchedule";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { GoalType, MonitoringStatus } from "../../../../graphql/gen/schema";

type GoalsScheduleListProps = {
  stage: MonitoringStatus;
  goalTypes: GoalType[];
};

const GoalsScheduleList: React.FC<GoalsScheduleListProps> = ({ goalTypes, stage }) => {
  const { selectedDevPlanId, setSelectedDevPlanId } = useDevPlan();
  const { currentGoal } = useGoal();
  const { currentMonitoring } = useMonitoringConfig();

  useEffect(() => {
    if (currentMonitoring && selectedDevPlanId !== currentMonitoring?.devPlanId)
      setSelectedDevPlanId(currentMonitoring?.devPlanId);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [currentMonitoring]);

  return (
    <Row gutter={{ xs: 4, sm: 8, md: 12 }}>
      {!currentGoal && (
        <Col span={12}>
          <Card title="Estructura del Plan de Desarrollo">
            {selectedDevPlanId && (
              <DevPlanTreeLoader
                devPlanId={selectedDevPlanId}
                goalTypes={
                  goalTypes?.includes(GoalType.Project)
                    ? [...goalTypes, GoalType.Activity]
                    : goalTypes
                }
              />
            )}
          </Card>
        </Col>
      )}
      {selectedDevPlanId && (
        <Col span={12}>
          <GoalsForLevel supportScheduling goalTypes={goalTypes} stage={stage} />
        </Col>
      )}
      <Col span={12}>
        <GoalSchedule goalTypes={goalTypes} stage={stage} />
      </Col>
    </Row>
  );
};

export { GoalsScheduleList };
