import React, { useState } from "react";
import { Select } from "antd";
import { useEntities } from "./hooks";
import { DataLoading } from "../Data/DataLoading";

const { Option } = Select;

type Props = {
  value?: number;
  onChange?: (value?: number) => void;
  disabled?: boolean;
  width?: number | string;
  multiple?: boolean;
  excludeIds?: number[];
};

const EntitySelect: React.FC<Props> = ({ value, onChange, disabled = false, width = 400, multiple = false, excludeIds = [] }) => {
  const { loading, data: entities, error } = useEntities();
  const [_, setValue] = useState<number | undefined>();

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onWeightingTypeChange = (value?: number) => {
    setValue(value);
    triggerChange(value);
  };

  return (
    <DataLoading loading={loading} error={error}>
      <span>
        <Select
          showSearch
          allowClear
          style={{ width }}
          onChange={onWeightingTypeChange}
          value={value}
          disabled={disabled}
          {...(multiple ? { mode: "multiple" } : {})}
          filterOption={(input, option) =>
            !!option && (option.children as unknown as string).toLowerCase().includes(input.toLowerCase())
          }
          filterSort={(optionA, optionB) =>
            !!optionA &&
            (optionA.children as unknown as string)
              .toLowerCase()
              .localeCompare(!!optionB && (optionB.children as unknown as string).toLowerCase())
          }
        >
          {entities?.filter((entity) => !excludeIds.includes(entity.id))?.map((entity) => (
            <Option
              value={entity.id}
              key={`entity${entity.id}`}
            >{`${entity.code} - ${entity.name}`}</Option>
          ))}
        </Select>
      </span>
    </DataLoading>
  );
};

export { EntitySelect };
