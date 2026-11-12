-- AlterTable
ALTER TABLE "goal" ADD COLUMN     "peace_politic_id" INTEGER,
ADD COLUMN     "victims_politic_id" INTEGER;

-- AddForeignKey
ALTER TABLE "goal" ADD CONSTRAINT "goal_peace_politic" FOREIGN KEY ("peace_politic_id") REFERENCES "public_politic"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "goal" ADD CONSTRAINT "goal_victims_politic" FOREIGN KEY ("victims_politic_id") REFERENCES "public_politic"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
