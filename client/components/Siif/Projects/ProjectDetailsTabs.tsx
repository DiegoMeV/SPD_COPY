import React from "react";
import { TabsProps, Tabs, Tooltip } from "antd";
import { ProyectoRecord } from "./hooks";
import ProjectActivities from "./ProjectActivities";
import { TextWithBadge } from "../../Utils/TextWithBadge";

type Props = {
  project: ProyectoRecord;
};

const ProjectDetailsTabs: React.FC<Props> = ({ project }) => {
  const tabs: TabsProps["items"] = [
    {
      key: "activities",
      label: <TextWithBadge text="Actividades" count={project.actividades?.length} />,
      children: <ProjectActivities project={project} />,
    },
  ];

  return <Tabs defaultActiveKey="activities" items={tabs} />;
};

export { ProjectDetailsTabs };
