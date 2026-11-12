import React from "react";
import { useRouteParam } from "../../../../client/hooks/useParam";
import { EntityEdit } from "../../../../client/components/Entities";

const EntityEditPage: React.FC = () => {
  const id = parseInt(useRouteParam("id") || "0");

  if (!id) return <></>;
  return <EntityEdit id={id} />;
};

export default EntityEditPage;
