/*
  Warnings:

  - You are about to drop the column `resources_capital` on the `monitoring_record_resource` table. All the data in the column will be lost.
  - You are about to drop the column `resources_cd` on the `monitoring_record_resource` table. All the data in the column will be lost.
  - You are about to drop the column `resources_cn` on the `monitoring_record_resource` table. All the data in the column will be lost.
  - You are about to drop the column `resources_credit` on the `monitoring_record_resource` table. All the data in the column will be lost.
  - You are about to drop the column `resources_de` on the `monitoring_record_resource` table. All the data in the column will be lost.
  - You are about to drop the column `resources_managment` on the `monitoring_record_resource` table. All the data in the column will be lost.
  - You are about to drop the column `resources_monopoly` on the `monitoring_record_resource` table. All the data in the column will be lost.
  - You are about to drop the column `resources_operation` on the `monitoring_record_resource` table. All the data in the column will be lost.
  - You are about to drop the column `resources_others` on the `monitoring_record_resource` table. All the data in the column will be lost.
  - You are about to drop the column `resources_rp` on the `monitoring_record_resource` table. All the data in the column will be lost.
  - You are about to drop the column `resources_sgp` on the `monitoring_record_resource` table. All the data in the column will be lost.
  - You are about to drop the column `resources_sgr` on the `monitoring_record_resource` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "monitoring_record_resource" RENAME COLUMN "resources_capital" TO "capital";
ALTER TABLE "monitoring_record_resource" RENAME COLUMN "resources_cd" TO "cd";
ALTER TABLE "monitoring_record_resource" RENAME COLUMN "resources_cn" TO "cn";
ALTER TABLE "monitoring_record_resource" RENAME COLUMN "resources_credit" TO "credit";
ALTER TABLE "monitoring_record_resource" RENAME COLUMN "resources_de" TO "de";
ALTER TABLE "monitoring_record_resource" RENAME COLUMN "resources_managment" TO "managment";
ALTER TABLE "monitoring_record_resource" RENAME COLUMN "resources_monopoly" TO "monopoly";
ALTER TABLE "monitoring_record_resource" RENAME COLUMN "resources_operation" TO "operation";
ALTER TABLE "monitoring_record_resource" RENAME COLUMN "resources_others" TO "others";
ALTER TABLE "monitoring_record_resource" RENAME COLUMN "resources_rp" TO "rp";
ALTER TABLE "monitoring_record_resource" RENAME COLUMN "resources_sgp" TO "sgp";
ALTER TABLE "monitoring_record_resource" RENAME COLUMN "resources_sgr" TO "sgr";
