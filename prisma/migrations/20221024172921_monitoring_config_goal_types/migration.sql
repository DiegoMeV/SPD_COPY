-- CreateTable
CREATE TABLE "monitoring_goal_type_config" (
    "id" SERIAL NOT NULL,
    "monitoring_config_id" INTEGER NOT NULL,
    "goal_type" "GoalType" NOT NULL,
    "dev_plan_level" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "monitoring_goal_type_config_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "monitoring_goal_type_config" ADD CONSTRAINT "monitoring_goal_type_config" FOREIGN KEY ("monitoring_config_id") REFERENCES "monitoring_config"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
