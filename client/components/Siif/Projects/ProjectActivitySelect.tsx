import React, { useState } from "react";
import { Select } from "antd";
import { useActivities } from "./hooks";
import { DataLoading } from "../../Data/DataLoading";

const { Option } = Select;

type Props = {
  project: string;
  value?: number;
  onChange?: (value?: number) => void;
  disabled?: boolean;
  width?: number | string;
  multiple?: boolean;
  excludeActivities?: number[];
};

const ProjectActivitySelect: React.FC<Props> = ({
  project,
  value,
  onChange,
  disabled = false,
  width = 400,
  multiple = false,
  excludeActivities = [],
}) => {
  const { loading, data: activities, error } = useActivities({ project });
  const [_, setValue] = useState<number | undefined>();

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onActivityChange = (value?: number) => {
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
          onChange={onActivityChange}
          value={value}
          disabled={disabled}
          {...(multiple ? { mode: "multiple" } : {})}
          filterOption={(input, option) =>
            !!option &&
            (option.children as unknown as string).toLowerCase().includes(input.toLowerCase())
          }
          filterSort={(optionA, optionB) =>
            !!optionA &&
            (optionA.children as unknown as string)
              .toLowerCase()
              .localeCompare(!!optionB && (optionB.children as unknown as string).toLowerCase())
          }
        >
          {activities
            ?.filter((activity) => !excludeActivities.includes(activity.id))
            ?.map((activity) => (
              <Option
                value={activity.id}
                key={`activity${activity.id}`}
              >{`${activity.codigoAct} - ${activity.descripcion}`}</Option>
            ))}
        </Select>
      </span>
    </DataLoading>
  );
};

export { ProjectActivitySelect };
