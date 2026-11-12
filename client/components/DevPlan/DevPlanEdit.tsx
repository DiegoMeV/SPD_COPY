import React from "react";
import { Card } from "antd";
import { DevPlanForm } from "./DevPlanForm";
import { useEditDevPlan } from "./hooks";
import { FormSubmitButtons } from "../Buttons/FormSubmitButtons";

type Props = {
  id: number;
};

const DevPlanEdit: React.FC<Props> = ({ id }) => {
  const { updateDevPlan, form, loading, error, updateLoading } = useEditDevPlan({ id });

  return (
    <Card
      title="Editar"
      extra={<FormSubmitButtons loading={updateLoading} submitAction={form.submit} type="icons" />}
    >
      <DevPlanForm
        form={form}
        id={id}
        onSave={updateDevPlan}
        operation="update"
        saveLoading={updateLoading}
        dataLoading={loading}
        dataError={error}
      />
    </Card>
  );
};

export { DevPlanEdit };
