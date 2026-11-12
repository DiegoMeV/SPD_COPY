import React from "react";
import { Spin, Result } from "antd";
import { ApolloError } from "@apollo/client";

interface ContentLoadingProps {
  loading?: boolean;
  error?: ApolloError | undefined;
  errorTitle?: string;
  children: React.ReactNode;
}

const ContentLoading: React.FC<ContentLoadingProps> = ({
  loading = false,
  error,
  errorTitle,
  children,
}) => {
  if (loading) {
    return <Spin />;
  }

  if (error) {
    return (
      <Result
        status="warning"
        title={errorTitle ?? "Hubo problemas cargando la información, por favor trate de nuevo."}
        subTitle={error.message}
      />
    );
  }

  return <>{children}</>;
};

export { ContentLoading };
