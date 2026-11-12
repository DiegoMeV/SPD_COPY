/*
  Warnings:

  - You are about to drop the column `parentId` on the `dev_plan_level` table. All the data in the column will be lost.
  - You are about to drop the column `parentId` on the `product_catalog` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "dev_plan_level" DROP CONSTRAINT "entity_itself";

-- DropForeignKey
ALTER TABLE "product_catalog" DROP CONSTRAINT "product_catalog_itself";

-- AlterTable
ALTER TABLE "dev_plan_level" DROP COLUMN "parentId",
ADD COLUMN     "parent_id" INTEGER;

-- AlterTable
ALTER TABLE "product_catalog" DROP COLUMN "parentId",
ADD COLUMN     "parent_id" INTEGER;

-- AddForeignKey
ALTER TABLE "dev_plan_level" ADD CONSTRAINT "entity_itself" FOREIGN KEY ("parent_id") REFERENCES "dev_plan_level"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "product_catalog" ADD CONSTRAINT "product_catalog_itself" FOREIGN KEY ("parent_id") REFERENCES "product_catalog"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
