import React from "react";
import { Card, Row, Col } from "antd";
import { useRouter } from "next/router";
import { ButtonAdd } from "../Buttons";
import { useDevPlans } from "./hooks";
import { TextWithBadge } from "../Utils/TextWithBadge";
import { DataLoading } from "../Data/DataLoading";
import { DevPlanCard } from "./DevPlanCard";
import { useApp } from "../../hooks/useApp";
import { OptionPermissionAction } from "../../types/common";

const DevPlanTable: React.FC = () => {
  const router = useRouter();
  const { loading, data, error, count, handleTableChange, getColumnRender } = useDevPlans();
  const { hasCreatePermission } = useApp();

  return (
    <DataLoading error={error} loading={loading}>
      <Card
        title={<TextWithBadge text="Planes de Desarrollo" count={count} />}
        {...(hasCreatePermission()
          ? {
              extra: (
                <ButtonAdd
                  title="Nuevo Plan"
                  onClick={() => router.push("/config/dev-plans/new")}
                />
              ),
            }
          : {})}
      >
        <Row gutter={[16, 16]}>
          {data?.map((devPlan) => (
            <Col sm={12} md={12} lg={8} xl={6} xxl={6} key={devPlan.id}>
              <DevPlanCard devPlan={devPlan} />
            </Col>
          ))}
        </Row>
      </Card>
    </DataLoading>
  );
};

export { DevPlanTable };
