-- CreateEnum
CREATE TYPE "GoalType" AS ENUM ('PRODUCT', 'RESULT', 'ACTIVITY');

-- CreateEnum
CREATE TYPE "AccumulationType" AS ENUM ('STOCK', 'FLOW', 'ACCUMULATED', 'CAPACITY', 'REDUCTION', 'ANNUAL_REDUCTION');

-- CreateTable
CREATE TABLE "tenant" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tenant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_account" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "email" TEXT NOT NULL,
    "doc_number" TEXT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT,
    "phone" TEXT,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "entity" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "start_date" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "end_date" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "parent_id" INTEGER,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "entity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dev_plan" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "start_date" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "end_date" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "government_name" TEXT NOT NULL,
    "government_start_date" TIMESTAMPTZ(6) NOT NULL,
    "government_end_date" TIMESTAMPTZ(6) NOT NULL,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "dev_plan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dev_plan_level" (
    "id" SERIAL NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "dev_plan_id" INTEGER NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "parentId" INTEGER,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "goalId" INTEGER,

    CONSTRAINT "dev_plan_level_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_catalog" (
    "id" SERIAL NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "parentId" INTEGER,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "product_catalog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "goal" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "dev_plan_id" INTEGER NOT NULL,
    "entity_id" INTEGER NOT NULL,
    "goalType" "GoalType" NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "indicator" TEXT,
    "description" TEXT,
    "accumulationType" "AccumulationType" NOT NULL,
    "base_value" DOUBLE PRECISION,
    "goal_value" DOUBLE PRECISION NOT NULL,
    "unitsFactor" INTEGER NOT NULL,
    "start_date" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "end_date" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT NOT NULL,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_by" TEXT NOT NULL,

    CONSTRAINT "goal_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_account_tenant_id_email_key" ON "user_account"("tenant_id", "email");

-- AddForeignKey
ALTER TABLE "user_account" ADD CONSTRAINT "user_tenant" FOREIGN KEY ("tenant_id") REFERENCES "tenant"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "entity" ADD CONSTRAINT "entity_tenant" FOREIGN KEY ("tenant_id") REFERENCES "tenant"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "entity" ADD CONSTRAINT "entity_itself" FOREIGN KEY ("parent_id") REFERENCES "entity"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dev_plan" ADD CONSTRAINT "dev_plan_tenant" FOREIGN KEY ("tenant_id") REFERENCES "tenant"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dev_plan_level" ADD CONSTRAINT "dev_plan_level_dev_plan" FOREIGN KEY ("dev_plan_id") REFERENCES "dev_plan"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dev_plan_level" ADD CONSTRAINT "entity_itself" FOREIGN KEY ("parentId") REFERENCES "dev_plan_level"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "product_catalog" ADD CONSTRAINT "product_catalog_itself" FOREIGN KEY ("parentId") REFERENCES "product_catalog"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "goal" ADD CONSTRAINT "goal_tenant" FOREIGN KEY ("tenant_id") REFERENCES "tenant"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "goal" ADD CONSTRAINT "goal_dev_plan" FOREIGN KEY ("dev_plan_id") REFERENCES "dev_plan"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "goal" ADD CONSTRAINT "goal_itself" FOREIGN KEY ("entity_id") REFERENCES "entity"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
