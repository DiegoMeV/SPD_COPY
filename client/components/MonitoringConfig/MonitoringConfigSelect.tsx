import React, { useState, useEffect } from "react";
import { Select } from "antd";
import { useMonitoringConfigs } from "./hooks";
import { DataLoading } from "../Data/DataLoading";
import { MonitoringConfig } from "../../types/monitoringConfig";

type Props = {
  value?: number;
  onChange?: (value?: number) => void;
  disabled?: boolean;
  firstSelected?: boolean;
  width?: number | string;
  render?: (monitoringConfig: MonitoringConfig) => string;
  onSelect?: (monitoringConfig: MonitoringConfig) => void;
  onDropdownVisibleChange?: (open: boolean) => void;
};

const MonitoringConfigSelect: React.FC<Props> = ({
  value,
  onChange,
  disabled = false,
  firstSelected = false,
  width = 400,
  render,
  onSelect,
  onDropdownVisibleChange,
}) => {
  const { data: monitoringConfigs, loading, error } = useMonitoringConfigs();
  const [_, setValue] = useState<number | undefined>();

  useEffect(() => {
    if (monitoringConfigs?.length && firstSelected) {
      onValueChange(monitoringConfigs?.[0]?.id);
      onSelect?.(monitoringConfigs?.[0]);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [monitoringConfigs?.length, firstSelected]);

  const triggerChange = (changedValue?: number) => {
    onChange?.(changedValue);
  };

  const onValueChange = (value?: number) => {
    setValue(value);
    triggerChange(value);
  };

  return (
    <DataLoading loading={false} error={error}>
      <span>
        <Select
          style={{ width }}
          variant="filled"
          onChange={onValueChange}
          value={value}
          disabled={disabled}
          loading={loading}
          options={monitoringConfigs?.map((monitoringConfig) => ({
            value: monitoringConfig.id,
            label: render
              ? render(monitoringConfig)
              : `(${monitoringConfig.period}-${monitoringConfig.subperiod}) ${monitoringConfig.devPlan?.name}`,
          }))}
          {...(onSelect
            ? {
                onSelect: (value) =>
                  onSelect?.(monitoringConfigs?.find((mc) => mc.id === value) as MonitoringConfig),
              }
            : {})}
          onDropdownVisibleChange={onDropdownVisibleChange}
        />
      </span>
    </DataLoading>
  );
};

export { MonitoringConfigSelect };
