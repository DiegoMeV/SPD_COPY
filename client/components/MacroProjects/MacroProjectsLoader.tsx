import React, { useEffect } from "react";
import { useTable } from "../../hooks/useTable";
import { useMacroProject } from "./hooks";
import { MacroProjectsTable } from "./MacroProjectsTable";

const MacroProjectsTableLoader: React.FC = () => {
  const { pagination, sorter, search, filters, setTotal, handleTableChange } = useTable({
    pagination: { pageSize: 10 },
    sorter: { field: "lastName", order: "asc" },
    filters: {
      isActive: [true],
    },
  });
  const { loading, data, count, error } = useMacroProject({
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
    <MacroProjectsTable
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

export { MacroProjectsTableLoader };
