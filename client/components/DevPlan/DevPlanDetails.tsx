import React from "react";
import { Card, Typography, Descriptions, Row, Col, Tree, Space, Modal } from "antd";
import { dateFromStr } from "../../utils/formatUtils";
import { useRouter } from "next/router";
import { ButtonDelete, ButtonEdit, ButtonBack } from "../Buttons";
import { DownOutlined } from "@ant-design/icons";
import { DevPlanTreeLoader } from "../DevPlanTree/DevPlanTreeLoader";
import { DevPlanFragment } from "../../../graphql/gen/ops";
import { ExclamationCircleOutlined } from "@ant-design/icons";
import { useDeleteDevPlan, useDevPlanDetail } from "./hooks";
import { ContentLoading } from "../Utils/ContentLoading";

type Props = {
  id: number;
  data?: DevPlanFragment[];
};

const { Title } = Typography;
const { confirm } = Modal;

const DevPlanDetails: React.FC<Props> = ({ id }) => {
  const router = useRouter();
  const { loading, error, data: devPlan, treeLevels } = useDevPlanDetail(id);
  const { deleteDevPlan } = useDeleteDevPlan();

  const showDeleteConfirm = (devPlan: DevPlanFragment) => {
    confirm({
      title: "Está seguro de eliminar este plan?",
      icon: <ExclamationCircleOutlined />,
      content: (
        <span>
          El plan{" "}
          <Title style={{ display: "inline" }} level={5}>
            {devPlan.name}
          </Title>{" "}
          se eliminará de forma permanente, desea continuar?
        </span>
      ),
      okText: "Confirmar",
      okType: "danger",
      cancelText: "Cancelar",
      onOk() {
        onConfirmDelete(devPlan.id);
        backDevPlan();
      },
    });
  };

  const onConfirmDelete = async (id: number) => {
    await deleteDevPlan(id);
  };

  const backDevPlan = () => router.back();

  return (
    <ContentLoading loading={loading} error={error} errorTitle="Error al cargar el plan">
      <Space direction="vertical" size="middle" style={{ display: "flex" }}>
        <Card
          title="Plan de Desarrollo"
          bordered
          extra={
            <>
              <Row>
                <Space>
                  <Col>
                    <ButtonBack title="Volver" onClick={() => router.back()} />
                  </Col>
                  <Col>
                    <ButtonEdit
                      title="Editar"
                      onClick={() => router.push(`/config/dev-plans/${devPlan?.id}/edit`)}
                    />
                  </Col>
                  <Col>
                    <ButtonDelete
                      title="Eliminar"
                      onClick={() => {
                        if (devPlan) {
                          showDeleteConfirm(devPlan);
                        }
                      }}
                    />
                  </Col>
                </Space>
              </Row>
            </>
          }
        >
          <Descriptions bordered>
            <Descriptions.Item label="ID" span={2}>
              {devPlan?.id}
            </Descriptions.Item>
            <Descriptions.Item label="Código">{devPlan?.code}</Descriptions.Item>
            <Descriptions.Item label="Nombre" span={3}>
              {devPlan?.name}
            </Descriptions.Item>
            <Descriptions.Item label="Nombre Gobernante" span={3}>
              {devPlan?.governmentName}
            </Descriptions.Item>
            <Descriptions.Item label="Fecha Inicio" span={2}>
              {dateFromStr(devPlan?.startDate)}
            </Descriptions.Item>
            <Descriptions.Item label="Fecha Fin">{dateFromStr(devPlan?.endDate)}</Descriptions.Item>
            <Descriptions.Item label="Fecha Inicio Gobierno" span={2}>
              {dateFromStr(devPlan?.governmentStartDate)}
            </Descriptions.Item>
            <Descriptions.Item label="Fecha Fin Gobierno">
              {dateFromStr(devPlan?.governmentEndDate)}
            </Descriptions.Item>

            <Descriptions.Item label="Niveles">
              <Tree
                defaultExpandAll
                showLine
                switcherIcon={<DownOutlined />}
                treeData={treeLevels}
                titleRender={(nodeData) => `${nodeData.code} ${nodeData.title}`}
              ></Tree>
            </Descriptions.Item>
          </Descriptions>
        </Card>
        {devPlan && (
          <Card
            title="Estructura del Plan"
            extra={
              <>
                <Row>
                  <Space>
                    <Col>
                      <ButtonEdit
                        title="Editar Estructura"
                        onClick={() => router.push(`/config/dev-plans/${devPlan?.id}/levels`)}
                      />
                    </Col>
                  </Space>
                </Row>
              </>
            }
          >
            <DevPlanTreeLoader devPlanId={devPlan.id} />
          </Card>
        )}
      </Space>
    </ContentLoading>
  );
};

export { DevPlanDetails };
