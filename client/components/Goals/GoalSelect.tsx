import React, { useState } from "react";
import { Select } from "antd";
import { useParentLevelGoals } from "./hooks";
import { DataLoading } from "../Data/DataLoading";

type Props = {
  levelId: number;
  parentGoals?: boolean;
  value?: number;
  onChange?: (value?: number) => void;
  disabled?: boolean;
  firstSelected?: boolean;
  width?: number | string;
};

const GoalSelect: React.FC<Props> = ({
  levelId,
  parentGoals = false,
  value,
  onChange,
  disabled = false,
  width = 400,
}) => {
  const { data: goals, loading, error } = useParentLevelGoals();
  const [_, setValue] = useState<number | undefined>();

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onGoalChange = (value?: number) => {
    setValue(value);
    triggerChange(value);
  };

  return (
    <DataLoading loading={loading} error={error}>
      <Select
        style={{ width }}
        onChange={onGoalChange}
        value={value}
        disabled={disabled}
        showSearch
        allowClear
        filterOption={(input, option) =>
          (option?.label ?? "").toLowerCase().includes(input.toLowerCase())
        }
        options={goals?.map((goal) => ({
          value: goal.id,
          label: `${goal.code} - ${goal.name ?? goal.indicator}`,
        }))}
      />
    </DataLoading>
  );
};

export { GoalSelect };
