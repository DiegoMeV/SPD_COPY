import React from "react";
import { Form, InputNumber } from "antd";
import { useStoreState } from "../../../store";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { useCurrentGoal } from "../../Goals/hooks";

type Props = {
  disabled?: boolean;
};

const MonitoringTrackCol: React.FC<Props> = ({ disabled = false }) => {
  const { currentMonitoring } = useMonitoringConfig();
  const { isProjectGoal, isActionPlanGoal } = useCurrentGoal();

  return (
    <>
      <Form.Item hidden name={["id"]}></Form.Item>
      {!(isProjectGoal() || isActionPlanGoal()) && (
        <Form.Item name={["goalAchievedValue"]}>
          <InputNumber
            style={{ width: "100%" }}
            className="input-number"
            controls={false}
            disabled={disabled}
          />
        </Form.Item>
      )}
      {currentMonitoring?.supportProductMonitoring && (
        <Form.Item name={["piGoalAchievedValue"]}>
          <InputNumber
            style={{ width: "100%" }}
            className="input-number"
            controls={false}
            disabled={disabled}
          />
        </Form.Item>
      )}
    </>
  );
};

export { MonitoringTrackCol };
