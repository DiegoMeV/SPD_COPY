import React from "react";
import { useProjects } from "./hooks";
import { ProjectsTable } from "./ProjectsTable";
import { Card, Col, Form, Row } from "antd";
import { DataLoading } from "../../Data/DataLoading";
import { TextWithBadge } from "../../Utils/TextWithBadge";
import _ from "lodash";
import { MonitoringStatus } from "../../../../graphql/gen/schema";

type ProjectsTableLoaderProps = {
  stage?: MonitoringStatus;
};

const ProjectsTableLoader: React.FC<ProjectsTableLoaderProps> = ({ stage }) => {
  const {
    form,
    loading,
    data,
    count,
    error,
    pagination,
    filters,
    search,
    setSearch,
    sorter,
    handleTableChange,
  } = useProjects();

  return (
    <Form
      form={form}
      initialValues={{
        layout: "horizontal",
      }}
    >
      <DataLoading loading={loading} error={error}>
        <Row gutter={[16, 0]}>
          <Col span={24}>
            <Card title={<TextWithBadge text="Proyectos" count={count} />}>
              <ProjectsTable
                data={data}
                loading={loading}
                error={error}
                pagination={{ ...pagination }}
                filters={{ ...filters }}
                sorter={sorter}
                searchParams={search}
                setSearchParams={setSearch}
                onChange={handleTableChange}
              />
            </Card>
          </Col>
        </Row>
      </DataLoading>
    </Form>
  );
};

export { ProjectsTableLoader };
