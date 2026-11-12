/* =============================================================================
   SPD - Vistas de apoyo para reportes y tableros (Oracle APEX)
   Ejecutar después de spd_schema.sql
   ============================================================================= */

-- Metas con los nombres del SIIF (entidad, plan) y su último estado de seguimiento
CREATE OR REPLACE VIEW V_SPD_GOAL AS
SELECT g.ID,
       g.NIT_COMPANIA,
       g.CODE,
       g.NAME,
       g.GOAL_TYPE,
       CASE g.GOAL_TYPE
         WHEN 'PRODUCT'              THEN 'Producto'
         WHEN 'RESULT'               THEN 'Resultado'
         WHEN 'ACTIVITY'             THEN 'Actividad'
         WHEN 'PROJECT'              THEN 'Proyecto'
         WHEN 'WELL_BEING'           THEN 'Bienestar'
         WHEN 'IMPACT'               THEN 'Impacto'
         WHEN 'PUBLIC_POLITIC'       THEN 'Política pública'
         WHEN 'ACTION_PLAN'          THEN 'Plan de acción'
         WHEN 'ACTION_PLAN_ACTIVITY' THEN 'Actividad de plan de acción'
       END                                   AS GOAL_TYPE_LABEL,
       g.ENTITY_ID,
       e.NOMBRE_ENT_PRY                      AS ENTITY_NAME,
       g.PLAN,
       pd.NOMBRE                             AS DEV_PLAN_NAME,
       g.DEV_PLAN_LEVEL_ID,
       l.NAME                                AS DEV_PLAN_LEVEL_NAME,
       g.BASE_VALUE,
       g.GOAL_VALUE,
       g.UNITS_NAME,
       g.WEIGHTING,
       g.IS_ACTIVE,
       g.START_DATE,
       g.END_DATE
FROM   SPD_GOAL g
JOIN   ENTIDADES_PRY e           ON e.ID = g.ENTITY_ID
LEFT JOIN PLAN_DESARROLLO pd     ON pd.NIT_COMPANIA = g.NIT_COMPANIA AND pd.PLAN = g.PLAN
LEFT JOIN SPD_DEV_PLAN_LEVEL l   ON l.ID = g.DEV_PLAN_LEVEL_ID;


-- Listas de valores (valor + texto a mostrar) para los formularios de APEX.
-- El número de plan se repite entre compañías: el texto incluye la compañía.
CREATE OR REPLACE VIEW V_SPD_LOV_PLAN AS
SELECT pd.PLAN, pd.NIT_COMPANIA, pd.PLAN || ' - ' || pd.NOMBRE || ' (' || c.NOMBRE || ')' AS NAME
FROM   PLAN_DESARROLLO pd
JOIN   COMPANIA c ON c.NIT_COMPANIA = pd.NIT_COMPANIA;

CREATE OR REPLACE VIEW V_SPD_LOV_DEV_PLAN_LEVEL AS
SELECT ID, NIT_COMPANIA, PLAN, CODE || ' - ' || NAME AS NAME FROM SPD_DEV_PLAN_LEVEL;

CREATE OR REPLACE VIEW V_SPD_LOV_GOAL AS
SELECT ID, NIT_COMPANIA, CODE || NVL2(NAME, ' - ' || SUBSTR(NAME, 1, 200), NULL) AS NAME FROM SPD_GOAL;

CREATE OR REPLACE VIEW V_SPD_LOV_PRODUCT AS
SELECT ID, CODE || ' - ' || SUBSTR(NAME, 1, 300) AS NAME FROM SPD_PRODUCT_CATALOG;

-- Colores de indicadores de cada configuración de seguimiento (SPD_MONITORING_CONFIG.COLORS_CONFIG), una fila por rango
CREATE OR REPLACE VIEW V_SPD_MONITORING_COLORS AS
SELECT mc.ID, mc.NIT_COMPANIA, jt.POS, jt.FROM_VALUE, jt.TO_VALUE, jt.COLOR, jt.LABEL,
       CASE WHEN jt.INCLUDE_FROM = 'true' THEN 'S' ELSE 'N' END AS INCLUDE_FROM,
       CASE WHEN jt.INCLUDE_TO   = 'true' THEN 'S' ELSE 'N' END AS INCLUDE_TO
FROM   SPD_MONITORING_CONFIG mc,
       JSON_TABLE(mc.COLORS_CONFIG, '$[*]' COLUMNS (
         POS          FOR ORDINALITY,
         FROM_VALUE   NUMBER        PATH '$.fromValue',
         TO_VALUE     NUMBER        PATH '$.toValue',
         COLOR        VARCHAR2(30)  PATH '$.color',
         LABEL        VARCHAR2(200) PATH '$.label',
         INCLUDE_FROM VARCHAR2(10)  PATH '$.includeFromValue',
         INCLUDE_TO   VARCHAR2(10)  PATH '$.includeToValue')) jt;

-- Definición de niveles de cada plan (PLAN_DESARROLLO.SPD_CONFIG.levels), una fila por nivel
CREATE OR REPLACE VIEW V_SPD_PLAN_LEVEL_CONFIG AS
SELECT pd.NIT_COMPANIA, pd.PLAN, jt.NUM, jt.SINGULAR_NAME, jt.PLURAL_NAME, jt.GOAL_TYPE,
       CASE WHEN jt.IS_SECTOR = 'true' THEN 'S' ELSE 'N' END AS IS_SECTOR
FROM   PLAN_DESARROLLO pd,
       JSON_TABLE(pd.SPD_CONFIG, '$.levels[*]' COLUMNS (
         NUM           NUMBER        PATH '$.number',
         SINGULAR_NAME VARCHAR2(200) PATH '$.singularName',
         PLURAL_NAME   VARCHAR2(200) PATH '$.pluralName',
         GOAL_TYPE     VARCHAR2(30)  PATH '$.goalType',
         IS_SECTOR     VARCHAR2(10)  PATH '$.isSectorLevel')) jt;


-- Registros de seguimiento con avance físico calculado
CREATE OR REPLACE VIEW V_SPD_MONITORING AS
SELECT mr.ID,
       mc.NIT_COMPANIA,
       mr.MONITORING_CONFIG_ID,
       mc.PERIOD || ' - ' || mc.SUBPERIOD    AS MONITORING_PERIOD,
       mc.STATUS                             AS MONITORING_STATUS,
       mr.GOAL_ID,
       g.CODE                                AS GOAL_CODE,
       g.NAME                                AS GOAL_NAME,
       g.GOAL_TYPE_LABEL,
       g.ENTITY_NAME,
       mr.PERIOD,
       mr.RECORD_STATUS,
       CASE mr.RECORD_STATUS
         WHEN 'COPIED'    THEN 'Copiado'
         WHEN 'PLANNED'   THEN 'Programado'
         WHEN 'REPORTED'  THEN 'Reportado'
         WHEN 'VALIDATED' THEN 'Validado'
         WHEN 'REVIEWED'  THEN 'Revisado'
         WHEN 'APPROVED'  THEN 'Aprobado'
         WHEN 'REJECTED'  THEN 'Rechazado'
       END                                   AS RECORD_STATUS_LABEL,
       mr.GOAL_VALUE,
       mr.GOAL_ACHIEVED_VALUE,
       CASE WHEN NVL(mr.GOAL_VALUE, 0) <> 0
            THEN ROUND(100 * NVL(mr.GOAL_ACHIEVED_VALUE, 0) / mr.GOAL_VALUE, 2)
       END                                   AS PHYSICAL_PROGRESS_PCT,
       mr.WEIGHTING,
       mr.UPDATED_AT
FROM   SPD_MONITORING_RECORD mr
JOIN   SPD_MONITORING_CONFIG mc ON mc.ID = mr.MONITORING_CONFIG_ID
JOIN   V_SPD_GOAL g             ON g.ID  = mr.GOAL_ID;


-- Recursos financieros por fuente (una fila por fuente) para los tableros
CREATE OR REPLACE VIEW V_SPD_RESOURCES_BY_SOURCE AS
SELECT u.MONITORING_RECORD_ID,
       u.NIT_COMPANIA,
       u.MONITORING_CONFIG_ID,
       u.MONITORING_PERIOD,
       u.ENTITY_NAME,
       u.GOAL_TYPE_LABEL,
       u.RESOURCE_TYPE,
       CASE u.RESOURCE_TYPE
         WHEN 'MANUAL'     THEN 'Manual'
         WHEN 'DEFINITIVE' THEN 'Definitivo'
         WHEN 'COMMITMENT' THEN 'Compromiso'
         WHEN 'OBLIGATION' THEN 'Obligación'
         WHEN 'PAYMENT'    THEN 'Pago'
       END                     AS RESOURCE_TYPE_LABEL,
       u.SOURCE_NAME,
       u.AMOUNT
FROM  (SELECT r.*, m.NIT_COMPANIA, m.MONITORING_CONFIG_ID, m.MONITORING_PERIOD,
              m.ENTITY_NAME, m.GOAL_TYPE_LABEL
       FROM   SPD_MONITORING_RECORD_RESOURCE r
       JOIN   V_SPD_MONITORING m ON m.ID = r.MONITORING_RECORD_ID)
UNPIVOT (AMOUNT FOR SOURCE_NAME IN (
         CAPITAL              AS 'Recursos de capital',
         CD                   AS 'Cofinanciación departamental',
         CN                   AS 'Cofinanciación nacional',
         CREDIT               AS 'Crédito',
         DE                   AS 'Destinación específica',
         OPERATION            AS 'Operación',
         MANAGEMENT           AS 'Gestión',
         MONOPOLY             AS 'Monopolio',
         OTHERS               AS 'Otros',
         RP                   AS 'Recursos propios',
         SGP                  AS 'SGP',
         SGP_EDUCATION        AS 'SGP Educación',
         SGP_HEALTH           AS 'SGP Salud',
         SGP_WATER            AS 'SGP Agua potable',
         SGP_CULTURE          AS 'SGP Cultura',
         SGP_SPORT            AS 'SGP Deporte',
         SGP_FREE_INVESTMENT  AS 'SGP Libre inversión',
         SGP_FREE_DESTINATION AS 'SGP Libre destinación',
         SGP_SCHOOL_FEEDING   AS 'SGP Alimentación escolar',
         SGP_MAGDALENA_RIVER  AS 'SGP Ribereños Magdalena',
         SGP_EARLY_CHILDHOOD  AS 'SGP Primera infancia',
         SGR                  AS 'SGR')) u
WHERE  u.AMOUNT <> 0;


-- Lista de valores de registros de seguimiento (para el historial de metas)
CREATE OR REPLACE VIEW V_SPD_LOV_MONITORING_RECORD AS
SELECT ID, NIT_COMPANIA, GOAL_CODE || ' / ' || MONITORING_PERIOD || ' / ' || RECORD_STATUS_LABEL AS NAME
FROM   V_SPD_MONITORING;


-- Catálogo de productos en una fila por indicador (o por producto si no tiene indicadores):
-- Sector > Programa > Producto > Indicador, como en la pantalla original
CREATE OR REPLACE VIEW V_SPD_PRODUCT_INDICATORS AS
SELECT NVL(i.ID, p.ID)                       AS ID,
       s.CODE  || ' - ' || s.NAME            AS SECTOR,
       pr.CODE || ' - ' || pr.NAME           AS PROGRAMA,
       p.CODE  || ' - ' || p.NAME            AS PRODUCTO,
       NVL2(i.ID, i.CODE || ' - ' || i.NAME, NULL) AS INDICADOR,
       NVL(i.CODE, p.CODE)                   AS CODE
FROM   SPD_PRODUCT_CATALOG p
JOIN   SPD_PRODUCT_CATALOG pr ON pr.ID = p.PARENT_ID
JOIN   SPD_PRODUCT_CATALOG s  ON s.ID  = pr.PARENT_ID AND s.PARENT_ID IS NULL
LEFT JOIN SPD_PRODUCT_CATALOG i ON i.PARENT_ID = p.ID;


-- Metas por seguimiento: una fila por (configuración de seguimiento, meta) con el estado de la meta
-- en cada etapa (programación, reporte, validación, revisión) y los valores del periodo.
-- Equivale a lo que calcula goalResolver.getGoalMonitoringRecordStatus en la app original.
CREATE OR REPLACE VIEW V_SPD_GOAL_MONITORING AS
WITH res AS (
  SELECT MONITORING_RECORD_ID, RESOURCE_TYPE,
         MAX(FINANCIAL_INDICATOR) AS FINANCIAL_INDICATOR,
         SUM(RP + CASE WHEN SGP <> 0 THEN SGP
                       ELSE NVL(SGP_EDUCATION,0) + NVL(SGP_HEALTH,0) + NVL(SGP_WATER,0) + NVL(SGP_CULTURE,0)
                          + NVL(SGP_SPORT,0) + NVL(SGP_FREE_INVESTMENT,0) + NVL(SGP_FREE_DESTINATION,0)
                          + NVL(SGP_SCHOOL_FEEDING,0) + NVL(SGP_MAGDALENA_RIVER,0) + NVL(SGP_EARLY_CHILDHOOD,0) END
             + CN + CD + SGR + CREDIT + OTHERS + MANAGEMENT + OPERATION) AS TOTAL
  FROM   SPD_MONITORING_RECORD_RESOURCE
  GROUP  BY MONITORING_RECORD_ID, RESOURCE_TYPE
), base AS (
  SELECT mc.ID                                        AS MONITORING_CONFIG_ID,
         mc.PERIOD || ' - ' || mc.SUBPERIOD || ' · ' || pd.NOMBRE AS MONITORING_LABEL,
         mc.NIT_COMPANIA,
         g.ID                                         AS GOAL_ID,
         g.GOAL_TYPE,
         CASE WHEN g.GOAL_TYPE IN ('PRODUCT','RESULT','IMPACT','WELL_BEING') THEN 'METAS'
              WHEN g.GOAL_TYPE IN ('PROJECT','ACTIVITY')                    THEN 'PROYECTOS'
              WHEN g.GOAL_TYPE = 'ACTION_PLAN'                              THEN 'PLANES' END AS GOAL_GROUP,
         g.CODE, g.NAME, g.INDICATOR, g.BASE_VALUE, g.GOAL_VALUE, g.ACCUMULATION_TYPE, g.PROJECT_CODE,
         e.CODIGO_ENT_PRY                             AS ENTITY_CODE,
         e.CODIGO_ENT_PRY || ' - ' || e.NOMBRE_ENT_PRY AS ENTITY_NAME,
         l.CODE || ' - ' || l.NAME                    AS DEV_PLAN_LEVEL_NAME,
         mr.ID                                        AS MONITORING_RECORD_ID,
         mr.RECORD_STATUS,
         mr.GOAL_VALUE                                AS PROGRAMMED_VALUE,
         mr.GOAL_ACHIEVED_VALUE                       AS ACHIEVED_VALUE,
         ROUND(mr.PHYSICAL_INDICATOR * 100, 2)        AS PHYSICAL_PROGRESS,
         rd.TOTAL                                     AS APPROPRIATED,
         rc.TOTAL                                     AS COMMITMENTS,
         ro.TOTAL                                     AS OBLIGATIONS,
         rp.TOTAL                                     AS PAYMENTS,
         ROUND(rc.FINANCIAL_INDICATOR * 100, 2)       AS FIN_PROGRESS_COMMITMENT,
         ROUND(ro.FINANCIAL_INDICATOR * 100, 2)       AS FIN_PROGRESS_OBLIGATION,
         (SELECT COUNT(*) FROM SPD_MONITORING_RECORD_RESOURCE x
           WHERE x.MONITORING_RECORD_ID = mr.ID AND x.RESOURCE_TYPE IN ('MANUAL','DEFINITIVE')) AS SCHEDULED_RESOURCES,
         CASE WHEN mc.MONITORING_RESOURCES_ORIGIN = 'USER_AND_FINANCIAL' THEN 2 ELSE 1 END AS REQUIRED_RESOURCES
  FROM   SPD_MONITORING_CONFIG mc
  JOIN   SPD_GOAL g ON g.NIT_COMPANIA = mc.NIT_COMPANIA AND g.PLAN = mc.PLAN
         AND (mc.GOAL_TYPES IS NULL
              OR INSTR(mc.GOAL_TYPES, '"' || g.GOAL_TYPE || '"') > 0
              OR (g.GOAL_TYPE = 'PROJECT' AND INSTR(mc.GOAL_TYPES, '"ACTIVITY"') > 0))
  JOIN   ENTIDADES_PRY e ON e.ID = g.ENTITY_ID
  LEFT JOIN PLAN_DESARROLLO pd     ON pd.NIT_COMPANIA = mc.NIT_COMPANIA AND pd.PLAN = mc.PLAN
  LEFT JOIN SPD_DEV_PLAN_LEVEL l   ON l.ID = g.DEV_PLAN_LEVEL_ID
  LEFT JOIN SPD_MONITORING_RECORD mr ON mr.MONITORING_CONFIG_ID = mc.ID AND mr.GOAL_ID = g.ID
  LEFT JOIN res rd ON rd.MONITORING_RECORD_ID = mr.ID AND rd.RESOURCE_TYPE = 'DEFINITIVE'
  LEFT JOIN res rc ON rc.MONITORING_RECORD_ID = mr.ID AND rc.RESOURCE_TYPE = 'COMMITMENT'
  LEFT JOIN res ro ON ro.MONITORING_RECORD_ID = mr.ID AND ro.RESOURCE_TYPE = 'OBLIGATION'
  LEFT JOIN res rp ON rp.MONITORING_RECORD_ID = mr.ID AND rp.RESOURCE_TYPE = 'PAYMENT'
), st AS (
  SELECT b.*,
         CASE WHEN b.RECORD_STATUS IS NULL         THEN 'Sin Programar'
              WHEN b.RECORD_STATUS = 'COPIED'      THEN 'Programada Parcial'
              WHEN b.RECORD_STATUS = 'PLANNED'     THEN CASE WHEN b.SCHEDULED_RESOURCES < b.REQUIRED_RESOURCES
                                                             THEN 'Programada Parcial' ELSE 'Programada' END
              WHEN b.RECORD_STATUS = 'REPORTED'    THEN 'Reportada'
              WHEN b.RECORD_STATUS = 'VALIDATED'   THEN 'Validada'
              WHEN b.RECORD_STATUS IN ('REVIEWED','APPROVED') THEN 'Revisada'
              WHEN b.RECORD_STATUS = 'REJECTED'    THEN 'Rechazada' END AS SCHEDULE_STATUS
  FROM   base b
)
SELECT st.*,
       CASE WHEN SCHEDULE_STATUS = 'Programada' THEN 'Sin Reportar' ELSE SCHEDULE_STATUS END AS REPORT_STATUS,
       CASE WHEN SCHEDULE_STATUS = 'Reportada'  THEN 'Sin Validar'  ELSE SCHEDULE_STATUS END AS VALIDATION_STATUS,
       CASE WHEN SCHEDULE_STATUS = 'Validada'   THEN 'Sin Revisar'  ELSE SCHEDULE_STATUS END AS REVIEW_STATUS
FROM   st;
