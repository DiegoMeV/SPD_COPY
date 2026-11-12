import React from "react";
import Table, { ColumnsType } from "antd/lib/table";
import { Card, Input, Typography } from "antd";
import { TextSearch } from "../../Utils/TextSearch";
import { SchedulingGoal } from "../../../types/goal";
import { useLevelGoals, usePublicPoliticGoals } from "../hooks";
import { useRowSelection, useTable } from "../../../hooks/useTable";
import { GoalsTableActions } from "./GoalsTableActions";
import { GoalsTableLegend } from "./GoalsTableLegend";
import { DataError } from "../../Data/DataError";
import { useDevPlanTree } from "../../DevPlanTree/hooks";
import { GoalNew } from "../GoalNew";
import { ModalLink } from "../../Utils/ModalLink";
import { GoalDetails } from "../GoalDetails/GoalDetails";
import { GoalStatus } from "../GoalStatus";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { MonitoringConfigUsedFor, MonitoringStatus } from "../../../../graphql/gen/schema";

type Props = {
  title?: string;
  supportScheduling?: boolean;
  onClickScheduling?: (goal: SchedulingGoal) => void;
};

const { Link } = Typography;
const { Search } = Input;

const GoalsForPublicPolitic: React.FC<Props> = ({
  title,
  supportScheduling = false,
  onClickScheduling,
}) => {
  const { getColumnRender } = useTable();
  const { rowClassName, setSelectedRowKeys } = useRowSelection();
  const { currentGoalTypeLabel } = useDevPlanTree();
  const { currentMonitoring } = useMonitoringConfig();

  const { data, loading, error, searchValue, selectedPublicPolitic, onSearchChange } =
    usePublicPoliticGoals();

  const columns: ColumnsType<SchedulingGoal> = [
    {
      ...getColumnRender("code", "Código"),
      width: 120,
      render: (field: string, row: SchedulingGoal) => (
        <ModalLink
          title="Datos acción"
          link={
            <Link style={{ margin: "0 auto", fontSize: "0.8rem" }}>
              <TextSearch text={field} searchText={searchValue} />
            </Link>
          }
        >
          <GoalDetails goal={row} />
        </ModalLink>
      ),
    },
    {
      ...getColumnRender("name", "Nombre"),
      render: (field: string) => <TextSearch text={field} searchText={searchValue} />,
    },
    {
      ...getColumnRender("indicator", "Indicador"),
      render: (field: string) => <TextSearch text={field} searchText={searchValue} />,
    },
    ...(supportScheduling
      ? [
          {
            dataIndex: "id",
            key: "goalStatus",
            title: "Estado",
            render: (field: number, row: SchedulingGoal) => (
              <GoalStatus
                goal={row}
                monitoringConfig={currentMonitoring}
                stage={MonitoringStatus.Scheduling}
              />
            ),
          },
        ]
      : []),
    {
      ...getColumnRender("id", "Acciones"),
      key: "idAcciones",
      width: 100,
      render: (id: number, row: SchedulingGoal) => (
        <GoalsTableActions
          goal={row}
          supportScheduling={supportScheduling}
          onClickScheduling={onClickScheduling}
          onSelectRow={() => setSelectedRowKeys([`${id}`])}
        />
      ),
    },
  ];

  return (
    <>
      <Card
        title={`Acciones de ${selectedPublicPolitic?.name}`}
        extra={<GoalNew usedFor={MonitoringConfigUsedFor.PublicPolitics} />}
      >
        <Search style={{ marginBottom: 8 }} placeholder="Buscar" onChange={onSearchChange} />
        <div style={{ marginBottom: "10px" }} />
        <DataError error={error}>
          <Table
            dataSource={data}
            columns={columns}
            loading={loading}
            rowKey={(record: SchedulingGoal) => record.id}
            rowClassName={rowClassName}
          />
        </DataError>
      </Card>
    </>
  );
};

export { GoalsForPublicPolitic };
