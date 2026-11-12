import React from "react";
import { Spin, Result } from "antd";
import { useGetMonitoringConfigsQuery } from "../../../graphql/gen/hooks";
import { MonitoringConfigTable } from "./MonitoringConfigTable";
import { MonitoringConfigUsedFor } from "../../../graphql/gen/schema";

type Props = {
  usedFor?: MonitoringConfigUsedFor;
}

const MonitoringConfigLoader: React.FC<Props> = ({ usedFor = MonitoringConfigUsedFor.DevelopmentPlans }) => {
  const { loading, error, data } = useGetMonitoringConfigsQuery({
    variables: {
      data: {
        usedFor
      }
    },
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

  return <MonitoringConfigTable data={data?.getMonitoringConfigs} usedFor={usedFor} />;
};

export { MonitoringConfigLoader };
