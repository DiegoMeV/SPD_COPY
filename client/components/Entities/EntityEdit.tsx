import React from "react";
import { Spin, Result, Button, Form, Input, Card, Tooltip, Space, Row, Col, Switch } from "antd";
import { useRouter } from "next/router";
import {
  GetEntitiesDocument,
  useGetEntityQuery,
  useUpdateEntityMutation,
} from "../../../graphql/gen/hooks";
import { ButtonSave, ButtonBack, FormButtonContainer } from "../Buttons";
import { Centered } from "../Utils/Centered";

type Props = {
  id: number;
};

const EntityEdit: React.FC<Props> = ({ id }) => {
  const router = useRouter();
  const [form] = Form.useForm();
  const { loading, error, data } = useGetEntityQuery({
    variables: { id },
    fetchPolicy: "cache-and-network",
  });
  const [updateEntity, { loading: updateEntityLoading }] = useUpdateEntityMutation();

  if (loading) return <Spin />;
  if (error)
    return (
      <Result
        status="warning"
        title="Hubo problemas cargando la información, por favor trate de nuevo."
      />
    );

  const entity = data?.getEntity;
  const editData = {
    code: entity?.code,
    name: entity?.name,
    hasManualBudget: entity?.hasManualBudget,
    isActive: entity?.isActive,
  };

  const formItemLayout = {
    labelCol: { span: 8 },
    wrapperCol: { span: 16 },
  };

  const save = () => {
    onFinish(form.getFieldsValue());
  };

  const onFinish = async (values: Record<string, string>) => {
    const variables = {
      data: {
        id,
        code: values.code,
        name: values.name,
        hasManualBudget: `${values.hasManualBudget}` === "true",
        isActive: `${values.isActive}` === "true",
      },
    };
    await updateEntity({ variables, refetchQueries: [{ query: GetEntitiesDocument }] });
    router.push("/config/entities");
  };

  return (
    <Centered width={800}>
      <Card
        title="Editar Entidad"
        extra={
          <>
            <Row style={{ width: 90 }}>
              <Col span={12}>
                <Tooltip>
                  <ButtonSave title="Guardar" loading={updateEntityLoading} onClick={save} />
                </Tooltip>
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
          initialValues={{ layout: "horizontal", ...editData }}
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
          <Form.Item name="isActive" label="Activa" valuePropName="checked">
            <Switch />
          </Form.Item>
          <Form.Item
            wrapperCol={{
              xs: { span: 24, offset: 0 },
              sm: { span: 14, offset: 10 },
            }}
          >
            <FormButtonContainer>
              <Button type="primary" htmlType="submit" loading={updateEntityLoading}>
                Guardar
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

export { EntityEdit };
