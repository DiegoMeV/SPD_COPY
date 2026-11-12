import React, { useState, useEffect } from "react";
import { Select, Spin } from "antd";
import { useCommonData } from "../../../hooks/useCommon";
import { useStoreState } from "../../../store";

const { Option } = Select;

type Props = {
  value?: number;
  onChange?: (value?: number) => void;
  disabled?: boolean;
  multiple?: boolean;
  showIds?: number[];
};

const SelectMacroProject: React.FC<Props> = ({
  value,
  onChange,
  disabled = false,
  multiple = false,
  showIds,
}) => {
  const macroProjects = useStoreState((state) => state.common.macroProjects);
  const loadingEntity = useStoreState((state) => state.entity.loading);
  const { getMacroProjects } = useCommonData();
  const [_, setValue] = useState<number | undefined>();

  useEffect(() => {
    if (!macroProjects) {
      getMacroProjects();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [macroProjects]);

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onComponentsChange = (value?: number) => {
    setValue(value);
    triggerChange(value);
  };

  if (loadingEntity.entities) return <Spin />;

  return (
    <span>
      <Select
        style={{ width: 400 }}
        onChange={onComponentsChange}
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
        value={value}
        disabled={disabled}
        {...(multiple ? { mode: "multiple" } : {})}
        showSearch
      >
        {macroProjects
          ?.filter((component) => !showIds || showIds.includes(component.id))
          ?.map((component) => (
            <Option value={component.id} key={`component${component.id}`}>{`${
              component.code ? `${component.code} - ` : ""
            }${component.name}`}</Option>
          ))}
      </Select>
    </span>
  );
};

export { SelectMacroProject };
