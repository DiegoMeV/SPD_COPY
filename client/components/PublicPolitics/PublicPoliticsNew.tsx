import React, { useState } from "react";
import { Button, Form, Input, Space, Drawer } from "antd";
import { ButtonAdd, FormButtonContainer } from "../Buttons";
import { useStoreActions } from "../../store";
import {
  GetPublicPoliticsDocument,
  SearchPublicPoliticsDocument,
  useCreatePublicPoliticMutation,
} from "../../../graphql/gen/hooks";
import TextArea from "antd/lib/input/TextArea";
import { SelectPublicPoliticCategory, SelectPublicPoliticComponents } from "../Selects";
import { PublicPoliticLocalization } from "../../types/publicPolitic";
import { PublicPoliticCategory } from "../../../graphql/gen/schema";

const formItemLayout = {
  labelCol: { span: 6 },
  wrapperCol: { span: 18 },
};

type Props = {
  localization: PublicPoliticLocalization;
};

const PublicPoliticsNew: React.FC<Props> = ({ localization }) => {
  const [form] = Form.useForm();
  const [open, setOpen] = useState(false);
  const [saving, setSaving] = useState(false);
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [createPublicPolitic] = useCreatePublicPoliticMutation({
    refetchQueries: [
      {
        query: SearchPublicPoliticsDocument,
        variables: {
          data: {
            categories:
              localization === "national"
                ? [PublicPoliticCategory.Peace, PublicPoliticCategory.Victims]
                : [PublicPoliticCategory.Territory],
          },
        },
      },
      "SearchPublicPolitics",
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
          category: values.category,
          ...(localization === "territorial"
            ? {
                fromYear: parseInt(values.fromYear),
                toYear: parseInt(values.toYear),
                componentIds: values.componentIds,
              }
            : {}),
        },
      };
      const result = await createPublicPolitic({ variables });
      sendNotification({
        type: "success",
        message: "Política Pública creada",
        description: `Se ha creado correctamente la política pública ${result.data?.createPublicPolitic?.name}`,
      });
      form.resetFields();
      setOpen(false);
    } catch (e) {
      sendNotification({
        type: "error",
        message: "Política Pública",
        description: `${e}`,
      });
    } finally {
      setSaving(false);
      setOpen(false);
    }
  };

  return (
    <Space>
      <ButtonAdd onClick={() => setOpen(true)} title={`Nueva Política Pública`} />
      <Drawer
        title={`Nueva Política Pública`}
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
          {localization === "national" && (
            <Form.Item name="category" required label="Categoría">
              <SelectPublicPoliticCategory />
            </Form.Item>
          )}
          {localization === "territorial" && (
            <Form.Item name="category" hidden initialValue={PublicPoliticCategory.Territory} />
          )}
          <Form.Item name="fromYear" required label="Año Inicial">
            <Input style={{ width: 100 }} />
          </Form.Item>
          <Form.Item name="toYear" required label="Año Final">
            <Input style={{ width: 100 }} />
          </Form.Item>
          <Form.Item name="componentIds" label="Componentes">
            <SelectPublicPoliticComponents />
          </Form.Item>
        </Form>
      </Drawer>
    </Space>
  );
};

export { PublicPoliticsNew };
