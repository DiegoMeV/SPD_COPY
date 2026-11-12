import React from "react";
import { MonitoringConfigSelectInput } from "../../client/components/MonitoringConfig/MonitoringConfigSelectInput";
import { MonitoringConfigSelect } from "../../client/components/MonitoringConfig/MonitoringConfigSelect";
import { Form } from "antd";

const MonitoringConfigSelectInputPage: React.FC = () => {
  const [form] = Form.useForm();
  return (
    <Form form={form}>
      <div>
        {/* <MonitoringConfigSelectInput width={600} /> */}
        <p>Test</p>
        <Form.Item label="MonitoringConfigSelect" name="monitoringConfigId">
          <MonitoringConfigSelectInput width={300} />
        </Form.Item>
      </div>
    </Form>
  );
};

export default MonitoringConfigSelectInputPage;
