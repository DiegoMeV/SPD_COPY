import React from "react";
import { Form, Card } from "antd";
import { Centered } from "../Utils/Centered";
import { FormSubmitButtons } from "../Buttons/FormSubmitButtons";
import { useEditUser } from "./hooks";
import { UserForm } from "./UserForm";

type Props = {
  id: number;
};

const UserEdit: React.FC<Props> = ({ id }) => {
  const [form] = Form.useForm();
  const { updateUser, updateLoading } = useEditUser({
    id,
    form,
  });

  const save = () => {
    updateUser(form.getFieldsValue());
  };

  return (
    <Centered width={800}>
      <Card
        title="Editar Usuario"
        extra={<FormSubmitButtons loading={updateLoading} submitAction={save} type="icons" />}
      >
        <UserForm operation="update" onSave={save} loading={updateLoading} form={form} />
      </Card>
    </Centered>
  );
};

export { UserEdit };
