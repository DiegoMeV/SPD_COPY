import React from "react";
import { Button, Col, Row } from "antd";
import { useRouter } from "next/router";
import { FormButtonContainer } from "./FormButtonContainer";
import { ButtonBack } from "./ButtonBack";
import { ButtonSave } from "./ButtonSave";

type Props = {
  loading: boolean;
  submitText?: string;
  returnText?: string;
  type?: "text" | "icons";
  showReturnButton?: boolean;
  showSubmitButton?: boolean;
  returnAction?: () => void;
  submitAction?: () => void;
};

const FormSubmitButtons: React.FC<Props> = ({
  loading,
  submitText = "Guardar",
  returnText = "Volver",
  type = "text",
  showReturnButton = true,
  showSubmitButton = true,
  returnAction,
  submitAction,
}) => {
  const router = useRouter();

  return (
    <>
      {type === "text" && (
        <FormButtonContainer>
          {showSubmitButton && (
            <Button
              type="primary"
              htmlType="submit"
              loading={loading}
              onClick={() => submitAction?.() ?? null}
            >
              {submitText}
            </Button>
          )}
          {showReturnButton && (
            <Button type="default" onClick={() => (returnAction ? returnAction() : router.back())}>
              {returnText}
            </Button>
          )}
        </FormButtonContainer>
      )}
      {type === "icons" && (
        <Row gutter={8}>
          {showSubmitButton && (
            <Col span={12}>
              <ButtonSave
                title="Guardar"
                loading={loading}
                onClick={() => submitAction?.() ?? null}
              />
            </Col>
          )}
          {showReturnButton && (
            <Col span={12}>
              <ButtonBack
                title="Volver"
                onClick={() => (returnAction ? returnAction() : router.back())}
              />
            </Col>
          )}
        </Row>
      )}
    </>
  );
};

export { FormSubmitButtons };
