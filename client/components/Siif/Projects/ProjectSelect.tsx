import React, { useState } from "react";
import { Select } from "antd";
import { useProjects } from "./hooks";
import { DataLoading } from "../../Data/DataLoading";

const { Option } = Select;

type Props = {
  value?: number;
  onChange?: (value?: number) => void;
  disabled?: boolean;
  width?: number | string;
  multiple?: boolean;
  excludeProjects?: string[];
};

const ProjectSelect: React.FC<Props> = ({
  value,
  onChange,
  disabled = false,
  width = 400,
  multiple = false,
  excludeProjects = [],
}) => {
  const { loading, data: projects, error } = useProjects();
  const [_, setValue] = useState<number | undefined>();

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onProjectChange = (value?: number) => {
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
          onChange={onProjectChange}
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
          {projects
            ?.filter((project) => !excludeProjects.includes(project.proyecto))
            ?.map((project) => (
              <Option
                value={project.proyecto}
                key={`project${project.proyecto}`}
              >{`${project.proyecto} - ${project.nombre}`}</Option>
            ))}
        </Select>
      </span>
    </DataLoading>
  );
};

export { ProjectSelect };
