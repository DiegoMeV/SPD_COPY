/*
  Warnings:

  - You are about to drop the column `budget_capital` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `budget_cd` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `budget_cn` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `budget_credit` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `budget_de` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `budget_managment` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `budget_monopoly` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `budget_operation` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `budget_others` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `budget_rp` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `budget_sgp` on the `monitoring_record` table. All the data in the column will be lost.
  - You are about to drop the column `budget_sgr` on the `monitoring_record` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "monitoring_record" DROP COLUMN "budget_capital",
DROP COLUMN "budget_cd",
DROP COLUMN "budget_cn",
DROP COLUMN "budget_credit",
DROP COLUMN "budget_de",
DROP COLUMN "budget_managment",
DROP COLUMN "budget_monopoly",
DROP COLUMN "budget_operation",
DROP COLUMN "budget_others",
DROP COLUMN "budget_rp",
DROP COLUMN "budget_sgp",
DROP COLUMN "budget_sgr",
ADD COLUMN     "resources_capital" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "resources_cd" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "resources_cn" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "resources_credit" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "resources_de" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "resources_managment" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "resources_monopoly" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "resources_operation" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "resources_others" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "resources_rp" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "resources_sgp" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "resources_sgr" DOUBLE PRECISION NOT NULL DEFAULT 0;
