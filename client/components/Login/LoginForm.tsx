import React from "react";
import { Button, Form, Input, Card, Row, Col } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faEnvelope, faLock } from "@fortawesome/free-solid-svg-icons";
import { useStoreActions, useStoreState } from "../../store";
import Image from "next/image";

const formItemLayout = {
  labelCol: { span: 20 },
  wrapperCol: { span: 20, offset: 2 },
};

const formTailLayout = {
  labelCol: { span: 8 },
  wrapperCol: { span: 20, offset: 2 },
};

export const LoginForm: React.FC = () => {
  const tenant = useStoreState((state) => state.tenant.data);
  const userLoading = useStoreState((state) => state.user.loading.user);
  const userLogin = useStoreActions((actions) => actions.user.userLogin);

  const [form] = Form.useForm();

  const onLogin = async () => {
    const values = await form.validateFields();
    await userLogin({ ...values, tenantId: tenant?.id });
  };

  return (
    <>
      <div
        style={{ display: "flex", justifyContent: "center", alignItems: "center", margin: "auto" }}
      >
        <Card style={{ width: "500px", boxShadow: "1px 0px 20px 0px #b3b3b3" }}>
          <Row justify="space-around" align="middle">
            <Col span={6}>
              <Image
                src={`/images/tenants/${tenant?.key}/logo.png`}
                width={200}
                height={200}
                sizes="100vw"
                style={{
                  width: "100%",
                  height: "auto",
                }}
                priority
                alt="Logo entidad"
              />
            </Col>
            <Col span={18}>
              <Form form={form} name="basic" initialValues={{ remember: true }} autoComplete="off">
                <Form.Item
                  {...formItemLayout}
                  name="email"
                  rules={[
                    {
                      required: true,
                      message: "Por favor ingrese su correo electrónico",
                    },
                  ]}
                >
                  <Input
                    prefix={<FontAwesomeIcon icon={faEnvelope} />}
                    placeholder="Correo electrónico"
                  />
                </Form.Item>
                <Form.Item
                  {...formItemLayout}
                  name="password"
                  rules={[{ required: true, message: "Por favor ingrese su contraseña" }]}
                >
                  <Input
                    prefix={<FontAwesomeIcon icon={faLock} />}
                    type="password"
                    placeholder="Contraseña"
                    autoComplete=""
                  />
                </Form.Item>
                <Form.Item {...formTailLayout}>
                  <Button
                    type="primary"
                    onClick={onLogin}
                    loading={userLoading}
                    style={{ width: "100%" }}
                  >
                    Ingresar
                  </Button>
                </Form.Item>
              </Form>
            </Col>
          </Row>
        </Card>
      </div>
    </>
  );
};
