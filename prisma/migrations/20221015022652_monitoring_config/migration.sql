-- CreateEnum
CREATE TYPE "SpentDoc" AS ENUM ('COMMITMENT', 'OBLIGATION', 'PAYMENT');

-- CreateEnum
CREATE TYPE "WeightingType" AS ENUM ('FINANCIAL', 'HIERARCHY', 'MANUAL');

-- CreateTable
CREATE TABLE "monitoring_config" (
    "id" SERIAL NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "dev_plan_id" INTEGER NOT NULL,
    "period" INTEGER NOT NULL,
    "subperiod" INTEGER NOT NULL,
    "spentDoc" "SpentDoc",
    "weightingType" "WeightingType" NOT NULL DEFAULT 'FINANCIAL',
    "datesConfig" JSONB,
    "colorsConfig" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" INTEGER,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_by" INTEGER,

    CONSTRAINT "monitoring_config_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "monitoring_config" ADD CONSTRAINT "monitoring_config_dev_plan" FOREIGN KEY ("dev_plan_id") REFERENCES "dev_plan"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
