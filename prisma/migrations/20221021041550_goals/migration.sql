/*
  Warnings:

  - You are about to drop the column `accumulationType` on the `goal` table. All the data in the column will be lost.
  - You are about to drop the column `dev_plan_id` on the `goal` table. All the data in the column will be lost.
  - You are about to drop the column `goalType` on the `goal` table. All the data in the column will be lost.
  - You are about to drop the column `unitsFactor` on the `goal` table. All the data in the column will be lost.
  - Added the required column `accumulation_type` to the `goal` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dev_plan_level_id` to the `goal` table without a default value. This is not possible if the table is not empty.
  - Added the required column `goal_type` to the `goal` table without a default value. This is not possible if the table is not empty.
  - Added the required column `units_factor` to the `goal` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "goal" DROP CONSTRAINT "goal_dev_plan";

-- AlterTable
ALTER TABLE "goal" DROP COLUMN "accumulationType",
DROP COLUMN "dev_plan_id",
DROP COLUMN "goalType",
DROP COLUMN "unitsFactor",
ADD COLUMN     "accumulation_type" "AccumulationType" NOT NULL,
ADD COLUMN     "dev_plan_level_id" INTEGER NOT NULL,
ADD COLUMN     "goal_type" "GoalType" NOT NULL,
ADD COLUMN     "is_base_value_not_available" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "ods_ids" JSONB,
ADD COLUMN     "parent_goal_id" INTEGER,
ADD COLUMN     "units_factor" INTEGER NOT NULL,
ADD COLUMN     "units_name" TEXT;

-- RenameForeignKey
ALTER TABLE "goal" RENAME CONSTRAINT "goal_itself" TO "goal_entity";

-- AddForeignKey
ALTER TABLE "goal" ADD CONSTRAINT "goal_itself" FOREIGN KEY ("parent_goal_id") REFERENCES "goal"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "goal" ADD CONSTRAINT "goal_dev_plan_level" FOREIGN KEY ("dev_plan_level_id") REFERENCES "dev_plan_level"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
