import { Space } from "antd";
import React from "react";
import { ProyectoFragment } from "../../../../graphql/gen/ops";
import { ButtonBack, ButtonDetails } from "../../Buttons";
import { useProjects } from "./hooks";

type Props = {
  project: ProyectoFragment;
  onSelectRow?: () => void;
};

const ProjectsTableActions: React.FC<Props> = ({ project, onSelectRow }) => {
  const { setSelectedProyecto } = useProjects();

  return (
    <Space size="middle" direction="horizontal" style={{ width: "100%", justifyContent: "center" }}>
      <ButtonDetails
        title="Ver Actividades"
        onClick={() => {
          setSelectedProyecto(project);
          onSelectRow?.();
        }}
      />
    </Space>
  );
};

export { ProjectsTableActions };
