import React, { useState } from "react";
import { Space, Button, Drawer, Form, Input, Alert, Col, Tooltip } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faLock, faUnlock as faUserUnlock } from "@fortawesome/free-solid-svg-icons";
import { useChangePassword } from "./hooks";
import { FormSubmitButtons } from "../Buttons/FormSubmitButtons";

const formItemLayout = {
  labelCol: { span: 6 },
  wrapperCol: { span: 16 },
};

type Props = {
  id: number;
  firstName?: string | null;
  lastName?: string | null;
};

const UserChangePassword: React.FC<Props> = ({ id, firstName, lastName }) => {
  const [form] = Form.useForm();
  const [open, setOpen] = useState(false);
  const { updatePassword, loading, alert } = useChangePassword({
    id,
    firstName,
    lastName,
    onSuccess: () => {
      setOpen(false);
    },
  });

  const onClose = () => {
    setOpen(false);
  };
  const [isPasswordOk, setIsPasswordOk] = useState(false);

  const onSave = () => {
    if (isPasswordOk) updatePassword(form.getFieldsValue());
  };

  return (
    <Space>
      <Tooltip title="Cambiar clave">
        <Button
          shape="circle"
          size="large"
          icon={<FontAwesomeIcon icon={faUserUnlock} />}
          title={`Cambiar clave`}
          onClick={() => setOpen(true)}
        />
      </Tooltip>
      <Drawer
        title="Cambiar clave"
        placement="right"
        size="large"
        onClose={onClose}
        open={open}
        extra={
          <FormSubmitButtons
            loading={loading}
            submitText="Guardar"
            submitAction={onSave}
            returnText="Cerrar"
            returnAction={onClose}
          />
        }
      >
        {alert?.message && (
          <Col style={{ marginBottom: "25px" }} span={24}>
            <Alert {...alert} />
          </Col>
        )}
        <Form
          form={form}
          onFinish={onSave}
          name="basic"
          initialValues={{ remember: true }}
          autoComplete="off"
        >
          <Form.Item
            {...formItemLayout}
            name="newPassword"
            label="Contraseña"
            rules={[{ required: true, message: "Por favor ingrese la nueva contraseña" }]}
          >
            <Input.Password
              prefix={<FontAwesomeIcon icon={faLock} />}
              type="password"
              placeholder="Nueva contraseña"
            />
          </Form.Item>
          <Form.Item
            {...formItemLayout}
            name="confirm"
            label="Confirmar Contraseña"
            dependencies={["newPassword"]}
            hasFeedback
            rules={[
              { required: true, message: "Por favor confirme la nueva contraseña" },
              ({ getFieldValue }) => ({
                validator(_, value) {
                  if (!value || getFieldValue("newPassword") === value) {
                    setIsPasswordOk(true);
                    return Promise.resolve();
                  }
                  setIsPasswordOk(false);
                  return Promise.reject(new Error("Las contraseñas no coinciden!"));
                },
              }),
            ]}
          >
            <Input.Password
              prefix={<FontAwesomeIcon icon={faLock} />}
              type="password"
              placeholder="Confirme la nueva contraseña"
            />
          </Form.Item>
        </Form>
      </Drawer>
    </Space>
  );
};

export { UserChangePassword };
