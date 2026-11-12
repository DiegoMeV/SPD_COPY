import React from "react";
import { Card } from "antd";
import { MonitoringConfigUsedFor } from "../../../graphql/gen/schema";
import { useEditMonitoringConfig } from "./hooks";
import { FormSubmitButtons } from "../Buttons/FormSubmitButtons";
import { MonitoringConfigForm } from "./MonitoringConfigForm";

type Props = {
  id: number;
  usedFor?: MonitoringConfigUsedFor;
};

const MonitoringConfigEdit: React.FC<Props> = ({ id, usedFor }) => {
  const { updateMonitoringConfig, form, loading, error, updateLoading } = useEditMonitoringConfig({
    id,
  });

  return (
    <Card
      title="Editar"
      extra={<FormSubmitButtons loading={updateLoading} submitAction={form.submit} type="icons" />}
    >
      <MonitoringConfigForm
        form={form}
        onSave={updateMonitoringConfig}
        operation="update"
        saveLoading={updateLoading}
        dataLoading={loading}
        dataError={error}
      />
    </Card>
  );
};

export { MonitoringConfigEdit };
