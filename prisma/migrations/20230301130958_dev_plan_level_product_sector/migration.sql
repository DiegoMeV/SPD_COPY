-- AlterTable
ALTER TABLE "dev_plan_level" ADD COLUMN     "product_catalog_id" INTEGER;

-- AddForeignKey
ALTER TABLE "dev_plan_level" ADD CONSTRAINT "devplanlevel_product_catalog" FOREIGN KEY ("product_catalog_id") REFERENCES "product_catalog"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
