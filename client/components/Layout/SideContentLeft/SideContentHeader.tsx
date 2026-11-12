import React from "react";
import { Typography, Tooltip, Layout } from "antd";
import Image from "next/image";
import { TenantRecord } from "../../../types/tenant";

type SideContentHeaderProps = {
  collapsed: boolean;
  tenant?: TenantRecord;
};

const { Header } = Layout;
const { Title } = Typography;

const SideContentHeader: React.FC<SideContentHeaderProps> = ({ collapsed, tenant }) => {
  return (
    <Header
      style={{
        display: "flex",
        alignItems: "center",
        padding: "0 16px",
        backgroundColor: "#fff",
        marginTop: collapsed ? 20 : 0,
        marginBottom: collapsed ? 20 : 0,
      }}
    >
      <Tooltip title={tenant?.name}>
        <Image
          src={`/images/tenants/${tenant?.key}/logo.png`}
          width={collapsed ? 70 : 40}
          height={collapsed ? 70 : 40}
          priority
          alt="Logo entidad"
        />
      </Tooltip>
      {!collapsed && (
        <Title level={5} style={{ marginLeft: 10, marginBottom: 0 }}>
          {tenant?.name}
        </Title>
      )}
    </Header>
  );
};

export { SideContentHeader };
