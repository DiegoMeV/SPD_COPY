import React, { useState } from "react";
import { Select } from "antd";
import { MonitoringResourcesOrigin } from "../../../graphql/gen/schema";
import {
  monitoringResourcesOriginCollection,
  monitoringResourcesOriginMap,
} from "../../utils/uiUtils";

const { Option } = Select;

type Props = {
  value?: MonitoringResourcesOrigin;
  onChange?: (value?: MonitoringResourcesOrigin) => void;
  disabled?: boolean;
};

const SelectMonitoringResourcesOrigin: React.FC<Props> = ({
  value,
  onChange,
  disabled = false,
}) => {
  const [_, setMonitoringResourcesOrigin] = useState<MonitoringResourcesOrigin | undefined>();

  const triggerChange = (changedValue?: MonitoringResourcesOrigin) => {
    onChange?.(changedValue);
  };

  const onMonitoringResourcesOriginChange = (value?: MonitoringResourcesOrigin) => {
    setMonitoringResourcesOrigin(value as MonitoringResourcesOrigin);
    triggerChange(value as MonitoringResourcesOrigin);
  };

  return (
    <span>
      <Select
        style={{ width: 400 }}
        onChange={onMonitoringResourcesOriginChange}
        value={value}
        disabled={disabled}
      >
        {monitoringResourcesOriginCollection.map((monitoringResourcesOrigin, index) => (
          <Option value={monitoringResourcesOrigin} key={`monitoringResourcesOriginOption${index}`}>
            {monitoringResourcesOriginMap[monitoringResourcesOrigin]?.tag}
          </Option>
        ))}
      </Select>
    </span>
  );
};

export { SelectMonitoringResourcesOrigin };
