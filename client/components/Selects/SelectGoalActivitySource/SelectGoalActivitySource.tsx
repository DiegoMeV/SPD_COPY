import React, { useState } from "react";
import { Select } from "antd";
import { GoalActivitySource } from "../../../../graphql/gen/schema";
import { goalActivitySourceCollection, goalActivitySourceMap } from "../../../utils/uiUtils";

const { Option } = Select;

type Props = {
  value?: GoalActivitySource;
  onChange?: (value?: GoalActivitySource) => void;
  disabled?: boolean;
  width?: number | string;
};

const SelectGoalActivitySource: React.FC<Props> = ({
  value,
  onChange,
  disabled = false,
  width = 200,
}) => {
  const [_, setGoalActivitySource] = useState<GoalActivitySource | undefined>();

  const triggerChange = (changedValue?: GoalActivitySource) => {
    onChange?.(changedValue);
  };

  const onGoalActivitySourceChange = (value?: GoalActivitySource) => {
    setGoalActivitySource(value as GoalActivitySource);
    triggerChange(value as GoalActivitySource);
  };

  return (
    <span>
      <Select
        style={{ width }}
        onChange={onGoalActivitySourceChange}
        value={value}
        disabled={disabled}
      >
        {goalActivitySourceCollection.map((goalActivitySource, index) => (
          <Option value={goalActivitySource} key={`goalActivitySourceOption${index}`}>
            {goalActivitySourceMap[goalActivitySource]?.tag}
          </Option>
        ))}
      </Select>
    </span>
  );
};

export { SelectGoalActivitySource };
