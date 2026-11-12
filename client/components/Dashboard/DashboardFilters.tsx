import { Form } from "antd";
import React from "react";
import { EntitySelect } from "../Entities/EntitySelect";
import { MonitoringConfigSelectInput } from "../MonitoringConfig/MonitoringConfigSelectInput";
import { useCurrentUser } from "../Users/hooks";

const { Item } = Form;
const DashboardFilters: React.FC = () => {
  const { user } = useCurrentUser();
  return (
    <>
      <MonitoringConfigSelectInput label="Periodo Seguimiento" />
      <Item name="selectedEntityId" label="Entidad">
        <EntitySelect value={user?.entityId ?? undefined} disabled width="100%" />
      </Item>
    </>
  );
};

export { DashboardFilters };
