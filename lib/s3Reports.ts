import ExcelJS from 'exceljs';
import s3 from "./s3";
import { reportsConfig } from './s3ReportsConfig';
import { v4 as uuidv4 } from 'uuid';
import { flattenObject } from './utils';

export interface GenerateExcelFileProps {
    reportName: string;
    data: Array<any> | undefined;
    worksheetName?: string;

};

export class S3Reports {
    private static _instance: S3Reports | undefined;

    private constructor(private data: S3Reports[] = []) { }

    static get instance() {
        if (this._instance === undefined) {
            this._instance = new this();
        }
        return this._instance;
    }

    async generateExcelFile({ reportName, data, worksheetName = "Datos" }: GenerateExcelFileProps): Promise<ExcelJS.Buffer> {
        const workbook = new ExcelJS.Workbook();
        const worksheet = workbook.addWorksheet(worksheetName);

        worksheet.columns = reportsConfig[reportName].columns;
        data?.forEach((row) => {
            worksheet.addRow(flattenObject(row));
        });

        return workbook.xlsx.writeBuffer();
    }

    async uploadExcelFile(buffer: ExcelJS.Buffer): Promise<AWS.S3.ManagedUpload.SendData | null> {
        if (!process.env.S3_BUCKET)
            throw new Error(`No se ha definido un bucket para generación de reportes`);

        const result = await s3
            .upload({
                Bucket: process.env.S3_BUCKET,
                Key: `tmp/reports/${uuidv4()}.xlsx`,
                Body: buffer,
                ContentType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            })
            .promise();
        return result;
    }

    async generateExcelReport({ reportName, data, worksheetName = "Datos" }: GenerateExcelFileProps): Promise<string | null> {
        const buffer = await this.generateExcelFile({ reportName, data, worksheetName });
        const result = await this.uploadExcelFile(buffer);

        if (result) {
            const url = await s3.getSignedUrlPromise('getObject', {
                Bucket: result.Bucket,
                Key: result.Key,
                Expires: 3600, // URL expires in 1 hour
            });
            return url;
        }

        return null;
    }
};