import { Action, action } from "easy-peasy";
import type { AppMenuItem, OptionPermissionAction } from "../../types/common";

export type AppModel = {
  currentOption: AppMenuItem | undefined;
  currentPermissions: OptionPermissionAction[];
  setCurrentOption: Action<AppModel, AppMenuItem | undefined>;
  setCurrentPermissions: Action<AppModel, OptionPermissionAction[]>;
};

export const appModel: AppModel = {
  currentOption: undefined,
  currentPermissions: [],
  setCurrentOption: action((state, currentOption) => {
    state.currentOption = currentOption;
  }),
  setCurrentPermissions: action((state, currentPermissions) => {
    state.currentPermissions = [...currentPermissions];
  }),
};
