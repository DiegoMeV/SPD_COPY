/*
  Warnings:

  - Added the required column `tenant_id` to the `public_politic_component` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public_politic_component" ADD COLUMN     "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "created_by" INTEGER,
ADD COLUMN     "tenant_id" INTEGER NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_by" INTEGER;

-- AddForeignKey
ALTER TABLE "public_politic_component" ADD CONSTRAINT "public_politic_component_tenant" FOREIGN KEY ("tenant_id") REFERENCES "tenant"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
