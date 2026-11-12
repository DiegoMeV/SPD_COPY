import React from "react";
import { Table, Card, Space, Divider } from "antd";
import { ColumnsType } from "antd/lib/table";
import { useRouter } from "next/router";
import { EntityFragment } from "../../../graphql/gen/ops";
import { ButtonAdd } from "../Buttons";
import { useSearchEntities } from "./hooks";
import { ActiveStatus } from "../Utils/ActiveStatus";
import { EntitiesTableActions } from "./EntitiesTableActions";
import { DataError } from "../Data/DataError";
import { SearchInput } from "../Inputs/SearchInput/SearchInput";
import { TextWithBadge } from "../Utils/TextWithBadge";
import Link from "next/link";

type Props = {
  data?: EntityFragment[];
};
const EntitiesTable: React.FC<Props> = () => {
  const router = useRouter();

  const {
    loading,
    data,
    error,
    pagination,
    search,
    filters,
    handleTableChange,
    setSearch,
    getColumnRender,
    commonFilters,
  } = useSearchEntities();

  const onSearch = (value: string | undefined) => {
    setSearch({ searchText: value, searchedColumn: "text" });
  };

  const columns: ColumnsType<EntityFragment> = [
    {
      ...getColumnRender("id", "ID", { sorter: true }),
      width: "10%",
      render: (field: string, row: EntityFragment) => (
        <Link href={`/config/entities/${row.id}`}>{field}</Link>
      ),
    },
    {
      ...getColumnRender("code", "Código", { sorter: true, highlightSearch: true }),
      width: "15%",
    },
    getColumnRender("name", "Nombre", { sorter: true, highlightSearch: true }),
    {
      ...getColumnRender("isActive", "Activo"),
      filters: commonFilters.isActive,
      filteredValue: filters?.isActive,
      align: "center",
      render: (isActive: boolean) => <ActiveStatus active={isActive} />,
    },
    {
      ...getColumnRender("hasManualBudget", "Presupuesto Externo"),
      align: "center",
      render: (hasManualBudget: boolean) => <ActiveStatus active={hasManualBudget} />,
    },
    {
      ...getColumnRender("id", "Acciones"),
      key: "idAcciones",
      width: "20%",
      align: "center",
      render: (field: number, row: EntityFragment) => <EntitiesTableActions entity={row} />,
    },
  ];

  return (
    <DataError error={error}>
      <Card
        title={<TextWithBadge text="Entidades" count={pagination.total} />}
        extra={
          <Space>
            <SearchInput
              placeholder="Buscar entidad"
              onSearch={onSearch}
              style={{ width: "25vw" }}
              value={search.searchText ?? ""}
            />
            <Divider type="vertical" />
            <ButtonAdd title="Crear Entidad" onClick={() => router.push("/config/entities/new")} />
          </Space>
        }
      >
        <Table
          dataSource={data}
          loading={loading}
          columns={columns}
          onChange={handleTableChange}
          rowKey={(record: EntityFragment) => record.id}
          pagination={pagination}
          size="small"
        />
      </Card>
    </DataError>
  );
};

export { EntitiesTable };
