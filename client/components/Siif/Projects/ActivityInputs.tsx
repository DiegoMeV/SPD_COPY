import React from "react";
import { ProyectoRecord } from "./hooks";
import type { ColumnsType } from "antd/lib/table";
import { useTable } from "../../../hooks/useTable";
import { Table } from "antd";
import { str2Money } from "../../../utils/formatUtils";

type ActivityType = NonNullable<ProyectoRecord["actividades"]>[number];
type InputType = NonNullable<ActivityType["insumos"]>[number];

type Props = {
  activity: NonNullable<ProyectoRecord["actividades"]>[number];
  initialYear?: string | null;
  endYear?: string | null;
};

const ActivityInputs: React.FC<Props> = ({ activity, initialYear, endYear }) => {
  const { getColumnRender } = useTable();
  const firstYear = parseInt(initialYear ?? "2020");
  const lastYear = parseInt(endYear ?? "2030");

  const columns: ColumnsType<InputType> = [
    {
      ...getColumnRender("tipoInsumo", "Insumo"),
      fixed: "left",
      width: lastYear - firstYear > 3 ? 200 : "100%",
      render: (field: string, row: InputType) => (
        <span>
          {field} - {row.nombreSubtipo}
        </span>
      ),
    },
  ];
  for (let year = firstYear; year <= lastYear; year++) {
    columns.push({
      ...getColumnRender(`valor${year}`, `${year}`),
      render: (field: string) => str2Money(field ?? "0"),
      align: "right",
    });
  }
  columns.push({
    ...getColumnRender("valorTotal", "Total"),
    render: (field: string) => str2Money(field ?? "0"),
    align: "right",
    fixed: "right",
  });

  return (
    <div>
      <Table
        dataSource={activity?.insumos ?? []}
        columns={columns}
        size="small"
        rowKey={(record: InputType) => record.id}
        scroll={{ x: "max-content" }}
        bordered
      />
    </div>
  );
};

export { ActivityInputs };
