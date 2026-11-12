import React from "react";
import { Form, Row, Col, Card, Typography } from "antd";
import { NumberInput } from "../../Inputs/NumberInput/NumberInput";
import { SelectGeoLocation } from "../../Selects";

const { Item } = Form;
const { Text } = Typography;

type MonitoringTrackTargetREFormProps = {
  id: string;
  onLocationChange: (ids?: number[], labels?: React.ReactNode[]) => void;
};

const MonitoringTrackTargetREForm: React.FC<MonitoringTrackTargetREFormProps> = ({
  id,
  onLocationChange,
}) => {
  return (
    <>
      <Item label="Localización" name={["targetMatrix", "re", id, "localizationLabel"]} hidden />
      <Item
        label="Localización"
        name={["targetMatrix", "re", id, "localization"]}
        labelCol={{ span: 4 }}
        wrapperCol={{ span: 16 }}
      >
        <SelectGeoLocation onChange={onLocationChange} />
      </Item>
      <Row gutter={[10, 4]}>
        <Col span={24}>
          <Card title="Recursos Ecosistémicos">
            <Row justify="center">
              <Col span={6}></Col>
              <Col span={6} style={{ textAlign: "center" }}>
                <Text>Macho</Text>
              </Col>
              <Col span={6} style={{ textAlign: "center" }}>
                <Text>Hembra</Text>
              </Col>
            </Row>
            <Row justify="center" gutter={[10, 0]}>
              <Col span={6}>
                <Item label="Canino"></Item>
              </Col>
              <Col span={6}>
                <Item name={["targetMatrix", "re", id, "canine", "m"]}>
                  <NumberInput />
                </Item>
              </Col>
              <Col span={6}>
                <Item name={["targetMatrix", "re", id, "canine", "f"]}>
                  <NumberInput />
                </Item>
              </Col>
            </Row>
            <Row justify="center" gutter={[10, 0]}>
              <Col span={6}>
                <Item label="Felino"></Item>
              </Col>
              <Col span={6}>
                <Item name={["targetMatrix", "re", id, "feline", "m"]}>
                  <NumberInput />
                </Item>
              </Col>
              <Col span={6}>
                <Item name={["targetMatrix", "re", id, "feline", "f"]}>
                  <NumberInput />
                </Item>
              </Col>
            </Row>
            <Row justify="center" gutter={[10, 0]}>
              <Col span={6}>
                <Item label="Otra Especie"></Item>
              </Col>
              <Col span={6}>
                <Item name={["targetMatrix", "re", id, "others", "m"]}>
                  <NumberInput />
                </Item>
              </Col>
              <Col span={6}>
                <Item name={["targetMatrix", "re", id, "others", "f"]}>
                  <NumberInput />
                </Item>
              </Col>
            </Row>
            <Row justify="center" gutter={[10, 0]}>
              <Col span={6}>
                <Item label="Flora"></Item>
              </Col>
              <Col span={12}>
                <Item name={["targetMatrix", "re", id, "flora"]}>
                  <NumberInput />
                </Item>
              </Col>
            </Row>
          </Card>
        </Col>
      </Row>
    </>
  );
};

export { MonitoringTrackTargetREForm };
