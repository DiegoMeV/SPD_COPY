import data890102006 from "./890102006";
import data8914800302 from "./8914800302";
import data891900853 from "./891900853";
import data8913800073 from "./8913800073";
import data891480085 from "./891480085";
import dataCommon from "./common";

// type DataFunction = () => Promise<any>;

export const data: Record<string, Record<string, unknown>> = {
  ...dataCommon,
  ...data890102006,
  ...data8914800302,
  ...data891900853,
  ...data8913800073,
  ...data891480085,
};
