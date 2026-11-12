import React from "react";
import { useRouteParam } from "../../../../client/hooks/useParam";
import { UserEdit } from "../../../../client/components/Users";

const UsersEditPage: React.FC = () => {
  const id = parseInt(useRouteParam("id") || "0");

  if (!id) return <></>;
  return <UserEdit id={id} />;
};

export default UsersEditPage;
