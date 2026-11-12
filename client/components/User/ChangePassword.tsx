import React, { useState } from "react";
import { Button, Form, Input, Card, Alert, AlertProps, Row, Col } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faLock } from "@fortawesome/free-solid-svg-icons";
import { useStoreState } from "../../store";
import { useChangeUserAccountPasswordMutation } from "../../../graphql/gen/hooks";

const formItemLayout = {
  labelCol: { span: 20 },
  wrapperCol: { span: 20, offset: 2 },
};

const formTailLayout = {
  labelCol: { span: 8 },
  wrapperCol: { span: 20, offset: 2 },
};

export const ChangePassword: React.FC = () => {
  const user = useStoreState((state) => state.user.data);
  const [alertProps, setAlertProps] = useState<AlertProps>();
  const [changePassword, { loading: saving }] = useChangeUserAccountPasswordMutation();

  const [form] = Form.useForm();

  const onFinish = async (values: Record<string, any>) => {
    try {
      if (user?.id) {
        const variables = {
          data: {
            id: user?.id,
            currentPassword: values.currentPassword,
            newPassword: values.newPassword,
          },
        };
        const result = await changePassword({ variables });
        if (result?.errors) {
          setAlertProps({
            type: "error",
            message: "Error",
            description: result?.errors?.[0]?.message,
            showIcon: true,
          });
        } else {
          setAlertProps({
            type: "success",
            message: "Exito",
            description: "Su clave de acceso se ha modificado correctamente!",
            showIcon: true,
          });
        }
      }
    } catch (e) {
      setAlertProps({
        type: "error",
        message: "Error",
        description: `${e}`,
        showIcon: true,
      });
    }
  };

  return (
    <>
      <div
        style={{
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
          margin: "auto",
        }}
      >
        <Row gutter={[8, 8]} justify="center" style={{ width: "500px" }}>
          {alertProps?.message && (
            <Col span={24}>
              <Alert {...alertProps} />
            </Col>
          )}
          <Col span={24}>
            <Card style={{ boxShadow: "1px 0px 20px 0px #b3b3b3" }}>
              <Form
                form={form}
                onFinish={onFinish}
                name="basic"
                initialValues={{ remember: true }}
                autoComplete="off"
              >
                <Form.Item
                  {...formItemLayout}
                  name="currentPassword"
                  rules={[
                    {
                      required: true,
                      message: "Por favor ingrese su actual contraseña",
                    },
                  ]}
                >
                  <Input.Password
                    prefix={<FontAwesomeIcon icon={faLock} />}
                    placeholder="Contraseña actual"
                  />
                </Form.Item>
                <Form.Item
                  {...formItemLayout}
                  name="newPassword"
                  rules={[{ required: true, message: "Por favor ingrese su nueva contraseña" }]}
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
                  dependencies={["newPassword"]}
                  hasFeedback
                  rules={[
                    { required: true, message: "Por favor confirme su nueva contraseña" },
                    ({ getFieldValue }) => ({
                      validator(_, value) {
                        if (!value || getFieldValue("newPassword") === value) {
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
                    placeholder="Confirme su nueva contraseña"
                  />
                </Form.Item>
                <Form.Item {...formTailLayout}>
                  <Button
                    type="primary"
                    loading={saving}
                    style={{ width: "100%" }}
                    htmlType="submit"
                  >
                    Cambiar password
                  </Button>
                </Form.Item>
              </Form>
            </Card>
          </Col>
        </Row>
      </div>
    </>
  );
};
