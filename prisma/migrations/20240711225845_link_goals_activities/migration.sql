-- CreateEnum
CREATE TYPE "GoalActivitySource" AS ENUM ('MANUAL', 'SIIF');

-- AlterTable
ALTER TABLE "dev_plan" ADD COLUMN     "goal_activity_source" "GoalActivitySource" DEFAULT 'SIIF';

-- CreateTable
CREATE TABLE "goal_to_activity" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "goal_id" INTEGER NOT NULL,
    "activity_id" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" INTEGER,

    CONSTRAINT "goal_to_activity_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "goal_to_activity_goal_id_activity_id_key" ON "goal_to_activity"("goal_id", "activity_id");

-- AddForeignKey
ALTER TABLE "goal_to_activity" ADD CONSTRAINT "goal_to_activity_tenant" FOREIGN KEY ("tenant_id") REFERENCES "tenant"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "goal_to_activity" ADD CONSTRAINT "goal_to_activity_goal" FOREIGN KEY ("goal_id") REFERENCES "goal"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
