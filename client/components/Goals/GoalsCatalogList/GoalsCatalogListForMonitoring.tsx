import React, { useEffect } from "react";
import Table, { ColumnsType } from "antd/lib/table";
import { Card, Col, Input, Row, Tooltip, Typography } from "antd";
import { TextSearch } from "../../Utils/TextSearch";
import { SearchGoal } from "../../../types/goal";
import { useRowSelection, useSorter, useTable } from "../../../hooks/useTable";
import { DataError } from "../../Data/DataError";
import { useDevPlanTree } from "../../DevPlanTree/hooks";
import { ModalLink } from "../../Utils/ModalLink";
import { GoalDetails } from "../GoalDetails/GoalDetails";
import { GoalStatus } from "../GoalStatus";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { GoalType, MonitoringStatus } from "../../../../graphql/gen/schema";
import { useMonitoring } from "../../../hooks/useMonitoring";
import { GoalsTableActions } from "../GoalsForLevel/GoalsTableActions";
import { useGoalsForSchedule } from "../hooks/useGoalSchedule";
import { GoalSchedule } from "../GoalsSchedule/GoalSchedule";
import { useCurrentUser } from "../../Users/hooks";
import { useEntitiesFilter } from "../../../hooks/useDataFilters";
import { EntityFragment } from "../../../../graphql/gen/ops";
import { TextWithBadge } from "../../Utils/TextWithBadge";
import { useGoal } from "../hooks";

type Props = {
  title?: string;
  goalTypes?: GoalType[];
  stage: MonitoringStatus;
};

const { Link } = Typography;
const { Search } = Input;

const GoalsCatalogListForMonitoring: React.FC<Props> = ({ title, goalTypes, stage }) => {
  const { user, isValidator, isOperator, isAuditor, isAdmin } = useCurrentUser();
  const { getColumnRender, filters, sorter, pagination, handleTableChange } = useTable({
    filters: {
      ...(isOperator() || isValidator() ? { entity: [user?.entityId] } : {}),
    },
    pagination: { current: 1, pageSize: 10 },
  });
  const { getColumnSortableProps } = useSorter();
  const { rowClassName, setSelectedRowKeys } = useRowSelection();
  const { currentMonitoring } = useMonitoringConfig();
  const { isGoalMonitoring, getMonitoringLabels } = useMonitoring({ goalTypes });
  const { isProjectMonitoring, isActionPlanMonitoring } = useMonitoring({ goalTypes });
  const { entitiesFilter } = useEntitiesFilter();
  const { currentGoal } = useGoal();

  const { data, count, loading, error, searchValue, onSearchChange } = useGoalsForSchedule({
    goalTypes,
    filters,
    pagination,
  });

  const columns: ColumnsType<SearchGoal> = [
    {
      ...getColumnRender("code", "Código"),
      width: "10vw",
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
    {
      ...getColumnRender("name", "Nombre"),
      render: (field: string) => <TextSearch text={field} searchText={searchValue} />,
    },
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
    ...((isAuditor() || isAdmin()) && !currentGoal
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
    {
      ...getColumnRender("goalValue", "Meta"),
      width: "8vw",
      align: "right",
    },
    ...(stage
      ? ([
          {
            dataIndex: "id",
            key: "goalStatus",
            title: "Estado",
            align: "center",
            width: "5vw",
            render: (field: number, row: SearchGoal, index: number) => {
              return <GoalStatus goal={row} monitoringConfig={currentMonitoring} stage={stage} />;
            },
          },
        ] as ColumnsType<SearchGoal>)
      : []),
    {
      ...getColumnRender("id", "Acciones"),
      key: "idAcciones",
      width: "6vw",
      render: (id: number, row: SearchGoal) => (
        <GoalsTableActions
          goal={row}
          stage={stage}
          onSelectRow={() => setSelectedRowKeys([`${id}`])}
        />
      ),
    },
  ];

  const cardTitle = (title ?? isGoalMonitoring()) ? `Metas` : getMonitoringLabels().plural;

  return (
    <>
      <Row gutter={{ xs: 4, sm: 8, md: 12 }}>
        <Col span={currentGoal ? 12 : 18}>
          <Card title={<TextWithBadge text={cardTitle} count={count} />}>
            <Search style={{ marginBottom: 8 }} placeholder="Buscar" onChange={onSearchChange} />
            <div style={{ marginBottom: "10px" }} />
            <DataError error={error}>
              <Table
                dataSource={data}
                columns={columns}
                loading={loading}
                rowKey={(record: SearchGoal) => record.id}
                rowClassName={rowClassName}
                size="small"
                scroll={{ y: "81.5vh" }}
                onChange={handleTableChange}
                pagination={{ ...pagination, total: count }}
              />
            </DataError>
          </Card>
        </Col>
        <Col span={currentGoal ? 12 : 6}>
          <GoalSchedule goalTypes={goalTypes} showReturnButton={true} stage={stage} />
        </Col>
      </Row>
    </>
  );
};

export { GoalsCatalogListForMonitoring };
