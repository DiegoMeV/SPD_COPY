import React from "react";
import { UserInfo } from "./UserInfo";
import { Typography, Flex } from "antd";
import Image from "next/image";
import { MonitoringConfigGlobal } from "../../MonitoringConfig";
import { useStoreState } from "../../../store";

const { Title } = Typography;

export const Header: React.FC = () => {
  const user = useStoreState((state) => state.user.data);

  return (
    <div
      style={{
        borderBottom: "solid",
        borderColor: "#f0f2f5",
        padding: 10,
        backgroundColor: "#fff",
      }}
    >
      <Flex justify="space-between" align="center">
        <Flex align="center" gap={10}>
          <Image
            src="/images/siifweb/logo_siifweb.png"
            width={45}
            height={45}
            style={{
              width: "45px",
              height: "45px",
            }}
            priority
            alt="Logo entidad"
          />
          <Title style={{ margin: 0, padding: 0 }}>SIIFWEB</Title>
          <Title level={3} style={{ color: "#8c8c8c", margin: 0, padding: 0 }}>
            {process.env.NEXT_PUBLIC_SPD_CUSTOM_TITLE ?? "SEGUIMIENTO AL PLAN DE DESARROLLO"}
          </Title>
        </Flex>
        {user && (
          <Flex justify="end">
            <Flex align="center" gap={10}>
              <MonitoringConfigGlobal />
              <UserInfo />
            </Flex>
          </Flex>
        )}
      </Flex>
    </div>
  );
};
