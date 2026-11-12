import { GetDevPlanQuery } from "../../graphql/gen/ops";
import { GoalType } from "../../graphql/gen/schema";

export interface GoalCount {
  goalType: GoalType;
  count: number;
}

export interface DataNode {
  title?: string;
  htmlTitle?: string | React.ReactNode;
  code?: string;
  weighting?: number | null;
  key: React.Key;
  level?: number;
  isLeaf?: boolean;
  children?: DataNode[];
  goalCount?: GoalCount[];
  productCatalogId?: number | null;
}

export interface DevPlanConfigLevel {
  number: number;
  pluralName: string;
  singularName: string;
  isSectorLevel?: boolean;
  goalType?: GoalType;
}

export interface DevPlanConfig {
  levels: Array<DevPlanConfigLevel>;
}

export type DevPlan = NonNullable<GetDevPlanQuery["getDevPlan"]>;
