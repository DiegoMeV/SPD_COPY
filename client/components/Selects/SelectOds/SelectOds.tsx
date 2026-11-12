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

const OdsSelect: React.FC<Props> = ({ value, onChange, disabled = false }) => {
  const ods = useStoreState((state) => state.common.ods);
  const loadingOds = useStoreState((state) => state.common.loading);
  const { getOds } = useCommonData();
  const [_, setValue] = useState<number | undefined>();

  useEffect(() => {
    if (!ods) {
      getOds();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [ods]);

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onOdsChange = (value?: number) => {
    setValue(value);
    triggerChange(value);
  };

  if (loadingOds.ods) return <Spin />;

  return (
    <span>
      <Select
        style={{ width: 400 }}
        onChange={onOdsChange}
        value={value}
        disabled={disabled}
        mode="multiple"
      >
        {ods?.map((ods) => (
          <Option value={ods.id} key={`ods${ods.id}`}>{`${ods.id} - ${ods.name}`}</Option>
        ))}
      </Select>
    </span>
  );
};

export { OdsSelect };
