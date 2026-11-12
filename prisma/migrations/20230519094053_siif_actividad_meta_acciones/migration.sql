-- CreateTable
CREATE TABLE "siif_actividad_meta_accion" (
    "id" SERIAL NOT NULL,
    "actividad_meta_id" INTEGER NOT NULL,
    "descripcion" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" INTEGER,

    CONSTRAINT "siif_actividad_meta_accion_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "siif_actividad_meta_accion" ADD CONSTRAINT "siif_actividad_meta_accion" FOREIGN KEY ("actividad_meta_id") REFERENCES "siif_actividad_meta"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
