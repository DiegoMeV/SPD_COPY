import { ApolloError } from "@apollo/client";
import { Result } from "antd";
import React from "react";

type Props = {
  error?: ApolloError;
  children?: React.ReactNode;
};

const DataError: React.FC<Props> = ({ error, children }) => {
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

export { DataError };
