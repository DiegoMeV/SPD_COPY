/*
  Warnings:

  - You are about to drop the column `record_type` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `resources_capital` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `resources_cd` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `resources_cn` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `resources_credit` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `resources_de` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `resources_managment` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `resources_monopoly` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `resources_operation` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `resources_others` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `resources_rp` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `resources_sgp` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `resources_sgr` on the `monitoring_record` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "monitoring_record" DROP COLUMN "record_type",
DROP COLUMN "resources_capital",
DROP COLUMN "resources_cd",
DROP COLUMN "resources_cn",
DROP COLUMN "resources_credit",
DROP COLUMN "resources_de",
DROP COLUMN "resources_managment",
DROP COLUMN "resources_monopoly",
DROP COLUMN "resources_operation",
DROP COLUMN "resources_others",
DROP COLUMN "resources_rp",
DROP COLUMN "resources_sgp",
DROP COLUMN "resources_sgr";

-- DropEnum
DROP TYPE "MonitoringRecordType";
