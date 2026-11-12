import React from "react";
import { Card, Divider, Space, Table } from "antd";
import { UserAccountFragment } from "../../../graphql/gen/ops";
import type { ColumnsType } from "antd/lib/table";
import { EntityFragment } from "../../../graphql/gen/ops";
import { ButtonAdd } from "../Buttons";
import { useRouter } from "next/router";
import { SpdRole } from "../../../graphql/gen/schema";
import { SPDRoleMap } from "../../utils/uiUtils";
import { TextWithBadge } from "../Utils/TextWithBadge";
import { ActiveStatus } from "../Utils/ActiveStatus";
import { UsersTableActions } from "./UsersTableActions";
import { TextSearch } from "../Utils/TextSearch";
import { DataError } from "../Data/DataError";
import { SearchInput } from "../Inputs/SearchInput/SearchInput";
import { useUsers } from "./hooks";
import { useEntitiesFilter } from "../../hooks/useDataFilters";

const UsersTable: React.FC = () => {
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
    enumFilters,
    commonFilters,
  } = useUsers();
  const { entitiesFilter } = useEntitiesFilter();

  const onSearch = (value: string | undefined) => {
    setSearch({ searchText: value, searchedColumn: "text" });
  };

  const columns: ColumnsType<UserAccountFragment> = [
    getColumnRender("lastName", "Apellidos", { sorter: true, highlightSearch: true }),
    getColumnRender("firstName", "Nombre", { sorter: true, highlightSearch: true }),
    getColumnRender("email", "Email", { sorter: true, highlightSearch: true, width: "10vw" }),
    getColumnRender("docNumber", "Documento", {
      sorter: true,
      highlightSearch: true,
      responsive: ["xl"],
    }),
    {
      ...getColumnRender("entity", "Entidad", { sorter: true, responsive: ["xl"] }),
      filters: entitiesFilter,
      filteredValue: filters?.entity,
      render: (entity: EntityFragment) => (
        <TextSearch
          text={entity ? `${entity.code} - ${entity.name}` : null}
          searchText={search.searchText}
        />
      ),
    },
    {
      ...getColumnRender("role", "Rol"),
      filters: enumFilters.SPDRole,
      filteredValue: filters?.role,
      render: (role: SpdRole) => (
        <TextSearch text={role ? SPDRoleMap[role]?.tag : null} searchText={search.searchText} />
      ),
    },
    {
      ...getColumnRender("isActive", "Activo"),
      filters: commonFilters.isActive,
      filteredValue: filters?.isActive,
      align: "center",
      render: (isActive: boolean) => <ActiveStatus active={isActive} />,
    },
    {
      ...getColumnRender("id", "Acciones"),
      key: "idAcciones",
      align: "center",
      render: (field: number, row: UserAccountFragment) => <UsersTableActions user={row} />,
    },
  ];

  return (
    <DataError error={error}>
      <Card
        title={<TextWithBadge text="Usuarios" count={pagination.total} />}
        extra={
          <Space>
            <SearchInput
              placeholder="Buscar usuario"
              onSearch={onSearch}
              style={{ width: "25vw" }}
              value={search.searchText ?? ""}
            />
            <Divider type="vertical" />
            <ButtonAdd title="Crear Usuario" onClick={() => router.push("/config/users/new")} />
          </Space>
        }
      >
        <Table
          dataSource={data}
          loading={loading}
          columns={columns}
          onChange={handleTableChange}
          rowKey={(record: UserAccountFragment) => record.id}
          pagination={pagination}
          size="small"
        />
      </Card>
    </DataError>
  );
};

export { UsersTable };
