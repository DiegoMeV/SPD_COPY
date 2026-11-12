import React from "react";
import { EntityDetails } from "../../../../client/components/Entities";
import { useRouteParam } from "../../../../client/hooks/useParam";

const EntityDetailsPage: React.FC = () => {
  const id = parseInt(useRouteParam("id") || "0");

  if (id) {
    return <EntityDetails id={id} />;
  }
  return <></>;
};

export default EntityDetailsPage;
