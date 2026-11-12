import { SortOrder } from "antd/es/table/interface";
import { useState } from "react";
import { SpdRole } from "../../graphql/gen/schema";
import { useEntities } from "../components/Entities/hooks";
import { DEFAULT_PAGE_SIZE } from "../const";
import { SPDRoleCollection, SPDRoleMap } from "../utils/uiUtils";
import { TextSearch } from "../components/Utils/TextSearch";
import { Breakpoint, Typography } from "antd";
import { dateFromStr } from "../utils/formatUtils";

const { Text } = Typography;

export type UsePaginationProps = {
  pageSize?: number;
  current?: number;
  total?: number;
};

export type UseSorterProps = {
  field?: string;
  order?: "asc" | "desc";
};

export type UseSearchProps = {
  searchedColumn?: string;
  searchText?: string;
};

export type UseFiltersProps = Record<string, any>;

export type UseTableProps = {
  pagination?: UsePaginationProps;
  sorter?: UseSorterProps;
  search?: UseSearchProps;
  filters?: UseFiltersProps;
};

export type UseRowSelectionProps = {
  multiple?: boolean;
};

export type ColumnRenderConfig = {
  sorter?: boolean;
  highlightSearch?: boolean;
  responsive?: Breakpoint[];
  width?: number | string;
  renderFormat?: "date" | "datetime";
};

const usePagination = (props?: UsePaginationProps) => {
  const { current = 1, pageSize = DEFAULT_PAGE_SIZE, total = 0 } = props ?? {};
  const [pagination, setPagination] = useState({
    pageSize,
    current,
    total,
  });

  const setStateProp = (prop: "pageSize" | "current" | "total", value: number) => {
    setPagination((currentPagination) => ({ ...currentPagination, [prop]: value }));
  };

  const setPageSize = (pageSize: number) => {
    setStateProp("pageSize", pageSize);
  };

  const setCurrent = (current: number) => {
    setStateProp("current", current);
  };

  const setTotal = (total: number) => {
    setStateProp("total", total);
  };

  return { pagination, ...pagination, setPagination, setPageSize, setCurrent, setTotal };
};

const useSorter = (props?: UseSorterProps) => {
  const [sorter, setSorter] = useState({
    ...(props ?? {}),
  });

  const getColumnSortableProps = (fieldName: string, currentSorter: UseSorterProps | undefined) => {
    return {
      sorter: true,
      ...((currentSorter ?? sorter)?.field === fieldName
        ? {
            defaultSortOrder:
              (currentSorter ?? sorter)?.order === "asc" ? "ascend" : ("descend" as SortOrder),
          }
        : {}),
    };
  };

  return { sorter, setSorter, getColumnSortableProps };
};

const useSearch = (props?: UseSearchProps) => {
  const [search, setSearch] = useState({
    ...(props ?? {}),
  });

  return { search, setSearch };
};

const useSearchHighlight = () => {
  const SearchHighlight = (text: string | undefined, searchText: string | undefined) =>
    TextSearch({ text, searchText });

  return { SearchHighlight };
};

const useFilters = (props?: UseFiltersProps) => {
  const [filters, setFilters] = useState<Record<string, any>>(props ?? {});

  const enumFilters = {
    SPDRole: SPDRoleCollection.map((role: SpdRole) => ({
      text: SPDRoleMap[role]?.tag,
      value: role,
    })),
  };

  const commonFilters = {
    isActive: [
      {
        text: "Activo",
        value: true,
      },
      {
        text: "Inactivo",
        value: false,
      },
    ],
  };

  return { filters, setFilters, enumFilters, commonFilters };
};

const useRowSelection = (props?: UseRowSelectionProps) => {
  const { multiple } = props ?? { multiple: true };
  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);

  const selectRow = (record: any) => {
    const keyProp = Object.hasOwn(record, "key") ? "key" : "id";
    const key = `${record[keyProp]}`;
    const newSelectedRowKeys = [...(multiple ? selectedRowKeys : [key])];
    if (multiple) {
      if (newSelectedRowKeys.indexOf(key) >= 0) {
        newSelectedRowKeys.splice(newSelectedRowKeys.indexOf(key), 1);
      } else {
        newSelectedRowKeys.push(key);
      }
    }
    setSelectedRowKeys(newSelectedRowKeys);
  };

  const onSelectedRowKeysChange = (newSelectedRowKeys: React.Key[]) => {
    setSelectedRowKeys(newSelectedRowKeys);
  };

  const rowSelection = {
    selectedRowKeys,
    selections: false,
    onChange: onSelectedRowKeysChange,
  };

  const onRow = (record: any) => ({
    onClick: () => {
      selectRow(record);
    },
  });

  const rowClassName = (record: any, index: number) => {
    const keyProp = Object.hasOwn(record, "key") ? "key" : "id";
    const key = `${record[keyProp]}`;
    return selectedRowKeys.includes(key) ? "ant-table-row-selected" : "";
  };

  return { rowSelection, selectedRowKeys, setSelectedRowKeys, onRow, rowClassName };
};

const useTable = (props?: UseTableProps) => {
  const { pagination, setPagination, setTotal } = usePagination(props?.pagination);
  const { sorter, setSorter, getColumnSortableProps } = useSorter(props?.sorter);
  const { search, setSearch } = useSearch(props?.search);
  const { filters, setFilters, enumFilters, commonFilters } = useFilters(props?.filters);
  const { SearchHighlight } = useSearchHighlight();

  const handleTableChange = (pagination: any, newFilters: any, sorter: any, extra: any) => {
    setPagination((currentPagination) => ({ ...currentPagination, ...pagination }));
    setFilters(newFilters);
    setSorter({ field: sorter?.field, order: sorter?.order === "ascend" ? "asc" : "desc" });
  };

  const getColumnRender = (dataIndex: string, title: string, config?: ColumnRenderConfig) => {
    const render = (field: any, record: any) => {
      const fieldTxt = field ? `${field}` : "";
      if (config?.highlightSearch) {
        return SearchHighlight(fieldTxt, search?.searchText);
      } else if (config?.renderFormat === "date") {
        return dateFromStr(field);
      }
      return Text({ children: fieldTxt });
    };
    return {
      dataIndex,
      key: dataIndex,
      title,
      ...(config?.sorter ? getColumnSortableProps(dataIndex, sorter) : {}),
      ...(config?.highlightSearch || config?.renderFormat ? { render } : {}),
      ...(config?.responsive ? { responsive: config.responsive } : {}),
      ...(config?.width ? { width: config.width } : {}),
    };
  };

  return {
    pagination,
    sorter,
    search,
    filters,
    enumFilters,
    commonFilters,
    setPagination,
    setSorter,
    setSearch,
    setTotal,
    handleTableChange,
    getColumnRender,
    setFilters,
  };
};

export { usePagination, useSorter, useSearch, useTable, useRowSelection, useFilters };
