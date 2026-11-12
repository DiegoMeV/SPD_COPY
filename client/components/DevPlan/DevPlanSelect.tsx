import React, { useState, useEffect } from "react";
import { Select } from "antd";
import { useDevPlans } from "./hooks";
import { DataLoading } from "../Data/DataLoading";
import { DevPlanFragment } from "../../../graphql/gen/ops";

const { Option } = Select;

type Props = {
  value?: number;
  onChange?: (value?: number) => void;
  disabled?: boolean;
  firstSelected?: boolean;
  width?: number | string;
  onSelect?: (devPlan?: DevPlanFragment | undefined) => void;
};

const DevPlanSelect: React.FC<Props> = ({
  value,
  onChange,
  disabled = false,
  firstSelected = false,
  width = 400,
  onSelect,
}) => {
  const [_, setValue] = useState<number | undefined>();
  const { loading, data: devPlans, error } = useDevPlans();

  useEffect(() => {
    if (devPlans?.length && firstSelected) onDevPlanChage(devPlans?.[0]?.id);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [devPlans, firstSelected]);

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onDevPlanChage = (value?: number) => {
    setValue(value);
    triggerChange(value);
  };

  const onDevPlanSelect = (value?: number) => {
    if (onSelect) {
      const devPlan = devPlans.find((devPlan) => devPlan.id === value);
      onSelect(devPlan);
    }
  };

  return (
    <DataLoading loading={loading} error={error}>
      <span>
        <Select
          style={{ width }}
          onChange={onDevPlanChage}
          value={value}
          disabled={disabled}
          onSelect={onDevPlanSelect}
        >
          {devPlans?.map((devPlan) => (
            <Option
              value={devPlan.id}
              key={`devPlan${devPlan.id}`}
            >{`${devPlan.code} - ${devPlan.name}`}</Option>
          ))}
        </Select>
      </span>
    </DataLoading>
  );
};

export { DevPlanSelect };
