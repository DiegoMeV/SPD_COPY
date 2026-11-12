import React from "react";
import { Spin, Result } from "antd";
import { OdsTable } from "./OdsTable";
import { useGetOdssQuery } from "../../../graphql/gen/hooks";

const OdsLoader: React.FC = () => {
  const { loading, error, data } = useGetOdssQuery({
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

  return <OdsTable data={data?.getOdss} />;
};

export { OdsLoader };
