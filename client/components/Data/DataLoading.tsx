import { ApolloError } from "@apollo/client";
import { Result, Spin } from "antd";
import React from "react";

type Props = {
  loading: boolean;
  error?: ApolloError;
  children?: React.ReactNode;
};

const DataLoading: React.FC<Props> = ({ loading, error, children }) => {
  if (loading) return <Spin tip="Cargando datos..." />;

  if (error)
    return (
      <Result
        status="warning"
        title="Hubo problemas cargando la información, por favor trate de nuevo."
        subTitle={error.message}
      />
    );

  return <>{children}</>;
};

export { DataLoading };
