import { Space } from "antd";
import React from "react";
import { ButtonDetails, ButtonBack } from "../Buttons";
import { SiifActividadRecord, useProjects } from "./hooks";

type Props = {
  activity: SiifActividadRecord;
  onSelectRow?: () => void;
};

const ActivitiesTableActions: React.FC<Props> = ({ activity, onSelectRow }) => {
  const { setSelectedSiifActividad } = useProjects();

  return (
    <Space size="middle" direction="horizontal" style={{ width: "100%", justifyContent: "center" }}>
      <ButtonDetails
        title="Ver Metas"
        onClick={() => {
          setSelectedSiifActividad(activity);
          onSelectRow?.();
        }}
      />
    </Space>
  );
};

export { ActivitiesTableActions };
