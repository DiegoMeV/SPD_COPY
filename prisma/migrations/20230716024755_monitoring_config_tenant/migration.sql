-- AlterTable
ALTER TABLE "monitoring_config" ADD COLUMN     "tenant_id" INTEGER;

-- AddForeignKey
ALTER TABLE "monitoring_config" ADD CONSTRAINT "monitoring_config_tenant" FOREIGN KEY ("tenant_id") REFERENCES "tenant"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
