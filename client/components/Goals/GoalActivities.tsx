import React from "react";
import { Collapse, Table, Typography } from "antd";
import type { ColumnsType } from "antd/lib/table";
import { Goal, SiifActividadMeta } from "../../types/goal";
import { useTable } from "../../hooks/useTable";

type Props = {
  goal: Goal;
};

const { Panel } = Collapse;
const { Text } = Typography;

export const GoalActivities: React.FC<Props> = ({ goal }) => {
  const { getColumnRender } = useTable();

  const columns: ColumnsType<SiifActividadMeta> = [
    {
      ...getColumnRender("proyecto", "Proyecto"),
    },
    {
      ...getColumnRender("codigoAct", "Actividad"),
    },
    {
      ...getColumnRender("weighting", "Ponderación"),
      align: "right",
    },
  ];

  if (!goal) return null;

  const PanelHeader = () => (
    <>
      <Text strong>Actividades </Text>
    </>
  );
  return (
    <Collapse>
      <Panel header={<PanelHeader />} key={`Goal${goal.id}`}>
        <Table
          columns={columns}
          dataSource={goal?.activities ?? []}
          rowKey={(record: SiifActividadMeta) => record.id}
        />
      </Panel>
    </Collapse>
  );
};
