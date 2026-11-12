import React, { useState } from "react";
import { Spin, Result, Row, Col, Card, Space, Alert } from "antd";
import { useRouter } from "next/router";
import { useGetDevPlanQuery } from "../../../graphql/gen/hooks";
import { ButtonBack } from "../Buttons";
import { DevPlanLevelCreate } from "./DevPlanLevelCreate";
import { DevPlanLevelEdit } from "./DevPlanLevelEdit";
import { DevPlanTreeLoader } from "../DevPlanTree/DevPlanTreeLoader";
import type { DataNode } from "../../types/devPlan";

type Props = {
  id: number;
};

const DevPlanLevels: React.FC<Props> = ({ id }) => {
  const router = useRouter();
  const [currentNode, setCurrentNode] = useState<DataNode>();

  const {
    data: dataDevPlan,
    error: errorDevPlan,
    loading: loadingDevPlan,
  } = useGetDevPlanQuery({ variables: { id } });

  const onSelect = (node: DataNode) => {
    setCurrentNode(node);
  };

  if (loadingDevPlan) return <Spin />;
  if (errorDevPlan)
    return (
      <Result
        status="warning"
        title="Hubo problemas cargando la información, por favor trate de nuevo."
      />
    );

  const devPlan = dataDevPlan?.getDevPlan;

  return (
    <Card
      style={{ display: "inline-block" }}
      title="Estructura del plan de desarrollo"
      extra={
        <>
          <Row style={{ width: "100%" }}>
            <Col span={12}>
              <ButtonBack title="Volver" onClick={() => router.back()} />
            </Col>
          </Row>
        </>
      }
    >
      <Row gutter={16}>
        <Col span={14}>
          <Card title="Árbol de Niveles">
            <Space direction="vertical" size="middle" style={{ display: "flex" }}>
              <Alert
                message="Seleccione un nodo para editar, eliminar o crear niveles hijos."
                type="info"
                closable
              />
              <DevPlanTreeLoader
                devPlanId={id}
                onSelectNode={onSelect}
                showRootAsNode={true}
                pAutoExpandParent
              />
            </Space>
          </Card>
        </Col>
        <Col span={10}>
          {devPlan && currentNode && (
            <div>
              <DevPlanLevelEdit devPlan={devPlan} currentNode={currentNode} />
              <DevPlanLevelCreate devPlan={devPlan} parentNode={currentNode} />
            </div>
          )}
        </Col>
      </Row>
    </Card>
  );
};

export { DevPlanLevels };
