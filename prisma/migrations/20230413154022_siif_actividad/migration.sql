-- CreateTable
CREATE TABLE "siif_actividad" (
    "id" INTEGER NOT NULL,
    "nit_compania" TEXT NOT NULL,
    "proyecto" INTEGER NOT NULL,
    "codigo_act" INTEGER NOT NULL,
    "descripcion" TEXT NOT NULL,
    "etapa" TEXT NOT NULL,
    "componente" TEXT NOT NULL,
    "codigo_und" INTEGER,
    "cantidad" INTEGER,
    "cod_subact" INTEGER,
    "activa" TEXT,
    "codigo" TEXT,
    "id_meta" INTEGER NOT NULL,
    "id_producto" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" INTEGER
);

-- CreateIndex
CREATE UNIQUE INDEX "siif_actividad_nit_compania_proyecto_codigo_act_key" ON "siif_actividad"("nit_compania", "proyecto", "codigo_act");

-- AddForeignKey
ALTER TABLE "siif_actividad" ADD CONSTRAINT "siif_actividad_proyecto" FOREIGN KEY ("nit_compania", "proyecto") REFERENCES "siif_proyecto"("nit_compania", "proyecto") ON DELETE NO ACTION ON UPDATE NO ACTION;
