import React, { useEffect } from "react";
import { Form } from "antd";
import { MonitoringConfigSelect } from "./MonitoringConfigSelect";
import { useMonitoringConfig } from "./hooks";

type Props = {
  label?: string;
  width?: string | number;
};

const MonitoringConfigSelectInput: React.FC<Props> = ({ label = "Periodo", width = "100%" }) => {
  const [form] = Form.useForm();
  const { activeMonitoring, setSelectedMonitoringConfigId, selectedMonitoringConfig } =
    useMonitoringConfig();

  useEffect(() => {
    if (activeMonitoring && selectedMonitoringConfig?.id !== activeMonitoring.id) {
      setSelectedMonitoringConfigId(activeMonitoring.id);
      form.setFieldValue("monitoringConfigId", activeMonitoring.id);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [activeMonitoring, setSelectedMonitoringConfigId]);

  return (
    <Form form={form}>
      <Form.Item name="monitoringConfigId" label={label}>
        <MonitoringConfigSelect
          width={width}
          onChange={setSelectedMonitoringConfigId}
          firstSelected
        />
      </Form.Item>
    </Form>
  );
};

export { MonitoringConfigSelectInput };
