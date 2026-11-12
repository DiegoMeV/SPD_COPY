/*
  Warnings:

  - You are about to drop the column `tenant_id` on the `goal` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "goal" DROP CONSTRAINT "goal_tenant";

-- AlterTable
ALTER TABLE "goal" DROP COLUMN "tenant_id";
