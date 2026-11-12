import React, { useState } from "react";
import { Select } from "antd";
import { AccumulationType } from "../../../../graphql/gen/schema";
import { accumulationTypeCollection, accumulationTypeMap } from "../../../utils/uiUtils";

const { Option } = Select;

type Props = {
  value?: AccumulationType;
  onChange?: (value?: AccumulationType) => void;
  disabled?: boolean;
};

const SelectAccumulationType: React.FC<Props> = ({ value, onChange, disabled = false }) => {
  const [_, setAccumulationType] = useState<AccumulationType | undefined>();

  const triggerChange = (changedValue?: AccumulationType) => {
    onChange?.(changedValue);
  };

  const onAccumulationTypeChange = (value?: AccumulationType) => {
    setAccumulationType(value as AccumulationType);
    triggerChange(value as AccumulationType);
  };

  return (
    <span>
      <Select
        style={{ width: 400 }}
        onChange={onAccumulationTypeChange}
        value={value}
        disabled={disabled}
      >
        {accumulationTypeCollection.map((accumulationType, index) => (
          <Option value={accumulationType} key={`accumulationTypeOption${index}`}>
            {accumulationTypeMap[accumulationType]?.tag}
          </Option>
        ))}
      </Select>
    </span>
  );
};

export { SelectAccumulationType };
