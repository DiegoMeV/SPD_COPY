import React, { useState, useEffect } from "react";
import { SearchProductIndicatorsDocument } from "../../../graphql/gen/hooks";
import { SearchProductIndicatorsQuery } from "../../../graphql/gen/ops";
import { useQuery } from "@apollo/client";
import { ProductCatalog } from "./ProductCatalog";

const ProductCatalogLoader: React.FC = () => {
  const [pagination, setPagination] = useState({
    current: 1,
    pageSize: 50,
  });
  const [count, setCount] = useState(0);
  const [sorter, setSorter] = useState<{ order: string | undefined; field: string | undefined }>({
    field: "code",
    order: "asc",
  });
  const [searchParams, setSearchParams] = useState({
    searchText: "",
    searchedColumn: "",
  });

  const { loading, data, error } = useQuery<SearchProductIndicatorsQuery>(
    SearchProductIndicatorsDocument,
    {
      variables: {
        data: {
          ...(searchParams.searchedColumn
            ? { [searchParams.searchedColumn]: searchParams.searchText }
            : {}),
          limit: pagination.pageSize,
          offset: (pagination.current - 1) * pagination.pageSize,
          sort: sorter,
        },
      },
      fetchPolicy: "cache-and-network",
    },
  );

  const { items, count: queryCount } = data?.searchProductIndicators || {
    items: [],
    count: 0,
  };

  useEffect(() => {
    if (queryCount) setCount(queryCount);
  }, [queryCount]);

  const onSetSearchParams = (searchParams: { searchText: string; searchedColumn: string }) => {
    setSearchParams(searchParams);
  };

  const handleTableChange = (pagination: any, filters: any, sorter: any, extra: any) => {
    setPagination((currentPagination) => ({ ...currentPagination, ...pagination }));
    setSorter({ field: sorter?.field, order: sorter?.order === "ascend" ? "asc" : "desc" });
  };

  return (
    <ProductCatalog
      data={items}
      loading={loading}
      error={error}
      pagination={{ ...pagination, total: count }}
      searchParams={searchParams}
      sorter={sorter}
      setSearchParams={onSetSearchParams}
      onChange={handleTableChange}
    />
  );
};

export { ProductCatalogLoader };
