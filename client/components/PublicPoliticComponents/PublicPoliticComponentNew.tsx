import React, { useState } from "react";
import { Button, Form, Input, Space, Drawer } from "antd";
import { ButtonAdd, FormButtonContainer } from "../Buttons";
import { useStoreActions } from "../../store";
import {
  useCreatePublicPoliticComponentMutation,
  GetPublicPoliticComponentsDocument,
} from "../../../graphql/gen/hooks";
import TextArea from "antd/lib/input/TextArea";

const formItemLayout = {
  labelCol: { span: 6 },
  wrapperCol: { span: 18 },
};

const PublicPoliticComponentNew: React.FC = () => {
  const [form] = Form.useForm();
  const [open, setOpen] = useState(false);
  const [saving, setSaving] = useState(false);
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [createPublicPoliticComponent] = useCreatePublicPoliticComponentMutation({
    refetchQueries: [
      {
        query: GetPublicPoliticComponentsDocument,
      },
    ],
  });

  const onClose = () => {
    setOpen(false);
  };

  const onSave = () => {
    onFinish(form.getFieldsValue());
  };

  const onFinish = async (values: Record<string, any>) => {
    try {
      setSaving(true);
      const variables = {
        data: {
          code: values.code,
          name: values.name,
          description: values.description,
        },
      };
      const result = await createPublicPoliticComponent({ variables });
      sendNotification({
        type: "success",
        message: "Componente creado",
        description: `Se ha creado correctamente el componente ${result.data?.createPublicPoliticComponent?.name}`,
      });
      form.resetFields();
      setOpen(false);
    } catch (e) {
      sendNotification({
        type: "error",
        message: "Componente",
        description: `${e}`,
      });
    } finally {
      setSaving(false);
      setOpen(false);
    }
  };

  return (
    <Space>
      <ButtonAdd onClick={() => setOpen(true)} title={`Nuevo Componente`} />
      <Drawer
        title={`Nuevo Componente`}
        placement="right"
        size="large"
        onClose={onClose}
        open={open}
        extra={
          <FormButtonContainer>
            <Button onClick={onClose}>Cancelar</Button>
            <Button type="primary" loading={saving} onClick={onSave}>
              Guardar
            </Button>
          </FormButtonContainer>
        }
      >
        <Form
          form={form}
          layout="horizontal"
          onFinish={onFinish}
          {...formItemLayout}
          requiredMark={true}
          initialValues={{ unitsFactor: 1 }}
          disabled={saving}
        >
          <Form.Item name="code" label="Código">
            <Input style={{ width: "80%" }} placeholder="Código" />
          </Form.Item>
          <Form.Item name="name" required label="Nombre ">
            <Input style={{ width: "80%" }} placeholder="Nombre" />
          </Form.Item>
          <Form.Item name="description" label="Descripción">
            <TextArea
              autoSize={{ minRows: 2, maxRows: 6 }}
              style={{ width: "80%" }}
              placeholder="Descripción"
            />
          </Form.Item>
        </Form>
      </Drawer>
    </Space>
  );
};

export { PublicPoliticComponentNew };
