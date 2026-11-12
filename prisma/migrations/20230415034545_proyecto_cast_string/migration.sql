-- DropForeignKey
ALTER TABLE "siif_actividad" DROP CONSTRAINT "siif_actividad_proyecto";

-- AlterTable
ALTER TABLE "siif_actividad" ALTER COLUMN "proyecto" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "siif_proyecto" ALTER COLUMN "proyecto" SET DATA TYPE TEXT;

-- AddForeignKey
ALTER TABLE "siif_actividad" ADD CONSTRAINT "siif_actividad_proyecto" FOREIGN KEY ("nit_compania", "proyecto") REFERENCES "siif_proyecto"("nit_compania", "proyecto") ON DELETE NO ACTION ON UPDATE NO ACTION;
