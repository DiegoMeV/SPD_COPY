import React, { useState, useEffect } from "react";
import { Select, Spin, TreeSelect } from "antd";
import { useCommonData } from "../../../hooks/useCommon";
import { useStoreState } from "../../../store";

const { Option } = Select;

type Props = {
  value?: number[];
  onChange?: (value?: number[], labels?: React.ReactNode[]) => void;
  disabled?: boolean;
  multiple?: boolean;
};

const SelectGeoLocation: React.FC<Props> = ({
  value,
  onChange,
  disabled = false,
  multiple = true,
}) => {
  const geoLocations = useStoreState((state) => state.common.geoLocations);
  const loadingEntity = useStoreState((state) => state.entity.loading);
  const { getGeoLocations } = useCommonData();
  const [_, setValue] = useState<number[] | undefined>();

  useEffect(() => {
    if (!geoLocations) {
      getGeoLocations();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [geoLocations]);

  const triggerChange = (changedValue?: number[], changedLabels?: React.ReactNode[]) => {
    onChange?.(changedValue, changedLabels);
  };

  const onGeoLocationsChange = (value?: number[], label?: React.ReactNode[]) => {
    setValue(value);
    triggerChange(value, label);
  };

  if (loadingEntity.entities) return <Spin />;

  return (
    <span>
      <TreeSelect
        style={{ width: "100%" }}
        onChange={onGeoLocationsChange}
        value={value}
        disabled={disabled}
        placeholder="Seleccione una ubicación"
        showSearch
        allowClear
        treeData={geoLocations}
        fieldNames={{ label: "name", value: "id" }}
        multiple={multiple}
        // treeCheckable={true}
      ></TreeSelect>
    </span>
  );
};

export { SelectGeoLocation };
