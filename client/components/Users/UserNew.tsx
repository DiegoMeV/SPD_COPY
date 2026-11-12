import React from "react";
import { Form, Card } from "antd";
import { useCreateUser } from "./hooks";
import { Centered } from "../Utils/Centered";
import { FormSubmitButtons } from "../Buttons/FormSubmitButtons";
import { UserForm } from "./UserForm";

const UserNew: React.FC = () => {
  const [form] = Form.useForm();
  const { createUser, loading } = useCreateUser();

  const save = () => {
    createUser(form.getFieldsValue());
  };

  return (
    <Centered width={800}>
      <Card
        title="Crear Usuario"
        extra={<FormSubmitButtons loading={loading} submitAction={save} type="icons" />}
      >
        <UserForm operation="create" onSave={save} loading={loading} form={form} />
      </Card>
    </Centered>
  );
};

export { UserNew };
