import React from "react";
import { Card } from "antd";
import { MonitoringConfigUsedFor } from "../../../graphql/gen/schema";
import { useCreateMonitoringConfig } from "./hooks";
import { FormSubmitButtons } from "../Buttons/FormSubmitButtons";
import { MonitoringConfigForm } from "./MonitoringConfigForm";

type Props = {
  usedFor?: MonitoringConfigUsedFor;
};

const MonitoringConfigNew: React.FC<Props> = ({
  usedFor = MonitoringConfigUsedFor.DevelopmentPlans,
}) => {
  const { createMonitoringConfig, form, loading } = useCreateMonitoringConfig({ usedFor });

  return (
    <Card
      title="Nuevo Seguimiento"
      extra={<FormSubmitButtons loading={loading} submitAction={form.submit} type="icons" />}
    >
      <MonitoringConfigForm
        form={form}
        onSave={createMonitoringConfig}
        operation="create"
        saveLoading={loading}
      />
    </Card>
  );
};

export { MonitoringConfigNew };
