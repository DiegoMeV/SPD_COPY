-- AlterTable
ALTER TABLE "entity" ADD COLUMN     "has_manual_budget" BOOLEAN DEFAULT false;

UPDATE entity
SET    has_manual_budget = false;