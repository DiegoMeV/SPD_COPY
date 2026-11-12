import React from "react";
import { Dropdown, Avatar, Typography } from "antd";
import type { MenuProps } from "antd";
import { useStoreState, useStoreActions } from "../../../store";
import { useRouter } from "next/router";

const { Link } = Typography;

export const UserInfo: React.FC = () => {
  const user = useStoreState((state) => state.user.data);
  const userLogout = useStoreActions((actions) => actions.user.userLogout);
  const router = useRouter();
  if (!user) return null;

  const items: MenuProps["items"] = [
    {
      key: "1",
      label: "Mi Perfil",
      onClick: () => {
        router.push(`/user/profile`);
      },
    },
    {
      key: "2",
      label: "Cambiar Clave",
      onClick: () => {
        router.push("/user/change-password");
      },
    },
    {
      key: "3",
      label: "Salir",
      onClick: () => {
        userLogout();
      },
    },
  ];

  return (
    <Dropdown key="more" menu={{ items }} placement="bottomRight">
      <Link>
        <Avatar style={{ backgroundColor: "#f56a00" }}>
          {user?.firstName?.[0]}
          {user?.lastName?.[0]}
        </Avatar>
      </Link>
    </Dropdown>
  );
};
