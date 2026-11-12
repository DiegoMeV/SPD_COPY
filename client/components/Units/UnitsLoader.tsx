import React from "react";
import { Spin, Result } from "antd";
import { UnitsTable } from "./UnitsTable";
import { useGetUnitsQuery } from "../../../graphql/gen/hooks";

const UnitsLoader: React.FC = () => {
  const { loading, error, data } = useGetUnitsQuery({
    fetchPolicy: "cache-and-network",
  });

  if (loading) return <Spin />;
  if (error)
    return (
      <Result
        status="warning"
        title="Hubo problemas cargando la información, por favor trate de nuevo."
      />
    );

  return <UnitsTable data={data?.getUnits} />;
};

export { UnitsLoader };
