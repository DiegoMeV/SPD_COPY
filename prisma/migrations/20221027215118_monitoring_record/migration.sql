-- CreateEnum
CREATE TYPE "MonitoringRecordType" AS ENUM ('SCHEDULED', 'COMMITMENT', 'OBLIGATION', 'PAYMENT');

-- CreateTable
CREATE TABLE "monitoring_record" (
    "id" SERIAL NOT NULL,
    "monitoring_config_id" INTEGER NOT NULL,
    "goal_id" INTEGER NOT NULL,
    "period" INTEGER NOT NULL,
    "goal_value" DOUBLE PRECISION NOT NULL,
    "from_month" INTEGER NOT NULL DEFAULT 1,
    "to_month" INTEGER NOT NULL DEFAULT 12,
    "record_type" "MonitoringRecordType" NOT NULL,
    "budget_capital" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "budget_cd" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "budget_cn" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "budget_credit" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "budget_de" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "budget_operation" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "budget_managment" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "budget_monopoly" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "budget_others" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "budget_rp" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "budget_sgp" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "budget_sgr" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" INTEGER,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_by" INTEGER,

    CONSTRAINT "monitoring_record_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "monitoring_record" ADD CONSTRAINT "monitoring_record_config" FOREIGN KEY ("monitoring_config_id") REFERENCES "monitoring_config"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "monitoring_record" ADD CONSTRAINT "monitoring_record_goal" FOREIGN KEY ("goal_id") REFERENCES "goal"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
