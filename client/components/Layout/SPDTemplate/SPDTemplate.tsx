import React from "react";
import { Header } from "../Header";
import { Content } from "../Content";
import { MainContent } from "../MainContent";
import { Navbar } from "../Navbar";
import { Layout } from "antd";
import { useStoreState } from "../../../store";
import { SideContentLeft } from "../SideContentLeft";

type Props = {
  children?: React.ReactNode;
};

export const SPDTemplate: React.FC<Props> = ({ children }) => {
  const user = useStoreState((state) => state.user.data);

  return (
    <>
      <Layout style={{ minHeight: '100vh' }}>
        <Header />
        <Layout>
          {user && <SideContentLeft />}
          <MainContent>
            <Navbar />
            <Content>{children}</Content>
          </MainContent>
        </Layout>
      </Layout>
    </>
  );
};
