/*
  Warnings:

  - Added the required column `tenant_id` to the `public_politic` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public_politic" ADD COLUMN     "is_active" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "tenant_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "public_politic" ADD CONSTRAINT "public_politic_tenant" FOREIGN KEY ("tenant_id") REFERENCES "tenant"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
