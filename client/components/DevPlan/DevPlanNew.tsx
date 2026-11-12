import React from "react";
import { Card } from "antd";
import { DevPlanForm } from "./DevPlanForm";
import { useCreateDevPlan } from "./hooks";
import { FormSubmitButtons } from "../Buttons/FormSubmitButtons";

const DevPlanNew: React.FC = () => {
  const { createDevPlan, form, loading } = useCreateDevPlan();

  return (
    <Card
      title="Nuevo Plan de Desarrollo"
      extra={<FormSubmitButtons loading={loading} submitAction={form.submit} type="icons" />}
    >
      <DevPlanForm form={form} onSave={createDevPlan} operation="create" saveLoading={loading} />
    </Card>
  );
};

export { DevPlanNew };
