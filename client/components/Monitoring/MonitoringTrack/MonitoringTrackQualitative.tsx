import React from "react";
import { Row, Col, Form, Input } from "antd";

const { Item } = Form;
const { TextArea } = Input;

type Props = {
  disabled?: boolean;
};

const MonitoringTrackQualitative: React.FC<Props> = ({ disabled = false }) => {
  const itemLayout = { labelCol: { span: 24 }, wrapperCol: { span: 24 } };
  return (
    <Row>
      <Col span={24}>
        <Item
          name={["questionHow"]}
          label="En qué consistió el logro del indicador/meta?"
          style={{ marginBottom: 0 }}
          {...itemLayout}
        >
          <TextArea disabled={disabled} />
        </Item>
        <Item
          name={["questionResult"]}
          label="Qué impacto, aspecto positivo o población beneficiada se logró?"
          style={{ marginBottom: 0 }}
          {...itemLayout}
        >
          <TextArea disabled={disabled}></TextArea>
        </Item>
        <Item
          name={["questionEvidence"]}
          label="Cómo se evidencia el logro o gestión?"
          style={{ marginBottom: 0 }}
          {...itemLayout}
        >
          <TextArea disabled={disabled}></TextArea>
        </Item>
        <Item
          name={["questionProblem"]}
          label="Qué dificultad de presentó para el logro del indicador/meta?"
          style={{ marginBottom: 0 }}
          {...itemLayout}
        >
          <TextArea disabled={disabled}></TextArea>
        </Item>
      </Col>
    </Row>
  );
};

export { MonitoringTrackQualitative };
