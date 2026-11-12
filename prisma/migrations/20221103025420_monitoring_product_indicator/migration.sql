-- AlterTable
ALTER TABLE "goal" ADD COLUMN     "pi_base_value" DOUBLE PRECISION,
ADD COLUMN     "pi_goal_value" DOUBLE PRECISION,
ADD COLUMN     "pi_units_factor" INTEGER,
ADD COLUMN     "pi_units_name" TEXT;
