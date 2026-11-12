import React from "react";
import { ProjectsSchedule } from "../../../Siif/Projects/ProjectsSchedule";
import { MonitoringStatus } from "../../../../../graphql/gen/schema";

type MonitoringProjectsListProps = {
  stage?: MonitoringStatus;
};

const MonitoringProjectsList: React.FC<MonitoringProjectsListProps> = ({ stage }) => {
  return <ProjectsSchedule />;
};

export { MonitoringProjectsList };
