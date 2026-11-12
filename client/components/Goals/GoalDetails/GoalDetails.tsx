import React, { useState, useEffect } from "react";
import { Card, Descriptions, Row, Col, List } from "antd";
import { useRouter } from "next/router";
import { useGetGoalLazyQuery } from "../../../../graphql/gen/hooks";
import { ButtonBack } from "../../Buttons";
import { accumulationTypeMap, goalTypeMap } from "../../../utils/uiUtils";
import { Goal } from "../../../types/goal";
import { useGoal } from "../hooks";
import { DataLoading } from "../../Data/DataLoading";
import { useMonitoring } from "../../../hooks/useMonitoring";

type Props = {
  id?: number;
  goal?: Goal;
  isModal?: boolean;
  mode?: "normal" | "compact" | "embed";
};

const GoalDetails: React.FC<Props> = ({ id, goal: pGoal, isModal = false, mode = "normal" }) => {
  const router = useRouter();
  const [goal, setGoal] = useState<Goal | undefined | null>();
  const [getGoal, { data: goalData, loading, error }] = useGetGoalLazyQuery();
  const { getGoalLevelLabel } = useGoal();
  const {
    getMonitoringLabels,
    isGoalMonitoring,
    isActionPlanActivityMonitoring,
    isActionPlanMonitoring,
  } = useMonitoring({
    goalTypes: goal?.goalType ? [goal?.goalType] : [],
  });

  useEffect(() => {
    if (pGoal) setGoal(pGoal);
    if (id)
      getGoal({
        variables: { id },
        fetchPolicy: "cache-and-network",
      });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [id, pGoal]);

  useEffect(() => {
    if (goalData) setGoal(goalData?.getGoal);
  }, [goalData]);

  const isCompact = mode === "compact";
  const isEmbedded = mode === "embed";

  if (!goal) return null;

  const DescriptionsContent: React.FC = () => {
    return (
      <DataLoading loading={loading} error={error}>
        <Descriptions
          title={
            isModal || mode === "embed"
              ? null
              : `Datos de la ${getMonitoringLabels([goal.goalType]).singular}`
          }
          size="small"
          bordered
          column={{ xxl: 4, xl: 4, lg: 4, md: 3, sm: 2, xs: 1 }}
          extra={
            isModal || mode ? null : (
              <>
                <Row>
                  <Col>
                    <ButtonBack title="Volver" onClick={() => router.back()} />
                  </Col>
                </Row>
              </>
            )
          }
        >
          {!isCompact && (
            <Descriptions.Item span={2} style={{ width: "15%" }} label="ID">
              {goal?.id}
            </Descriptions.Item>
          )}
          <Descriptions.Item span={2} style={{ width: "15%" }} label="Código">
            {goal?.code}
          </Descriptions.Item>
          {!isActionPlanMonitoring() && (
            <Descriptions.Item label="Meta" span={isCompact ? 2 : 4}>
              {goal?.name}
            </Descriptions.Item>
          )}
          {(isActionPlanActivityMonitoring() || isActionPlanMonitoring()) && (
            <Descriptions.Item label="Proyecto" span={isCompact ? 2 : 4}>
              {goal?.projectCode} - {goal?.proyecto?.nombre}
            </Descriptions.Item>
          )}
          {isActionPlanActivityMonitoring() && (
            <Descriptions.Item label="Actividad" span={isCompact ? 2 : 4}>
              {goal?.actividad?.codigoAct} - {goal?.actividad?.descripcion}
            </Descriptions.Item>
          )}
          <Descriptions.Item
            label="Entidad"
            span={isCompact ? 2 : 4}
          >{`${goal?.entity?.code} - ${goal?.entity?.name}`}</Descriptions.Item>
          {!isCompact && goal?.goalType && (
            <Descriptions.Item label="Tipo de meta" span={2}>
              {goalTypeMap[goal?.goalType]?.tag}
            </Descriptions.Item>
          )}
          <Descriptions.Item label={getGoalLevelLabel(goal)} span={2}>
            {goal?.devPlanLevel?.code} - {goal?.devPlanLevel?.name}
          </Descriptions.Item>

          {isGoalMonitoring([goal?.goalType]) && (
            <Descriptions.Item label="Indicador" span={isCompact ? 2 : 4}>
              {goal?.indicator}
            </Descriptions.Item>
          )}

          {goal?.unitsName && (
            <Descriptions.Item label="Unidades" span={2}>
              {goal?.unitsName}
            </Descriptions.Item>
          )}
          {isGoalMonitoring() && goal?.accumulationType && (
            <Descriptions.Item label="Tipo de acumulación" span={2}>
              {accumulationTypeMap[goal?.accumulationType]?.tag}
            </Descriptions.Item>
          )}
          {isGoalMonitoring([goal?.goalType]) && (
            <Descriptions.Item label="Valor base" span={isCompact ? 1 : 2}>
              {goal?.baseValue}
            </Descriptions.Item>
          )}
          {isGoalMonitoring([goal?.goalType]) && (
            <Descriptions.Item label="Valor meta" span={isCompact ? 3 : 2}>
              {goal?.goalValue}
            </Descriptions.Item>
          )}
          {goal?.publicPolitic && (
            <Descriptions.Item label="Política Pública" span={4}>
              {`${goal?.publicPolitic?.code}- ${goal?.publicPolitic?.name}`}
            </Descriptions.Item>
          )}
          {!isCompact && goal?.ods && (
            <Descriptions.Item label="Objetivos de desarrollo sostenible" span={4}>
              <List
                dataSource={goal?.ods || []}
                renderItem={(item) => <List.Item>{`${item.id} - ${item.name}`}</List.Item>}
              />
            </Descriptions.Item>
          )}
          {goal?.productCatalog && (
            <>
              <Descriptions.Item label="Indicador de Producto" span={4}>
                {`${goal?.productCatalog?.code}-${goal?.productCatalog?.name}`}
              </Descriptions.Item>
              <Descriptions.Item label="Valor base - producto" span={isCompact ? 1 : 2}>
                {goal?.piBaseValue}
              </Descriptions.Item>
              <Descriptions.Item label="Valor meta - producto" span={isCompact ? 1 : 2}>
                {goal?.piGoalValue}
              </Descriptions.Item>
            </>
          )}
        </Descriptions>
      </DataLoading>
    );
  };

  return isModal || isEmbedded ? (
    <DescriptionsContent />
  ) : (
    <Card>
      <DescriptionsContent />
    </Card>
  );
};

export { GoalDetails };
