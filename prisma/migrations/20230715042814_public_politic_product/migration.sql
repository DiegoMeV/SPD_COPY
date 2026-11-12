-- AlterEnum
ALTER TYPE "GoalType" ADD VALUE 'PUBLIC_POLITIC';

-- AlterTable
ALTER TABLE "goal" ADD COLUMN     "extra_entity_ids" JSONB,
ADD COLUMN     "linked_goal_ids" JSONB,
ALTER COLUMN "dev_plan_level_id" DROP NOT NULL,
ALTER COLUMN "dev_plan_id" DROP NOT NULL;
