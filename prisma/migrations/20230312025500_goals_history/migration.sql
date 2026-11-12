-- CreateEnum
CREATE TYPE "GoalHistoryEvent" AS ENUM ('CREATED', 'UPDATED', 'SCHEDULED', 'MONITORED', 'VALIDATED', 'REVIEWED');

-- CreateTable
CREATE TABLE "goal_history" (
    "id" SERIAL NOT NULL,
    "goal_id" INTEGER,
    "monitoring_record_id" INTEGER,
    "event" "GoalHistoryEvent" NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" INTEGER,

    CONSTRAINT "goal_history_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "goal_history" ADD CONSTRAINT "goal_history" FOREIGN KEY ("goal_id") REFERENCES "goal"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "goal_history" ADD CONSTRAINT "goal_history_monitoring_record" FOREIGN KEY ("monitoring_record_id") REFERENCES "monitoring_record"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

INSERT INTO goal_history(goal_id, event, created_at, created_by)
SELECT id, CAST('CREATED' as "GoalHistoryEvent"), created_at, created_by
FROM   goal
UNION
SELECT id, CAST('UPDATED' as "GoalHistoryEvent"), updated_at, updated_by
FROM   goal
where  updated_at IS NOT NULL;
