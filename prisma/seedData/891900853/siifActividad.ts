import * as path from "path";
import * as csv from "fast-csv";

export type ActividadTsv = {
  NIT_COMPANIA: string;
  PROYECTO: string;
  CODIGO_ACT: string;
  DESCRIPCION: string;
  ETAPA: string;
  COMPONENTE: string;
  CODIGO_UND: string;
  CANTIDAD: string;
  COD_SUBACT: string;
  ACTIVA: string;
  ID: string;
  ID_META: string;
  ID_PRODUCTO: string;
};

export type ActividadRow = {
  id: number;
  nitCompania: string;
  proyecto: string;
  codigoAct: number;
  descripcion: string;
  etapa: string;
  componente: string;
  codigoUnd?: number | null;
  cantidad?: number | null;
  codSubact?: number;
  activa?: string;
  codigo?: string;
  idMeta?: number | null;
  idProducto?: number | null;
};

function parseActividades(
  path: string,
  rowProcessor: (row: ActividadTsv) => ActividadRow,
): Promise<ActividadRow[]> {
  return new Promise((resolve, reject) => {
    const data: ActividadRow[] = [];
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

export const actividades = async () => {
  const data = (
    await parseActividades(path.resolve(__dirname, "siif_actividad.tsv"), (row) => ({
      id: parseInt(row.ID),
      nitCompania: row.NIT_COMPANIA,
      proyecto: row.PROYECTO,
      codigoAct: parseInt(row.CODIGO_ACT),
      descripcion: row.DESCRIPCION,
      etapa: row.ETAPA,
      componente: row.COMPONENTE,
      codigoUnd: row.CODIGO_UND ? parseInt(row.CODIGO_UND) : null,
      cantidad: row.CANTIDAD ? parseInt(row.CANTIDAD) : null,
      activa: row.ACTIVA,
      idMeta: row.ID_META ? parseInt(row.ID_META) : null,
      idProducto: row.ID_PRODUCTO ? parseInt(row.ID_PRODUCTO) : null,
    }))
  ).filter((a) => a.nitCompania === "891900853");

  return data;
};
