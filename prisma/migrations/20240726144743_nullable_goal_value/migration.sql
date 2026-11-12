-- AlterTable
ALTER TABLE "goal" ALTER COLUMN "goal_value" DROP NOT NULL;

-- AlterTable
ALTER TABLE "monitoring_record" ALTER COLUMN "goal_value" DROP NOT NULL;
