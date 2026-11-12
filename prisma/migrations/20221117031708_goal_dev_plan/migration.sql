-- AlterTable
ALTER TABLE "goal" ADD COLUMN     "dev_plan_id" INTEGER;

UPDATE goal g
SET    dev_plan_id = (
    SELECT dpl.dev_plan_id
    FROM   dev_plan_level dpl
    WHERE  dpl.id = g.dev_plan_level_id
);
