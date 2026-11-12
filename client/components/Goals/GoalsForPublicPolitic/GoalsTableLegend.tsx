import React from "react";
import { Collapse, Row, Col } from "antd";
import { ButtonMoney } from "../../Buttons";

const { Panel } = Collapse;

const GoalsTableLegend = () => {
  return (
    <Collapse size="small">
      <Panel header="Leyenda" key="1">
        <Row gutter={[4, 4]}>
          <Col span={8}>
            <div style={{ display: "flex", gap: "3px" }}>
              <span>
                <ButtonMoney size="small" variant="default" width={24} heigth={24} />
              </span>
              <span>Meta Sin Programar</span>
            </div>
          </Col>
          <Col span={8}>
            <div style={{ display: "flex", gap: "3px" }}>
              <span>
                <ButtonMoney size="small" variant="active" width={24} heigth={24} />
              </span>
              <span>Meta Programada</span>
            </div>
          </Col>
          <Col span={8}>
            <div style={{ display: "flex", gap: "3px" }}>
              <span>
                <ButtonMoney size="small" variant="partial" width={24} heigth={24} />
              </span>
              <span>Meta Programada Parcialmente</span>
            </div>
          </Col>
        </Row>

        <Row></Row>
      </Panel>
    </Collapse>
  );
};

export { GoalsTableLegend };
