import React from "react";
import { Card, Col, Divider, Progress, Row, Typography } from "antd";
import { useGoal, useGoalIndicators } from "../../Goals/hooks";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { GoalType, MonitoringResourceType, SpentDoc } from "../../../../graphql/gen/schema";
import { monitoringResourceTypeMap } from "../../../utils/uiUtils";
import { ProgressProps } from "antd/lib";

const { Text } = Typography;

type MonitoringTrackIndicatorsProps = {
  type?: ProgressProps["type"];
};

const MonitoringTrackIndicators: React.FC<MonitoringTrackIndicatorsProps> = ({
  type = "dashboard",
}) => {
  const { currentMonitoring } = useMonitoringConfig();
  const { currentGoal } = useGoal();
  const { getPhysicalIndicator, getFinancialIndicator } = useGoalIndicators();

  if (!currentGoal || !currentMonitoring) return null;

  const ProgressIndicator = ({ percent, color }: { percent: number; color?: string }) => (
    <Progress
      percent={percent}
      type={type}
      format={(percent) => `${percent}%`}
      {...(color ? { strokeColor: color } : {})}
      {...(type === "line"
        ? {
            percentPosition: { align: "end", type: "outer" },
            size: ["100%", 15],
          }
        : {})}
    />
  );

  const PhysicalIndicator = () => {
    const { percent: physicalIndicatorPercent, color: physicalIndicatorColor } =
      getPhysicalIndicator(currentGoal, currentMonitoring);
    return type === "line" ? (
      <ProgressIndicator percent={physicalIndicatorPercent ?? 0} color={physicalIndicatorColor} />
    ) : (
      <Card title="Avance Físico">
        <div style={{ width: "100%", margin: "0 auto", textAlign: "center" }}>
          <ProgressIndicator
            percent={physicalIndicatorPercent ?? 0}
            color={physicalIndicatorColor}
          />
        </div>
      </Card>
    );
  };

  const FinancialIndicator: React.FC<{ spentDoc: SpentDoc }> = ({ spentDoc }) => {
    const monitoringResourceType =
      spentDoc === SpentDoc.Commitment
        ? MonitoringResourceType.Commitment
        : MonitoringResourceType.Obligation;
    const { percent: financialIndicatorPercent, color: financialIndicatorColor } =
      getFinancialIndicator(currentGoal, currentMonitoring, monitoringResourceType);
    return type === "line" ? (
      <ProgressIndicator percent={financialIndicatorPercent ?? 0} color={financialIndicatorColor} />
    ) : (
      <Card
        title={`Avance Financiero - ${monitoringResourceTypeMap[monitoringResourceType]?.tagPlural}`}
      >
        <div style={{ width: "100%", margin: "0 auto", textAlign: "center" }}>
          <ProgressIndicator
            percent={financialIndicatorPercent ?? 0}
            color={financialIndicatorColor}
          />
        </div>
      </Card>
    );
  };

  return (
    <>
      {type === "line" ? (
        <>
          <Row gutter={16} justify="start">
            {currentGoal?.goalType !== GoalType.Project && (
              <Col span={8} style={{ textAlign: "center" }} key="physical-indicator-text">
                <Text strong>Avance Físico</Text>
              </Col>
            )}

            {currentMonitoring.spentDocs?.map((spentDoc) => {
              const monitoringResourceType =
                spentDoc === SpentDoc.Commitment
                  ? MonitoringResourceType.Commitment
                  : MonitoringResourceType.Obligation;
              return (
                <Col span={8} key={`${spentDoc}`} style={{ textAlign: "center" }}>
                  <Text strong>
                    Avance Financiero -{" "}
                    {monitoringResourceTypeMap[monitoringResourceType]?.tagPlural}
                  </Text>
                </Col>
              );
            })}
          </Row>
          <Row gutter={16} justify="start" style={{ marginTop: 4 }}>
            {currentGoal?.goalType !== GoalType.Project && (
              <>
                <Col span={7}>
                  <PhysicalIndicator />
                </Col>
                <Col span={1}></Col>
              </>
            )}
            {currentMonitoring.spentDocs?.map((spentDoc) => (
              <>
                <Col span={7} key={`${spentDoc}`}>
                  <FinancialIndicator spentDoc={spentDoc} />
                </Col>
                <Col span={1}></Col>
              </>
            ))}
          </Row>
        </>
      ) : (
        <Row gutter={16}>
          {currentGoal?.goalType !== GoalType.Project && (
            <Col span={8}>
              <PhysicalIndicator />
            </Col>
          )}
          {currentMonitoring.spentDocs?.map((spentDoc) => (
            <Col span={8} key={`${spentDoc}`}>
              <FinancialIndicator spentDoc={spentDoc} />
            </Col>
          ))}
        </Row>
      )}
    </>
  );
};

export { MonitoringTrackIndicators };
