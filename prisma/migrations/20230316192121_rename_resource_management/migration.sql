/*
  Warnings:

  - You are about to drop the column `managment` on the `monitoring_record_resource` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "monitoring_record_resource" RENAME COLUMN "managment" TO "management";
