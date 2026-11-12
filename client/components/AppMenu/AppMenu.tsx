import React from "react";
import type { MenuProps } from "antd";
import { Menu, Tooltip } from "antd";
import { useRouter } from "next/router";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { IconDefinition } from "@fortawesome/free-solid-svg-icons";
import { useAppMenu } from "./hooks";
import { AppMenuItem } from "../../types/common";

type MenuItem = Required<MenuProps>["items"][number];

export const AppMenu: React.FC = () => {
  const router = useRouter();
  const { userMenu, setCurrentKeyPath } = useAppMenu();

  function getItem(item: AppMenuItem): MenuItem {
    const style = item.style ?? {
      "--fa-primary-color": "#141414",
      "--fa-secondary-color": "#ce6503",
      "--fa-secondary-opacity": 0.8,
      "--fa-primary-opacity": 0.9,
    };
    return {
      key: item.path,
      permissions: item.permissions,
      ...(item.icon
        ? {
            icon: <FontAwesomeIcon icon={item.icon as IconDefinition} style={style} />,
          }
        : {}),
      children: item.children?.map((child) => getItem(child)),
      label: item.children ? <Tooltip title={item.label}>{item.label}</Tooltip> : item.label,
    } as MenuItem;
  }

  const items = userMenu.map((item) => getItem(item));

  const onClick: MenuProps["onClick"] = (e) => {
    setCurrentKeyPath(e.keyPath);
    router.push(e.key);
  };

  return (
    <Menu
      onClick={onClick}
      defaultSelectedKeys={["/dashboard/goals"]}
      defaultOpenKeys={["/dashboard/goals"]}
      inlineCollapsed={true}
      mode="inline"
      theme="light"
      selectedKeys={[router.pathname.replace(/\/\[id\].*$/, "")]}
      items={items}
      style={{ border: "none" }}
    />
  );
};
