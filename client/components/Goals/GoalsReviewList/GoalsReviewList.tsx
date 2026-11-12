import React, { useEffect } from "react";
import Table, { ColumnsType } from "antd/lib/table";
import { Card, Input, Tooltip, Typography } from "antd";
import { accumulationTypeMap } from "../../../utils/uiUtils";
import { AccumulationType, GoalType, MonitoringStatus } from "../../../../graphql/gen/schema";
import { Goal } from "../../../types/goal";
import { TextSearch } from "../../Utils/TextSearch";
import { useGoal, useGoalReview } from "../hooks";
import { DataLoading } from "../../Data/DataLoading";
import { useRowSelection, useSorter, useTable } from "../../../hooks/useTable";
import { ModalLink } from "../../Utils/ModalLink";
import { GoalDetails } from "../GoalDetails/GoalDetails";
import { GoalsReviewTableActions } from "./GoalsReviewTableActions";
import { GoalStatus } from "../GoalStatus";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { TextWithBadge } from "../../Utils/TextWithBadge";
import { useCurrentUser } from "../../Users/hooks";
import { useMonitoring } from "../../../hooks/useMonitoring";
import { useEntitiesFilter } from "../../../hooks/useDataFilters";
import { EntityFragment } from "../../../../graphql/gen/ops";
import { GoalsReviewTableBadges } from "./GoalsReviewTableBadges";
import { GoalsTableBadges } from "../GoalsTableBadges/GoalsTableBadges";

type Props = {
  goalTypes?: GoalType[];
};

const { Link } = Typography;
const { Search } = Input;

const GoalsReviewList: React.FC<Props> = ({ goalTypes }) => {
  const { user, isValidator, isOperator, isAuditor, isAdmin } = useCurrentUser();
  const { getColumnRender, pagination, sorter, filters, handleTableChange, setTotal } = useTable({
    pagination: { pageSize: 10 },
    filters: {
      ...(isOperator() || isValidator() ? { entity: [user?.entityId] } : {}),
    },
  });
  const { getColumnSortableProps } = useSorter();
  const { data, loading, error, searchValue, onSearchChange, count, countByType } = useGoalReview({
    pagination,
    goalTypes,
    filters,
  });
  const { currentGoal } = useGoal();
  const { rowClassName, setSelectedRowKeys } = useRowSelection();
  const { currentMonitoring } = useMonitoringConfig();
  const { isProjectMonitoring, isActionPlanMonitoring } = useMonitoring({ goalTypes });
  const { entitiesFilter } = useEntitiesFilter();

  useEffect(() => {
    setTotal(count ?? 0);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [count]);

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
      title: "Estado",
      render: (field: number, row: Goal) => (
        <GoalStatus
          goal={row}
          monitoringConfig={currentMonitoring}
          stage={MonitoringStatus.Reviewing}
        />
      ),
    },
    {
      ...getColumnRender("id", "Acciones"),
      key: "idAcciones",
      width: 100,
      render: (id: number, row: Goal) => (
        <GoalsReviewTableActions
          goal={row}
          onSelectRow={() => setSelectedRowKeys([`${id}`])}
          stage={MonitoringStatus.Reviewing}
        />
      ),
    },
  ];

  return (
    <DataLoading loading={loading} error={error}>
      <Card
        title={
          <>
            <span>Metas Validadas</span>
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
          pagination={{ ...pagination, total: count }}
          onChange={handleTableChange}
        />
      </Card>
    </DataLoading>
  );
};

export { GoalsReviewList };
