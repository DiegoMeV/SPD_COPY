import {
  AccumulationType,
  GoalType,
  SpentDoc,
  WeightingType,
  MonitoringStatus,
  SpdRole,
  PublicPoliticCategory,
  MonitoringResourcesOrigin,
  MonitoringResourceType,
  GoalMonitoringRecordStatus,
  GoalHistoryEvent,
  GoalActivitySource,
} from "../../graphql/gen/schema";
import {
  faCircleCheck,
  faCircleDot as faScrubber,
  faCalendarDays,
  faTriangleExclamation as faSensorTriangleExclamation,
  faCalendarCheck,
  IconDefinition,
  faThumbsUp,
  faDollarSign,
  faCalendarDays as faCalendarLinesPen,
  faCheck,
  faCheckDouble,
  faCircleDollarToSlot as faCircleDollar,
  faCheckCircle,
  faCircleExclamation as faCircleExclamationCheck,
  faCircleExclamation,
  faCalendarXmark as faCalendarExclamation,
} from "@fortawesome/free-solid-svg-icons";
import { TextProps } from "antd/es/typography/Text";

export const accumulationTypeCollection = [
  AccumulationType.Accumulated,
  AccumulationType.NoAccumulated,
  AccumulationType.Stock,
  AccumulationType.Capacity,
  AccumulationType.Flow,
  AccumulationType.Reduction,
  AccumulationType.AnnualReduction,
];

export const accumulationTypeMap: Partial<Record<AccumulationType, { tag: string }>> = {
  [AccumulationType.Accumulated]: { tag: "Acumulado" },
  [AccumulationType.NoAccumulated]: { tag: "No Acumulado" },
  [AccumulationType.AnnualReduction]: { tag: "Reducción Anual" },
  [AccumulationType.Capacity]: { tag: "Capacidad" },
  [AccumulationType.Flow]: { tag: "Flujo" },
  [AccumulationType.Reduction]: { tag: "Reducción" },
  [AccumulationType.Stock]: { tag: "Stock" },
};

export const goalTypeCollection = [
  GoalType.Product,
  GoalType.Result,
  GoalType.WellBeing,
  GoalType.Impact,
];

export const goalTypeMap: Partial<Record<GoalType, { tag: string; color: string }>> = {
  [GoalType.Product]: { tag: "Producto", color: "#9FD912" },
  [GoalType.Result]: { tag: "Resultado", color: "#52c41a" },
  [GoalType.WellBeing]: { tag: "Bienestar", color: "#52c41a" },
  [GoalType.Activity]: { tag: "Actividad", color: "blue" },
  [GoalType.Project]: { tag: "Proyecto", color: "green" },
  [GoalType.Impact]: { tag: "Impacto", color: "#52c41a" },
  [GoalType.ActionPlan]: { tag: "Plan de Acción", color: "blueviolet" },
  [GoalType.ActionPlanActivity]: { tag: "Meta de Plan de Acción", color: "orange" },
};

export const selectGoalTypeCollection = [
  GoalType.Product,
  GoalType.Result,
  GoalType.WellBeing,
  GoalType.Impact,
  GoalType.Activity,
  GoalType.ActionPlan,
];

export const selectGoalTypeMap: Partial<Record<GoalType, { tag: string }>> = {
  [GoalType.Product]: { tag: "Metas de Producto" },
  [GoalType.Result]: { tag: "Metas de Resultado" },
  [GoalType.WellBeing]: { tag: "Metas de Bienestar" },
  [GoalType.Activity]: { tag: "Proyectos y Actividades" },
  [GoalType.Impact]: { tag: "Metas Impacto" },
  [GoalType.ActionPlan]: { tag: "Planes de Acción" },
};

export const spentDocMap: Partial<Record<SpentDoc, { tag: string }>> = {
  [SpentDoc.Commitment]: { tag: "Compromiso" },
  [SpentDoc.Obligation]: { tag: "Obligación" },
  [SpentDoc.Payment]: { tag: "Pago" },
};

export const weightingTypeMap: Partial<Record<WeightingType, { tag: string }>> = {
  [WeightingType.Financial]: { tag: "Financiero" },
  [WeightingType.Hierarchy]: { tag: "Estructura del plan" },
  [WeightingType.Manual]: { tag: "Manual" },
};
export const monitoringStatusMap: Partial<
  Record<MonitoringStatus, { tag: string; icon: IconDefinition; color?: string }>
> = {
  [MonitoringStatus.Closed]: { tag: "Cerrado", icon: faThumbsUp, color: "green" },
  [MonitoringStatus.Created]: { tag: "Creado", icon: faScrubber, color: "black" },
  [MonitoringStatus.Reporting]: {
    tag: "Reportado",
    icon: faSensorTriangleExclamation,
    color: "darkorange",
  },
  [MonitoringStatus.Reviewing]: { tag: "Revisado", icon: faCalendarCheck, color: "green" },
  [MonitoringStatus.Scheduling]: { tag: "Programado", icon: faCalendarDays, color: "black" },
  [MonitoringStatus.Validating]: { tag: "Validado", icon: faCircleCheck, color: "blue" },
};

export const SPDRoleCollection = [
  SpdRole.Operator,
  SpdRole.Validator,
  SpdRole.Auditor,
  SpdRole.Admin,
];

export const SPDRoleMap: Partial<Record<SpdRole, { tag: string }>> = {
  [SpdRole.Operator]: { tag: "Operador de Seguimiento - Reporta" },
  [SpdRole.Validator]: { tag: "Jefe de Oficina - Valida" },
  [SpdRole.Auditor]: { tag: "Administrador de Seguimiento - Revisa" },
  [SpdRole.Admin]: { tag: "Súper Administrador" },
};

export const publicPoliticCategoryMap: Partial<Record<PublicPoliticCategory, { tag: string }>> = {
  [PublicPoliticCategory.Peace]: { tag: "Paz" },
  [PublicPoliticCategory.Territory]: { tag: "Entidad" },
  [PublicPoliticCategory.Victims]: { tag: "Víctimas" },
};

export const monitoringResourcesOriginCollection = [
  MonitoringResourcesOrigin.Financial,
  MonitoringResourcesOrigin.User,
  MonitoringResourcesOrigin.UserAndFinancial,
];

export const monitoringResourcesOriginMap: Partial<
  Record<MonitoringResourcesOrigin, { tag: string; shortTag: string }>
> = {
  [MonitoringResourcesOrigin.Financial]: { tag: "Integración Financiera", shortTag: "Apropiado" },
  [MonitoringResourcesOrigin.User]: { tag: "Digitados por el Usuario", shortTag: "Programación" },
  [MonitoringResourcesOrigin.UserAndFinancial]: {
    tag: "Digitados por el Usuario + Integración Financiera",
    shortTag: "Usuario + Integración",
  },
};

export const monitoringResourceTypeMap: Partial<
  Record<MonitoringResourceType, { tag: string; tagPlural: string }>
> = {
  [MonitoringResourceType.Commitment]: { tag: "Compromiso", tagPlural: "Compromisos" },
  [MonitoringResourceType.Obligation]: { tag: "Obligación", tagPlural: "Obligaciones" },
  [MonitoringResourceType.Payment]: { tag: "Pago", tagPlural: "Pagos" },
};

export const goalCurrentStatusMap: Partial<
  Record<
    GoalMonitoringRecordStatus,
    {
      tag: string;
      style?: Omit<React.CSSProperties, "border"> & {
        primaryColor?: string;
        secondaryColor?: string;
        opacity?: string;
        border?: boolean;
      };
      icon: IconDefinition;
      textType: TextProps["type"];
    }
  >
> = {
  [GoalMonitoringRecordStatus.New]: {
    tag: "Sin Programar",
    icon: faCircleDollar,
    textType: "secondary",
    style: {
      primaryColor: "#0f1129",
      secondaryColor: "#0f1129",
      opacity: "0.02",
      border: true,
    },
  },
  [GoalMonitoringRecordStatus.Scheduled]: {
    tag: "Programada",
    icon: faCircleDollar,
    style: {
      primaryColor: "#008000",
      secondaryColor: "#008000",
      opacity: "0.4",
      border: true,
    },
    textType: "success",
  },
  [GoalMonitoringRecordStatus.PartiallyScheduled]: {
    tag: "Programada Parcial",
    icon: faCircleDollar,
    style: {
      primaryColor: "#f99c07",
      secondaryColor: "#f99c07",
      opacity: "0.4",
      border: true,
    },
    textType: "warning",
  },
  [GoalMonitoringRecordStatus.Reported]: {
    tag: "Reportada",
    icon: faCalendarLinesPen,
    style: {
      primaryColor: "#008000",
      secondaryColor: "#008000",
      opacity: "0.4",
    },
    textType: "success",
  },
  [GoalMonitoringRecordStatus.NoReported]: {
    tag: "Sin Reportar",
    icon: faCalendarLinesPen,
    style: {
      primaryColor: "#1d2f4e",
      secondaryColor: "#1e2f4d",
      opacity: "0.4",
    },
    textType: "success",
  },
  [GoalMonitoringRecordStatus.Validated]: {
    tag: "Validada",
    icon: faCheckCircle,
    style: {
      primaryColor: "#008000",
      secondaryColor: "#008000",
      opacity: "0.4",
      border: true,
    },
    textType: "success",
  },
  [GoalMonitoringRecordStatus.NoValidated]: {
    tag: "Sin Validar",
    icon: faCircleExclamationCheck,
    style: {
      primaryColor: "#1d2f4e",
      secondaryColor: "#1e2f4d",
      opacity: "0.15",
    },
    textType: "success",
  },
  [GoalMonitoringRecordStatus.Reviewed]: {
    tag: "Revisada",
    icon: faCheckDouble,
    style: {
      primaryColor: "#008000",
      secondaryColor: "#008000",
      opacity: "1.0",
      border: true,
      backgroundColor: "rgba(0, 128, 0, 0.4)",
    },
    textType: "success",
  },
  [GoalMonitoringRecordStatus.NoReviewed]: {
    tag: "Sin Revisar",
    icon: faCheckDouble,
    style: {
      primaryColor: "#008000",
      secondaryColor: "#ff0000",
      opacity: "1.0",
      border: true,
    },
    textType: "success",
  },
  [GoalMonitoringRecordStatus.Rejected]: {
    tag: "Rechazada",
    icon: faCalendarExclamation,
    style: {
      primaryColor: "#ef440b",
      secondaryColor: "#cb3b0b",
      opacity: "0.4",
    },
    textType: "warning",
  },
};

export const goalHistoryEventLocale: Record<GoalHistoryEvent, string> = {
  [GoalHistoryEvent.Created]: "Creada",
  [GoalHistoryEvent.Monitored]: "Reportada",
  [GoalHistoryEvent.Rejected]: "Rechazada",
  [GoalHistoryEvent.Reviewed]: "Aprobada",
  [GoalHistoryEvent.Scheduled]: "Programada",
  [GoalHistoryEvent.Updated]: "Actualizada",
  [GoalHistoryEvent.Validated]: "Validada",
};

export enum ProyectoEstadoProceso {
  REGISTRADO = "REGISTRADO",
  ACTUALIZACION = "ACTUALIZACION",
  FINALIZADO = "FINALIZADO",
  RADICADO = "RADICADO",
}

export const proyectoEstadoProcesoMap: Record<ProyectoEstadoProceso, string> = {
  [ProyectoEstadoProceso.REGISTRADO]: "Registrado",
  [ProyectoEstadoProceso.ACTUALIZACION]: "En Actualización",
  [ProyectoEstadoProceso.FINALIZADO]: "Finalizado",
  [ProyectoEstadoProceso.RADICADO]: "Radicado",
};

export const goalActivitySourceCollection = [GoalActivitySource.Manual, GoalActivitySource.Siif];

export const goalActivitySourceMap: Partial<Record<GoalActivitySource, { tag: string }>> = {
  [GoalActivitySource.Manual]: { tag: "Manual" },
  [GoalActivitySource.Siif]: { tag: "Obtener de SIIF" },
};

export const monitoringLabelMap: Record<GoalType, { singular: string; plural: string }> = {
  [GoalType.ActionPlan]: { singular: "Plan de Acción", plural: "Planes de Acción" },
  [GoalType.ActionPlanActivity]: {
    singular: "Meta Plan de Acción",
    plural: "Metas Plan de Acción",
  },
  [GoalType.Activity]: { singular: "Actividad", plural: "Actividades" },
  [GoalType.Impact]: { singular: "Meta", plural: "Metas" },
  [GoalType.Product]: { singular: "Meta", plural: "Metas" },
  [GoalType.Result]: { singular: "Meta", plural: "Metas" },
  [GoalType.WellBeing]: { singular: "Meta", plural: "Metas" },
  [GoalType.Project]: { singular: "Proyecto", plural: "Proyectos" },
  [GoalType.PublicPolitic]: { singular: "Política Pública", plural: "Políticas Públicas" },
};

export function convertPathToArray(path: string): string[] {
  const segments = path.split("/").filter(Boolean); // Split the path and remove empty segments
  const result = [];
  for (let i = segments.length; i > 0; i--) {
    const segment = "/" + segments.slice(0, i).join("/");
    result.push(segment + (i !== segments.length ? "/" : ""));
  }
  return result;
}
