/* =============================================================================
   SPD - Columnas propias de SPD en tablas existentes del SIIF
   ENTIDADES_PRY y PLAN_DESARROLLO

   REVISAR CON EL DBA ANTES DE EJECUTAR EN EL SIIF.
   Es el único script de SPD que modifica tablas del SIIF. Solo AGREGA columnas
   opcionales (con prefijo SPD_); no cambia ni borra nada existente.

   Equivalencias con PostgreSQL (prisma/schema.prisma):
     entity.has_manual_budget        -> ENTIDADES_PRY.SPD_PRESUPUESTO_MANUAL
     entity.start_date / end_date    -> ENTIDADES_PRY.SPD_FECHA_INICIO / SPD_FECHA_FIN
     entity.parent_id                -> ENTIDADES_PRY.SPD_ID_ENTIDAD_PADRE
     entity.code / name / managerName / is_active -> ya existen (CODIGO_ENT_PRY, NOMBRE_ENT_PRY,
                                                       SECRETARIO, ACTIVA)
     dev_plan.is_active              -> PLAN_DESARROLLO.SPD_ACTIVO
     dev_plan.government_start/end   -> PLAN_DESARROLLO.SPD_INICIO_GOBIERNO / SPD_FIN_GOBIERNO
     dev_plan.config                 -> PLAN_DESARROLLO.SPD_CONFIG (JSON)
     dev_plan.goal_activity_source   -> PLAN_DESARROLLO.SPD_ORIGEN_ACTIVIDADES
     dev_plan.code / name / start_date / end_date / government_name -> ya existen (PLAN, NOMBRE,
                                                       FECHA_INICIO, FECHA_FIN, GOBERNANTE)

   Orden: después de que existan ENTIDADES_PRY y PLAN_DESARROLLO, antes de spd_schema.sql.
   ============================================================================= */

ALTER TABLE ENTIDADES_PRY ADD (
  SPD_PRESUPUESTO_MANUAL  VARCHAR2(1) DEFAULT 'N',
  SPD_FECHA_INICIO        DATE,
  SPD_FECHA_FIN           DATE,
  SPD_ID_ENTIDAD_PADRE    NUMBER,
  CONSTRAINT ENT_PRY_SPD_PPTO_CK  CHECK (SPD_PRESUPUESTO_MANUAL IN ('S','N')),
  CONSTRAINT ENT_PRY_SPD_PADRE_FK FOREIGN KEY (SPD_ID_ENTIDAD_PADRE) REFERENCES ENTIDADES_PRY (ID)
);
CREATE INDEX ENT_PRY_SPD_PADRE_I ON ENTIDADES_PRY (SPD_ID_ENTIDAD_PADRE);

COMMENT ON COLUMN ENTIDADES_PRY.SPD_PRESUPUESTO_MANUAL IS 'SPD: S = la entidad registra su presupuesto manualmente en el seguimiento';
COMMENT ON COLUMN ENTIDADES_PRY.SPD_FECHA_INICIO       IS 'SPD: fecha desde la que la entidad está vigente';
COMMENT ON COLUMN ENTIDADES_PRY.SPD_FECHA_FIN          IS 'SPD: fecha hasta la que la entidad está vigente';
COMMENT ON COLUMN ENTIDADES_PRY.SPD_ID_ENTIDAD_PADRE   IS 'SPD: entidad de la que depende (ENTIDADES_PRY.ID)';


ALTER TABLE PLAN_DESARROLLO ADD (
  SPD_ACTIVO              VARCHAR2(1)  DEFAULT 'S',
  SPD_INICIO_GOBIERNO     DATE,
  SPD_FIN_GOBIERNO        DATE,
  SPD_CONFIG              CLOB,
  SPD_ORIGEN_ACTIVIDADES  VARCHAR2(10) DEFAULT 'SIIF',
  CONSTRAINT PD_SPD_ACTIVO_CK  CHECK (SPD_ACTIVO IN ('S','N')),
  CONSTRAINT PD_SPD_CONFIG_CK  CHECK (SPD_CONFIG IS JSON),
  CONSTRAINT PD_SPD_ORIGEN_CK  CHECK (SPD_ORIGEN_ACTIVIDADES IN ('MANUAL','SIIF'))
);

COMMENT ON COLUMN PLAN_DESARROLLO.SPD_ACTIVO             IS 'SPD: S = el plan está activo para seguimiento';
COMMENT ON COLUMN PLAN_DESARROLLO.SPD_INICIO_GOBIERNO    IS 'SPD: inicio del periodo de gobierno';
COMMENT ON COLUMN PLAN_DESARROLLO.SPD_FIN_GOBIERNO       IS 'SPD: fin del periodo de gobierno';
COMMENT ON COLUMN PLAN_DESARROLLO.SPD_CONFIG             IS 'SPD: configuración del plan en JSON';
COMMENT ON COLUMN PLAN_DESARROLLO.SPD_ORIGEN_ACTIVIDADES IS 'SPD: origen de las actividades de las metas (SIIF o MANUAL)';
