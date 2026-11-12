/*
  Warnings:

  - The `created_by` column on the `dev_plan` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `created_by` column on the `goal` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `updated_by` column on the `goal` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "dev_plan" DROP COLUMN "created_by",
ADD COLUMN     "created_by" INTEGER,
ALTER COLUMN "updated_by" DROP NOT NULL;

-- AlterTable
ALTER TABLE "dev_plan_level" ALTER COLUMN "updated_at" DROP NOT NULL;

-- AlterTable
ALTER TABLE "goal" DROP COLUMN "created_by",
ADD COLUMN     "created_by" INTEGER,
DROP COLUMN "updated_by",
ADD COLUMN     "updated_by" INTEGER;

-- AlterTable
ALTER TABLE "product_catalog" ALTER COLUMN "updated_at" DROP NOT NULL;
