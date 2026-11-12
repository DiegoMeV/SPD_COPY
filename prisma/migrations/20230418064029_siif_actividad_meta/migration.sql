-- CreateTable
CREATE TABLE "siif_actividad_meta" (
    "id" SERIAL NOT NULL,
    "nit_compania" TEXT NOT NULL,
    "proyecto" TEXT NOT NULL,
    "codigo_act" INTEGER NOT NULL,
    "goal_id" INTEGER NOT NULL,
    "weighting" DOUBLE PRECISION NOT NULL DEFAULT 100.0,

    CONSTRAINT "siif_actividad_meta_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "siif_actividad_meta_nit_compania_proyecto_codigo_act_goal_i_key" ON "siif_actividad_meta"("nit_compania", "proyecto", "codigo_act", "goal_id");

-- AddForeignKey
ALTER TABLE "siif_actividad_meta" ADD CONSTRAINT "siif_actividad_meta_actividad" FOREIGN KEY ("nit_compania", "proyecto", "codigo_act") REFERENCES "siif_actividad"("nit_compania", "proyecto", "codigo_act") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "siif_actividad_meta" ADD CONSTRAINT "siif_actividad_meta_goal" FOREIGN KEY ("goal_id") REFERENCES "goal"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
