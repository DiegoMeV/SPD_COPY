import { SPDRole } from "@prisma/client";
import { useCurrentUser } from "../Users/hooks";
import {
  faBox,
  faBuilding,
  faBullseye,
  faChartLine,
  faChartPie,
  faCheck,
  faClipboard,
  faClipboardList,
  faCog,
  faCubes,
  faEdit,
  faFileAlt,
  faFlag,
  faListAlt,
  faListUl as faListTree,
  faProjectDiagram,
  faTasks,
  faUsers,
  faWandMagicSparkles,
  faChartLine as faDisplayChartUp,
} from "@fortawesome/free-solid-svg-icons";
import { useMonitoringConfig } from "../MonitoringConfig/hooks";
import { useMonitoring } from "../../hooks/useMonitoring";
import { useEffect, useState } from "react";
import { OptionPermissionAction, type AppMenuItem } from "../../types/common";
import { useStoreActions } from "../../store";

const MENU_CONFIG: AppMenuItem[] = [
  {
    path: "/config/",
    label: "Configuración",
    icon: faCog,
    roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
    children: [
      {
        path: "/config/users",
        label: "Usuarios",
        icon: faUsers,
        roles: [SPDRole.ADMIN, SPDRole.AUDITOR],
      },
      {
        path: "/config/entities",
        label: "Entidades",
        icon: faBuilding,
        roles: [SPDRole.ADMIN, SPDRole.AUDITOR],
      },
      {
        path: "/config/dev-plans",
        label: "Planes de Desarrollo",
        icon: faTasks,
        roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
        permissions: {
          [OptionPermissionAction.CREATE]: [SPDRole.ADMIN, SPDRole.AUDITOR],
          [OptionPermissionAction.READ]: [
            SPDRole.ADMIN,
            SPDRole.AUDITOR,
            SPDRole.VALIDATOR,
            SPDRole.OPERATOR,
          ],
          [OptionPermissionAction.UPDATE]: [SPDRole.ADMIN, SPDRole.AUDITOR],
          [OptionPermissionAction.DELETE]: [SPDRole.ADMIN, SPDRole.AUDITOR],
        },
      },
      {
        path: "/config/goals",
        label: "Metas",
        icon: faBullseye,
        roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
      },
      {
        path: "/config/projects",
        label: "Proyectos",
        icon: faProjectDiagram,
        roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
      },
      {
        path: "/config/monitoring",
        label: "Seguimiento",
        icon: faChartLine,
        roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
      },
      {
        path: "/config/policies",
        label: "Políticas",
        roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
        children: [
          {
            path: "/config/policies/components",
            label: "Componentes",
            icon: faBox,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/config/policies/national",
            label: "Nacionales",
            icon: faFlag,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/config/policies/territorial",
            label: "Territoriales",
            icon: faFlag,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
        ],
      },
    ],
  },
  {
    path: "/catalogs/",
    label: "Catálogos",
    icon: faCubes,
    roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
    children: [
      {
        path: "/catalogs/ods",
        label: "ODS",
        icon: faClipboardList,
        roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
      },
      {
        path: "/catalogs/units",
        label: "Unidades",
        icon: faBox,
        roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
      },
      {
        path: "/catalogs/products",
        label: "Productos",
        icon: faListAlt,
        roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
      },
    ],
  },
  {
    path: "/monitoring/",
    label: "Seguimiento",
    icon: faDisplayChartUp,
    roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
    children: [
      {
        path: "/monitoring/goals/",
        label: "Metas",
        icon: faChartLine,
        roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
        children: [
          {
            path: "/monitoring/goals/config",
            label: "Configuración",
            icon: faCog,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR],
          },
          {
            path: "/monitoring/goals/goals",
            label: "Metas",
            icon: faBullseye,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/goals/schedule",
            label: "Programación",
            icon: faClipboard,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/goals/report",
            label: "Reporte",
            icon: faFileAlt,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/goals/validation",
            label: "Validación",
            icon: faCheck,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/goals/review",
            label: "Revisión",
            icon: faEdit,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR],
          },
          {
            path: "/monitoring/goals/dashboard",
            label: "Tableros de Control",
            icon: faChartPie,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
        ],
      },
      {
        path: "/monitoring/projects/",
        label: "Proyectos",
        icon: faProjectDiagram,
        roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
        children: [
          {
            path: "/monitoring/projects/config",
            label: "Configuración",
            icon: faCog,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR],
          },
          {
            path: "/monitoring/projects",
            label: "Proyectos",
            icon: faListTree,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/projects/schedule",
            label: "Programación",
            icon: faClipboardList,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/projects/report",
            label: "Reporte",
            icon: faFileAlt,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/projects/validation",
            label: "Validación",
            icon: faCheck,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/projects/review",
            label: "Revisión",
            icon: faEdit,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR],
          },
          {
            path: "/monitoring/projects/dashboard",
            label: "Tableros de Control",
            icon: faChartPie,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
        ],
      },
      {
        path: "/monitoring/action-plans/",
        label: "Planes de Acción",
        icon: faTasks,
        roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
        children: [
          {
            path: "/monitoring/action-plans/config",
            label: "Configuración",
            icon: faCog,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR],
          },
          {
            path: "/monitoring/action-plans/plans",
            label: "Planes de Acción",
            icon: faTasks,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/action-plans/schedule",
            label: "Programación",
            icon: faClipboard,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/action-plans/report",
            label: "Reporte",
            icon: faFileAlt,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/action-plans/validation",
            label: "Validación",
            icon: faCheck,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/action-plans/review",
            label: "Revisión",
            icon: faEdit,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR],
          },
          {
            path: "/monitoring/action-plans/dashboard",
            label: "Tableros de Control",
            icon: faChartPie,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
        ],
      },
      {
        path: "/monitoring/policies/",
        label: "Políticas",
        icon: faFlag,
        roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
        children: [
          {
            path: "/monitoring/policies/config",
            label: "Configuración",
            icon: faCog,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR],
          },
          {
            path: "/monitoring/policies/policies",
            label: "Políticas",
            icon: faFlag,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/policies/schedule",
            label: "Programación",
            icon: faClipboard,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/policies/report",
            label: "Reporte",
            icon: faFileAlt,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/policies/validation",
            label: "Validación",
            icon: faCheck,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
          {
            path: "/monitoring/policies/review",
            label: "Revisión",
            icon: faEdit,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR],
          },
          {
            path: "/monitoring/policies/dashboard",
            label: "Tableros de Control",
            icon: faChartPie,
            roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
          },
        ],
      },
    ],
  },
  {
    path: "/wizard/",
    label: "Asistente",
    icon: faWandMagicSparkles,
    roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
    style: {
      "--fa-primary-color": "#154eb2",
      "--fa-secondary-color": "#ce6503",
      "--fa-secondary-opacity": 0.8,
    },
  },
];

const useAppMenu = () => {
  const { hasRole } = useCurrentUser();
  const { currentMonitoring } = useMonitoringConfig();
  const {
    isGoalMonitoring,
    isProjectMonitoring,
    isActionPlanMonitoring,
    isPublicPoliticMonitoring,
  } = useMonitoring();
  const [menuConfigForUser, setMenuConfigForUser] = useState<AppMenuItem[]>([]);
  const setCurrentOption = useStoreActions((actions) => actions.app.setCurrentOption);

  useEffect(() => {
    setMenuConfigForUser(getMenuConfigForUser());
  }, []);

  useEffect(() => {
    setMenuConfigForUser(getMenuConfigForUser());
  }, [currentMonitoring?.goalTypes]);

  const isMenuItemVisible = (item: AppMenuItem): boolean => {
    if (hasRole(item.roles)) {
      if (item.path.startsWith("/monitoring/goals/")) {
        return isGoalMonitoring(currentMonitoring?.goalTypes);
      }
      if (item.path.startsWith("/monitoring/projects/")) {
        return isProjectMonitoring(currentMonitoring?.goalTypes);
      }
      if (item.path.startsWith("/monitoring/action-plans/")) {
        return isActionPlanMonitoring(currentMonitoring?.goalTypes);
      }
      if (item.path.startsWith("/monitoring/policies/")) {
        return isPublicPoliticMonitoring(currentMonitoring?.goalTypes);
      }
      return true;
    }
    return false;
  };

  const getMenuConfigForUser = (menu = MENU_CONFIG): AppMenuItem[] => {
    return menu
      .map((item) => {
        const { children, ...menuRecord } = item;
        const isItemVisible = isMenuItemVisible(menuRecord);
        if (!isItemVisible) return null;

        if (!children) return isItemVisible ? menuRecord : null;
        return {
          ...menuRecord,
          children: isItemVisible ? getMenuConfigForUser(children) : [],
        } as AppMenuItem;
      })
      .filter((item) => item !== null) as AppMenuItem[];
  };

  const findKeyPathOption = (menu: AppMenuItem[], keyPath: string[]): AppMenuItem | undefined => {
    for (const item of menu) {
      if (item.path === keyPath[0]) {
        if (keyPath.length === 1) return item;
        return findKeyPathOption(item.children ?? [], keyPath.slice(1));
      }
    }
    return undefined;
  };

  const setCurrentKeyPath = (keyPath: string[]) => {
    const currentOption = findKeyPathOption(MENU_CONFIG, keyPath.reverse());
    setCurrentOption(currentOption);
  };

  return {
    userMenu: menuConfigForUser,
    setCurrentKeyPath,
  };
};

export { useAppMenu };
