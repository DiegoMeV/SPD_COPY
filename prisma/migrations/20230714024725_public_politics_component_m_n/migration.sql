/*
  Warnings:

  - You are about to drop the column `component_id` on the `public_politic` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "public_politic" DROP CONSTRAINT "public_politic_component";

-- AlterTable
ALTER TABLE "public_politic" DROP COLUMN "component_id";

-- CreateTable
CREATE TABLE "_public_politic_to_component" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_public_politic_to_component_AB_unique" ON "_public_politic_to_component"("A", "B");

-- CreateIndex
CREATE INDEX "_public_politic_to_component_B_index" ON "_public_politic_to_component"("B");

-- AddForeignKey
ALTER TABLE "_public_politic_to_component" ADD CONSTRAINT "_public_politic_to_component_A_fkey" FOREIGN KEY ("A") REFERENCES "public_politic"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_public_politic_to_component" ADD CONSTRAINT "_public_politic_to_component_B_fkey" FOREIGN KEY ("B") REFERENCES "public_politic_component"("id") ON DELETE CASCADE ON UPDATE CASCADE;
