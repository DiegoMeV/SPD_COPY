import React from "react";
import { Form, Collapse, Col, Row } from "antd";
import { NumberInput } from "../../Inputs/NumberInput/NumberInput";
import type { CollapseProps } from "antd";
import { SelectGeoLocation } from "../../Selects";

const { Item } = Form;
const itemLayout = { labelCol: { span: 12 }, wrapperCol: { span: 12 } };

const CollapseGenre: React.FC<{ id: string }> = ({ id }) => {
  return (
    <>
      <Row>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "genre", "h"]}
            label="Hombres"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "genre", "m"]}
            label="Mujeres"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
      </Row>
    </>
  );
};
const CollapseZone: React.FC<{ id: string }> = ({ id }) => {
  return (
    <>
      <Row>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "zone", "u"]}
            label="Urbano"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "zone", "r"]}
            label="Rural"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
      </Row>
    </>
  );
};
const CollapseAgeCycles: React.FC<{ id: string }> = ({ id }) => {
  return (
    <>
      <Row gutter={[5, 3]}>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "ageCycles", "pi"]}
            label="Primera Infancia"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "ageCycles", "adol"]}
            label="Adolescencia"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "ageCycles", "j"]}
            label="Juventud"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "ageCycles", "aj"]}
            label="Adulto Joven"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "ageCycles", "a"]}
            label="Adulto"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "ageCycles", "am"]}
            label="Adulto Mayor"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
      </Row>
    </>
  );
};
const CollapseConditions: React.FC<{ id: string }> = ({ id }) => {
  return (
    <>
      <Row gutter={[5, 3]}>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "conditions", "noC"]}
            label="Sin Condición"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "conditions", "d"]}
            label="Discapacidad"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "conditions", "des"]}
            label="Desplazado"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "conditions", "vca"]}
            label="Victima Conf."
            tooltip="Victima Conflicto Armado"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "conditions", "mch"]}
            label="Mujer C. H."
            tooltip="Mujer Cabeza de Hogar"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "conditions", "hc"]}
            label="Hab. Calle"
            tooltip="Habitante de Calle"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "conditions", "mig"]}
            label="Migrante"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
      </Row>
    </>
  );
};
const CollapseEthnicity: React.FC<{ id: string }> = ({ id }) => {
  return (
    <>
      <Row gutter={[5, 3]}>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "ageCycles", "mz"]}
            label="Mestizo"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "ageCycles", "afro"]}
            label="AfroCol"
            tooltip="Afrocolombiano"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "ageCycles", "i"]}
            label="Indígena"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "ageCycles", "p"]}
            label="Palenquero"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "ageCycles", "r"]}
            label="Raizal"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
        <Col span={8}>
          <Item
            name={["targetMatrix", "ed", id, "ageCycles", "rom"]}
            label="ROM"
            style={{ marginBottom: 0 }}
            {...itemLayout}
          >
            <NumberInput />
          </Item>
        </Col>
      </Row>
    </>
  );
};

type MonitoringTrackTargetEDFormProps = {
  id: string;
  onLocationChange: (ids?: number[], labels?: React.ReactNode[]) => void;
};

const MonitoringTrackTargetEDForm: React.FC<MonitoringTrackTargetEDFormProps> = ({
  id,
  onLocationChange,
}) => {
  const collapseItems: CollapseProps["items"] = [
    {
      key: "1",
      label: "Género",
      children: <CollapseGenre id={id} />,
    },
    {
      key: "2",
      label: "Zona",
      children: <CollapseZone id={id} />,
    },
    {
      key: "3",
      label: "Ciclos de Edad",
      children: <CollapseAgeCycles id={id} />,
    },
    {
      key: "4",
      label: "Condición",
      children: <CollapseConditions id={id} />,
    },
    {
      key: "5",
      label: "Etnia",
      children: <CollapseEthnicity id={id} />,
    },
  ];

  return (
    <>
      <Item label="Localización" name={["targetMatrix", "ed", id, "localizationLabel"]} hidden />
      <Item
        label="Localización"
        name={["targetMatrix", "ed", id, "localization"]}
        labelCol={{ span: 4 }}
        wrapperCol={{ span: 16 }}
      >
        <SelectGeoLocation onChange={onLocationChange} />
      </Item>
      <Collapse items={collapseItems} defaultActiveKey={["1", "2", "3", "4", "5"]} />
    </>
  );
};

export { MonitoringTrackTargetEDForm };
