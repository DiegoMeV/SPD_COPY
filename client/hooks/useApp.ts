import { SPDRole } from "@prisma/client";
import { useCurrentUser } from "../components/Users/hooks";
import { useStoreState, useStoreActions } from "../store";
import { OptionPermissionAction } from "../types/common";

const useApp = () => {
  const currentOption = useStoreState((state) => state.app.currentOption);
  const setCurrentOption = useStoreActions((actions) => actions.app.setCurrentOption);
  const setCurrentPermissions = useStoreActions((actions) => actions.app.setCurrentPermissions);
  const currentPermissions = useStoreState((state) => state.app.currentPermissions);
  const { user } = useCurrentUser();

  const getAllowedActions = () => {
    return [
      OptionPermissionAction.CREATE,
      OptionPermissionAction.READ,
      OptionPermissionAction.UPDATE,
      OptionPermissionAction.DELETE,
    ].filter((action) => {
      return (
        !currentOption?.permissions ||
        currentOption?.permissions[action].includes(user?.role ?? SPDRole.OPERATOR)
      );
    });
  };

  const hasCreatePermission = () => currentPermissions?.includes(OptionPermissionAction.CREATE);
  const hasReadPermission = () => currentPermissions?.includes(OptionPermissionAction.READ);
  const hasUpdatePermission = () => currentPermissions?.includes(OptionPermissionAction.UPDATE);
  const hasDeletePermission = () => currentPermissions?.includes(OptionPermissionAction.DELETE);
  const hasAllPermissions = () =>
    !currentOption?.permissions ||
    (hasCreatePermission() &&
      hasReadPermission() &&
      hasUpdatePermission() &&
      hasDeletePermission());

  return {
    currentOption,
    setCurrentOption,
    setCurrentPermissions,
    currentPermissions,
    getAllowedActions,
    hasCreatePermission,
    hasReadPermission,
    hasUpdatePermission,
    hasDeletePermission,
    hasAllPermissions,
  };
};

export { useApp };
