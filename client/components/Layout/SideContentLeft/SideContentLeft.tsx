import React, { useState } from "react";
import { Typography, Layout, Tooltip } from "antd";
import { useStoreState } from "../../../store";
import { AppMenu } from "../../AppMenu";
import { SideContentHeader } from "./SideContentHeader";

const { Sider } = Layout;

export const SideContentLeft: React.FC = () => {
  const tenant = useStoreState((state) => state.tenant.data);
  const [collapsed, setCollapsed] = useState(true);

  return (
    <>
      <Sider
        collapsible
        collapsed={collapsed}
        onCollapse={(value) => setCollapsed(value)}
        theme="light"
        collapsedWidth={90}
      >
        <SideContentHeader collapsed={collapsed} tenant={tenant} />
        <AppMenu />
        {!collapsed && (
          <Tooltip title="Versión">
            <Typography.Text
              type="secondary"
              italic
              style={{
                fontSize: 10,
                textAlign: "right",
                width: "100%",
                display: "block",
                paddingRight: 30,
              }}
            >
              {"v.20241112.06"}
            </Typography.Text>
          </Tooltip>
        )}
      </Sider>
    </>
  );
};
