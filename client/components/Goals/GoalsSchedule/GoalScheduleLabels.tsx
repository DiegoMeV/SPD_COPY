import React from "react";
import { Form, Typography, Space, Divider, Row, Col } from "antd";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { DownOutlined, UpOutlined } from "@ant-design/icons";
import { useCurrentGoal, useGoal } from "../hooks";
const { Item } = Form;
const { Title, Text } = Typography;

const GoalsScheduleLabels: React.FC = () => {
  const { currentMonitoring, isSgpDiscriminatedExpanded, toggleIsSgpDiscriminatedExpanded } =
    useMonitoringConfig();
  const { isProjectGoal, isActionPlanGoal } = useCurrentGoal();

  const SGPLabel = () => {
    const ExpandIcon = isSgpDiscriminatedExpanded ? UpOutlined : DownOutlined;
    if (!currentMonitoring?.sgpDiscriminated) return <>Recursos SGP</>;
    return (
      <Space>
        <ExpandIcon
          onClick={() => {
            toggleIsSgpDiscriminatedExpanded();
          }}
        />
        <Text strong>Recursos SGP</Text>
      </Space>
    );
  };

  return (
    <>
      {!(isProjectGoal() || isActionPlanGoal()) && <Item label="Programación Meta"></Item>}
      {currentMonitoring?.supportProductMonitoring && (
        <Item label="Programación Indicador Producto"></Item>
      )}
      <Item label="Ponderación"></Item>
      <Item label="Mes inicial"></Item>
      <Item label="Mes final"></Item>
      <Item label="Origen Datos Financieros" style={{ height: "1.7rem" }}></Item>
      <Item label="Recursos Propios"></Item>
      <Item label={<SGPLabel />}></Item>
      {isSgpDiscriminatedExpanded && (
        <Row>
          <Col span={2}>
            <Divider type="vertical" style={{ height: "100%" }} />
          </Col>
          <Col span={20}>
            <Item label="Educación"></Item>
            <Item label="Salud"></Item>
            <Item label="Agua Potable"></Item>
            <Item label="Cultura"></Item>
            <Item label="Deporte"></Item>
            <Item label="Libre Inversión"></Item>
            <Item label="Libre Destinación"></Item>
            <Item label="Alimentación Escolar"></Item>
            <Item label="Río Magdalena"></Item>
            <Item label="Primera Infancia"></Item>
          </Col>
        </Row>
      )}
      <Item label="Recursos CN"></Item>
      <Item label="Recursos CD"></Item>
      <Item label="Recursos SGR"></Item>
      <Item label="Recursos Crédito"></Item>
      <Item label="Otros Recursos"></Item>
      <Item label="Recursos Gestión"></Item>
      <Item label="Recursos Funcionamiento"></Item>
      <Item>
        <Title level={5}>{"Total Recursos:"}</Title>
      </Item>
    </>
  );
};

export { GoalsScheduleLabels };
