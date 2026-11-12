import { Space } from "antd";
import React from "react";
import { MacroProjectFragment } from "../../../graphql/gen/ops";
import { ButtonDelete } from "../Buttons";
import { useDeleteMacroProject } from "./hooks";
import { MacroProjectEdit } from "./MacroProjectEdit";

type Props = {
  data: MacroProjectFragment;
};

const MacroProjectsTableActions: React.FC<Props> = ({ data }) => {
  const { remove, loading } = useDeleteMacroProject();

  return (
    <Space size="middle" direction="horizontal" style={{ width: "100%", justifyContent: "center" }}>
      <MacroProjectEdit data={data} />
      <ButtonDelete
        message="Está seguro de eliminar este macro proyecto?"
        onDelete={() => {
          remove(data.id);
        }}
        loading={loading}
      />
    </Space>
  );
};

export { MacroProjectsTableActions };
