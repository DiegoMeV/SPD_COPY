import React, { useState } from "react";
import { InputNumber } from "antd";

type Props = {
  value?: string;
  placeholder?: string;
  onChange?: (value?: string) => void;
  disabled?: boolean;
};

const NumberInput: React.FC<Props> = ({ value, placeholder, onChange, disabled = false }) => {
  const [_, setNumber] = useState<string | null>("");

  const triggerChange = (changedValue?: string) => {
    onChange?.(changedValue);
  };

  const onNumberChange = (value: string | null) => {
    setNumber(value);
    triggerChange(value ?? undefined);
  };

  return (
    <InputNumber
      formatter={(value) => `${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ",")}
      placeholder={placeholder}
      onChange={onNumberChange}
      className="input-number"
      controls={false}
      value={value}
      style={{ width: "100%" }}
      disabled={disabled}
    />
  );
};

export { NumberInput };
