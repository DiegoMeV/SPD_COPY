import React, { useState } from "react";
import { InputNumber } from "antd";

type Props = {
  value?: string;
  onChange?: (value?: string) => void;
  disabled?: boolean;
};

const MoneyInput: React.FC<Props> = ({ value, onChange, disabled = false }) => {
  const [_, setMoney] = useState<string | null>("");

  const triggerChange = (changedValue?: string) => {
    onChange?.(changedValue);
  };

  const onMoneyChange = (value: string | null) => {
    setMoney(value);
    triggerChange(value ?? undefined);
  };

  return (
    <InputNumber
      formatter={(value) => `$ ${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ",")}
      parser={(value) => (value ? value?.replace(/\$\s?|(,*)/g, "") : "")}
      onChange={onMoneyChange}
      className="input-money"
      controls={false}
      value={value}
      style={{ width: "100%" }}
      disabled={disabled}
    />
  );
};

export { MoneyInput };
