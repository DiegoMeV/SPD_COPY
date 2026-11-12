import React from "react";
import { Card, Table } from "antd";
import { ColumnsType } from "antd/lib/table";
import { useRowSelection, useTable } from "../../hooks/useTable";
import { SiifActividadRecord, useActivities, useProjects } from "./hooks";
import { ActivitiesTableActions } from "./ActivitiesTableActions";
import { TextWithBadge } from "../Utils/TextWithBadge";
import { ButtonBack } from "../Buttons";
import { DataLoading } from "../Data/DataLoading";

type Props = {
  project: string;
};

const ActivitiesTable: React.FC<Props> = ({ project }) => {
  const { getColumnRender, handleTableChange } = useTable();
  const { rowClassName, setSelectedRowKeys } = useRowSelection();
  const { setSelectedSiifProyecto } = useProjects();
  const { loading, data, error } = useActivities({ project });

  const columns: ColumnsType<SiifActividadRecord> = [
    {
      ...getColumnRender("codigoAct", "Código"),
    },
    getColumnRender("descripcion", "Nombre Actividad"),
    {
      ...getColumnRender("id", "Acciones"),
      key: "idAcciones",
      align: "center",
      render: (id: number, row: SiifActividadRecord) => (
        <ActivitiesTableActions activity={row} onSelectRow={() => setSelectedRowKeys([`${id}`])} />
      ),
    },
  ];

  return (
    <Card
      title={<TextWithBadge text="Actividades" count={data.length} />}
      extra={<ButtonBack title="Regresar" onClick={() => setSelectedSiifProyecto(undefined)} />}
    >
      <DataLoading loading={loading} error={error}>
        <Table
          dataSource={data}
          columns={columns}
          onChange={handleTableChange}
          rowKey={(record: SiifActividadRecord) => record.id}
          size="small"
          rowClassName={rowClassName}
        />
      </DataLoading>
    </Card>
  );
};

export { ActivitiesTable };
