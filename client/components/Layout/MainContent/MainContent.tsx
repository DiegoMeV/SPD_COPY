import React from "react";
import { Layout } from "antd";

type Props = {
  children: React.ReactNode;
};

export const MainContent: React.FC<Props> = ({ children }) => {
  return (
    <>
      <Layout
        style={{
          background: "#fff",
          borderLeft: "2px solid #f0f0f0",
          height: "auto",
          padding: "0 10px",
          marginLeft: 0,
          minHeight: "87vh",
        }}
      >
        {children}
      </Layout>
    </>
  );
};
