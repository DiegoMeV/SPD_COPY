import React, { useState, useRef } from "react";
import { Table, Spin, Typography, Input, Space, Button, Card, Progress } from "antd";
import { ColumnsType, ColumnType } from "antd/lib/table";
import type { FilterConfirmProps } from "antd/es/table/interface";
import type { FormInstance, InputRef } from "antd";
import { SearchOutlined } from "@ant-design/icons";
import {
  AccumulationType,
  GoalType,
  MonitoringResourceType,
  MonitoringStatus,
  SpdRole,
  SpentDoc,
} from "../../../../graphql/gen/schema";
import { accumulationTypeMap, goalTypeMap, spentDocMap } from "../../../utils/uiUtils";
import { DevPlanLevelFragment, GoalTypeCountFragment } from "../../../../graphql/gen/ops";
import { TextWithBadge } from "../../Utils/TextWithBadge";
import Highlighter from "react-highlight-words";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faListUl as faListTree } from "@fortawesome/free-solid-svg-icons";
import { CheckedKeys } from "../../../types/common";
import _ from "lodash";
import { ButtonDownload } from "../../Buttons/ButtonDownload";
import { useEntities } from "../../Entities/hooks";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { num2Money } from "../../../utils/formatUtils";
import { useGoal, useGoalIndicators } from "../../Goals/hooks";
import { useTable } from "../../../hooks/useTable";
import { useCurrentUser } from "../../Users/hooks";
import { GoalStatus } from "../../Goals/GoalStatus";
import { ModalLink } from "../../Utils/ModalLink";
import { GoalTrackDetails } from "../../Goals/GoalTrackDetails/GoalTrackDetails";
import { DevPlanTreeLoader } from "../../DevPlanTree/DevPlanTreeLoader";
import { GoalsTableBadges } from "../../Goals/GoalsTableBadges/GoalsTableBadges";
import { SearchGoal } from "../../../types/goal";
import { useMonitoring } from "../../../hooks/useMonitoring";

type Goal = SearchGoal & {
  text?: string;
};
type DataIndex = keyof Goal;

type Props = {
  form: FormInstance<any>;
  goals: Goal[];
  dataLoading: boolean;
  pagination: any;
  searchParams: any;
  filters?: Record<string, string[]>;
  searchFilters: Record<string, Array<any> | null>;
  selectedDevPlanId?: number;
  goalTypes?: GoalType[];
  countByType?: GoalTypeCountFragment[];
  setSelectedDevPlanId: (selectedDevPlanId: number) => void;
  onChange: (pagination: any, filters: any, sorter: any, extra: any) => void;
  setSearchParams: (searchParams: any | ((current: any) => any)) => void;
  setFilters: React.Dispatch<React.SetStateAction<Record<string, string[]> | undefined>>;
  getDownloadUrl: () => Promise<string | null | undefined>;
};

const { Link, Text } = Typography;

export const DashboardGoals: React.FC<Props> = ({
  goals,
  dataLoading,
  pagination,
  searchParams,
  filters,
  searchFilters,
  selectedDevPlanId,
  form,
  goalTypes,
  countByType = [],
  setSelectedDevPlanId,
  onChange,
  setSearchParams,
  setFilters,
  getDownloadUrl,
}) => {
  const { data: entities } = useEntities();
  const [devPlanCheckedKeys, setDevPlanCheckedKeys] = useState<React.Key[]>([]);
  const [isGeneratingUrl, setIsGeneratingUrl] = useState<boolean>(false);
  const { currentMonitoring } = useMonitoringConfig();
  const { getFinancialIndicator, getPhysicalIndicator } = useGoalIndicators();
  const { getColumnRender } = useTable();
  const { user } = useCurrentUser();
  const { setCurrentGoal } = useGoal();
  const { isActionPlanMonitoring, isGoalMonitoring } = useMonitoring({ goalTypes });

  const searchInput = useRef<InputRef>(null);

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

  const handleDevPlanFilter = (confirm: (param?: FilterConfirmProps) => void) => {
    confirm();
    setFilters((currentFilters) => ({
      ...currentFilters,
      devPlanLevelIds: devPlanCheckedKeys.map((key) => `${key}`),
    }));
  };

  const handleReset = (clearFilters: () => void) => {
    clearFilters();
    setSearchParams({
      searchText: "",
      searchedColumn: "",
    });
  };

  const getColumnSearchProps = (dataIndex: DataIndex): ColumnType<Goal> => ({
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

  const entitiesFilter = entities?.map((entity) => {
    const count =
      (searchFilters?.entityId || []).find(
        (entityFilter: { value: string; count: number }) => entityFilter.value === `${entity.id}`,
      )?.count ?? 0;
    return { ...entity, count };
  });
  const columns: ColumnsType<Goal> = [
    {
      title: "ID",
      dataIndex: "id",
      key: "id",
      align: "left",
      width: "6vw",
      fixed: "left",
      render: (field: number, row: Goal) => (
        <ModalLink
          title="Seguimiento Meta"
          link={<Link style={{ margin: "0 auto", fontSize: "0.8rem" }}>{field}</Link>}
          preLoad={() => setCurrentGoal(row)}
        >
          <GoalTrackDetails />
        </ModalLink>
      ),
    },
    {
      title: "Meta",
      dataIndex: "code",
      key: "code",
      fixed: "left",
      width: 300,
      render: (code: string, row: Goal) => (
        <>
          <Text strong>
            <Highlighter
              highlightStyle={{ backgroundColor: "#ffc069", padding: 0 }}
              searchWords={[searchParams?.searchText]}
              autoEscape
              textToHighlight={`${row.code}`}
            />
          </Text>
          {!isActionPlanMonitoring() && (
            <>
              {" - "}
              <Text>
                <Highlighter
                  highlightStyle={{ backgroundColor: "#ffc069", padding: 0 }}
                  searchWords={[searchParams?.searchText]}
                  autoEscape
                  textToHighlight={`${row.name}`}
                />
              </Text>
            </>
          )}
        </>
      ),
      ...getColumnSearchProps("text"),
    },
    {
      dataIndex: "id",
      key: "goalStatus",
      title: "Estado",
      fixed: "left",
      width: 100,
      render: (field: number, row: Goal) => (
        <GoalStatus
          goal={row}
          monitoringConfig={currentMonitoring}
          stage={MonitoringStatus.Reviewing}
        />
      ),
    },
    {
      title: "Entidad",
      dataIndex: "entityId",
      key: "entityId",
      width: 200,
      ...(user?.role === SpdRole.Admin || user?.role === SpdRole.Auditor
        ? {
            filters: entitiesFilter?.map((entity) => ({
              text: <TextWithBadge count={entity.count} text={entity.name} type="filter" />,
              value: entity.id,
            })),
            filteredValue: filters?.entityId,
          }
        : {}),
      render: (entityId: number, row: Goal) => (
        <>
          <Text strong>{row.entity?.code}</Text> - <Text>{row.entity?.name}</Text>
        </>
      ),
    },
    {
      title: "Nivel Plan",
      dataIndex: "devPlanLevel",
      key: "devPlanLevel",
      width: 200,
      render: (devPlanLevel: DevPlanLevelFragment) => (
        <>
          <Text strong>{devPlanLevel.code}</Text> - <Text>{devPlanLevel.name}</Text>
        </>
      ),
      filterDropdown: ({ setSelectedKeys, selectedKeys, confirm, clearFilters, close }) => (
        <div style={{ padding: 8, marginRight: 10 }} onKeyDown={(e) => e.stopPropagation()}>
          <DevPlanTreeLoader
            devPlanId={2}
            treeMode="filter"
            pOnClose={close}
            pCheckedKeys={devPlanCheckedKeys}
            pOnClear={() => {
              setDevPlanCheckedKeys([]);
              handleDevPlanFilter(confirm);
            }}
            pOnFilter={() => {
              handleDevPlanFilter(confirm);
            }}
            pSetCheckedKeys={(checkedKeys: CheckedKeys) => {
              if (Array.isArray(checkedKeys)) {
                setDevPlanCheckedKeys(checkedKeys);
              } else {
                setDevPlanCheckedKeys(checkedKeys?.checked);
              }
            }}
            goalTypes={goalTypes ?? []}
          />
        </div>
      ),
      filterIcon: (filtered: boolean) => (
        <FontAwesomeIcon
          icon={faListTree}
          style={{ color: filters?.devPlanLevelIds?.length ? "#1890ff" : "undefined" }}
        />
      ),
    },
    {
      title: "Tipo",
      dataIndex: "goalType",
      key: "goalType",
      width: 120,
      filters: (searchFilters?.goalType || []).map(
        (goalFilter: { value: string; count: number }) => ({
          text: (
            <TextWithBadge
              count={goalFilter.count}
              text={goalTypeMap[goalFilter.value as GoalType]?.tag}
              type="filter"
              width={100}
            />
          ),
          value: goalFilter.value,
        }),
      ),
      filteredValue: filters?.goalType,
      render: (goalType: GoalType) => goalTypeMap[goalType]?.tag,
    },
    ...(isGoalMonitoring()
      ? [
          {
            ...getColumnRender("accumulationType", "Tipo de Acumulación"),
            width: 130,
            render: (accumulationType: AccumulationType) =>
              accumulationType ? accumulationTypeMap[accumulationType]?.tag : null,
          },
          {
            ...getColumnRender("baseValue", "Valor Base"),
            width: 120,
            align: "right",
          },
          {
            ...getColumnRender("goalValue", "Valor Meta"),
            width: 120,
            align: "right",
          },
        ]
      : []),
    {
      title: "Programado Periodo",
      dataIndex: "monitoringRecords",
      key: "scheduledGoal",
      align: "right",
      width: 120,
      // fixed: "right",
      render: (monitoringRecords: Goal["monitoringRecords"]) => {
        const scheduledRecord = monitoringRecords?.find(
          (monitoringRecord) => monitoringRecord.monitoringConfigId === currentMonitoring?.id,
        );
        return scheduledRecord ? `${scheduledRecord?.goalValue}` : null;
      },
    },
    {
      title: "Ejecutado Periodo",
      dataIndex: "monitoringRecords",
      key: "trackedGoal",
      align: "right",
      width: 120,
      // fixed: "right",
      render: (monitoringRecords: Goal["monitoringRecords"]) => {
        const scheduledRecord = monitoringRecords?.find(
          (monitoringRecord) => monitoringRecord.monitoringConfigId === currentMonitoring?.id,
        );
        return scheduledRecord ? `${scheduledRecord?.goalAchievedValue}` : null;
      },
    },
    {
      title: "Apropiado",
      dataIndex: "schedule",
      key: "scheduledResources",
      align: "right",
      width: "10vw",
      // fixed: "right",
      render: (schedule: Goal["schedule"]) => {
        const scheduledResources = schedule
          ?.find(
            (monitoringRecord) => monitoringRecord.monitoringConfigId === currentMonitoring?.id,
          )
          ?.resources?.find(
            (resourceRecord) => resourceRecord.resourceType === MonitoringResourceType.Definitive,
          );
        return scheduledResources ? num2Money(scheduledResources?.resourcesTotal) : null;
      },
    },
    {
      title: "Compromisos",
      dataIndex: "tracking",
      key: "trackingCompromisos",
      align: "right",
      width: "10vw",
      // fixed: "right",
      render: (tracking: Goal["tracking"]) => {
        const trackingdResources = tracking
          ?.find(
            (monitoringRecord) => monitoringRecord.monitoringConfigId === currentMonitoring?.id,
          )
          ?.resources?.find(
            (resourceRecord) => resourceRecord.resourceType === MonitoringResourceType.Commitment,
          );
        return trackingdResources ? num2Money(trackingdResources?.resourcesTotal) : null;
      },
    },
    {
      title: "Obligaciones",
      dataIndex: "tracking",
      key: "trackingObligaciones",
      align: "right",
      width: "10vw",
      // fixed: "right",
      render: (tracking: Goal["tracking"]) => {
        const trackingdResources = tracking
          ?.find(
            (monitoringRecord) => monitoringRecord.monitoringConfigId === currentMonitoring?.id,
          )
          ?.resources?.find(
            (resourceRecord) => resourceRecord.resourceType === MonitoringResourceType.Obligation,
          );
        return trackingdResources ? num2Money(trackingdResources?.resourcesTotal) : null;
      },
    },
    {
      title: "Avance Físico",
      dataIndex: "id",
      key: "physicalIndicator",
      width: 120,
      fixed: "right",
      align: "center",
      render: (field: number, row: Goal) => {
        if (!currentMonitoring) return null;
        const { percent, color } = getPhysicalIndicator(row, currentMonitoring);
        if (percent === undefined) return null;
        return (
          <Progress
            percent={percent}
            size="small"
            type="dashboard"
            format={(percent) => `${percent}%`}
            {...(color ? { strokeColor: color } : {})}
          />
        );
      },
    },
    {
      title: `Avance Financiero - ${
        spentDocMap[(filters?.spentDoc?.[0] ?? SpentDoc.Commitment) as SpentDoc]?.tag
      }`,
      dataIndex: "id",
      key: "spentDoc",
      width: 120,
      fixed: "right",
      align: "center",
      filters: (currentMonitoring?.spentDocs || []).map((spentDoc) => ({
        text: spentDocMap[spentDoc]?.tag,
        value: spentDoc,
      })),
      filteredValue: filters?.spentDoc,
      filterMultiple: false,
      render: (field: number, row: Goal) => {
        if (!currentMonitoring) return null;
        const spentDoc = (filters?.spentDoc?.[0] ?? SpentDoc.Commitment) as SpentDoc;
        const { percent, color } = getFinancialIndicator(
          row,
          currentMonitoring,
          (filters?.spentDoc?.[0] ?? SpentDoc.Commitment) as MonitoringResourceType,
        );
        if (percent === undefined) return null;
        return (
          <Progress
            percent={percent}
            size="small"
            type="dashboard"
            format={(percent) => `${percent}%`}
            {...(color ? { strokeColor: color } : {})}
          />
        );
      },
    },
  ] as ColumnsType<Goal>;

  return (
    <Spin spinning={dataLoading}>
      <Card
        title={
          <>
            <span>Avance de Metas</span>
            <GoalsTableBadges data={countByType ?? []} />
          </>
        }
        extra={
          <Space>
            <ButtonDownload
              title="Exportar a Excel"
              loading={isGeneratingUrl}
              onClick={async () => {
                setIsGeneratingUrl(true);
                const url = await getDownloadUrl();
                if (url) window.location.href = url;
                setIsGeneratingUrl(false);
              }}
            />
          </Space>
        }
      >
        <Table
          dataSource={goals}
          columns={columns}
          rowKey={(record: Goal) => record.id}
          pagination={pagination}
          onChange={onChange}
          size="small"
          scroll={{ x: 1200 }}
        />
      </Card>
    </Spin>
  );
};
