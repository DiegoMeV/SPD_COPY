-- CreateEnum
CREATE TYPE "MonitoringRecordStatus" AS ENUM ('PLANNED', 'REPORTED', 'VALIDATED', 'REVIEWED', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "MonitoringResourceType" AS ENUM ('MANUAL', 'DEFINITIVE', 'COMMITMENT', 'OBLIGATION', 'PAYMENT');

-- AlterTable
ALTER TABLE "monitoring_record" ADD COLUMN     "goal_achieved_value" DOUBLE PRECISION,
ADD COLUMN     "pi_goal_achieved_value" DOUBLE PRECISION,
ADD COLUMN     "record_status" "MonitoringRecordStatus";

-- CreateTable
CREATE TABLE "monitoring_record_resource" (
    "id" SERIAL NOT NULL,
    "monitoring_record_id" INTEGER NOT NULL,
    "resource_type" "MonitoringResourceType" NOT NULL,
    "resources_capital" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "resources_cd" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "resources_cn" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "resources_credit" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "resources_de" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "resources_operation" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "resources_managment" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "resources_monopoly" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "resources_others" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "resources_rp" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "resources_sgp" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "resources_sgr" DOUBLE PRECISION NOT NULL DEFAULT 0,

    CONSTRAINT "monitoring_record_resource_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "monitoring_record_resource" ADD CONSTRAINT "monitoring_record_resource" FOREIGN KEY ("monitoring_record_id") REFERENCES "monitoring_record"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

INSERT INTO monitoring_record_resource(monitoring_record_id, resource_type, resources_capital, resources_cd, resources_cn,
    resources_credit, resources_de, resources_operation, resources_managment, resources_monopoly, resources_others, 
    resources_sgp, resources_sgr)
SELECT mr.id, CAST('DEFINITIVE' as "MonitoringResourceType"), resources_capital, resources_cd, resources_cn,
    resources_credit, resources_de, resources_operation, resources_managment, resources_monopoly, resources_others, 
    resources_sgp, resources_sgr
FROM   monitoring_record mr
WHERE  mr.record_type = 'SCHEDULED';
