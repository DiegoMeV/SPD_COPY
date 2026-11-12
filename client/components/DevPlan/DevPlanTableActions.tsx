import { faSitemap } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Button, Space, Tooltip, Typography } from "antd";
import { useRouter } from "next/router";
import React from "react";
import { ButtonEdit, ButtonDelete, ButtonDetails, ButtonCopy } from "../Buttons";
import { useDeleteDevPlan } from "./hooks";
import { DevPlan } from "../../types/devPlan";
import { useApp } from "../../hooks/useApp";

type Props = {
  devPlan: DevPlan;
};

const { Title } = Typography;

const DevPlansTableActions: React.FC<Props> = ({ devPlan }) => {
  const router = useRouter();
  const { deleteDevPlan, loading } = useDeleteDevPlan();
  const { hasCreatePermission, hasUpdatePermission, hasDeletePermission } = useApp();

  return (
    <Space size="middle" direction="horizontal" style={{ width: "100%", justifyContent: "center" }}>
      <ButtonDetails
        title="Detalles"
        onClick={() => router.push(`/config/dev-plans/${devPlan.id}/details`)}
      />
      {!devPlan.levels?.length && hasCreatePermission() && (
        <ButtonCopy
          title="Copiar de SIIF"
          onClick={() => router.push(`/config/dev-plans/copy-levels?devPlanId=${devPlan.id}`)}
        />
      )}
      {hasUpdatePermission() && (
        <ButtonEdit
          title="Editar"
          onClick={() => router.push(`/config/dev-plans/${devPlan.id}/edit`)}
        />
      )}
      <Tooltip title="Estructura">
        <Button
          shape="circle"
          size="large"
          icon={<FontAwesomeIcon icon={faSitemap} />}
          onClick={() => router.push(`/config/dev-plans/${devPlan.id}/levels`)}
        ></Button>
      </Tooltip>
      {hasDeletePermission() && (
        <ButtonDelete
          message="Está seguro de eliminar este plan?"
          description={
            <span>
              El plan{" "}
              <Title style={{ display: "inline" }} level={5}>
                {devPlan.name}
              </Title>{" "}
              se eliminará de forma permanente, desea continuar?
            </span>
          }
          onDelete={() => {
            deleteDevPlan(devPlan.id);
          }}
          loading={loading}
        />
      )}
    </Space>
  );
};

export { DevPlansTableActions };
