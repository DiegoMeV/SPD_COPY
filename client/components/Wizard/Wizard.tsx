import React from "react";
import { useRouter } from "next/router";
import { Alert, Card, Col, List, Row, Space } from "antd";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faPlusCircle,
  faPlayCircle,
  faBullseye,
  faTasks,
  faClipboardCheck,
  faChartBar,
  faCopy,
} from "@fortawesome/free-solid-svg-icons";
import { useCurrentUser } from "../Users/hooks";
import { SPDRole } from "@prisma/client";

interface MenuItem {
  title: string;
  description: string;
  icon: JSX.Element;
  route: string;
  roles: SPDRole[];
}

const menuItems: MenuItem[] = [
  {
    title: "Crear un nuevo plan de desarrollo",
    description:
      "Un nuevo plan de desarrollo ha sido aprobado? Use este asistente para crear el plan de desarrollo con su información básica y adicione cada uno de los niveles del mismo.",
    icon: <FontAwesomeIcon icon={faPlusCircle} />,
    route: "/config/dev-plans/new",
    roles: [SPDRole.ADMIN, SPDRole.AUDITOR],
  },
  {
    title: "Copiar niveles de un plan de desarrollo",
    description:
      "Si ya ha creado los diferentes niveles del plan de desarrollo en SIIF, puede utilizar esta opción para copiarlos.",
    icon: <FontAwesomeIcon icon={faCopy} />,
    route: "/config/dev-plans/copy-levels",
    roles: [SPDRole.ADMIN, SPDRole.AUDITOR],
  },
  {
    title: "Copiar catálogo de metas",
    description:
      "Si ya ha creado las metas del plan de desarrollo en SIIF, puede utilizar esta opción para copiarlas.",
    icon: <FontAwesomeIcon icon={faCopy} />,
    route: "/config/goals/copy-goals",
    roles: [SPDRole.ADMIN, SPDRole.AUDITOR],
  },
  {
    title: "Iniciar un seguimiento",
    description:
      "Se acerca un nuevo seguimiento? Cree y active los parámetros de seguimiento, verifique que se cuenta con la información básica necesaria antes de habilitar el reporte de cada entidad.",
    icon: <FontAwesomeIcon icon={faPlayCircle} />,
    route: "/monitoring/config/new",
    roles: [SPDRole.ADMIN, SPDRole.AUDITOR],
  },
  {
    title: "Reportar seguimiento",
    description:
      "Informe sobre el progreso de las metas, proyectos y planes de acción que corresponden a su secretaría.",
    icon: <FontAwesomeIcon icon={faClipboardCheck} />,
    route: "/monitoring/track",
    roles: [SPDRole.ADMIN, SPDRole.AUDITOR, SPDRole.VALIDATOR, SPDRole.OPERATOR],
  },
  // {
  //   title: "Planear metas",
  //   description: "Defina y planifique las metas de desarrollo.",
  //   icon: <FontAwesomeIcon icon={faBullseye} />,
  //   route: "/planear-metas",
  // },
  // {
  //   title: "Crear planes de acción",
  //   description: "Elabore planes de acción específicos para alcanzar sus metas.",
  //   icon: <FontAwesomeIcon icon={faTasks} />,
  //   route: "/crear-planes-accion",
  // },
  // {
  //   title: "Ver tableros de control",
  //   description: "Consulte los tableros de control para obtener una visión general.",
  //   icon: <FontAwesomeIcon icon={faChartBar} />,
  //   route: "/ver-tableros-control",
  // },
];

const Wizard: React.FC = () => {
  const router = useRouter();
  const { hasRole } = useCurrentUser();

  const onMenuItemClick = (route: string) => {
    router.push(route);
  };

  return (
    <Card title="Asistente de Seguimiento">
      <Space direction="vertical" size="middle" style={{ display: "flex" }}>
        <Alert
          message="Seleccione la acción que desea realizar para abrir un asistente que lo guiará paso a paso. Aquí encontrará las opciones más comunes para comenzar."
          type="info"
          showIcon
          style={{ width: "50%" }}
        />

        <List
          grid={{ gutter: 16, column: 2 }}
          itemLayout="horizontal"
          dataSource={menuItems.filter((item) => hasRole(item.roles))}
          renderItem={(item) => (
            <List.Item onClick={() => onMenuItemClick(item.route)}>
              <Card
                hoverable
                onClick={() => onMenuItemClick(item.route)}
                style={{ textAlign: "center" }}
              >
                <div style={{ fontSize: "24px", marginBottom: "8px" }}>{item.icon}</div>
                <div style={{ fontSize: "18px", fontWeight: "bold" }}>{item.title}</div>
                <div style={{ fontSize: "14px", color: "#888" }}>{item.description}</div>
              </Card>
            </List.Item>
          )}
        />
      </Space>
    </Card>
  );
};

export { Wizard };
