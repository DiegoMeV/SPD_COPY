import { AccumulationType, GoalType } from "../../../graphql/gen/schema";
import * as path from "path";
import * as csv from "fast-csv";
import { PrismaClient } from "@prisma/client";
import { GoalRow } from "../common/types";

const TENANT_KEY = "8913800073";
const prisma = new PrismaClient();

export type ProductGoalsCsv = {
  ID: string;
  NIT_COMPANIA: string;
  ID_PLAN: number;
  ID_ENTIDAD: number;
  CODIGO: string;
  TIPO: string;
  NOMBRE: string;
  DESCRIPCION: string;
  PONDERACION: string;
  INDICADOR: string;
  UNIDAD: string;
  PERIODO: string;
  VALOR_BASE: string;
  FACTOR_BASE: string;
  COMPARADOR: string;
  VALOR_META: string;
  FACTOR_META: string;
  VALOR_PROGRAMADO: string;
  MES_INICIO: string;
  MES_FIN: string;
  ACCION: string;
  ID_FUT: number;
  ID_PLAN_ACCION: number;
  PROYECTO: number;
  ID_PADRE: number;
};

function parseProductGoals(
  path: string,
  rowProcessor: (row: ProductGoalsCsv) => GoalRow,
): Promise<GoalRow[]> {
  return new Promise((resolve, reject) => {
    const data: GoalRow[] = [];
    csv
      .parseFile(path, { headers: true, delimiter: "\t" })
      .on("error", reject)
      .on("data", (row) => {
        if (row.TIPO === "PRODUCTO") data.push(rowProcessor(row));
      })
      .on("end", () => {
        resolve(data);
      });
  });
}

export const goals = async () => {
  const entities = await prisma.entity.findMany({
    where: {
      tenant: {
        key: TENANT_KEY,
      },
    },
  });
  const devPlanLevels = await prisma.devPlanLevel.findMany({
    where: {
      devPlan: {
        tenant: {
          key: TENANT_KEY,
        },
      },
    },
    select: {
      id: true,
      originId: true,
      devPlanId: true,
    },
  });
  console.log(`[seedGoals] Number of devPlanLevels: ${devPlanLevels.length}`);
  const getEntityId = (tenantKey: string, entityId: number): number => {
    const entity = entities.find((e) => e.originId == entityId);
    if (!entity) {
      throw new Error(`Entity with origin id ${entityId} not found`);
    }
    return entity.id;
  };
  const getDevPlanLevelId = (tenantKey: string, idPlan: number) => {
    const devPlanLevel = devPlanLevels.find((d) => d.originId == idPlan);
    if (!devPlanLevel) {
      throw new Error(`Dev plan level with origin id ${idPlan} not found`);
    }
    return { devPlanLevelId: devPlanLevel.id, devPlanId: devPlanLevel.devPlanId };
  };
  const getAccumulationType = (action: string): AccumulationType => {
    if (action === "AUMENTO") {
      return AccumulationType.Accumulated;
    }
    if (action === "MANTENIMIENTO") {
      return AccumulationType.Stock;
    }
    if (action === "DISMINUCION") {
      return AccumulationType.Reduction;
    }
    return AccumulationType.NoAccumulated;
  };

  const productGoals = await parseProductGoals(path.resolve(__dirname, "goals.tsv"), (row) => ({
    isActive: true,
    ...getDevPlanLevelId(row.NIT_COMPANIA, row.ID_PLAN),
    entityId: getEntityId(row.NIT_COMPANIA, row.ID_ENTIDAD),
    goalType: GoalType.Product,
    code: row.CODIGO,
    name: row.NOMBRE || (row.DESCRIPCION ?? row.INDICADOR),
    indicator: row.INDICADOR,
    description: row.DESCRIPCION,
    accumulationType: getAccumulationType(row.ACCION),
    baseValue: row.VALOR_BASE ? parseFloat(row.VALOR_BASE) : null,
    goalValue: row.VALOR_META ? parseFloat(row.VALOR_META) : 0,
    unitsFactor: row.FACTOR_META ? parseFloat(row.FACTOR_META) : 0,
    unitsName: row.UNIDAD,
    isBaseValueNotAvailable: row.VALOR_BASE === null || row.VALOR_BASE === undefined,
    weighting: row.PONDERACION ? parseFloat(row.PONDERACION) : null,
    originId: parseInt(row.ID),
  }));
  return productGoals;
};
