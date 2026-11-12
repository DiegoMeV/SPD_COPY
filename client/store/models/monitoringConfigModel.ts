import { Action, action, computed, Computed } from "easy-peasy";
import { MonitoringConfig } from "../../types/monitoringConfig";

export type MonitoringConfigModel = {
  monitoringConfigs: MonitoringConfig[] | undefined;
  activeMonitoring: MonitoringConfig | undefined;
  selectedMonitoringConfigId: number | undefined;
  sgpDiscriminatedExpanded?: boolean;
  setActiveMonitoring: Action<MonitoringConfigModel, MonitoringConfig | undefined>;
  setMonitoringConfigs: Action<MonitoringConfigModel, MonitoringConfig[] | undefined>;
  setSelectedMonitoringConfigId: Action<MonitoringConfigModel, number | undefined>;
  selectedMonitoringConfig: Computed<MonitoringConfigModel, MonitoringConfig | undefined>;
  toggleIsSgpDiscriminatedExpanded: Action<MonitoringConfigModel>;
};

export const monitoringConfigModel: MonitoringConfigModel = {
  activeMonitoring: undefined,
  monitoringConfigs: undefined,
  selectedMonitoringConfigId: undefined,
  sgpDiscriminatedExpanded: false,
  setActiveMonitoring: action((state, activeMonitoring) => {
    state.activeMonitoring = activeMonitoring;
  }),
  setMonitoringConfigs: action((state, monitoringConfigs) => {
    state.monitoringConfigs = [...(monitoringConfigs ?? [])];
  }),
  setSelectedMonitoringConfigId: action((state, selectedMonitoringConfigId) => {
    state.selectedMonitoringConfigId = selectedMonitoringConfigId;
  }),
  selectedMonitoringConfig: computed((state) => {
    return state.monitoringConfigs?.find(
      (monitoringConfig) => monitoringConfig.id === state.selectedMonitoringConfigId,
    );
  }),
  toggleIsSgpDiscriminatedExpanded: action((state) => {
    state.sgpDiscriminatedExpanded = !state.sgpDiscriminatedExpanded;
  }),
};
