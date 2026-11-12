import React from "react";
import { Typography, Layout } from "antd";

const { Title } = Typography;
const { Content } = Layout;

type Props = {
  title: React.ReactNode;
  children: React.ReactNode;
};

const AppContent: React.FC<Props> = ({ title, children }) => {
  return (
    <Content>
      <Title level={3}>{title}</Title>
      {children}
    </Content>
  );
};

export { AppContent };
