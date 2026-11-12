import React from "react";
import { Table, Card } from "antd";
import { ColumnsType } from "antd/lib/table";
import { UnitFragment } from "../../../graphql/gen/ops";

type Props = {
  data?: UnitFragment[];
};

const UnitsTable: React.FC<Props> = ({ data }) => {
  const columns: ColumnsType<UnitFragment> = [
    {
      title: "ID",
      dataIndex: "id",
      key: "id",
      width: "10%",
      sorter: () => 0,
    },
    {
      title: "Nombre",
      dataIndex: "name",
      key: "name",
      sorter: () => 0,
    },
    {
      title: "Sigla",
      dataIndex: "initials",
      key: "initials",
      width: "20%",
      sorter: () => 0,
    },
  ];

  return (
    <>
      <Card title="Unidades">
        <Table
          dataSource={data}
          columns={columns}
          pagination={{ pageSize: 20 }}
          rowKey={(record: UnitFragment) => record.id}
        />
      </Card>
    </>
  );
};

export { UnitsTable };
