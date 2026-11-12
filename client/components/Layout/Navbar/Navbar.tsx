import React from "react";
import { useRouter } from "next/router";
import { Breadcrumb } from "antd";
import { useStoreState } from "../../../store";
import Link from "next/link";

const pathnameToText: Record<string, string> = {
  "/": "Inicio",
  "/config": "Configuración",
  "/config/users": "Usuarios",
  "/config/users/new": "Crear Usuario",
  "/config/users/edit": "Editar Usuario",
  "/config/entities": "Entidades",
  "/config/entities/new": "Nueva Entidad",
  "/config/entities/edit": "Editar Entidad",
  "/config/dev-plans": "Planes de Desarrollo",
  "/config/dev-plans/copy-levels": "Copiar Plan",
  "/config/dev-plans/new": "Nuevo",
  "/config/dev-plans/[id]/details": "Detalles",
  "/config/dev-plans/[id]/edit": "Editar",
  "/config/dev-plans/[id]/levels": "Niveles",
  "/config/goals": "Metas",
  "/config/projects": "Proyectos",
  "/config/projects/[project]": "Detalle Proyecto",
  "/config/monitoring": "Seguimiento",
  "/catalogs": "Catálogos",
  "/catalogs/products": "Catálogo de Productos",
  "/catalogs/ods": "Objetivos de Desarrollo Sostenible",
  "/catalogs/units": "Unidades de Medida",
  "/config/policies": "Políticas",
  "/config/policies/components": "Componentes",
  "/config/policies/national": "Políticas Nacionales",
  "/config/policies/territorial": "Políticas Territoriales",
  "/basic/macro-projects": "Macro Proyectos",
  "/goals": "Metas",
  "/projects": "Proyectos",
  "/goals/catalog": "Catálogo de Metas",
  "/goals/catalog/hierarchy": "Por Estructura del Plan",
  "/goals/catalog/list": "Listado General",
  "/goals/programming": "Programación de Metas",
  "/monitoring": "Seguimiento",
  "/monitoring/config": "Parámetros de Seguimiento",
  "/monitoring/config/[id]": "Detalle",
  "/monitoring/config/new": "Crear Seguimiento",
  "/monitoring/config/edit": "Editar Seguimiento",
  "/monitoring/action-plans": "Planes de Acción",
  "/monitoring/action-plans/config": "Configuraciónn",
  "/monitoring/action-plans/plans": "Catálogo",
  "/monitoring/action-plans/schedule": "Programación",
  "/monitoring/action-plans/report": "Reporte",
  "/monitoring/action-plans/validation": "Validación",
  "/monitoring/action-plans/review": "Revisión",
  "/monitoring/projects": "Proyectos",
  "/monitoring/projects/config": "Configuración",
  "/monitoring/projects/projects": "Listado de Proyectos",
  "/monitoring/projects/[project]": "Detalle",
  "/monitoring/projects/schedule": "Programación",
  "/monitoring/projects/report": "Reporte",
  "/monitoring/goals": "Metas",
  "/monitoring/goals/config": "Configuración",
  "/monitoring/goals/goals": "Catálogo",
  "/monitoring/goals/schedule": "Programación",
  "/monitoring/goals/report": "Reporte",
  "/monitoring/goals/validation": "Validación",
  "/monitoring/goals/review": "Revisión",
  "/monitoring/goals/dashboard": "Tableros de Control",
  "/monitoring/schedule": "Programación de Metas",
  "/monitoring/track": "Reportar Seguimiento",
  "/monitoring/validate": "Validar Seguimiento",
  "/monitoring/review": "Revisar Seguimiento",
  "/user": "Usuario",
  "/user/change-password": "Cambiar Clave",
  "/user/profile": "Mi perfil",
  "/spp": "Políticas Públicas",
  "/spp/monitoring": "Seguimiento",
  "/spp/monitoring/config": "Parámetros de Seguimiento",
  "/spp/monitoring/actions": "Acciones",
  "/wizard": "Asistente de Seguimiento",
};

export const Navbar: React.FC = () => {
  const router = useRouter();
  const user = useStoreState((state) => state.user.data);

  const pathnameAndText = Object.entries(pathnameToText).filter(([pathname, _]) =>
    router.pathname.startsWith(pathname),
  );

  if (!user) return null;

  return (
    <>
      <Breadcrumb style={{ margin: "16px 0" }}>
        {pathnameAndText.flatMap(([pathname, crumb], i) => {
          return [
            <Breadcrumb.Item key={i}>
              <Link href={pathname}>{crumb}</Link>
            </Breadcrumb.Item>,
          ];
        })}
      </Breadcrumb>
    </>
  );
};
