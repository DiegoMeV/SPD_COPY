import React from "react";
import { Spin, Result, Card, Typography, Descriptions, Row, Col, Modal, Space, List } from "antd";
import { useRouter } from "next/router";
import { dateFromStr } from "../../utils/formatUtils";
import { useGetMonitoringConfigQuery } from "../../../graphql/gen/hooks";
import { ButtonBack, ButtonDelete, ButtonEdit } from "../Buttons";
import { DevPlanFragment, MonitoringConfigFragment } from "../../../graphql/gen/ops";
import {
  GetMonitoringConfigDocument,
  useDeleteMonitoringConfigMutation,
} from "../../../graphql/gen/hooks";
import { ExclamationCircleOutlined } from "@ant-design/icons";
import { monitoringStatusMap, spentDocMap, weightingTypeMap } from "../../utils/uiUtils";
import { MonitoringConfigColors } from "./MonitoringConfigColors";
import Link from "next/link";

const { Title } = Typography;
const { confirm } = Modal;

type Props = {
  id: number;
  data?: MonitoringConfigFragment[];
};

const MonitoringConfigDetails: React.FC<Props> = ({ id }) => {
  const router = useRouter();
  const [deleteConfigMonitoring] = useDeleteMonitoringConfigMutation({
    refetchQueries: [{ query: GetMonitoringConfigDocument }, "GetConfigMonitorig"],
  });
  const { loading, error, data } = useGetMonitoringConfigQuery({
    variables: { id },
    fetchPolicy: "cache-and-network",
  });

  if (loading) return <Spin />;
  if (error)
    return (
      <Result
        status="warning"
        title="Hubo problemas cargando la información, por favor trate de nuevo."
      />
    );

  const configMonitoring = data?.getMonitoringConfig;

  if (loading) return <Spin />;
  if (error)
    return (
      <Result
        status="warning"
        title="Hubo problemas cargando la información, por favor trate de nuevo."
      />
    );

  const showDeleteConfirm = (
    configMonitoring: MonitoringConfigFragment & { devPlan?: DevPlanFragment | null },
  ) => {
    confirm({
      title: "Está seguro de eliminar este registro?",
      icon: <ExclamationCircleOutlined />,
      content: (
        <span>
          <Title style={{ display: "inline" }} level={5}>
            {configMonitoring?.devPlan?.name}
          </Title>
          se eliminará de forma permanente, desea continuar?
        </span>
      ),
      okText: "Confirmar",
      okType: "danger",
      cancelText: "Cancelar",
      onOk() {
        onConfirmDelete(configMonitoring.id);
        backConfigMonitoring();
      },
    });
  };

  const onConfirmDelete = async (id: number) => {
    await deleteConfigMonitoring({
      variables: {
        id,
      },
    });
  };

  const backConfigMonitoring = () => router.push("/monitoring/config");

  const periodicityValue = (field: number) => {
    const periodicityDescription: Record<number, string> = {
      1: "Mensual",
      2: "Bimestral",
      3: "Trimestral",
      4: "Cuatrimestral",
      6: "semestral",
    };
    return periodicityDescription[field];
  };

  return (
    <Card>
      <Descriptions
        title="Parámetros de seguimiento"
        bordered
        column={{ xxl: 2, xl: 2, lg: 2, md: 2, sm: 2, xs: 1 }}
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
                    onClick={() => router.push(`/monitoring/config/edit/${configMonitoring?.id}`)}
                  />
                </Col>
                <Col>
                  <ButtonDelete
                    title="Eliminar"
                    onClick={() => {
                      if (configMonitoring) {
                        showDeleteConfirm(configMonitoring);
                      }
                    }}
                  />
                </Col>
              </Space>
            </Row>
          </>
        }
      >
        <Descriptions.Item label="ID">{configMonitoring?.id}</Descriptions.Item>
        <Descriptions.Item label="Plan de Desarrollo">
          {
            <Link href={`/config/dev-plans/${configMonitoring?.devPlanId}`}>
              {configMonitoring?.devPlan?.name}
            </Link>
          }
        </Descriptions.Item>
        <Descriptions.Item label="Periodo">{configMonitoring?.period}</Descriptions.Item>
        <Descriptions.Item label="Subperiodo">{configMonitoring?.subperiod}</Descriptions.Item>
        {configMonitoring?.spentDocs?.length && (
          <Descriptions.Item label="Documentos de ejecución">
            <List
              bordered
              dataSource={configMonitoring?.spentDocs}
              renderItem={(item) => (
                <List.Item>
                  <Typography.Text>$ {spentDocMap[item]?.tag}</Typography.Text>
                </List.Item>
              )}
            />
          </Descriptions.Item>
        )}
        {configMonitoring?.weightingType && (
          <Descriptions.Item label="Documento de ejecución">
            {weightingTypeMap[configMonitoring?.weightingType]?.tag}
          </Descriptions.Item>
        )}
        <Descriptions.Item label="Periodicidad">
          {periodicityValue(configMonitoring?.periodicity || 0)}
        </Descriptions.Item>
        {configMonitoring?.datesConfig?.scheduling?.[0] && (
          <Descriptions.Item label="Fecha de programación  ">
            {`${dateFromStr(configMonitoring?.datesConfig?.scheduling?.[0])} - ${dateFromStr(
              configMonitoring?.datesConfig?.scheduling?.[1],
            )}`}
          </Descriptions.Item>
        )}
        {configMonitoring?.datesConfig?.reporting?.[0] && (
          <Descriptions.Item label="Fecha de reporte ">
            {`${dateFromStr(configMonitoring?.datesConfig?.reporting?.[0])} - ${dateFromStr(
              configMonitoring?.datesConfig?.reporting?.[1],
            )}`}
          </Descriptions.Item>
        )}
        {configMonitoring?.datesConfig?.validating?.[0] && (
          <Descriptions.Item label="Fecha de validación ">
            {`${dateFromStr(configMonitoring?.datesConfig?.validating?.[0])} - ${dateFromStr(
              configMonitoring?.datesConfig?.validating[1],
            )}`}
          </Descriptions.Item>
        )}
        {configMonitoring?.datesConfig?.reviewing?.[0] && (
          <Descriptions.Item label="Fecha de revisión ">
            {`${dateFromStr(configMonitoring?.datesConfig?.reviewing?.[0])} - ${dateFromStr(
              configMonitoring?.datesConfig?.reviewing?.[1],
            )}`}
          </Descriptions.Item>
        )}
        {configMonitoring?.status && (
          <Descriptions.Item label="Estado">
            {monitoringStatusMap[configMonitoring?.status]?.tag}
          </Descriptions.Item>
        )}
        <Descriptions.Item label="Colores Indicadores">
          {<MonitoringConfigColors colorsConfig={configMonitoring?.colorsConfig} />}
        </Descriptions.Item>
      </Descriptions>
    </Card>
  );
};

export { MonitoringConfigDetails };
