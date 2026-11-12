import React from "react";
import Table, { ColumnsType } from "antd/lib/table";
import { Card, Input, Typography } from "antd";
import { TextSearch } from "../../Utils/TextSearch";
import { SearchGoal } from "../../../types/goal";
import { useLevelGoals } from "../hooks";
import { useRowSelection, useTable } from "../../../hooks/useTable";
import { GoalsTableActions } from "./GoalsTableActions";
import { DataError } from "../../Data/DataError";
import { useDevPlanTree } from "../../DevPlanTree/hooks";
import { GoalNew } from "../GoalNew";
import { ModalLink } from "../../Utils/ModalLink";
import { GoalDetails } from "../GoalDetails/GoalDetails";
import { GoalStatus } from "../GoalStatus";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { GoalType, MonitoringStatus } from "../../../../graphql/gen/schema";
import { useMonitoring } from "../../../hooks/useMonitoring";

type Props = {
  title?: string;
  supportScheduling?: boolean;
  goalTypes?: GoalType[];
  stage: MonitoringStatus;
  onClickScheduling?: (goal: SearchGoal) => void;
};

const { Link } = Typography;
const { Search } = Input;

const GoalsForLevel: React.FC<Props> = ({
  title,
  supportScheduling = false,
  goalTypes,
  stage,
  onClickScheduling,
}) => {
  const { getColumnRender } = useTable();
  const { rowClassName, setSelectedRowKeys } = useRowSelection();
  const { currentGoalTypeLabel, isGoalLevel } = useDevPlanTree();
  const { currentMonitoring } = useMonitoringConfig();
  const {
    isProjectMonitoring,
    isActionPlanMonitoring,
    isActionPlanActivityMonitoring,
    isGoalMonitoring,
    getMonitoringLabels,
  } = useMonitoring({
    goalTypes,
  });

  const { data, loading, error, searchValue, onSearchChange } = useLevelGoals({ goalTypes });

  const columns: ColumnsType<SearchGoal> = [
    {
      ...getColumnRender("code", "Código"),
      width: 200,
      render: (field: string, row: SearchGoal) => (
        <ModalLink
          title="Datos Meta"
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
    ...(isActionPlanMonitoring()
      ? [
          {
            title: "Proyecto",
            dataIndex: "projectCode",
            key: "projectCode",
          },
        ]
      : []),
    // ...(isActionPlanMonitoring() || isActionPlanActivityMonitoring()
    //   ? []
    //   : [
    {
      ...getColumnRender("name", "Nombre"),
      render: (field: string) => <TextSearch text={field} searchText={searchValue} />,
    },
    // ]),
    ...(isProjectMonitoring() || isActionPlanMonitoring()
      ? []
      : ([
          {
            ...getColumnRender("indicator", "Indicador"),
            render: (field: string) => <TextSearch text={field} searchText={searchValue} />,
          },
          {
            ...getColumnRender("baseValue", "Línea Base"),
            align: "right",
          },
        ] as ColumnsType<SearchGoal>)),

    ...(isActionPlanMonitoring()
      ? []
      : ([
          {
            ...getColumnRender("goalValue", "Meta"),
            align: "right",
          },
        ] as ColumnsType<SearchGoal>)),
    ...(supportScheduling
      ? [
          {
            dataIndex: "id",
            key: "goalStatus",
            title: "Estado",
            width: "12%",
            align: "center",
            render: (field: number, row: SearchGoal, index: number) => {
              return (
                <GoalStatus
                  goal={row}
                  monitoringConfig={currentMonitoring}
                  stage={MonitoringStatus.Scheduling}
                />
              );
            },
          },
        ]
      : []),
    ...([
      MonitoringStatus.Created,
      MonitoringStatus.Scheduling,
      MonitoringStatus.Reporting,
    ].includes(stage)
      ? [
          {
            ...getColumnRender("id", "Acciones"),
            key: "idAcciones",
            width: "12%",
            render: (id: number, row: SearchGoal) => (
              <GoalsTableActions
                goal={row}
                stage={stage}
                onSelectRow={() => setSelectedRowKeys([`${id}`])}
              />
            ),
          },
        ]
      : []),
  ] as ColumnsType<SearchGoal>;

  return (
    <>
      {isGoalLevel && (
        <Card
          title={
            (title ?? isGoalMonitoring())
              ? `Metas de ${currentGoalTypeLabel}`
              : getMonitoringLabels().plural
          }
          extra={<GoalNew goalTypes={goalTypes} />}
        >
          <Search style={{ marginBottom: 8 }} placeholder="Buscar" onChange={onSearchChange} />
          <div style={{ marginBottom: "10px" }} />
          <DataError error={error}>
            <Table
              dataSource={data}
              columns={columns}
              loading={loading}
              rowKey={(record: SearchGoal) => record.id}
              rowClassName={rowClassName}
              // Workaround to hide children for action plans when creating them.
              // Might be needed when tracking or scheduling.
              expandable={{
                childrenColumnName: stage === MonitoringStatus.Created ? "_children_" : "children",
              }}
            />
          </DataError>
        </Card>
      )}
    </>
  );
};

export { GoalsForLevel };
