import React from "react";
import { useRouteParam } from "../../../../client/hooks/useParam";
import { ProjectDetails } from "../../../../client/components/Siif/Projects/ProjectDetails";

const ProjectDetailsPage: React.FC = () => {
  const project = useRouteParam("project");

  if (project) {
    return <ProjectDetails projectNumber={project} />;
  }
  return <></>;
};

export default ProjectDetailsPage;
