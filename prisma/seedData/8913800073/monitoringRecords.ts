import * as childProcess from "child_process";
import * as path from "path";
import * as csv from "fast-csv";
import {
  MonitoringRecordStatus,
  MonitoringResourceType,
  PrismaClient,
  SpentDoc,
} from "@prisma/client";
import { MonitoringRecordRow } from "../common/types";
import { round2dp } from "../../../client/utils/formatUtils";

const TENANT_KEY = "8913800073";
const prisma = new PrismaClient();

export type MonitoringRecordTsv = {
  ID: number;
  NIT_COMPANIA: string;
  PERIODO: string;
  SUBPERIODO: string;
  ID_META: number;
  PONDERACION: number;
  VALOR_ESPERADO: number;
  RECURSOS_CN: number;
  RECURSOS_CD: number;
  RECURSOS_CREDITO: number;
  RECURSOS_FUNCIONAMIENTO: number;
  RECURSOS_GESTION: number;
  RECURSOS_OTROS: number;
  RECURSOS_RP: number;
  RECURSOS_SGP: number;
  RECURSOS_SGR: number;
  RECURSOS: number;
  VALOR_LOGRADO: number;
  EJECUCION_CN: number;
  EJECUCION_CD: number;
  EJECUCION_CREDITO: number;
  EJECUCION_FUNCIONAMIENTO: number;
  EJECUCION_GESTION: number;
  EJECUCION_OTROS: number;
  EJECUCION_RP: number;
  EJECUCION_SGP: number;
  EJECUCION_SGR: number;
  EJECUCION: number;
  ESTADO: string;
  USUARIO: string;
  FECHA: string;
  USUARIO_VALIDA: string;
  FECHA_VALIDA: string;
  USUARIO_REVISA: string;
  FECHA_REVISA: string;
  OBSERVACION: string;
  OBSERVACION_COMO: string;
  OBSERVACION_IMPACTO: string;
  OBSERVACION_EVIDENCIA: string;
  OBSERVACION_DIFICULTAD: string;
  ESTADO2: string;
  USUARIO_VALIDA2: string;
  FECHA_VALIDA2: string;
  COD_META: string;
  MES_INICIO: number;
  MES_FIN: number;
  PERIODO_PROGRAMADO: string;
  MES_INICIO_EJECUCION: number;
  MES_FIN_EJECUCION: number;
  CV_H_PI: number;
  CV_M_PI: number;
  CV_H_NINO: number;
  CV_M_NINO: number;
  CV_H_ADOLESCENTES: number;
  CV_M_ADOLESCENTES: number;
  CV_H_JOVENES: number;
  CV_M_JOVENES: number;
};

function decompressZipFile(zipFilePath: string, outputDirectory: string): void {
  try {
    // Execute the unzip shell command
    const command = `unzip -o ${zipFilePath} -d ${outputDirectory}`;
    childProcess.execSync(command);
  } catch (error) {
    console.error("Error decompressing zip file:", error);
  }
}

function getMonitoringResourceType(spentDocs: SpentDoc[]): MonitoringResourceType {
  const spentDoc = spentDocs?.[0];
  if (spentDoc === SpentDoc.COMMITMENT) return MonitoringResourceType.COMMITMENT;
  if (spentDoc === SpentDoc.OBLIGATION) return MonitoringResourceType.OBLIGATION;
  if (spentDoc === SpentDoc.PAYMENT) return MonitoringResourceType.PAYMENT;

  return MonitoringResourceType.OBLIGATION;
}

function parseMonitoringRecords(
  path: string,
  rowProcessor: (row: MonitoringRecordTsv) => MonitoringRecordRow | undefined,
): Promise<MonitoringRecordRow[]> {
  return new Promise((resolve, reject) => {
    const data: MonitoringRecordRow[] = [];
    csv
      .parseFile(path, { headers: true, delimiter: "\t" })
      .on("error", reject)
      .on("data", (row) => {
        const processedRow = rowProcessor(row);
        if (processedRow) {
          data.push(processedRow);
        }
      })
      .on("end", () => {
        resolve(data);
      });
  });
}

function calculateFinancialIndicator(resources: MonitoringRecordRow["resources"]) {
  const calculateTotals = (resource: MonitoringRecordRow["resources"][number]) =>
    resource.capital +
      resource.cd +
      resource.cn +
      resource.credit +
      resource.operation +
      resource.management +
      resource.others +
      resource.rp +
      resource.sgp +
      resource.sgr ?? 0;
  const schedulingTotals = calculateTotals(resources[0]);
  const trackingTotals = calculateTotals(resources[1]);
  return trackingTotals ? round2dp(Math.min(trackingTotals / schedulingTotals, 1.0), 4) : 0;
}

const getMonitoringRecords = async () => {
  const monitoringConfigs = await prisma.monitoringConfig.findMany({
    where: {
      tenant: {
        key: TENANT_KEY,
      },
    },
  });
  const goals = await prisma.goal.findMany({
    where: {
      devPlanLevel: {
        devPlan: {
          tenant: {
            key: TENANT_KEY,
          },
        },
      },
    },
  });

  const getMonitoringConfig = (period: number, subperiod: number) => {
    const monitoringConfig = monitoringConfigs.find(
      (monitoringConfig) =>
        monitoringConfig.period === period && monitoringConfig.subperiod === subperiod,
    );
    return monitoringConfig;
  };

  const getGoal = (idMeta: number) => {
    const goal = goals.find((goal) => goal.originId == idMeta);
    return goal;
  };

  const monitoringRecords = await parseMonitoringRecords(
    path.resolve(__dirname, "monitoring_records.tsv"),
    (row) => {
      const monitoringConfig = getMonitoringConfig(Number(row.PERIODO), Number(row.SUBPERIODO));
      const goal = getGoal(row.ID_META);
      if (!monitoringConfig || !goal) return undefined;
      if (row.PERIODO !== row.PERIODO_PROGRAMADO) return undefined;

      const goalValue = Number(row.VALOR_ESPERADO ?? "0.0");
      const goalAchievedValue = Number(row.VALOR_LOGRADO ?? "0.0");

      const resources = [
        {
          capital: 0,
          cd: Number(row.RECURSOS_CD ?? "0.0"),
          cn: Number(row.RECURSOS_CN ?? "0.0"),
          credit: Number(row.RECURSOS_CREDITO ?? "0.0"),
          management: Number(row.RECURSOS_GESTION ?? "0.0"),
          operation: Number(row.RECURSOS_FUNCIONAMIENTO ?? "0.0"),
          others: Number(row.RECURSOS_OTROS ?? "0.0"),
          rp: Number(row.RECURSOS_RP ?? "0.0"),
          sgp: Number(row.RECURSOS_SGP ?? "0.0"),
          sgr: Number(row.RECURSOS_SGR ?? "0.0"),
          resourceType: MonitoringResourceType.DEFINITIVE,
        },
        {
          capital: 0,
          cd: Number(row.EJECUCION_CD ?? "0.0"),
          cn: Number(row.EJECUCION_CN ?? "0.0"),
          credit: Number(row.EJECUCION_CREDITO ?? "0.0"),
          management: Number(row.EJECUCION_GESTION ?? "0.0"),
          operation: Number(row.EJECUCION_FUNCIONAMIENTO ?? "0.0"),
          others: Number(row.EJECUCION_OTROS ?? "0.0"),
          rp: Number(row.EJECUCION_RP ?? "0.0"),
          sgp: Number(row.EJECUCION_SGP ?? "0.0"),
          sgr: Number(row.EJECUCION_SGR ?? "0.0"),
          resourceType: getMonitoringResourceType(monitoringConfig.spentDocs),
        },
      ];

      const financialIndicator = calculateFinancialIndicator(resources);
      return {
        monitoringConfigId: monitoringConfig.id,
        period: Number(row.PERIODO),
        goalId: goal.id,
        goalValue,
        fromMonth: Number(row.MES_INICIO_EJECUCION ?? "1"),
        toMonth: Number(row.MES_FIN_EJECUCION ?? "12"),
        goalAchievedValue,
        weighting: Number(row.PONDERACION ?? "0.0"),
        notes: row.OBSERVACION,
        questionHow: row.OBSERVACION_COMO,
        questionResult: row.OBSERVACION_IMPACTO,
        questionEvidence: row.OBSERVACION_EVIDENCIA,
        questionProblem: row.OBSERVACION_DIFICULTAD,
        piGoalValue: 0,
        piGoalAchievedValue: 0,
        physicalIndicator: goalValue
          ? round2dp(Math.min(goalAchievedValue / goalValue, 1), 4)
          : 0.0,
        totalPeople: 0,
        recordStatus: MonitoringRecordStatus.REVIEWED,
        resources: [
          resources[0],
          {
            ...resources[1],
            financialIndicator: financialIndicator,
          },
        ],
      };
    },
  );

  return monitoringRecords;
};

export const monitoringRecords = async () => {
  // Decompress the zip file
  decompressZipFile(`${__dirname}/monitoring_records.tsv.zip`, `${__dirname}`);

  // Parse and get the data of the uncompressed file
  const monitoringRecords = await getMonitoringRecords();

  // Delete the uncompressed file
  childProcess.execSync(`rm ${__dirname}/monitoring_records.tsv`);

  // Return the data
  return monitoringRecords;
};
