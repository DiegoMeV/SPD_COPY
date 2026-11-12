-- AlterTable
ALTER TABLE "dev_plan_level" ADD COLUMN     "weighting" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "goal" ADD COLUMN     "weighting" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "monitoring_record" ADD COLUMN     "weighting" DOUBLE PRECISION;
