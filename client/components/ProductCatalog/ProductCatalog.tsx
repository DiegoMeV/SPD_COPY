/* eslint-disable @typescript-eslint/no-explicit-any */
import React, { useState } from "react";
import { Card, Result, Spin, Table } from "antd";
import { ProductCatalogFragment } from "../../../graphql/gen/ops";
import type { ColumnsType } from "antd/lib/table";
import Search from "antd/lib/input/Search";
import { TextSearch } from "../Utils/TextSearch";

type Sorter = {
  field?: string;
  order?: string;
};

type Props = {
  data: ProductCatalogFragment[];
  loading: boolean;
  error: any;
  pagination: any;
  searchParams: any;
  sorter?: Sorter;
  onChange: (pagination: any, filters: any, sorter: any, extra: any) => void;
  setSearchParams: (searchParams: any | ((current: any) => any)) => void;
};

const ProductCatalog: React.FC<Props> = ({
  data,
  loading,
  error,
  pagination,
  searchParams,
  sorter,
  onChange,
  setSearchParams,
}) => {
  const [searchedText, setSearchedText] = useState<string>(searchParams?.searchedText ?? "");

  const columns: ColumnsType<ProductCatalogFragment> = [
    {
      title: "Sector",
      dataIndex: "product",
      key: "program",
      sorter: () => 0,
      render: (product: { program: { sector: ProductCatalogFragment } }) => (
        <TextSearch
          text={`${product.program.sector.code} - ${product.program.sector.name}`}
          searchText={searchedText}
        />
      ),
    },
    {
      title: "Programa",
      dataIndex: "product",
      key: "program",
      sorter: () => 0,
      render: (product: { program: ProductCatalogFragment }) => (
        <TextSearch
          text={`${product.program.code} - ${product.program.name}`}
          searchText={searchedText}
        />
      ),
    },
    {
      title: "Producto",
      dataIndex: "product",
      key: "product",
      sorter: () => 0,
      render: (field: ProductCatalogFragment) => (
        <TextSearch text={`${field.code} - ${field.name}`} searchText={searchedText} />
      ),
    },
    {
      title: "Indicador",
      dataIndex: "code",
      key: "code",
      sorter: () => 0,
      render: (field: string, row: ProductCatalogFragment) => (
        <TextSearch text={`${row.code} - ${row.name}`} searchText={searchedText} />
      ),
    },
  ];

  const onSearch = (value: string) => {
    setSearchParams({ searchText: value, searchedColumn: "text" });
  };

  if (loading) return <Spin tip="Cargando datos..." />;
  if (error)
    return (
      <Result
        status="warning"
        title="Hubo problemas cargando la información, por favor trate de nuevo."
      />
    );

  return (
    <Card
      title="Catálogo de Productos"
      extra={
        <Search
          style={{ marginBottom: 8, width: "50vw" }}
          placeholder="Buscar"
          onSearch={onSearch}
          onChange={(e) => setSearchedText(e.target.value)}
          value={searchedText}
        />
      }
    >
      <Table
        dataSource={data}
        columns={columns}
        onChange={onChange}
        rowKey={(record: ProductCatalogFragment) => record.id}
        pagination={pagination}
        size="middle"
      />
    </Card>
  );
};

export { ProductCatalog };
