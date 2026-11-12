-- CreateTable
CREATE TABLE "siif_proyecto" (
    "id" SERIAL NOT NULL,
    "plan" INTEGER NOT NULL,
    "programa" INTEGER NOT NULL,
    "sector" INTEGER NOT NULL,
    "eje" INTEGER NOT NULL,
    "nit_compania" TEXT NOT NULL,
    "proyecto" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "fecha_registro" TIMESTAMPTZ(6),
    "objetivos" TEXT,
    "descripcion" TEXT,
    "presentado_por" TEXT,
    "fecha_evaluacion" TIMESTAMPTZ(6),
    "evaluado_por" TEXT,
    "valor" DOUBLE PRECISION,
    "ver_desde" INTEGER,
    "estado" TEXT,
    "codigo_ent_pry" TEXT,
    "viabilizado_por" TEXT,
    "fecha_viabilidad" TIMESTAMPTZ(6),
    "estado_proceso" TEXT,
    "usuario" TEXT,
    "fecha_creacion" TIMESTAMPTZ(6),
    "observacion" TEXT,
    "subprograma" INTEGER,
    "id_entidad_presenta" INTEGER,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" INTEGER,

    CONSTRAINT "siif_proyecto_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "siif_proyecto_nit_compania_proyecto_key" ON "siif_proyecto"("nit_compania", "proyecto");
