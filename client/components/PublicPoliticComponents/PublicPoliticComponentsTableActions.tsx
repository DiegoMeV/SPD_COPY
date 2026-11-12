import { Space } from "antd";
import React from "react";
import { PublicPoliticComponentFragment } from "../../../graphql/gen/ops";
import { ButtonDelete } from "../Buttons";
import { useDeletePublicPoliticComponent } from "./hooks";
import { PublicPoliticComponentEdit } from "./PublicPoliticComponentEdit";

type Props = {
  data: PublicPoliticComponentFragment;
};

const PublicPoliticComponentsTableActions: React.FC<Props> = ({ data }) => {
  const { deleteComponent, loading } = useDeletePublicPoliticComponent();

  return (
    <Space size="middle" direction="horizontal" style={{ width: "100%", justifyContent: "center" }}>
      <PublicPoliticComponentEdit data={data} />
      <ButtonDelete
        message="Está seguro de eliminar este componente?"
        onDelete={() => {
          deleteComponent(data.id);
        }}
        loading={loading}
      />
    </Space>
  );
};

export { PublicPoliticComponentsTableActions };
