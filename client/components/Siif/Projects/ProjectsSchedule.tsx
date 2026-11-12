import React from "react";
import { useProjectsSchedule } from "./hooks";
import { Card, Col, Form, Row } from "antd";
import { DataLoading } from "../../Data/DataLoading";
import { TextWithBadge } from "../../Utils/TextWithBadge";
import _ from "lodash";
import { MonitoringStatus } from "../../../../graphql/gen/schema";
import { ProjectsScheduleTable } from "./ProjectsScheduleTable";

const ProjectsSchedule: React.FC = () => {
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
  } = useProjectsSchedule();

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
              <ProjectsScheduleTable
                data={data}
                loading={loading}
                error={error}
                pagination={{ ...pagination }}
                filters={{ ...filters }}
                sorter={sorter}
                searchParams={search}
                setSearchParams={setSearch}
                onChange={handleTableChange}
                stage={MonitoringStatus.Scheduling}
              />
            </Card>
          </Col>
        </Row>
      </DataLoading>
    </Form>
  );
};

export { ProjectsSchedule };
