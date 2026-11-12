import React from "react";
import { Row, Col, Typography } from "antd";
import { GoalScheduleCol } from "../../Goals/GoalsSchedule/GoalScheduleCol";
import { MonitoringTrackCol } from "./MonitoringTrackCol";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { MonitoringTrackLabels } from "./MonitoringTrackLabels";
import { MonitoringResourcesOrigin } from "../../../../graphql/gen/schema";
import { GoalScheduleResourcesCol } from "../../Goals/GoalsSchedule/GoalScheduleResourcesCol";
import { MonitoringTrackResourcesCol } from "./MonitoringTrackResourcesCol";
import { SPENT_DOC_TO_RESOURCE_TYPE } from "../../../../shared/const";
import { useCurrentUser } from "../../Users/hooks";
import { useStoreState } from "../../../store";
import { useGoal } from "../../Goals/hooks";
import { useMonitoring } from "../../../hooks/useMonitoring";

const { Title } = Typography;

type Props = {
  onUpdateFinancialResources?: () => void;
  disabled?: boolean;
};

const MonitoringTrackQuantitative: React.FC<Props> = ({ onUpdateFinancialResources, disabled }) => {
  const { currentMonitoring } = useMonitoringConfig();
  const { user } = useCurrentUser();
  const { currentGoal } = useGoal();
  const { isActionPlanActivityMonitoring, isActionPlanMonitoring } = useMonitoring({
    goalTypes: currentGoal?.goalType ? [currentGoal?.goalType] : [],
  });
  const resourcesOriginColsCount =
    currentMonitoring?.monitoringResourcesOrigin === MonitoringResourcesOrigin.UserAndFinancial &&
    !(isActionPlanMonitoring() || isActionPlanActivityMonitoring())
      ? 2
      : 1;
  const monitoringDocsColsCount = currentMonitoring?.spentDocs?.length || 1;

  return (
    <>
      <Row justify="center">
        <Col span={6}></Col>
        <Col span={9} style={{ textAlign: "center" }}>
          <Title level={4}>Programación</Title>
        </Col>
        <Col span={9}>
          <Title level={4} style={{ textAlign: "center" }}>
            Ejecución
          </Title>
        </Col>
      </Row>
      <Row gutter={4}>
        <Col span={6} id="col-labels">
          <MonitoringTrackLabels />
        </Col>
        <Col span={18}>
          <Row gutter={[10, 0]}>
            <Col span={12}>
              <GoalScheduleCol isTracking disabled />
            </Col>
            <Col span={12}>
              <MonitoringTrackCol disabled={disabled} />
            </Col>
          </Row>
          <Row gutter={[10, 0]}>
            {currentMonitoring?.monitoringResourcesOrigin &&
              [MonitoringResourcesOrigin.User, MonitoringResourcesOrigin.UserAndFinancial].includes(
                currentMonitoring?.monitoringResourcesOrigin,
              ) && (
                <Col span={12 / resourcesOriginColsCount}>
                  <GoalScheduleResourcesCol origin={MonitoringResourcesOrigin.User} disabled />
                </Col>
              )}
            {currentMonitoring?.monitoringResourcesOrigin &&
              [
                MonitoringResourcesOrigin.Financial,
                MonitoringResourcesOrigin.UserAndFinancial,
              ].includes(currentMonitoring?.monitoringResourcesOrigin) &&
              !(isActionPlanMonitoring() || isActionPlanActivityMonitoring()) && (
                <Col span={12 / resourcesOriginColsCount}>
                  <GoalScheduleResourcesCol
                    origin={MonitoringResourcesOrigin.Financial}
                    disabled
                    isTracking
                  />
                </Col>
              )}
            {currentMonitoring?.spentDocs?.map((spentDoc) => (
              <Col span={12 / monitoringDocsColsCount} key={`spent${spentDoc}`}>
                <MonitoringTrackResourcesCol
                  resourceType={SPENT_DOC_TO_RESOURCE_TYPE[spentDoc]}
                  disabled={!user?.entity?.hasManualBudget && !isActionPlanActivityMonitoring()}
                  onUpdateFinancialResources={onUpdateFinancialResources}
                />
              </Col>
            ))}
          </Row>
        </Col>
      </Row>
    </>
  );
};

export { MonitoringTrackQuantitative };
