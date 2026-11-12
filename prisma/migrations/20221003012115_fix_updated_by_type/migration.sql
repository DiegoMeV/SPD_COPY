/*
  Warnings:

  - The `updated_by` column on the `dev_plan` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "dev_plan" DROP COLUMN "updated_by",
ADD COLUMN     "updated_by" INTEGER;
