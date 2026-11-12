import React, { useState } from "react";
import { Button, Form, Input, Space, Drawer } from "antd";
import { ButtonAdd, FormButtonContainer } from "../Buttons";
import { useStoreActions } from "../../store";
import {
  useCreateMacroProjectMutation,
  GetMacroProjectsDocument,
} from "../../../graphql/gen/hooks";
import TextArea from "antd/lib/input/TextArea";

const formItemLayout = {
  labelCol: { span: 6 },
  wrapperCol: { span: 18 },
};

const MacroProjectNew: React.FC = () => {
  const [form] = Form.useForm();
  const [open, setOpen] = useState(false);
  const [saving, setSaving] = useState(false);
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [createMacroProject] = useCreateMacroProjectMutation({
    refetchQueries: [
      {
        query: GetMacroProjectsDocument,
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
      const result = await createMacroProject({ variables });
      sendNotification({
        type: "success",
        message: "Macro proyecto creado",
        description: `Se ha creado correctamente el macro proyecto ${result.data?.createMacroProject?.name}`,
      });
      form.resetFields();
      setOpen(false);
    } catch (e) {
      sendNotification({
        type: "error",
        message: "Macro proyecto",
        description: `${e}`,
      });
    } finally {
      setSaving(false);
      setOpen(false);
    }
  };

  return (
    <Space>
      <ButtonAdd onClick={() => setOpen(true)} title={`Nuevo Macro proyecto`} />
      <Drawer
        title={`Nuevo Macro proyecto`}
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

export { MacroProjectNew };
