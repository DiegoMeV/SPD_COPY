import { AccumulationType, GoalType } from "../../../graphql/gen/schema";
import * as path from "path";
import * as csv from "fast-csv";
import { str2Number } from "../../../client/utils/formatUtils";

export type GoalRow = {
  devPlanId: number;
  devPlanLevelCode: string;
  entityId: number;
  goalType: GoalType;
  code: string;
  name?: string;
  description?: string;
  indicator: string;
  productCatalogCode?: string;
  unitsFactor: number;
  unitsName: string;
  baseValue?: number | null;
  isBaseValueNotAvailable: boolean;
  accumulationType: AccumulationType;
  goalValue: number;
  goal2020?: number;
  goal2021?: number;
  goal2022?: number;
  goal2023?: number;
};

export type WellBeingGoalsCsv = {
  devPlanId: string;
  devPlanLevelCode: string;
  entityId: string;
  goalType: string;
  code: string;
  indicator: string;
  baseValue: string;
  unitsFactor: string;
  unitsName: string;
  accumulationType: string;
  goalValue: string;
  goal2020: string;
  goal2021: string;
  goal2022: string;
  goal2023: string;
};

export type ProductGoalsCsv = {
  devPlanId: string;
  devPlanLevelCode: string;
  goalType: string;
  entityId: string;
  code: string;
  name: string;
  description: string;
  productCatalogCode: string;
  indicator: string;
  accumulationType: string;
  goalValue: string;
  goal2020: string;
  goal2021: string;
  goal2022: string;
  goal2023: string;
  resources2020: string;
  rp2020: string;
  sgp2020: string;
  sgr2020: string;
  cd2020: string;
  credito2020: string;
  otros2020: string;
  gestion2020: string;
  resources2021: string;
  rp2021: string;
  sgp2021: string;
  sgr2021: string;
  cd2021: string;
  credito2021: string;
  otros2021: string;
  gestion2021: string;
  resources2022: string;
  rp2022: string;
  sgp2022: string;
  sgr2022: string;
  cd2022: string;
  credito2022: string;
  otros2022: string;
  gestion2022: string;
  resources2023: string;
  rp2023: string;
  sgp2023: string;
  sgr2023: string;
  cd2023: string;
  credito2023: string;
  otros2023: string;
  gestion2023: string;
};

function parseWellBeingGoals(
  path: string,
  rowProcessor: (row: WellBeingGoalsCsv) => GoalRow,
): Promise<GoalRow[]> {
  return new Promise((resolve, reject) => {
    const data: GoalRow[] = [];
    csv
      .parseFile(path, { headers: true, delimiter: "\t" })
      .on("error", reject)
      .on("data", (row) => {
        data.push(rowProcessor(row));
      })
      .on("end", () => {
        resolve(data);
      });
  });
}

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
        data.push(rowProcessor(row));
      })
      .on("end", () => {
        resolve(data);
      });
  });
}

export const goals = async () => {
  const wellBeingGoals = await parseWellBeingGoals(
    path.resolve(__dirname, "goalsWellBeing.csv"),
    (row) => ({
      devPlanId: parseInt(row.devPlanId),
      devPlanLevelCode: row.devPlanLevelCode,
      entityId: parseInt(row.entityId),
      goalType: row.goalType as GoalType,
      code: row.code,
      indicator: row.indicator,
      baseValue: row.baseValue === "N.D" ? null : str2Number(row.baseValue),
      isBaseValueNotAvailable: row.baseValue === "N.D",
      goalValue: str2Number(row.goalValue),
      accumulationType: row.accumulationType as AccumulationType,
      unitsFactor: parseInt(row.unitsFactor),
      unitsName: row.unitsName,
    }),
  );
  const productGoals = await parseProductGoals(
    path.resolve(__dirname, "goalsProduct.csv"),
    (row) => ({
      devPlanId: parseInt(row.devPlanId),
      devPlanLevelCode: row.devPlanLevelCode,
      entityId: parseInt(row.entityId),
      goalType: row.goalType as GoalType,
      code: row.code,
      name: row.name,
      description: row.description,
      productCatalogCode: row.productCatalogCode,
      indicator: row.indicator,
      goalValue: str2Number(row.goalValue),
      accumulationType: row.accumulationType as AccumulationType,
      unitsFactor: row.goalValue.indexOf("%") > -1 ? 100 : 1,
      unitsName: row.goalValue.indexOf("%") > -1 ? "Porcentaje" : "Número",
      isBaseValueNotAvailable: false,
    }),
  );
  // return [...wellBeingGoals, ...productGoals];
  return [...productGoals];
};
