import { Space } from "antd";
import { useRouter } from "next/router";
import React from "react";
import { EntityFragment } from "../../../graphql/gen/ops";
import { ButtonEdit, ButtonDelete } from "../Buttons";
import { useDeleteEntity } from "./hooks";

type Props = {
  entity: EntityFragment;
};

const EntitiesTableActions: React.FC<Props> = ({ entity }) => {
  const router = useRouter();
  const { deleteEntity, loading } = useDeleteEntity();

  return (
    <Space size="middle" direction="horizontal" style={{ width: "100%", justifyContent: "center" }}>
      <ButtonEdit
        title="Editar"
        onClick={() => router.push(`/config/entities/edit/${entity.id}`)}
      />
      <ButtonDelete
        message="Está seguro de eliminar esta entidad?"
        onDelete={() => {
          deleteEntity(entity.id);
        }}
        loading={loading}
      />
    </Space>
  );
};

export { EntitiesTableActions };
