/*
  Warnings:

  - Added the required column `status` to the `monitoring_config` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "MonitoringStatus" AS ENUM ('CREATED', 'SCHEDULING', 'REPORTING', 'VALIDATING', 'REVIEWING', 'CLOSED');

-- AlterTable
ALTER TABLE "monitoring_config" ADD COLUMN     "status" "MonitoringStatus" NOT NULL;
