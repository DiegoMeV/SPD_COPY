import React, { useEffect, useState } from "react";
import { Button, Form, Input, Space, Drawer, Switch } from "antd";
import { useUpdatePublicPoliticMutation } from "../../../graphql/gen/hooks";
import { ButtonEdit, FormButtonContainer } from "../Buttons";
import { useStoreActions } from "../../store";
import { PublicPoliticComponentFragment, PublicPoliticFragment } from "../../../graphql/gen/ops";
import { SelectPublicPoliticCategory, SelectPublicPoliticComponents } from "../Selects";
import { PublicPoliticLocalization } from "../../types/publicPolitic";
import { PublicPoliticCategory } from "../../../graphql/gen/schema";

type Props = {
  data: PublicPoliticFragment & { components?: PublicPoliticComponentFragment[] };
  localization: PublicPoliticLocalization;
};

const PublicPoliticsEdit: React.FC<Props> = ({ data, localization }) => {
  const [open, setOpen] = useState(false);
  const [saving, setSaving] = useState(false);
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [form] = Form.useForm();
  const [updatePublicPolitic] = useUpdatePublicPoliticMutation();

  const getDBValues = () => ({ ...data, componentIds: data?.components?.map(component => component.id) });

  useEffect(() => {
    form.setFieldsValue(getDBValues());
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
          category: values.category,
          isActive: `${values.isActive}` === "true",
          ...(data.category === PublicPoliticCategory.Territory ? {
            fromYear: parseInt(values.fromYear),
            toYear: parseInt(values.toYear),
            componentIds: values.componentIds,
          } : {})
        },
      };
      const result = await updatePublicPolitic({ variables });
      sendNotification({
        type: "success",
        message: "Política Pública editada",
        description: `Se ha editado correctamente la política pública ${result.data?.updatePublicPolitic?.code}`,
      });
      form.resetFields();
      setOpen(false);
    } catch (e) {
      sendNotification({
        type: "error",
        message: "Creando política pública",
        description: `${e}`,
      });
    } finally {
      setSaving(false);
      setOpen(false);
    }
  };

  return (
    <Space>
      <ButtonEdit onClick={() => setOpen(true)} title={`Editar política pública`} />
      <Drawer
        title={`Editar política pública`}
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
          initialValues={() => getDBValues()}
          disabled={saving}
        >
          <Form.Item name="code" label="Código">
            <Input style={{ width: "80%" }} placeholder="Código" />
          </Form.Item>
          <Form.Item name="name" required label="Nombre ">
            <Input style={{ width: "80%" }} placeholder="Nombre" />
          </Form.Item>
          <Form.Item name="description" required label="Descripción">
            <Input style={{ width: "80%" }} placeholder="Descripción" />
          </Form.Item>
          {localization === "national" && (
            <Form.Item name="category" required label="Categoría">
              <SelectPublicPoliticCategory />
            </Form.Item>
          )}
          <Form.Item name="fromYear" required label="Año Inicial">
            <Input style={{ width: 100 }} />
          </Form.Item>
          <Form.Item name="toYear" required label="Año Final">
            <Input style={{ width: 100 }} />
          </Form.Item>
          <Form.Item name="isActive" required label="Activa" valuePropName="checked">
            <Switch />
          </Form.Item>
          <Form.Item name="componentIds" label="Componentes">
            <SelectPublicPoliticComponents />
          </Form.Item>
        </Form>
      </Drawer>
    </Space>
  );
};

export { PublicPoliticsEdit };
