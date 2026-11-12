import React, { useEffect } from "react";
import { Table, Card, Space, Tooltip, Typography, Modal, Badge } from "antd";
import { ColumnsType } from "antd/lib/table";
import {
  PublicPoliticComponentFragment,
  PublicPoliticFragment,
  SearchPublicPoliticsQuery,
} from "../../../graphql/gen/ops";
import { ButtonDelete } from "../Buttons";
import { TextSearch } from "../Utils/TextSearch";
import { ModalLink } from "../Utils/ModalLink";

import { PublicPoliticsNew } from "./PublicPoliticsNew";
import { PublicPoliticsEdit } from "./PublicPoliticsEdit";
import { ExclamationCircleOutlined } from "@ant-design/icons";
import {
  SearchPublicPoliticsDocument,
  useDeletePublicPoliticMutation,
} from "../../../graphql/gen/hooks";
import { PublicPoliticCategory } from "../../../graphql/gen/schema";
import { publicPoliticCategoryMap } from "../../utils/uiUtils";
import { PublicPoliticLocalization } from "../../types/publicPolitic";
import { ActiveStatus } from "../Utils/ActiveStatus";
import { PublicComponentsModal } from "./PublicPoliticComponentsModal";
import { useRowSelection } from "../../hooks/useTable";
import { useStoreActions, useStoreState } from "../../store";
import { TextWithBadge } from "../Utils/TextWithBadge";

type Props = {
  data?: SearchPublicPoliticsQuery["searchPublicPolitics"]["items"];
  localization: PublicPoliticLocalization;
  title?: string;
  selectable?: boolean;
};

const { Title } = Typography;
const { confirm } = Modal;
const { Link } = Typography;

const PublicPoliticsTable: React.FC<Props> = ({
  data,
  localization,
  title = "Políticas Públicas",
  selectable = false,
}) => {
  const { rowClassName, onRow, selectedRowKeys } = useRowSelection({ multiple: false });
  const setSelectedPublicPolitic = useStoreActions(
    (actions) => actions.publicPolitic.setSelectedPublicPolitic,
  );

  useEffect(() => {
    if (selectedRowKeys?.length) {
      const publicPolitic = data?.find(
        (publicPolitic) => publicPolitic.id === parseInt(`${selectedRowKeys?.[0]}`),
      );
      setSelectedPublicPolitic(publicPolitic);
    }
  }, [selectedRowKeys, data]);

  const [deleteEntity] = useDeletePublicPoliticMutation({
    refetchQueries: [
      {
        query: SearchPublicPoliticsDocument,
        variables: {
          data: {
            categories:
              localization === "national"
                ? [PublicPoliticCategory.Peace, PublicPoliticCategory.Victims]
                : [PublicPoliticCategory.Territory],
          },
        },
      },
      "SearchPublicPolitics",
    ],
  });

  const columns: ColumnsType<PublicPoliticFragment> = [
    ...(!selectable
      ? [
          {
            title: "ID",
            dataIndex: "id",
            key: "id",
            sorter: () => 0,
          },
        ]
      : []),
    ...(localization !== "territorial"
      ? [
          {
            title: "Categoría",
            dataIndex: "category",
            key: "category",
            sorter: () => 0,
            render: (field: PublicPoliticCategory) => {
              return publicPoliticCategoryMap[field]?.tag;
            },
          },
        ]
      : []),
    {
      title: "Codigo",
      dataIndex: "code",
      key: "code",
      sorter: () => 0,
    },
    {
      title: "Nombre",
      dataIndex: "name",
      key: "name",
      sorter: () => 0,
    },
    ...(!selectable
      ? [
          {
            title: "Descripción",
            dataIndex: "description",
            key: "description",
            sorter: () => 0,
          },
        ]
      : []),
    ...(localization === "territorial" && !selectable
      ? [
          {
            title: "Año Inicial",
            dataIndex: "fromYear",
            key: "fromYear",
            sorter: () => 0,
          },
          {
            title: "Año Final",
            dataIndex: "toYear",
            key: "toYear",
            sorter: () => 0,
          },
        ]
      : []),
    {
      title: "Componentes",
      dataIndex: "components",
      key: "components",
      render: (components: PublicPoliticComponentFragment[], data: PublicPoliticFragment) => {
        return (
          <ModalLink
            title={`Componentes de ${data.name}`}
            link={
              <Link
                style={{
                  margin: "0 auto",
                  fontSize: "0.8rem",
                  display: "flex",
                  justifyContent: "center",
                }}
              >
                <TextSearch text={`${components.length}`} />
              </Link>
            }
          >
            <PublicComponentsModal components={components} />
          </ModalLink>
        );
      },
    },
    {
      title: "Acciones",
      dataIndex: "goalCount",
      key: "goalCount",
      align: "right",
      render: (goalCount: number) => (
        <Badge count={goalCount} overflowCount={999} showZero color="blue" />
      ),
    },
    ...(!selectable
      ? [
          {
            title: "Activa",
            dataIndex: "isActive",
            key: "isActive",
            align: "center" as any,
            render: (isActive: boolean) => <ActiveStatus active={isActive} />,
          },
          {
            title: "Acciones",
            dataIndex: "id",
            key: "idDelete",
            render: (field: number, row: PublicPoliticFragment) => (
              <Space size="middle">
                <PublicPoliticsEdit data={row} localization={localization} />
                <Tooltip>
                  <ButtonDelete
                    title="Eliminar"
                    onClick={() => {
                      showDeleteConfirm(row);
                    }}
                  />
                </Tooltip>
              </Space>
            ),
          },
        ]
      : []),
  ];

  const showDeleteConfirm = (publicPolitic: PublicPoliticFragment) => {
    confirm({
      title: "Está seguro(a) de eliminar esta política pública?",
      icon: <ExclamationCircleOutlined />,
      content: (
        <span>
          <Title style={{ display: "inline" }} level={5}>
            {publicPolitic.name}
          </Title>{" "}
          se eliminará de forma permanente, desea continuar?
        </span>
      ),
      okText: "Confirmar",
      okType: "danger",
      cancelText: "Cancelar",
      onOk() {
        onConfirmDelete(publicPolitic.id);
      },
    });
  };

  const onConfirmDelete = async (id: number) => {
    await deleteEntity({
      variables: {
        id,
      },
    });
  };

  return (
    <>
      <Card title={title} extra={<PublicPoliticsNew localization={localization} />}>
        <Table
          dataSource={data}
          columns={columns}
          pagination={{ pageSize: 100 }}
          rowKey={(record: PublicPoliticFragment) => record.id}
          onRow={onRow}
          rowClassName={rowClassName}
          size="small"
        />
      </Card>
    </>
  );
};

export { PublicPoliticsTable };
