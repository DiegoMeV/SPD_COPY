import * as path from "path";
import * as csv from "fast-csv";
import { LocationType, GeoLocation } from "@prisma/client";

export type NeighborhoodTsv = {
  CODIGO_COMUNA: string;
  COMUNA: string;
  CODIGO_BARRIO: string;
  BARRIO: string;
};

export type NeighborhoodRow = {
  codigoComuna?: string;
  comuna: string;
  codigoBarrio?: string;
  barrio: string;
};

export type RuralSettlementTsv = {
  CODIGO_CORREGIMIENTO: string;
  CORREGIMIENTO: string;
  CODIGO_VEREDA: string;
  VEREDA: string;
};

export type RuralSettlementRow = {
  codigoCorregimiento?: string;
  corregimiento: string;
  codigoVereda?: string;
  vereda: string;
};

function parseNeighborhoods(
  path: string,
  rowProcessor: (row: NeighborhoodTsv) => NeighborhoodRow,
): Promise<NeighborhoodRow[]> {
  return new Promise((resolve, reject) => {
    const data: NeighborhoodRow[] = [];
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

export const neighborhoods = async () => {
  const data = await parseNeighborhoods(path.resolve(__dirname, "neighborhoods.tsv"), (row) => ({
    codigoComuna: row.CODIGO_COMUNA,
    comuna: row.COMUNA,
    codigoBarrio: row.CODIGO_BARRIO,
    barrio: row.BARRIO,
  }));

  return data;
};

function parseRuralSettlements(
  path: string,
  rowProcessor: (row: RuralSettlementTsv) => RuralSettlementRow,
): Promise<RuralSettlementRow[]> {
  return new Promise((resolve, reject) => {
    const data: RuralSettlementRow[] = [];
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

export const ruralSettlements = async () => {
  const data = await parseRuralSettlements(
    path.resolve(__dirname, "ruralSettlements.tsv"),
    (row) => ({
      codigoCorregimiento: row.CODIGO_CORREGIMIENTO,
      corregimiento: row.CORREGIMIENTO,
      codigoVereda: row.CODIGO_VEREDA,
      vereda: row.VEREDA,
    }),
  );

  return data;
};

export const initialLocations: Array<Pick<GeoLocation, "code" | "name" | "locationType">> = [
  {
    code: "66001",
    name: "Municipio de Pereira",
    locationType: LocationType.MUNICIPALITY,
  },
];
