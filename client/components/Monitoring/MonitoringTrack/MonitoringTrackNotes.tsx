import React from "react";
import { Row, Col, Form, Input } from "antd";

const { Item } = Form;
const { TextArea } = Input;

type Props = {
  disabled?: boolean;
};

const MonitoringTrackNotes: React.FC<Props> = ({ disabled = false }) => {
  const itemLayout = { labelCol: { span: 24 }, wrapperCol: { span: 24 } };

  return (
    <Row>
      <Col span={24}>
        <Item name={["notes"]} label="Notas Generales" style={{ marginBottom: 0 }} {...itemLayout}>
          <TextArea rows={10} disabled={disabled} />
        </Item>
      </Col>
    </Row>
  );
};

export { MonitoringTrackNotes };
