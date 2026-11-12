import React, { useState, useEffect } from "react";
import { GoalsCatalogList } from "./GoalsCatalogList";
import { SearchGoalsFormatQuery } from "../../../../graphql/gen/ops";
import { SearchGoalsFormatDocument, useSearchGoalsLazyQuery } from "../../../../graphql/gen/hooks";
import { useRouter } from "next/router";
import { ExportFormat, GoalType, MonitoringStatus } from "../../../../graphql/gen/schema";
import { apolloClient } from "../../../lib/apollo";
import { useDevPlan } from "../../DevPlan/hooks";

type Props = {
  id: string;
  filters?: Record<string, string[]>;
  stage?: MonitoringStatus;
  goalTypes?: GoalType[];
};

export const GoalsCatalogListLoader: React.FC<Props> = ({
  id,
  filters: queryFilters,
  stage,
  goalTypes,
}) => {
  const router = useRouter();
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
  const { selectedDevPlanId } = useDevPlan();

  const getQueryParams = () => ({
    devPlanId: selectedDevPlanId,
    goalTypes: filters?.goalType?.length
      ? filters?.goalType
          ?.map((goalType) => goalType as GoalType)
          ?.filter((goalType) => !goalTypes || goalTypes.includes(goalType))
      : goalTypes,
    entityIds: filters?.entityId?.length ? filters?.entityId?.map((id) => parseInt(id)) : null,
    devPlanLevelIds: filters?.devPlanLevelIds?.length
      ? filters?.devPlanLevelIds?.map((id) => parseInt(id))
      : null,
    // text: filters?.text?.[0] ?? null,
    limit: pagination.pageSize,
    offset: (pagination.current - 1) * pagination.pageSize,
    sort: sorter,
  });

  const [searchGoals, { loading, data }] = useSearchGoalsLazyQuery({
    variables: {
      data: {
        ...getQueryParams(),
      },
    },
  });

  useEffect(() => {
    if (selectedDevPlanId) searchGoals();
  }, [selectedDevPlanId, filters, pagination, sorter]);

  const {
    items: goals,
    count: queryCount,
    filters: searchFilters,
  } = data?.searchGoals || { items: [], count: 0, filters: {} };

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
    setSorter({ field: sorter?.field, order: sorter?.order === "ascend" ? "asc" : "desc" });
  };

  const getDownloadUrl = async () => {
    const result = await apolloClient.query<SearchGoalsFormatQuery>({
      query: SearchGoalsFormatDocument,
      variables: {
        data: {
          ...getQueryParams(),
          format: ExportFormat.Excel,
        },
      },
      fetchPolicy: "network-only",
    });
    return result?.data?.searchGoalsFormat;
  };

  return (
    <GoalsCatalogList
      goals={goals ?? []}
      stage={stage}
      goalTypes={goalTypes}
      dataLoading={loading}
      pagination={{ ...pagination, total: count }}
      searchParams={searchParams}
      filters={filters}
      searchFilters={searchFilters}
      setSearchParams={onSetSearchParams}
      setFilters={setFilters}
      onChange={handleTableChange}
      getDownloadUrl={getDownloadUrl}
    />
  );
};
