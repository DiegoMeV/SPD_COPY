/*
  Warnings:

  - A unique constraint covering the columns `[dev_plan_id,code]` on the table `goal` will be added. If there are existing duplicate values, this will fail.
  - Made the column `dev_plan_id` on table `goal` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "goal" ALTER COLUMN "dev_plan_id" SET NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "goal_dev_plan_id_code_key" ON "goal"("dev_plan_id", "code");
