import React, { useState } from "react";
import { Select } from "antd";
import { GoalType } from "../../../../graphql/gen/schema";
import { goalTypeCollection, goalTypeMap } from "../../../utils/uiUtils";
import { selectGoalTypeCollection, selectGoalTypeMap } from "../../../utils/uiUtils";

const { Option } = Select;

type Props = {
  value?: GoalType;
  onChange?: (value?: GoalType) => void;
  disabled?: boolean;
  width?: number | string;
  fullGoalTypes?: boolean;
  multiple?: boolean;
};

const SelectGoalType: React.FC<Props> = ({
  value,
  onChange,
  disabled = false,
  width = 400,
  fullGoalTypes = false,
  multiple = false,
}) => {
  const [_, setGoalType] = useState<GoalType | undefined>();

  const triggerChange = (changedValue?: GoalType) => {
    onChange?.(changedValue);
  };

  const onGoalTypeChange = (value?: GoalType) => {
    setGoalType(value as GoalType);
    triggerChange(value as GoalType);
  };

  const typeCollection = fullGoalTypes ? selectGoalTypeCollection : goalTypeCollection;
  const typeMap = fullGoalTypes ? selectGoalTypeMap : goalTypeMap;

  return (
    <span>
      <Select
        style={{ width }}
        onChange={onGoalTypeChange}
        value={value}
        disabled={disabled}
        mode={multiple ? "multiple" : "tags"}
      >
        {typeCollection.map((goalType, index) => (
          <Option value={goalType} key={`goalTypeOption${index}`}>
            {typeMap[goalType]?.tag}
          </Option>
        ))}
      </Select>
    </span>
  );
};

export { SelectGoalType };
