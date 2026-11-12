import React from "react";
import { Collapse, Typography } from "antd";
import { MonitoringTrackIndicators } from "./MonitoringTrackIndicators";

const { Panel } = Collapse;
const { Text } = Typography;

export const MonitoringTrackIndicatorsSummary: React.FC = () => {
  return (
    <Collapse defaultActiveKey={["goal-indicators-panel"]}>
      <Panel header={<Text strong>Indicadores</Text>} key={"goal-indicators-panel"}>
        <MonitoringTrackIndicators type="line" />
      </Panel>
    </Collapse>
  );
};
