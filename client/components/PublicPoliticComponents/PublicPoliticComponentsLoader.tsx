import React, { useEffect } from "react";
import { useTable } from "../../hooks/useTable";
import { usePublicPoliticComponent } from "./hooks";
import { PublicPoliticComponentsTable } from "./PublicPoliticComponentsTable";

const PublicPoliticComponentsTableLoader: React.FC = () => {
  const { pagination, sorter, search, filters, setTotal, handleTableChange } = useTable({
    pagination: { pageSize: 10 },
    sorter: { field: "lastName", order: "asc" },
    filters: {
      isActive: [true],
    },
  });
  const { loading, data, count, error } = usePublicPoliticComponent({
    pagination,
    sorter,
    search,
    filters,
  });

  useEffect(() => {
    setTotal(count);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [count]);

  return (
    <PublicPoliticComponentsTable
      data={data}
      loading={loading}
      error={error}
      pagination={{ ...pagination }}
      filters={{ ...filters }}
      sorter={sorter}
      onChange={handleTableChange}
    />
  );
};

export { PublicPoliticComponentsTableLoader };
