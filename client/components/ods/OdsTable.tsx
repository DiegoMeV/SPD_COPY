import React from "react";
import { Table, Card } from "antd";
import { ColumnsType } from "antd/lib/table";
import { OdsFragment } from "../../../graphql/gen/ops";

type Props = {
  data?: OdsFragment[];
};

const OdsTable: React.FC<Props> = ({ data }) => {
  const columns: ColumnsType<OdsFragment> = [
    {
      title: "ID",
      dataIndex: "id",
      key: "id",
      sorter: () => 0,
    },
    {
      title: "Nombre",
      dataIndex: "name",
      key: "name",
      sorter: () => 0,
    },
  ];

  return (
    <>
      <Card title="Objetivos de Desarrollo Sostenible (ODS)">
        <Table
          dataSource={data}
          columns={columns}
          pagination={{ pageSize: 100 }}
          rowKey={(record: OdsFragment) => record.id}
        />
      </Card>
    </>
  );
};

export { OdsTable };
