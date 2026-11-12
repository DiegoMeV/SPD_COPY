import { ExclamationCircleOutlined } from "@ant-design/icons";
import { Card, Modal, Space, Table, Tooltip } from "antd";
import { ColumnsType } from "antd/lib/table";
import { useRouter } from "next/router";
import React from "react";
import {
  GetMonitoringConfigsDocument,
  useCopyMonitoringConfigPreviousScheduleMutation,
  useDeleteMonitoringConfigMutation,
} from "../../../graphql/gen/hooks";
import { DevPlanFragment, MonitoringConfigFragment } from "../../../graphql/gen/ops";
import { ButtonEdit, ButtonDelete, ButtonAdd, ButtonClone } from "../Buttons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCheckCircle } from "@fortawesome/free-solid-svg-icons";
import { MonitoringConfigUsedFor } from "../../../graphql/gen/schema";
import { useStoreActions } from "../../store";
import Link from "next/link";

type Props = {
  data?: MonitoringConfigFragment[];
  usedFor?: MonitoringConfigUsedFor;
};

const { confirm } = Modal;

const MonitoringConfigTable: React.FC<Props> = ({
  data,
  usedFor = MonitoringConfigUsedFor.DevelopmentPlans,
}) => {
  const router = useRouter();
  const { sendNotification } = useStoreActions((actions) => actions.notifications);
  const [deleteMonitoringConfig] = useDeleteMonitoringConfigMutation({
    refetchQueries: [
      { query: GetMonitoringConfigsDocument, variables: { data: { usedFor } } },
      "GetMonitoringConfigs",
    ],
  });
  const [cloneGoalsSchedule] = useCopyMonitoringConfigPreviousScheduleMutation();

  const columns: ColumnsType<MonitoringConfigFragment> = [
    {
      title: "ID",
      dataIndex: "id",
      key: "id",
      sorter: () => 0,
      render: (field: string, row: MonitoringConfigFragment) => (
        <Link href={`/monitoring/config/${row.id}`}>{field}</Link>
      ),
    },
    {
      title: "Periodo",
      dataIndex: "period",
      key: "period",
      sorter: () => 0,
    },
    {
      title: "Subperiodo",
      dataIndex: "subperiod",
      key: "subperiod",
      sorter: () => 0,
    },
    ...(usedFor === MonitoringConfigUsedFor.DevelopmentPlans
      ? [
          {
            title: "Plan de desarrollo",
            dataIndex: "devPlan",
            key: "devPlan",
            sorter: () => 0,
            render: (field: DevPlanFragment) => field.name,
          },
        ]
      : []),
    // {
    //   title: "Inicio estado",
    //   dataIndex: "statusDates",
    //   key: "statusDates",
    //   sorter: () => 0,
    //   render: (field: string) => dateFromStr(field[0]),
    // },
    // {
    //   title: "Fin estado",
    //   dataIndex: "statusDates",
    //   key: "statusDates",
    //   sorter: () => 0,
    //   render: (field: string) => (field?.[1] ? dateFromStr(field[1]) : ""),
    // },
    {
      title: "Activo",
      dataIndex: "isActive",
      key: "isActive",
      align: "center",
      render: (isActive: boolean) => {
        return (
          <>
            <FontAwesomeIcon
              icon={faCheckCircle}
              style={{
                color: isActive ? "green" : "gray",
                height: "38px",
                width: "40px",
                paddingTop: "5px",
              }}
            />
          </>
        );
      },
    },
    {
      title: "Acciones",
      dataIndex: "id",
      key: "idDelete",
      render: (field: number, row: MonitoringConfigFragment) => (
        <Space size="middle">
          <ButtonEdit
            title="Editar"
            onClick={() =>
              router.push(
                `${
                  usedFor === MonitoringConfigUsedFor.PublicPolitics ? "/spp" : ""
                }/monitoring/config/edit/${field}`,
              )
            }
          />
          <Tooltip>
            <ButtonDelete
              title="Eliminar"
              onClick={() => {
                showDeleteConfirm(row);
              }}
            />
          </Tooltip>
          <ButtonClone
            title="Copiar Programación"
            onClick={() => {
              showCloneConfirm(row);
            }}
          />
        </Space>
      ),
    },
  ];

  const showDeleteConfirm = (config: MonitoringConfigFragment) => {
    confirm({
      title: "Está seguro de eliminar este seguimiento? ",
      icon: <ExclamationCircleOutlined />,
      okText: "Confirmar",
      okType: "danger",
      cancelText: "Cancelar",
      onOk() {
        onConfirmDelete(config.id);
      },
    });
  };

  const onConfirmDelete = async (id: number) => {
    await deleteMonitoringConfig({
      variables: {
        id,
      },
    });
  };

  const showCloneConfirm = (config: MonitoringConfigFragment) => {
    confirm({
      title: "Confirmar copia de programación",
      content:
        "Al dar clic en Confirmar, se copiará la programación de las metas del subperiodo inmediatamente anterior",
      icon: <ExclamationCircleOutlined />,
      okText: "Confirmar",
      okType: "primary",
      cancelText: "Cancelar",
      onOk() {
        onConfirmClone(config.id);
      },
    });
  };

  const onConfirmClone = async (id: number) => {
    const result = await cloneGoalsSchedule({
      variables: {
        data: {
          id,
        },
      },
    });
    if (result.data?.copyMonitoringConfigPreviousSchedule?.length) {
      sendNotification({
        type: "success",
        message: "Programación Copiada",
        description: `Se ha copiado correctamente la programación de ${
          result.data?.copyMonitoringConfigPreviousSchedule?.length
        } ${usedFor === MonitoringConfigUsedFor.DevelopmentPlans ? "metas" : "acciones"}`,
      });
    } else {
      sendNotification({
        type: "warning",
        message: "Copiando Programación",
        description:
          "No se ha encontrado programación de metas a copiar para este periodo. Verifique que no hayan metas ya programadas.",
      });
    }
  };

  return (
    <>
      <Card
        title="Parámetros de Seguimiento"
        extra={
          <ButtonAdd
            title="Nuevo parámetro"
            onClick={() =>
              router.push(
                `${
                  usedFor === MonitoringConfigUsedFor.PublicPolitics ? "/spp" : ""
                }/monitoring/config/new`,
              )
            }
          />
        }
      >
        <Table
          dataSource={data}
          columns={columns}
          rowKey={(record: MonitoringConfigFragment) => record.id}
        />
      </Card>
    </>
  );
};

export { MonitoringConfigTable };
