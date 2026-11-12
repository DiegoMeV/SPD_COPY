import React from "react";
import { Button, Form, Input, Card, Row, Col, Switch } from "antd";
import { ButtonSave, ButtonBack, FormButtonContainer } from "../Buttons";
import { useRouter } from "next/router";
import { GetEntitiesDocument, useCreateEntityMutation } from "../../../graphql/gen/hooks";
import { Centered } from "../Utils/Centered";

const EntitiesNew: React.FC = () => {
  const router = useRouter();
  const [form] = Form.useForm();
  const [saveEntities, { loading }] = useCreateEntityMutation();

  const formItemLayout = {
    labelCol: { span: 8 },
    wrapperCol: { span: 16 },
  };

  const save = () => {
    onFinish(form.getFieldsValue());
  };

  const onFinish = async (values: any) => {
    const variables = {
      data: {
        code: values.code,
        name: values.name,
        hasManualBudget: `${values.hasManualBudget}` === "true",
      },
    };
    await saveEntities({ variables, refetchQueries: [{ query: GetEntitiesDocument }] });
    router.push("/config/entities");
  };

  return (
    <Centered width={800}>
      <Card
        title="Nueva Entidad"
        extra={
          <>
            <Row style={{ width: 90 }}>
              <Col span={12}>
                <ButtonSave title="Guardar" loading={loading} onClick={save} />
              </Col>
              <Col span={12}>
                <ButtonBack title="Volver" onClick={() => router.push("/config/entities")} />
              </Col>
            </Row>
          </>
        }
      >
        <Form
          {...formItemLayout}
          layout="horizontal"
          form={form}
          initialValues={{ layout: "horizontal" }}
          onFinish={onFinish}
          requiredMark={true}
        >
          <Form.Item name="code" required label="Código entidad">
            <Input placeholder="Código" style={{ width: 100 }} />
          </Form.Item>
          <Form.Item name="name" required label="Nombre entidad">
            <Input placeholder="Nombre de la entidad" />
          </Form.Item>
          <Form.Item name="hasManualBudget" label="Presupuesto Externo" valuePropName="checked">
            <Switch />
          </Form.Item>
          <Form.Item
            wrapperCol={{
              xs: { span: 24, offset: 0 },
              sm: { span: 14, offset: 10 },
            }}
          >
            <FormButtonContainer>
              <Button type="primary" htmlType="submit" loading={loading}>
                Crear
              </Button>
              <Button type="default" onClick={() => router.push("/config/entities")}>
                Volver
              </Button>
            </FormButtonContainer>
          </Form.Item>
        </Form>
      </Card>
    </Centered>
  );
};

export { EntitiesNew };
