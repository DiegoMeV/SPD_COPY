import React, { useState } from "react";
import { Select } from "antd";

const { Option } = Select;

type Props = {
  value?: number;
  onChange?: (value?: number) => void;
  disabled?: boolean;
};

const SelectMonth: React.FC<Props> = ({ value, onChange, disabled = false }) => {
  const [_, setMonth] = useState<number | undefined>();

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onMonthChange = (value?: number) => {
    setMonth(value);
    triggerChange(value);
  };
  const MONTHS = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre",
  ];

  return (
    <span>
      <Select
        style={{ width: 200 }}
        onChange={onMonthChange}
        value={value}
        disabled={disabled}
        allowClear
      >
        {MONTHS.map((month, index) => (
          <Option key={month} value={index + 1}>
            {month}
          </Option>
        ))}
      </Select>
    </span>
  );
};

export { SelectMonth };
