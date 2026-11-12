import React, { useEffect, useRef } from "react";
import { useGetSupersetGuestTokenMutation } from "../../graphql/gen/hooks";
import { embedDashboard } from "@superset-ui/embedded-sdk";

const DASHBOARD_ID = "e070e409-effe-4875-88c4-bbbe00b7f4a3";

const SupersetDashboard: React.FC = () => {
  const [getGuestToken] = useGetSupersetGuestTokenMutation({
    variables: {
      data: {
        dashboardId: DASHBOARD_ID,
      },
    },
  });

  const getToken = async () => {
    const token = await getGuestToken();
    return token?.data?.getSupersetGuestToken ?? "";
  };

  useEffect(() => {
    getGuestToken();

    const embed = async () => {
      const dashboard = document.getElementById("dashboard");
      if (dashboard) {
        await embedDashboard({
          id: DASHBOARD_ID, // given by the Superset embedding UI
          supersetDomain: "http://localhost:8088",
          mountPoint: dashboard, // html element in which iframe render
          fetchGuestToken: () => getToken(),
          dashboardUiConfig: {
            hideTitle: true,
            hideChartControls: true,
            hideTab: true,
          },
        });
      }
    };
    if (document.getElementById("dashboard")) {
      embed();
    }
  }, []);

  return <div id="dashboard" style={{ width: "100%", minHeight: 500 }} />;
};

export default SupersetDashboard;
