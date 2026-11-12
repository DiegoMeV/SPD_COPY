import React from "react";
import Table, { ColumnsType } from "antd/lib/table";
import { Card, Input, Tooltip, Typography } from "antd";
import { accumulationTypeMap } from "../../../utils/uiUtils";
import { AccumulationType, GoalType, MonitoringStatus } from "../../../../graphql/gen/schema";
import { Goal } from "../../../types/goal";
import { TextSearch } from "../../Utils/TextSearch";
import { useGoal, useGoalTracking } from "../hooks";
import { DataLoading } from "../../Data/DataLoading";
import { useRowSelection, useSorter, useTable } from "../../../hooks/useTable";
import { ModalLink } from "../../Utils/ModalLink";
import { GoalDetails } from "../GoalDetails/GoalDetails";
import { GoalsTrackTableActions } from "./GoalsTrackTableActions";
import { GoalsTrackTableBadges } from "./GoalsTrackTableBadges";
import { GoalStatus } from "../GoalStatus";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { useCurrentUser } from "../../Users/hooks";
import { useMonitoring } from "../../../hooks/useMonitoring";
import { useEntitiesFilter } from "../../../hooks/useDataFilters";
import { EntityFragment } from "../../../../graphql/gen/ops";
import { GoalsTableBadges } from "../GoalsTableBadges/GoalsTableBadges";

const { Link } = Typography;
const { Search } = Input;

type Props = {
  goalTypes?: GoalType[];
  stage: MonitoringStatus;
};

const GoalsTrackList: React.FC<Props> = ({ goalTypes, stage }) => {
  const { user, isValidator, isOperator, isAuditor, isAdmin } = useCurrentUser();
  const { getColumnRender, sorter, filters, pagination, handleTableChange } = useTable({
    filters: {
      ...(isOperator() || isValidator() ? { entity: [user?.entityId] } : {}),
    },
    pagination: { pageSize: 10, current: 1 },
  });
  const { getColumnSortableProps } = useSorter();
  const { data, count, countByType, loading, error, searchValue, onSearchChange } = useGoalTracking(
    {
      goalTypes,
      filters,
      pagination,
    },
  );
  const { currentGoal } = useGoal();
  const { currentMonitoring } = useMonitoringConfig();
  const { rowClassName, setSelectedRowKeys } = useRowSelection();
  const { isProjectMonitoring, isActionPlanMonitoring } = useMonitoring({ goalTypes });
  const { entitiesFilter } = useEntitiesFilter();

  console.log("GoalsTrackList", data);

  const columns: ColumnsType<Goal> = [
    {
      ...getColumnRender("code", "Código"),
      width: "8vw",
      render: (field: string, row: Goal) => (
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
    ...(!currentGoal
      ? [
          {
            ...getColumnRender("name", "Nombre"),
            render: (field: string) => <TextSearch text={field} searchText={searchValue} />,
          },
          ...(isProjectMonitoring() || isActionPlanMonitoring()
            ? []
            : [
                {
                  ...getColumnRender("indicator", "Indicador"),
                  render: (field: string) => <TextSearch text={field} searchText={searchValue} />,
                },
                {
                  ...getColumnRender("accumulationType", "Tipo de Acumulación"),
                  render: (accumulationType: AccumulationType) =>
                    accumulationType ? accumulationTypeMap[accumulationType]?.tag : null,
                },
                {
                  ...getColumnRender("baseValue", "Valor Base"),
                },
                {
                  ...getColumnRender("goalValue", "Valor Meta"),
                },
              ]),
          ...(isAuditor() || isAdmin()
            ? [
                {
                  ...getColumnRender("entity", "Entidad"),
                  ...getColumnSortableProps("entity", sorter),
                  filters: entitiesFilter,
                  filteredValue: filters?.entity,
                  filterSearch: true,
                  render: (entity: EntityFragment) =>
                    entity ? <Tooltip title={entity.name}>{entity.code}</Tooltip> : null,
                  width: "8vw",
                },
              ]
            : []),
        ]
      : []),
    {
      dataIndex: "id",
      key: "goalStatus",
      width: "6vw",
      title: "Estado",
      render: (field: number, row: Goal) => (
        <GoalStatus
          goal={row}
          monitoringConfig={currentMonitoring}
          stage={MonitoringStatus.Reporting}
        />
      ),
    },
    {
      ...getColumnRender("id", "Acciones"),
      key: "idAcciones",
      width: "6vw",
      render: (id: number, row: Goal) => (
        <GoalsTrackTableActions
          goal={row}
          onSelectRow={() => setSelectedRowKeys([`${id}`])}
          stage={stage}
        />
      ),
    },
  ];

  return (
    <DataLoading loading={loading} error={error}>
      <Card
        title={
          <>
            <span>Metas Programadas</span>
            <GoalsTableBadges data={countByType ?? []} />
          </>
        }
        styles={{
          title: {
            whiteSpace: "normal",
            wordWrap: "break-word",
            overflow: "visible",
          },
        }}
      >
        <Search style={{ marginBottom: 8 }} placeholder="Buscar" onChange={onSearchChange} />
        <Table
          dataSource={data}
          columns={columns}
          rowKey={(record: Goal) => record.id}
          rowClassName={rowClassName}
          onChange={handleTableChange}
          pagination={{ ...pagination, total: count }}
        />
      </Card>
    </DataLoading>
  );
};

export { GoalsTrackList };
