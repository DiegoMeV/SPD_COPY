import React, { useState } from "react";
import { Select } from "antd";
import { DataLoading } from "../Data/DataLoading";
import { GoalType } from "../../../graphql/gen/schema";
import { useSearchGoalsSummaryQuery } from "../../../graphql/gen/hooks";

type Props = {
  devPlanId: number;
  goalType: GoalType;
  value?: number;
  onChange?: (value?: number) => void;
  disabled?: boolean;
  firstSelected?: boolean;
  width?: number | string;
  onBlur?: () => void;
  inputRef?: React.RefObject<any>;
};

const GoalSelectForPlan: React.FC<Props> = ({
  devPlanId,
  goalType = GoalType.Product,
  value,
  onChange,
  disabled = false,
  width = 400,
  onBlur,
  inputRef,
}) => {
  const {
    data: goals,
    loading,
    error,
  } = useSearchGoalsSummaryQuery({
    variables: {
      data: {
        devPlanId,
        goalType,
      },
    },
  });
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
        style={{ width, boxSizing: "border-box", maxWidth: "100%" }}
        onChange={onGoalChange}
        value={value}
        disabled={disabled}
        showSearch
        allowClear
        filterOption={(input, option) =>
          (option?.label ?? "").toLowerCase().includes(input.toLowerCase())
        }
        options={goals?.searchGoals?.items?.map((goal) => ({
          value: goal.id,
          label: `${goal.code} - ${goal.name ?? goal.indicator}`,
        }))}
        {...{ onBlur }}
        ref={inputRef}
      />
    </DataLoading>
  );
};

export { GoalSelectForPlan };
