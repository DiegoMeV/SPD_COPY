import React, { useState, useEffect, useMemo } from "react";
import { DashboardGoals } from "./DashboardGoals";
import { DashboardGoalsFormatQuery } from "../../../../graphql/gen/ops";
import { DashboardGoalsFormatDocument, useSearchGoalsQuery } from "../../../../graphql/gen/hooks";
import { useRouter } from "next/router";
import {
  ExportFormat,
  GoalType,
  MonitoringRecordStatus,
  MonitoringResourcesOrigin,
} from "../../../../graphql/gen/schema";
import { apolloClient } from "../../../lib/apollo";
import { Form } from "antd";
import { useMonitoringConfig } from "../../MonitoringConfig/hooks";
import { SearchGoalItem } from "../../../types/goal";

type Props = {
  id: string;
  filters?: Record<string, string[]>;
};

const layout = {
  labelCol: { span: 4 },
  wrapperCol: { span: 8 },
};

export const DashboardGoalsLoader: React.FC<Props> = ({ id, filters: queryFilters }) => {
  const router = useRouter();
  const [form] = Form.useForm();
  const { currentMonitoring } = useMonitoringConfig();

  const [count, setCount] = useState(0);
  const [pagination, setPagination] = useState({
    current: 1,
    pageSize: 20,
  });
  const [filters, setFilters] = useState(queryFilters);
  const [sorter, setSorter] = useState<{ order: string | undefined; field: string | undefined }>({
    field: "id",
    order: "asc",
  });
  const [searchParams, setSearchParams] = useState({
    searchText: queryFilters?.entities?.[0] || "",
    searchedColumn: queryFilters?.domain ? "entityName" : "",
  });
  const [selectedDevPlanId, setSelectedDevPlanId] = useState<number>();
  const goalTypes = useMemo(() => {
    return filters?.goalType?.length
      ? filters?.goalType?.map((goalType) => goalType as GoalType)
      : undefined;
  }, [filters?.goalType]);

  const getQueryParams = () => ({
    devPlanId: selectedDevPlanId,
    goalTypes,
    entityIds: filters?.entityId?.length ? filters?.entityId?.map((id) => parseInt(id)) : undefined,
    monitoringConfigId: currentMonitoring?.id,
    isReported: true,
    text: filters?.text?.[0] ?? undefined,
    limit: pagination.pageSize,
    offset: (pagination.current - 1) * pagination.pageSize,
    sort: sorter,
  });

  const { loading, data } = useSearchGoalsQuery({
    variables: {
      data: {
        ...getQueryParams(),
      },
    },
    fetchPolicy: "network-only",
  });

  const {
    items: goals,
    count: queryCount,
    countByType,
    filters: searchFilters,
  } = data?.searchGoals || { items: [], count: 0, countByType: [], filters: {} };

  useEffect(() => {
    setCount(queryCount ?? 0);
  }, [queryCount]);

  useEffect(() => {
    // Join the current query params with new filters
    router.query = {
      ...router.query,
      ...(filters
        ? Object.fromEntries(
            Object.entries(filters).map(([k, v]) => [
              `${id}${k[0].toUpperCase()}${k.substring(1)}`,
              v,
            ]),
          )
        : {}),
    };
    router.push(router, undefined, { shallow: true });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [filters]);

  const goalsData = useMemo(() => {
    const searchValue = filters?.text?.[0] ?? undefined;
    const containsStr = (text: string | null = "", searchText: string | null = "") =>
      (text ?? "").toLocaleLowerCase().indexOf((searchText ?? "").toLocaleLowerCase()) > -1;
    const isReviewed = (goal: SearchGoalItem): boolean => {
      return (goal.monitoringRecords ?? []).some(
        (record) =>
          record.monitoringConfigId === currentMonitoring?.id &&
          record.recordStatus === MonitoringRecordStatus.Reviewed,
      );
    };
    return data?.searchGoals?.items
      ?.filter((goal) => {
        const resourcesRecords = goal?.tracking?.find(
          (trackingRecord) =>
            [
              MonitoringRecordStatus.Reported,
              MonitoringRecordStatus.Validated,
              MonitoringRecordStatus.Reviewed,
              MonitoringRecordStatus.Rejected,
            ].includes(trackingRecord.recordStatus) &&
            trackingRecord.monitoringConfigId === currentMonitoring?.id,
        )?.resources;
        return (
          (resourcesRecords?.length ?? 0) >=
          (currentMonitoring?.monitoringResourcesOrigin ===
          MonitoringResourcesOrigin.UserAndFinancial
            ? 2
            : 1)
        );
      })
      ?.filter(
        (goal) =>
          containsStr(goal.code, searchValue) ||
          containsStr(goal.name, searchValue) ||
          containsStr(goal.indicator, searchValue),
      )
      ?.filter((goal) => {
        return isReviewed(goal);
      })
      ?.map((goal) => {
        const { children, ...goalData } = goal;
        return {
          ...goalData,
          ...(children?.length
            ? {
                children: children.filter((goal) => {
                  return isReviewed(goal);
                }),
              }
            : {}),
        };
      });
  }, [
    data?.searchGoals?.items,
    filters?.text?.[0],
    currentMonitoring?.monitoringResourcesOrigin,
    currentMonitoring?.id,
  ]);

  const onSetSearchParams = (searchParams: { searchText: string; searchedColumn: string }) => {
    setSearchParams(searchParams);
    setFilters((currentFilters) => ({
      ...currentFilters,
      ...(searchParams.searchedColumn
        ? { [searchParams.searchedColumn]: [searchParams.searchText] }
        : {}),
    }));
  };

  const handleTableChange = (pagination: any, newFilters: any, sorter: any, extra: any) => {
    setPagination((currentPagination) => ({ ...currentPagination, ...pagination }));
    setFilters({
      ...newFilters,
      devPlanLevelIds: filters?.devPlanLevelIds,
      ...(searchParams.searchedColumn
        ? { [searchParams.searchedColumn]: [searchParams.searchText] }
        : {}),
    });
    setSorter({
      field: sorter?.field ?? "id",
      order: sorter?.order === "descend" ? "desc" : "asc",
    });
  };

  const getDownloadUrl = async () => {
    const result = await apolloClient.query<DashboardGoalsFormatQuery>({
      query: DashboardGoalsFormatDocument,
      variables: {
        data: {
          ...getQueryParams(),
          format: ExportFormat.Excel,
        },
      },
      fetchPolicy: "network-only",
    });
    return result?.data?.dashboardGoalsFormat;
  };

  return (
    <Form form={form} initialValues={{ devPlanId: selectedDevPlanId }} {...layout}>
      <DashboardGoals
        goals={goalsData ?? []}
        dataLoading={loading}
        pagination={{ ...pagination, total: count }}
        searchParams={searchParams}
        filters={filters}
        searchFilters={searchFilters}
        selectedDevPlanId={selectedDevPlanId}
        setSelectedDevPlanId={setSelectedDevPlanId}
        setSearchParams={onSetSearchParams}
        setFilters={setFilters}
        onChange={handleTableChange}
        getDownloadUrl={getDownloadUrl}
        form={form}
        goalTypes={goalTypes}
        countByType={countByType}
      />
    </Form>
  );
};
