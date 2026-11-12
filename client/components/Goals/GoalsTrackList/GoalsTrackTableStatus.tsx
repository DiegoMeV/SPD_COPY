import { Col, Row, Space, Typography } from "antd";
import React, { useState, useEffect } from "react";
import { Goal } from "../../../types/goal";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { ButtonTrack } from "../../Buttons/ButtonTrack";
import { MonitoringResourceType } from "../../../../graphql/gen/schema";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faCalendar,
  faClock as faCalendarClock,
  faCalendarDays as faCalendarLinesPen,
} from "@fortawesome/free-solid-svg-icons";

const { Text } = Typography;

type Props = {
  goal: Goal;
  validate?: boolean;
  review?: boolean;
};

const GoalsTrackTableStatus: React.FC<Props> = ({ goal, validate = false, review = false }) => {
  const [hasTracking, setHasTracking] = useState(false);
  const { currentMonitoring } = useMonitoringConfig();

  useEffect(() => {
    setHasTracking(
      !!goal?.tracking?.find(
        (trackingRecord) =>
          trackingRecord.monitoringConfigId === currentMonitoring?.id &&
          trackingRecord.resources?.length &&
          trackingRecord?.resources?.filter((resource) =>
            [
              MonitoringResourceType.Commitment,
              MonitoringResourceType.Obligation,
              MonitoringResourceType.Payment,
            ].includes(resource.resourceType),
          )?.length,
      ),
    );
  }, [goal, currentMonitoring?.id]);

  const statusText = hasTracking ? "Reportada" : "Programada";
  const statusType = hasTracking ? "success" : "secondary";
  const statusIcon = hasTracking ? faCalendarLinesPen : faCalendarClock;
  const statusIconStyle = hasTracking ? { color: "green" } : {};

  const GoalText: React.FC = () => (
    <Text type={statusType} style={{ fontSize: "1rem" }}>
      {statusText}
    </Text>
  );
  const GoalIcon: React.FC = () => (
    <FontAwesomeIcon icon={statusIcon} size="2x" style={statusIconStyle} />
  );

  return (
    // <Space size="middle" direction="horizontal" style={{ width: "100%", justifyContent: "center" }}>
    // {/* <ButtonTrack size="large" title="Reportar" variant={hasTracking ? "active" : "default"} /> */}
    // Sin Programar
    // </Space>
    <Row gutter={2}>
      <Col>
        <GoalIcon />
      </Col>
      <Col>
        <GoalText />
      </Col>
    </Row>
  );
};

export { GoalsTrackTableStatus };
