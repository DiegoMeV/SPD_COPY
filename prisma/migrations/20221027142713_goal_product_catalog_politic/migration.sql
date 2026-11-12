-- AlterTable
ALTER TABLE "goal" ADD COLUMN     "product_catalog_id" INTEGER,
ADD COLUMN     "public_politic_id" INTEGER;

-- AddForeignKey
ALTER TABLE "goal" ADD CONSTRAINT "goal_public_politic" FOREIGN KEY ("public_politic_id") REFERENCES "public_politic"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "goal" ADD CONSTRAINT "goal_product_catalog" FOREIGN KEY ("product_catalog_id") REFERENCES "product_catalog"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
