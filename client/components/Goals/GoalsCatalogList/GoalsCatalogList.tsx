import React, { useState, useRef } from "react";
import { Table, Spin, Typography, Input, Space, Button, Card, Form } from "antd";
import { ColumnsType, ColumnType } from "antd/lib/table";
import type { FilterConfirmProps } from "antd/es/table/interface";
import type { InputRef } from "antd";
import { SearchOutlined } from "@ant-design/icons";
import { GoalType, MonitoringStatus } from "../../../../graphql/gen/schema";
import { goalTypeMap } from "../../../utils/uiUtils";
import { SearchGoalsQuery, DevPlanLevelFragment } from "../../../../graphql/gen/ops";
import { TextWithBadge } from "../../Utils/TextWithBadge";
import { useStoreState } from "../../../store";
import Highlighter from "react-highlight-words";
import { DevPlanTreeLoader } from "../../DevPlanTree/DevPlanTreeLoader";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faListUl as faListTree } from "@fortawesome/free-solid-svg-icons";
import { CheckedKeys } from "../../../types/common";
import _ from "lodash";
import { ButtonDownload } from "../../Buttons/ButtonDownload";
import Link from "next/link";
import { useDevPlan } from "../../DevPlan/hooks";
import { GoalNew } from "../GoalNew";
import { useMonitoring } from "../../../hooks/useMonitoring";
import { useEntitiesByCodeFilter, useEntitiesFilter } from "../../../hooks/useDataFilters";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";

type Goal = NonNullable<SearchGoalsQuery["searchGoals"]>["items"][number] & {
  text?: string;
};
type DataIndex = keyof Goal;

type Props = {
  goals: Goal[];
  dataLoading: boolean;
  pagination: any;
  searchParams: any;
  filters?: Record<string, string[]>;
  searchFilters: Record<string, Array<any> | null>;
  stage?: MonitoringStatus;
  goalTypes?: GoalType[];
  onChange: (pagination: any, filters: any, sorter: any, extra: any) => void;
  setSearchParams: (searchParams: any | ((current: any) => any)) => void;
  setFilters: React.Dispatch<React.SetStateAction<Record<string, string[]> | undefined>>;
  getDownloadUrl: () => Promise<string | null | undefined>;
};

const { Text } = Typography;

export const GoalsCatalogList: React.FC<Props> = ({
  goals,
  dataLoading,
  pagination,
  searchParams,
  filters,
  searchFilters,
  stage,
  goalTypes,
  onChange,
  setSearchParams,
  setFilters,
  getDownloadUrl,
}) => {
  const { entitiesByCodeFilter } = useEntitiesByCodeFilter();

  const [devPlanCheckedKeys, setDevPlanCheckedKeys] = useState<React.Key[]>([]);
  const [form] = Form.useForm();
  const [isGeneratingUrl, setIsGeneratingUrl] = useState<boolean>(false);
  const { selectedDevPlanId } = useDevPlan();
  const { getMonitoringLabels, isActionPlanMonitoring } = useMonitoring({ goalTypes });
  const { currentMonitoring } = useMonitoringConfig();

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

  const columns: ColumnsType<Goal> = [
    {
      title: "ID",
      dataIndex: "id",
      key: "id",
      align: "left",
      width: "5%",
      render: (field: number) => <Link href={`/goals/catalog/${field}`}> {field} </Link>,
    },
    {
      title: "Nivel Plan",
      dataIndex: "devPlanLevel",
      key: "devPlanLevel",
      render: (devPlanLevel: DevPlanLevelFragment) => (
        <>
          <Text strong>{devPlanLevel.code}</Text>
          <Text> {devPlanLevel.name}</Text>
        </>
      ),
      filterDropdown: ({ setSelectedKeys, selectedKeys, confirm, clearFilters, close }) => (
        <div style={{ padding: 8, marginRight: 10 }} onKeyDown={(e) => e.stopPropagation()}>
          <DevPlanTreeLoader
            devPlanId={currentMonitoring?.devPlanId ?? 0}
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
      title: getMonitoringLabels(goalTypes)?.singular,
      dataIndex: "code",
      key: "code",
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
          {row.name && (
            <>
              {" "}
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
    ...(isActionPlanMonitoring()
      ? []
      : [
          {
            title: "Tipo",
            dataIndex: "goalType",
            key: "goalType",
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
        ]),
    ...(isActionPlanMonitoring()
      ? [
          {
            title: "Proyecto",
            dataIndex: "projectCode",
            key: "projectCode",
          },
        ]
      : []),
    {
      title: "Entidad",
      dataIndex: "entityId",
      key: "entityId",
      filters: entitiesByCodeFilter,
      filteredValue: filters?.entity,
      render: (entityId: number, row: Goal) => (
        <>
          <Text strong>{row.entity?.code}</Text> - <Text>{row.entity?.name}</Text>
        </>
      ),
    },
  ];

  return (
    <>
      <Spin spinning={dataLoading}>
        <Card
          title={
            <TextWithBadge
              text={getMonitoringLabels(goalTypes)?.plural}
              count={pagination.total ?? 0}
              offset={[25, 10]}
            />
          }
          extra={
            <Space>
              {/* 
              //TODO: Add support for creating new goals
              <GoalNew mode="list" /> 
              */}
              <ButtonDownload
                title="Exportar a Excel"
                loading={isGeneratingUrl}
                onClick={async () => {
                  setIsGeneratingUrl(true);
                  const url = await getDownloadUrl();
                  if (url) window.location.href = url;
                  setIsGeneratingUrl(false);
                }}
              />{" "}
            </Space>
          }
        >
          <Form form={form}>
            {selectedDevPlanId && (
              <Table
                dataSource={goals}
                columns={columns}
                rowKey={(record: Goal) => record.id}
                pagination={pagination}
                onChange={onChange}
                expandable={{
                  showExpandColumn: false,
                }}
                size="small"
              />
            )}
          </Form>
        </Card>
      </Spin>
    </>
  );
};
