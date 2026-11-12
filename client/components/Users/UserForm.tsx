import React from "react";
import { Form, FormInstance, Input, Switch } from "antd";
import { SelectEntity, SelectSPDRole } from "../Selects";
import { faLock } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { FormSubmitButtons } from "../Buttons/FormSubmitButtons";

type Props = {
  onSave: () => void;
  operation: "create" | "update";
  loading: boolean;
  form: FormInstance<any>;
};

const UserForm: React.FC<Props> = ({ form, onSave, operation, loading }) => {
  const formItemLayout = {
    labelCol: { span: 8 },
    wrapperCol: { span: 16 },
  };

  return (
    <Form
      {...formItemLayout}
      layout="horizontal"
      form={form}
      initialValues={{ layout: "horizontal" }}
      onFinish={onSave}
      requiredMark={true}
    >
      <Form.Item name="docNumber" rules={[{ required: true }]} label="Número de documento">
        <Input placeholder="Documento" style={{ width: 200 }} />
      </Form.Item>
      <Form.Item name="firstName" rules={[{ required: true }]} label="Nombres">
        <Input placeholder="Nombres" />
      </Form.Item>
      <Form.Item name="lastName" rules={[{ required: true }]} label="Apellidos">
        <Input placeholder="Primer y segundo nombre" />
      </Form.Item>
      <Form.Item name="email" rules={[{ required: true }]} label="Correo Electrónico">
        <Input placeholder="Email" />
      </Form.Item>
      <Form.Item name="phone" label="Número Telefónico">
        <Input placeholder="3003003003" />
      </Form.Item>
      <Form.Item name="entityId" label="Entidad">
        <SelectEntity />
      </Form.Item>
      <Form.Item name="role" rules={[{ required: true }]} label="Rol">
        <SelectSPDRole />
      </Form.Item>
      {operation === "update" && (
        <Form.Item name="isActive" label="Activo" valuePropName="checked">
          <Switch />
        </Form.Item>
      )}
      {operation === "create" && (
        <>
          <Form.Item
            name="password"
            rules={[{ required: true, message: "Contraseña" }]}
            label="Contraseña"
          >
            <Input.Password
              prefix={<FontAwesomeIcon icon={faLock} />}
              type="password"
              placeholder="Contraseña"
            />
          </Form.Item>
          <Form.Item
            {...formItemLayout}
            name="confirm"
            label="Confirmar Contraseña"
            dependencies={["password"]}
            hasFeedback
            rules={[
              { required: true, message: "Por favor confirme la nueva contraseña" },
              ({ getFieldValue }) => ({
                validator(_, value) {
                  if (!value || getFieldValue("password") === value) {
                    return Promise.resolve();
                  }
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
        </>
      )}
      <Form.Item
        wrapperCol={{
          xs: { span: 24, offset: 0 },
          sm: { span: 14, offset: 10 },
        }}
      >
        <FormSubmitButtons
          loading={loading}
          submitText={operation === "create" ? "Crear" : "Guardar"}
        />
      </Form.Item>
    </Form>
  );
};

export { UserForm };
