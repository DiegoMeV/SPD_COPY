import React from "react";
import { Form, Row, Col, Card, Input } from "antd";
import { NumberInput } from "../../Inputs/NumberInput/NumberInput";
import { SelectGeoLocation } from "../../Selects";

const { Item } = Form;
const { TextArea } = Input;

type MonitoringTrackTargetOrgFormProps = {
  id: string;
  onLocationChange: (ids?: number[], labels?: React.ReactNode[]) => void;
};

const MonitoringTrackTargetOrgForm: React.FC<MonitoringTrackTargetOrgFormProps> = ({
  id,
  onLocationChange,
}) => {
  const itemLayout = { labelCol: { span: 6 }, wrapperCol: { span: 18 } };

  return (
    <>
      <Item label="Localización" name={["targetMatrix", "org", id, "localizationLabel"]} hidden />
      <Item
        label="Localización"
        name={["targetMatrix", "org", id, "localization"]}
        labelCol={{ span: 4 }}
        wrapperCol={{ span: 16 }}
      >
        <SelectGeoLocation onChange={onLocationChange} />
      </Item>
      <Row gutter={[10, 4]}>
        <Col span={24}>
          <Card title="Focalización Organizacional">
            <Item
              label="Tipo de institución"
              tooltip="Tipo de institución u organización"
              name={["targetMatrix", "org", id, "orgType"]}
              {...itemLayout}
            >
              <Input />
            </Item>
            <Item
              label="Objeto de institución"
              tooltip="Objeto de institución u organización"
              name={["targetMatrix", "org", id, "orgObject"]}
              {...itemLayout}
            >
              <TextArea rows={4} />
            </Item>
            <Item
              label="Número de beneficiarios"
              name={["targetMatrix", "org", id, "numBeneficiaries"]}
              labelCol={{ span: 6 }}
              wrapperCol={{ span: 4 }}
            >
              <NumberInput />
            </Item>
            <Item
              label="Total población /unidad"
              name={["targetMatrix", "org", id, "populationDesc"]}
              {...itemLayout}
              tooltip="Total población / unidad de medida"
            >
              <Input />
            </Item>
          </Card>
        </Col>
      </Row>
    </>
  );
};

export { MonitoringTrackTargetOrgForm };
