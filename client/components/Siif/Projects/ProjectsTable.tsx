import React, { useRef } from "react";
import { Button, Input, Space, Table, Typography } from "antd";
import { EntityFragment } from "../../../../graphql/gen/ops";
import {
  UseFiltersProps,
  UsePaginationProps,
  useRowSelection,
  useSorter,
  UseSorterProps,
  useTable,
} from "../../../hooks/useTable";
import { ApolloError } from "@apollo/client";
import type { FilterConfirmProps } from "antd/es/table/interface";
import type { InputRef } from "antd";
import type { ColumnsType, ColumnType } from "antd/lib/table";
import { SearchOutlined } from "@ant-design/icons";
import Highlighter from "react-highlight-words";
import type { ProyectoRecord } from "./hooks";
import { useEntitiesByCodeFilter } from "../../../hooks/useDataFilters";
import { ButtonDetails } from "../../Buttons";
import { useRouter } from "next/router";
import Link from "next/link";

type Props = {
  data: ProyectoRecord[];
  loading: boolean;
  error?: ApolloError;
  pagination: UsePaginationProps;
  filters?: UseFiltersProps;
  sorter?: UseSorterProps;
  searchParams: any;
  onChange: (pagination: UsePaginationProps, filters: any, sorter: any, extra: any) => void;
  setSearchParams: (searchParams: any | ((current: any) => any)) => void;
};

type DataIndex = string;

const { Text } = Typography;

const ProjectsTable: React.FC<Props> = ({
  data,
  loading,
  error,
  pagination,
  filters,
  sorter,
  searchParams,
  onChange,
  setSearchParams,
}) => {
  const searchInput = useRef<InputRef>(null);
  const router = useRouter();

  const { getColumnRender } = useTable();
  const { entitiesByCodeFilter } = useEntitiesByCodeFilter();
  const { getColumnSortableProps } = useSorter();
  const { rowClassName, setSelectedRowKeys } = useRowSelection();

  const handleSearch = (
    selectedKeys: string[],
    confirm: (param?: FilterConfirmProps) => void,
    dataIndex: DataIndex,
  ) => {
    confirm();
    setSearchParams({
      searchText: selectedKeys[0],
      searchedColumn: dataIndex,
    });
  };

  const handleReset = (clearFilters: () => void) => {
    clearFilters();
    setSearchParams({
      searchText: "",
      searchedColumn: "",
    });
  };

  const getColumnSearchProps = (dataIndex: DataIndex): ColumnType<ProyectoRecord> => ({
    filterDropdown: ({ setSelectedKeys, selectedKeys, confirm, clearFilters, close }) => (
      <div style={{ padding: 8 }} onKeyDown={(e) => e.stopPropagation()}>
        <Input
          ref={searchInput}
          placeholder={`Search ${dataIndex}`}
          value={selectedKeys[0]}
          onChange={(e) => setSelectedKeys(e.target.value ? [e.target.value] : [])}
          onPressEnter={() => handleSearch(selectedKeys as string[], confirm, dataIndex)}
          style={{ marginBottom: 8, display: "block" }}
        />
        <Space>
          <Button
            type="primary"
            onClick={() => handleSearch(selectedKeys as string[], confirm, dataIndex)}
            icon={<SearchOutlined />}
            size="small"
            style={{ width: 90 }}
          >
            Buscar
          </Button>
          <Button
            onClick={() => clearFilters && handleReset(clearFilters)}
            size="small"
            style={{ width: 90 }}
          >
            Limpiar
          </Button>
          <Button
            type="link"
            size="small"
            onClick={() => {
              close();
            }}
          >
            Cerrar
          </Button>
        </Space>
      </div>
    ),
    filterIcon: (filtered: boolean) => (
      <SearchOutlined style={{ color: searchParams?.searchText ? "#1890ff" : undefined }} />
    ),
    onFilterDropdownOpenChange: (visible) => {
      if (visible) {
        setTimeout(() => searchInput.current?.select(), 100);
      }
    },
  });

  const columns: ColumnsType<ProyectoRecord> = [
    {
      ...getColumnRender("proyecto", "Proyecto"),
      ...getColumnSortableProps("proyecto", sorter),
      ...getColumnSearchProps("proyecto"),
      render: (proyecto: string) => (
        <>
          <Link href={`${router.pathname}/${proyecto}`}>
            <Highlighter
              highlightStyle={{ backgroundColor: "#ffc069", padding: 0 }}
              searchWords={[searchParams?.searchText]}
              autoEscape
              textToHighlight={`${proyecto}`}
            />
          </Link>
        </>
      ),
      width: 140,
    },
    {
      ...getColumnRender("nombre", "Nombre"),
      ...getColumnSortableProps("nombre", sorter),
      ...getColumnSearchProps("nombre"),
      render: (nombre: string) => (
        <>
          <Text>
            <Highlighter
              highlightStyle={{ backgroundColor: "#ffc069", padding: 0 }}
              searchWords={[searchParams?.searchText]}
              autoEscape
              textToHighlight={`${nombre}`}
            />
          </Text>
        </>
      ),
    },
    {
      ...getColumnRender("entity", "Entidad"),
      ...getColumnSortableProps("entity", sorter),
      filters: entitiesByCodeFilter,
      filteredValue: filters?.entity,
      filterSearch: true,
      render: (entity: EntityFragment) => (entity ? `${entity.name} (${entity.code})` : null),
      width: 300,
    },
    {
      ...getColumnRender("id", "Acciones"),
      key: "idAcciones",
      align: "center",
      render: (id: number, row: ProyectoRecord) => (
        <ButtonDetails
          title="Ver Proyecto"
          onClick={() => router.push(`${router.pathname}/${row.proyecto}`)}
        />
      ),
    },
  ];

  return (
    <Table
      dataSource={data}
      columns={columns}
      onChange={onChange}
      rowKey={(record: ProyectoRecord) => record.proyecto}
      pagination={pagination}
      size="small"
      rowClassName={rowClassName}
    />
  );
};

export { ProjectsTable };
