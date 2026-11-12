-- CreateEnum
CREATE TYPE "MonitoringResourcesOrigin" AS ENUM ('FINANCIAL', 'USER');

-- AlterTable
ALTER TABLE "monitoring_config" ADD COLUMN     "monitoring_resources_origin" "MonitoringResourcesOrigin" DEFAULT 'FINANCIAL';
