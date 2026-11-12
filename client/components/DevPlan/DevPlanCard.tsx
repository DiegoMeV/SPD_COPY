import React from "react";
import { DevPlanFragment } from "../../../graphql/gen/ops";
import { Card, Col, Row, Typography } from "antd";
import { DevPlansTableActions } from "./DevPlanTableActions";

type Props = {
  devPlan: DevPlanFragment;
};

const { Title, Text } = Typography;

const DevPlanCard: React.FC<Props> = ({ devPlan }) => {
  return (
    <Card
      title={<span className="card-title">{`${devPlan.code}. ${devPlan.name}`}</span>}
      className="plan-card"
    >
      <Row gutter={[8, 8]}>
        <Col span={24} style={{ textAlign: "center" }}>
          <p className="card-subtitle">
            <Title level={4}>{devPlan.governmentName}</Title>
          </p>
        </Col>
        <Col span={24} style={{ textAlign: "center" }}>
          <p>
            <Title level={5}>
              {new Date(devPlan.startDate).getFullYear()} -{" "}
              {new Date(devPlan.endDate).getFullYear()}
            </Title>
          </p>
        </Col>
      </Row>
      <div className="card-actions">
        <DevPlansTableActions devPlan={devPlan} />
      </div>
    </Card>
  );
};

export { DevPlanCard };
