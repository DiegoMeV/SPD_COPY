import { PrismaClient } from "@prisma/client";
import { data } from "../seedData";
import { MonitoringRecordRow } from "../seedData/common/types";

const prisma = new PrismaClient();

async function seedMonitoringRecords(tenantKey: string) {
  const monitoringRecords = data[tenantKey].monitoringRecords;

  if (typeof monitoringRecords === "function") {
    console.log(`[seedMonitoringRecords] Seeding monitoringRecords`);
    const monitoringRecordsData: MonitoringRecordRow[] = await monitoringRecords();
    console.log(
      `[seedMonitoringRecords] Number of monitoringRecords to create: ${monitoringRecordsData.length}`,
    );

    const chunkSize = 20;
    const numChunks = Math.ceil(monitoringRecordsData.length / chunkSize);
    let numCreatedRecords = 0;

    for (let i = 0; i < numChunks; i++) {
      const start = i * chunkSize;
      const end = start + chunkSize;
      const chunk = monitoringRecordsData.slice(start, end);

      const result = await Promise.all(
        chunk.map(async (monitoringRecord: MonitoringRecordRow) => {
          const { resources, ...monitoringRecordData } = monitoringRecord;
          const approvedRecordResult = await prisma.monitoringRecord.create({
            data: {
              ...monitoringRecordData,
              resources: {
                create: resources,
              },
            },
          });
          return approvedRecordResult.id;
        }),
      );
      numCreatedRecords += result.length;
    }

    console.log(
      `[seedMonitoringRecords] Number of monitoringRecords created: ${numCreatedRecords}`,
    );
  }
}

export { seedMonitoringRecords };
