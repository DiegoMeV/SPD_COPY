-- AlterTable
ALTER TABLE "goal" ADD COLUMN     "public_politic_component_id" INTEGER;

-- AddForeignKey
ALTER TABLE "goal" ADD CONSTRAINT "goal_public_politic_component" FOREIGN KEY ("public_politic_component_id") REFERENCES "public_politic_component"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
