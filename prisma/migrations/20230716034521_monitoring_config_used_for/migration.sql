-- CreateEnum
CREATE TYPE "MonitoringConfigUsedFor" AS ENUM ('DEVELOPMENT_PLANS', 'PUBLIC_POLITICS');

-- AlterTable
ALTER TABLE "monitoring_config" ADD COLUMN     "used_for" "MonitoringConfigUsedFor" DEFAULT 'DEVELOPMENT_PLANS';

UPDATE monitoring_config
SET    used_for = 'DEVELOPMENT_PLANS'
WHERE  dev_plan_id IS NOT NULL;

UPDATE monitoring_config
SET    used_for = 'PUBLIC_POLITICS'
WHERE  dev_plan_id IS NULL;
