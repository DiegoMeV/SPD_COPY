/*
  Warnings:

  - Made the column `created_at` on table `dev_plan` required. This step will fail if there are existing NULL values in that column.
  - Made the column `created_at` on table `dev_plan_level` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updated_at` on table `dev_plan_level` required. This step will fail if there are existing NULL values in that column.
  - Made the column `created_at` on table `entity` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updated_at` on table `entity` required. This step will fail if there are existing NULL values in that column.
  - Made the column `created_at` on table `goal` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updated_at` on table `goal` required. This step will fail if there are existing NULL values in that column.
  - Made the column `created_at` on table `product_catalog` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updated_at` on table `product_catalog` required. This step will fail if there are existing NULL values in that column.
  - Made the column `created_at` on table `tenant` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updated_at` on table `tenant` required. This step will fail if there are existing NULL values in that column.
  - Made the column `created_at` on table `user_account` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updated_at` on table `user_account` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "dev_plan" ALTER COLUMN "created_at" SET NOT NULL;

-- AlterTable
ALTER TABLE "dev_plan_level" ALTER COLUMN "created_at" SET NOT NULL,
ALTER COLUMN "updated_at" SET NOT NULL;

-- AlterTable
ALTER TABLE "entity" ALTER COLUMN "created_at" SET NOT NULL,
ALTER COLUMN "updated_at" SET NOT NULL;

-- AlterTable
ALTER TABLE "goal" ALTER COLUMN "created_at" SET NOT NULL,
ALTER COLUMN "updated_at" SET NOT NULL;

-- AlterTable
ALTER TABLE "product_catalog" ALTER COLUMN "created_at" SET NOT NULL,
ALTER COLUMN "updated_at" SET NOT NULL;

-- AlterTable
ALTER TABLE "tenant" ALTER COLUMN "created_at" SET NOT NULL,
ALTER COLUMN "updated_at" SET NOT NULL;

-- AlterTable
ALTER TABLE "user_account" ALTER COLUMN "created_at" SET NOT NULL,
ALTER COLUMN "updated_at" SET NOT NULL;
