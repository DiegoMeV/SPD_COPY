import * as path from 'path';
import * as csv from 'fast-csv';
import { dateFromFormat, str2Number } from "../../../client/utils/formatUtils";

export type ProyectoTsv = {
    PLAN: string;
    PROGRAMA: string;
    SECTOR: string;
    EJE: string;
    NIT_COMPANIA: string;
    PROYECTO: string;
    NOMBRE: string;
    AVANCE_CUALITATIVO: string;
    COD_SECTOR: string;
    COD_PROGRAMA: string;
    RUBRO_FUT: string;
    ANO: string;
    CODIGO: string;
    FECHA_REGISTRO: string;
    OBJETIVOS: string;
    DESCRIPCION: string;
    PRESENTADO_POR: string;
    FORMULADO_POR: string;
    FECHA_EVALUACION: string;
    EVALUADO_POR: string;
    VALOR: string;
    VER_DESDE: string;
    ESTADO: string;
    CODIGO_ENT_PRY: string;
    NOMBRE_ANT: string;
    FECHA_CREACION: string;
    USUARIO: string;
    OBSERVACION: string;
    ESTADO_PROCESO: string;
    SUBPROGRAMA: string;
    FECHA_VIABILIDAD: string;
    VIABILIZADO_POR: string;
    ID_SESION: string;
    VIABLE_TECNICAMENTE: string;
    VIABLE_ECONOMICAMENTE: string;
    VIABLE_FINANCIERAMENTE: string;
    VIABLE_INSTITUCIONALMENTE: string;
    VIABLE_AMBIENTALMENTE: string;
    VIABLE_SOSTENIBILIDAD: string;
    ID_ENTIDAD_PRESENTA: string;
    FICTICIO: string;
};

export type ProyectoRow = {
    plan: number;
    programa: number;
    sector: number;
    eje: number;
    nitCompania: string;
    proyecto: string;
    nombre: string;
    fechaRegistro?: Date;
    objetivos?: string;
    descripcion?: string;
    presentadoPor?: string;
    fechaEvaluacion?: Date;
    evaluadoPor?: string;
    valor?: number | null;
    verDesde?: number | null;
    fechaViabilidad?: Date;
    estadoProceso?: string;
    usuario?: string;
    fechaCreacion?: Date;
    observacion?: string;
    subprograma?: number | null;
    idEntidadPresenta?: number | null;
};

function parseProyectos(path: string, rowProcessor: (row: ProyectoTsv) => ProyectoRow): Promise<ProyectoRow[]> {
    return new Promise((resolve, reject) => {
        const data: ProyectoRow[] = [];
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

export const proyectos = async () => {
    const data = (await parseProyectos(
        path.resolve(__dirname, 'siif_proyecto.tsv'),
        (row) => ({
            plan: parseInt(row.PLAN),
            programa: parseInt(row.PROGRAMA),
            sector: parseInt(row.SECTOR),
            eje: parseInt(row.EJE),
            nitCompania: row.NIT_COMPANIA,
            proyecto: row.PROYECTO,
            nombre: row.NOMBRE,
            // fechaRegistro: row.FECHA_REGISTRO ? dateFromFormat(row.FECHA_REGISTRO, "dd/MM/yy") : undefined,
            objetivos: row.OBJETIVOS,
            descripcion: row.DESCRIPCION,
            presentadoPor: row.PRESENTADO_POR,
            // fechaEvaluacion: row.FECHA_EVALUACION ? dateFromFormat(row.FECHA_EVALUACION, "dd/MM/yy") : undefined,
            evaluadoPor: row.EVALUADO_POR,
            valor: row.VALOR ? str2Number(row.VALOR) : null,
            verDesde: row.VER_DESDE ? parseInt(row.VER_DESDE) : null,
            estado: row.ESTADO,
            codigoEntPry: row.CODIGO_ENT_PRY,
            vialibilizadoPor: row.VIABILIZADO_POR,
            // fechaViabilidad: row.FECHA_VIABILIDAD ? dateFromFormat(row.FECHA_VIABILIDAD, "dd/MM/yy") : undefined,
            estadoProceso: row.ESTADO_PROCESO,
            usuario: row.USUARIO,
            // fechaCreacion: row.FECHA_CREACION ? dateFromFormat(row.FECHA_CREACION, "dd/MM/yy") : undefined,
            observacion: row.OBSERVACION,
            subprograma: row.SUBPROGRAMA ? parseInt(row.SUBPROGRAMA) : null,
            idEntidadPresenta: row.ID_ENTIDAD_PRESENTA ? parseInt(row.ID_ENTIDAD_PRESENTA) : null,
        }))).filter(p => p.nitCompania === '890102006');

    return data;
} 
