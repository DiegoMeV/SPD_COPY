import React, { useEffect, useState } from "react";
import { Select } from "antd";
import { WeightingType } from "../../../../graphql/gen/schema";

const { Option } = Select;

type Props = {
  value?: WeightingType;
  onChange?: (value?: WeightingType) => void;
  disabled?: boolean;
};

const SelectWeightingType: React.FC<Props> = ({ value, onChange, disabled = false }) => {
  const [_, setWeightingType] = useState<WeightingType | undefined>();

  useEffect(() => {
    onWeightingTypeChange(WeightingType.Financial);
  }, []);

  const triggerChange = (changedValue?: WeightingType) => {
    onChange?.(changedValue);
  };

  const onWeightingTypeChange = (value?: WeightingType) => {
    setWeightingType(value as WeightingType);
    triggerChange(value as WeightingType);
  };

  return (
    <span>
      <Select
        style={{ width: 200 }}
        onChange={onWeightingTypeChange}
        value={value}
        disabled={disabled}
        defaultValue={WeightingType.Financial}
      >
        <Option value={WeightingType.Financial} key={`WeightingType.Financial`}>
          Financiera
        </Option>
        <Option value={WeightingType.Manual} key={`WeightingType.Manual`}>
          Manual
        </Option>
        <Option value={WeightingType.Hierarchy} key={`WeightingType.Hierarchy`}>
          Jerárquica
        </Option>
      </Select>
    </span>
  );
};

export { SelectWeightingType };
