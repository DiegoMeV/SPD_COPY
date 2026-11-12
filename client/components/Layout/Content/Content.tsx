import React from "react";
import { Layout } from "antd";

type Props = {
  children?: React.ReactNode;
};

export const Content: React.FC<Props> = ({ children }) => {
  return (
    <>
      <Layout
        style={{
          margin: 5,
          padding: 4,
          height: "280",
          background: "#fff",
        }}
      >
        {children}
      </Layout>
    </>
  );
};
