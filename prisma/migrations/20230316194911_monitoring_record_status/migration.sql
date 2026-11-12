/*
  Warnings:

  - Made the column `record_status` on table `monitoring_record` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
UPDATE monitoring_record SET record_status = 'PLANNED';
ALTER TABLE "monitoring_record" ALTER COLUMN "record_status" SET NOT NULL;
