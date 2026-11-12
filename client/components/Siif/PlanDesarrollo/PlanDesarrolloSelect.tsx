import React, { useState, useEffect } from "react";
import { Select } from "antd";
import { usePlanesDesarrollo } from "./hooks";
import { DataLoading } from "../../Data/DataLoading";

const { Option } = Select;

type Props = {
  value?: number;
  onChange?: (value?: number) => void;
  disabled?: boolean;
  firstSelected?: boolean;
  width?: number | string;
};

const PlanDesarrolloSelect: React.FC<Props> = ({
  value,
  onChange,
  disabled = false,
  firstSelected = false,
  width = 400,
}) => {
  const [_, setValue] = useState<number | undefined>();
  const { loading, data: planesDesarrollo, error } = usePlanesDesarrollo();

  useEffect(() => {
    if (planesDesarrollo?.length && firstSelected) onDevPlanChage(planesDesarrollo?.[0]?.plan);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [planesDesarrollo, firstSelected]);

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onDevPlanChage = (value?: number) => {
    setValue(value);
    triggerChange(value);
  };

  return (
    <DataLoading loading={loading} error={error}>
      <span>
        <Select style={{ width }} onChange={onDevPlanChage} value={value} disabled={disabled}>
          {planesDesarrollo?.map((planDesarrollo) => (
            <Option
              value={planDesarrollo.plan}
              key={`planDesarrollo${planDesarrollo.plan}`}
            >{`${planDesarrollo.plan} - ${planDesarrollo.nombre}`}</Option>
          ))}
        </Select>
      </span>
    </DataLoading>
  );
};

export { PlanDesarrolloSelect };
