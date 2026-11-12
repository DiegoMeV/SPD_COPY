import React, { useState, useEffect } from "react";
import { Select, Spin } from "antd";
import { useCommonData } from "../../../hooks/useCommon";
import { useStoreState } from "../../../store";

const { Option } = Select;

type Props = {
  value?: number;
  onChange?: (value?: number) => void;
  disabled?: boolean;
};

const UnitsSelect: React.FC<Props> = ({ value, onChange, disabled = false }) => {
  const units = useStoreState((state) => state.common.units);
  const loadingEntity = useStoreState((state) => state.entity.loading);
  const { getUnits } = useCommonData();
  const [_, setValue] = useState<number | undefined>();

  useEffect(() => {
    if (!units) {
      getUnits();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [units]);

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onUnitsChange = (value?: number) => {
    setValue(value);
    triggerChange(value);
  };

  if (loadingEntity.entities) return <Spin />;

  return (
    <span>
      <Select
        style={{ width: 400 }}
        onChange={onUnitsChange}
        value={value}
        disabled={disabled}
        placeholder="Seleccione una unidad"
        showSearch
        allowClear
      >
        {units?.map((unit) => (
          <Option value={unit.name} key={`unit${unit.id}`}>
            {unit.name}
          </Option>
        ))}
      </Select>
    </span>
  );
};

export { UnitsSelect };
