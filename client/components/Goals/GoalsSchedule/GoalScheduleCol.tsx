import React from "react";
import { Form, InputNumber } from "antd";
import { SelectMonth } from "../../Selects";
import { useCurrentGoal, useGoal } from "../hooks";
import { useMonitoring } from "../../../hooks/useMonitoring";
import { GoalType, WeightingType } from "../../../../graphql/gen/schema";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";

type Props = {
  disabled?: boolean;
  isTracking?: boolean;
};

const GoalScheduleCol: React.FC<Props> = ({ disabled = false, isTracking = false }) => {
  const { currentMonitoring } = useMonitoringConfig();
  const { isProjectGoal, isActionPlanGoal } = useCurrentGoal();

  return (
    <>
      <Form.Item hidden name={["id"]}></Form.Item>
      {!(isProjectGoal() || isActionPlanGoal()) && (
        <Form.Item name={["goalValue"]}>
          <InputNumber
            style={{ width: "10vw" }}
            className="input-number"
            controls={false}
            disabled={disabled}
          />
        </Form.Item>
      )}
      {currentMonitoring?.supportProductMonitoring && (
        <Form.Item name={["piGoalValue"]}>
          <InputNumber
            style={{ width: "10vw" }}
            className="input-number"
            controls={false}
            disabled={disabled}
          />
        </Form.Item>
      )}
      {!isTracking && (
        <>
          <Form.Item name={["weighting"]}>
            <InputNumber
              style={{ width: "4vw" }}
              className="input-number"
              controls={false}
              disabled={disabled || currentMonitoring?.weightingType === WeightingType.Financial}
            />
          </Form.Item>
          <Form.Item name={["fromMonth"]}>
            <SelectMonth disabled={disabled} />
          </Form.Item>
          <Form.Item name={["toMonth"]}>
            <SelectMonth disabled={disabled} />
          </Form.Item>
        </>
      )}
    </>
  );
};

export { GoalScheduleCol };
