import React, { useEffect, useState } from "react";
import { Form, Input, Space, Drawer, Switch, Button } from "antd";
import { MacroProjectFragment } from "../../../graphql/gen/ops";
import { ButtonEdit, FormButtonContainer } from "../Buttons";
import { useStoreActions } from "../../store";
import { useUpdateMacroProjectMutation } from "../../../graphql/gen/hooks";

type Props = {
  data: MacroProjectFragment;
};

const MacroProjectEdit: React.FC<Props> = ({ data }) => {
  const [open, setOpen] = useState(false);
  const [saving, setSaving] = useState(false);
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [form] = Form.useForm();
  const [updateMacroProject] = useUpdateMacroProjectMutation();

  useEffect(() => {
    form.setFieldsValue(data);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [data]);

  const formItemLayout = {
    labelCol: { span: 4 },
    wrapperCol: { span: 14 },
  };

  const onClose = () => {
    setOpen(false);
  };

  const onSave = () => {
    onFinish(form.getFieldsValue());
    form.resetFields();
  };

  const onFinish = async (values: Record<string, any>) => {
    try {
      setSaving(true);
      const variables = {
        data: {
          id: data.id,
          code: values.code,
          name: values.name,
          description: values.description,
          isActive: values.isActive,
        },
      };
      const result = await updateMacroProject({ variables });
      sendNotification({
        type: "success",
        message: "Macro proyecto editado",
        description: `Se ha editado correctamente el macro proyecto ${result.data?.updateMacroProject?.code}`,
      });
      form.resetFields();
      setOpen(false);
    } catch (e) {
      sendNotification({
        type: "error",
        message: "Creando macro proyecto",
        description: `${e}`,
      });
    } finally {
      setSaving(false);
      setOpen(false);
    }
  };

  return (
    <Space>
      <ButtonEdit onClick={() => setOpen(true)} title={`Editar macro proyecto`} />
      <Drawer
        title={`Editar macro proyecto`}
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
          initialValues={{ ...data }}
          disabled={saving}
        >
          <Form.Item name="code" label="Código">
            <Input placeholder="Código" style={{ width: 200 }} />
          </Form.Item>
          <Form.Item name="name" required label="Nombre">
            <Input placeholder="Nombre" />
          </Form.Item>
          <Form.Item name="description" label="Descripción">
            <Input placeholder="Descripción" />
          </Form.Item>
          <Form.Item name="isActive" label="Activo" valuePropName="checked">
            <Switch />
          </Form.Item>
          <Form.Item
            wrapperCol={{
              xs: { span: 24, offset: 0 },
              sm: { span: 14, offset: 10 },
            }}
          ></Form.Item>
        </Form>
      </Drawer>
    </Space>
  );
};

export { MacroProjectEdit };
