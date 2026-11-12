import React from "react";
import { SPDRole } from "@prisma/client";
import { IconDefinition } from "@fortawesome/free-solid-svg-icons";

export type NotificationType = "success" | "info" | "warning" | "error";

export type CheckedKeys =
  | {
      checked: React.Key[];
      halfChecked: React.Key[];
    }
  | React.Key[];

export enum OptionPermissionAction {
  CREATE = "create",
  READ = "read",
  UPDATE = "update",
  DELETE = "delete",
}

export type AppMenuItem = {
  label: string;
  path: string;
  roles: SPDRole[];
  icon?: IconDefinition;
  children?: AppMenuItem[];
  style?: Record<string, string | number>;
  permissions?: Record<OptionPermissionAction, SPDRole[]>;
};
