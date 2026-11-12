/*
  Warnings:

  - You are about to drop the `monitoring_goal_type_config` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "monitoring_goal_type_config" DROP CONSTRAINT "monitoring_goal_type_config";

-- DropTable
DROP TABLE "monitoring_goal_type_config";
