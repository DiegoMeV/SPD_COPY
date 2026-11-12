import * as path from 'path';
import * as csv from 'fast-csv';

export type MetaTsv = {
    ID: string;
    CODIGO: string;
    NOMBRE: string;
    DESCRIPCION: string;
};

export type MetaRow = {
    id: number;
    codigo: string;
    nombre: string;
    descripcion: string;
};

function parseMetas(path: string, rowProcessor: (row: MetaTsv) => MetaRow): Promise<MetaRow[]> {
    return new Promise((resolve, reject) => {
        const data: MetaRow[] = [];
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

export const metas = async () => {
    const data = await parseMetas(
        path.resolve(__dirname, 'siif_meta.tsv'),
        (row) => ({
            id: parseInt(row.ID),
            codigo: row.CODIGO,
            descripcion: row.DESCRIPCION,
            nombre: row.NOMBRE,
        }));

    return data;
} 
