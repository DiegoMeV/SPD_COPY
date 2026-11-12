import React, { useEffect } from "react";
import { MonitoringConfigSelect } from "./MonitoringConfigSelect";
import { MonitoringConfig } from "../../types/monitoringConfig";
import { useMonitoringConfig } from "./hooks";
import { useDevPlan } from "../DevPlan/hooks";

const MonitoringConfigGlobal = () => {
  const {
    activeMonitoring,
    setActiveMonitoring,
    setSelectedMonitoringConfigId,
    currentMonitoring,
  } = useMonitoringConfig();
  const { setSelectedDevPlanId } = useDevPlan();
  const [dropDownVisible, setDropDownVisible] = React.useState(false);

  const setSelectedMonitoringConfig = (monitoringConfig: MonitoringConfig) => {
    setActiveMonitoring(monitoringConfig);
    setSelectedMonitoringConfigId(monitoringConfig.id);
    setSelectedDevPlanId(monitoringConfig.devPlanId);
  };

  useEffect(() => {
    console.log("[MonitoringConfigGlobal] currentMonitoring", currentMonitoring);
    console.log(
      "[MonitoringConfigGlobal] period-subperiod",
      `${currentMonitoring?.period}-${currentMonitoring?.subperiod}`,
    );
  }, [currentMonitoring]);

  return (
    <MonitoringConfigSelect
      render={(monitoringConfig: MonitoringConfig) =>
        dropDownVisible
          ? `(${monitoringConfig.period}-${monitoringConfig.subperiod}) ${monitoringConfig.devPlan?.name}`
          : `${monitoringConfig.period} - ${monitoringConfig.subperiod}`
      }
      width={dropDownVisible ? 400 : 120}
      value={activeMonitoring?.id}
      onSelect={setSelectedMonitoringConfig}
      onDropdownVisibleChange={setDropDownVisible}
      firstSelected
    />
  );
};

export { MonitoringConfigGlobal };
