import React from "react";
import { Card, Table } from "antd";
import { MacroProjectFragment } from "../../../graphql/gen/ops";
import type { ColumnsType } from "antd/lib/table";
import { TextWithBadge } from "../Utils/TextWithBadge";
import {
  UseFiltersProps,
  UsePaginationProps,
  useSorter,
  UseSorterProps,
  useTable,
} from "../../hooks/useTable";
import { DataLoading } from "../Data/DataLoading";
import { ApolloError } from "@apollo/client";
import { ActiveStatus } from "../Utils/ActiveStatus";
import { MacroProjectsTableActions } from "./MacroProjectsTableActions";
import { MacroProjectNew } from "./MacroProjectNew";

type Props = {
  data: MacroProjectFragment[];
  loading: boolean;
  error?: ApolloError;
  pagination: UsePaginationProps;
  filters?: UseFiltersProps;
  sorter?: UseSorterProps;
  onChange: (pagination: UsePaginationProps, filters: any, sorter: any, extra: any) => void;
};

const MacroProjectsTable: React.FC<Props> = ({
  data,
  loading,
  error,
  pagination,
  filters,
  sorter,
  onChange,
}) => {
  const { getColumnRender } = useTable();
  const { getColumnSortableProps } = useSorter();

  const columns: ColumnsType<MacroProjectFragment> = [
    {
      ...getColumnRender("code", "Codigo"),
      ...getColumnSortableProps("code", sorter),
    },
    {
      ...getColumnRender("name", "Nombre"),
      ...getColumnSortableProps("name", sorter),
    },
    {
      ...getColumnRender("description", "Descripción"),
      ...getColumnSortableProps("description", sorter),
    },
    {
      ...getColumnRender("isActive", "Activo"),
      align: "center",
      render: (isActive: boolean) => <ActiveStatus active={isActive} />,
    },
    {
      ...getColumnRender("id", "Acciones"),
      key: "idAcciones",
      align: "center",
      render: (field: number, row: MacroProjectFragment) => (
        <MacroProjectsTableActions data={row} />
      ),
    },
  ];

  return (
    <DataLoading loading={loading} error={error}>
      <Card
        title={<TextWithBadge text="Macro proyectos" count={pagination.total} />}
        extra={<MacroProjectNew />}
      >
        <Table
          dataSource={data}
          columns={columns}
          onChange={onChange}
          rowKey={(record: MacroProjectFragment) => record.id}
          pagination={pagination}
          size="small"
        />
      </Card>
    </DataLoading>
  );
};

export { MacroProjectsTable };
