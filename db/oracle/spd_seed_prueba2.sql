/* =============================================================================
   SPD - Semilla de prueba "SPD PRUEBA 2" para Oracle (ambientes locales o de desarrollo)
   -----------------------------------------------------------------------------
   Más completa que spd_seed_mini.sql y compatible con ella (pueden estar las dos cargadas).

   Compañía: 891900853 (UCEVA). Debe existir: el script NO crea ni modifica COMPANIA.

   Todo lo que crea se reconoce como dato de prueba:
     nombres  "SPD PRUEBA 2 " + el nombre real (entidades, plan, niveles, metas, proyectos,
              políticas, macroproyecto, ubicaciones, unidades y productos que falten)
     códigos  ENTIDADES_PRY SPDP2INF y SPDP2EDU, metas "SPDP2-...", usuario SPDP2_DEMO,
              PROYECTO.USUARIO = SPDP2_DEMO
   Se puede volver a ejecutar: al empezar borra SOLO esos datos (y lo creado desde las pantallas
   dentro del plan "SPD PRUEBA 2 ..."); no toca los de spd_seed_mini.sql ni el resto de la compañía.

   Qué crea:
     Entidades ............ Secretaría de Infraestructura y Secretaría de Educación
     Usuario .............. SPDP2_DEMO (entidad Infraestructura)
     Plan de desarrollo ... 2024-2027 con 5 niveles: Eje > Sector > Programa > Subprograma >
                            Plan de acción, y 2 ramas (Transporte y Educación)
     Metas (regla de niveles: 1 impacto, 2 sin metas, 3 resultado, 4 producto, 5 plan de acción)
       2 de impacto (nivel 1), 4 de resultado (nivel 3), 6 de producto (nivel 4),
       2 proyectos con 2 actividades cada uno (nivel 4),
       2 planes de acción con 2 metas cada uno (nivel 5)
     Proyectos SIIF ....... 2 en PROYECTO (V_PROYECTO)
     Catálogos ............ unidades y productos de la compañía (UNIDADES_PRY / PRODUCTOS_PRY):
                            usa los que existan y crea los que falten con prefijo "SPD PRUEBA 2"
     Políticas, macroproyecto y ubicaciones
     Seguimiento .......... 2026-3 cerrado (todo revisado) y 2026-4 activo con todas las etapas
                            abiertas hoy y metas en cada estado (sin programar, programada,
                            reportada, validada y revisada), con recursos, adjunto, focalización
                            e historial.

   Orden: después de spd_schema.sql y spd_views.sql. En local, luego siif_apex_local.sql
   (login con SPDP2_DEMO / Spd#2026). Ejecutar como SIIF.
   Compatible con Oracle 12c+ (no usa BOOLEAN en SQL).
   ============================================================================= */
SET SERVEROUTPUT ON
SET DEFINE OFF
WHENEVER SQLERROR EXIT FAILURE ROLLBACK

DECLARE
  c_nit       CONSTANT VARCHAR2(15)  := '891900853';
  c_pref      CONSTANT VARCHAR2(20)  := 'SPD PRUEBA 2 ';
  c_code      CONSTANT VARCHAR2(10)  := 'SPDP2-';
  c_ent_inf   CONSTANT VARCHAR2(20)  := 'SPDP2INF';
  c_ent_edu   CONSTANT VARCHAR2(20)  := 'SPDP2EDU';
  c_user      CONSTANT VARCHAR2(30)  := 'SPDP2_DEMO';
  c_plan_name CONSTANT VARCHAR2(100) := 'SPD PRUEBA 2 Plan de Desarrollo 2024 - 2027';

  v_plan    NUMBER;   -- PLAN_DESARROLLO.PLAN
  v_pry1    NUMBER;   -- PROYECTO.PROYECTO
  v_pry2    NUMBER;
  v_user    NUMBER;   -- USUARIOS.ID, se usa como CREATED_BY
  v_inf     NUMBER;   -- ENTIDADES_PRY.ID
  v_edu     NUMBER;
  v_cfg     NUMBER;   -- seguimiento activo 2026-4
  v_cfg_old NUMBER;   -- seguimiento cerrado 2026-3
  v_id      NUMBER;
  n         NUMBER;

  -- estructura del plan: eje 1 (Transporte) y eje 2 (Educación)
  t1 NUMBER; t2 NUMBER; t3 NUMBER; t4 NUMBER; t5 NUMBER;
  e1 NUMBER; e2 NUMBER; e3 NUMBER; e4 NUMBER; e5 NUMBER;
  -- catálogos
  v_ods4 NUMBER; v_ods9 NUMBER; v_ods11 NUMBER;
  v_km NUMBER; v_num NUMBER; v_pct NUMBER; v_min NUMBER; v_tasa NUMBER;
  p_via NUMBER; p_placa NUMBER; p_puente NUMBER; p_aula NUMBER; p_dotacion NUMBER; p_docentes NUMBER;
  -- políticas, macroproyecto
  v_comp NUMBER; v_peace NUMBER; v_victims NUMBER; v_territ NUMBER; v_macro NUMBER; v_geo NUMBER;
  -- metas
  i1 NUMBER; i2 NUMBER;                                   -- impacto
  r1 NUMBER; r2 NUMBER; r3 NUMBER; r4 NUMBER;             -- resultado
  m1 NUMBER; m2 NUMBER; m3 NUMBER; m4 NUMBER; m5 NUMBER; m6 NUMBER;   -- producto
  y1 NUMBER; y1a NUMBER; y1b NUMBER; y2 NUMBER; y2a NUMBER; y2b NUMBER;  -- proyectos / actividades
  a1 NUMBER; a1a NUMBER; a1b NUMBER; a2 NUMBER; a2a NUMBER; a2b NUMBER;  -- planes de acción
  v_rec NUMBER;
  v_act_goal NUMBER;

  /* ------------------------------------------------------------- utilidades */
  -- Ventana [inicio, fin] (formato de la app React) de hoy-10 a hoy+20 días, o una pasada
  FUNCTION win(p_from DATE, p_days NUMBER) RETURN VARCHAR2 IS
  BEGIN
    RETURN '["' || TO_CHAR(p_from, 'YYYY-MM-DD') || 'T05:00:00.000Z","'
                || TO_CHAR(p_from + p_days, 'YYYY-MM-DD') || 'T04:59:59.000Z"]';
  END;

  -- Estructura del plan en el SIIF (EJE_ESTRUCTURANTE > SECTOR > PROGRAMA_PRY): PROYECTO tiene FK
  -- (PROY_PROGRA_FK) a PROGRAMA_PRY. SQL dinámico y solo si la tabla existe (en local no se crean).
  FUNCTION siif_table(p_table VARCHAR2) RETURN BOOLEAN IS
    k NUMBER;
  BEGIN
    SELECT COUNT(*) INTO k FROM USER_TABLES WHERE TABLE_NAME = p_table;
    RETURN k > 0;
  END;

  PROCEDURE siif_structure(p_delete BOOLEAN) IS
  BEGIN
    IF v_plan IS NULL THEN
      RETURN;
    END IF;
    IF p_delete THEN   -- hijos primero
      IF siif_table('PROGRAMA_PRY') THEN
        EXECUTE IMMEDIATE 'DELETE FROM PROGRAMA_PRY WHERE NIT_COMPANIA = :1 AND PLAN = :2' USING c_nit, v_plan;
      END IF;
      IF siif_table('SECTOR') THEN
        EXECUTE IMMEDIATE 'DELETE FROM SECTOR WHERE NIT_COMPANIA = :1 AND PLAN = :2' USING c_nit, v_plan;
      END IF;
      IF siif_table('EJE_ESTRUCTURANTE') THEN
        EXECUTE IMMEDIATE 'DELETE FROM EJE_ESTRUCTURANTE WHERE NIT_COMPANIA = :1 AND PLAN = :2' USING c_nit, v_plan;
      END IF;
    ELSE               -- eje e > sector e > programa e (e = 1 Transporte, 2 Educación)
      FOR e IN 1 .. 2 LOOP
        IF siif_table('EJE_ESTRUCTURANTE') THEN
          EXECUTE IMMEDIATE 'INSERT INTO EJE_ESTRUCTURANTE (NIT_COMPANIA, PLAN, EJE, NOMBRE) VALUES (:1, :2, :3, :4)'
            USING c_nit, v_plan, e, c_pref || CASE e WHEN 1 THEN 'Territorio conectado' ELSE 'Educación de calidad' END;
        END IF;
        IF siif_table('SECTOR') THEN
          EXECUTE IMMEDIATE 'INSERT INTO SECTOR (NIT_COMPANIA, PLAN, EJE, SECTOR, NOMBRE) VALUES (:1, :2, :3, :3, :4)'
            USING c_nit, v_plan, e, c_pref || CASE e WHEN 1 THEN 'Transporte' ELSE 'Educación' END;
        END IF;
        IF siif_table('PROGRAMA_PRY') THEN
          EXECUTE IMMEDIATE 'INSERT INTO PROGRAMA_PRY (NIT_COMPANIA, PLAN, EJE, SECTOR, PROGRAMA, NOMBRE) '
                         || 'VALUES (:1, :2, :3, :3, :3, :4)'
            USING c_nit, v_plan, e, c_pref || CASE e WHEN 1 THEN 'Infraestructura red vial regional'
                                                    ELSE 'Calidad y fomento de la educación' END;
        END IF;
      END LOOP;
    END IF;
  END;

  -- ODS (tabla global): usa el existente (con o sin prefijo) o lo crea con prefijo
  FUNCTION ods(p_name VARCHAR2) RETURN NUMBER IS
    v NUMBER;
  BEGIN
    SELECT MIN(ID) INTO v FROM SPD_ODS WHERE NAME IN (p_name, 'SPD ' || p_name, c_pref || p_name);
    IF v IS NULL THEN
      INSERT INTO SPD_ODS (NAME) VALUES (c_pref || p_name) RETURNING ID INTO v;
    END IF;
    RETURN v;
  END;

  -- Unidad de la compañía (UNIDADES_PRY): la que exista con ese nombre o una nueva "SPD PRUEBA 2 ...".
  FUNCTION unit(p_name VARCHAR2, p_initials VARCHAR2 DEFAULT NULL) RETURN NUMBER IS
    v NUMBER;
  BEGIN
    SELECT MIN(CODIGO_UND) INTO v FROM UNIDADES_PRY
     WHERE NIT_COMPANIA = c_nit
       AND UPPER(TRIM(NOMBRE_UNIDAD)) IN (UPPER(p_name), UPPER('SPD ' || p_name), UPPER(c_pref || p_name));
    IF v IS NULL THEN
      SELECT NVL(MAX(CODIGO_UND), 0) + 1 INTO v FROM UNIDADES_PRY WHERE NIT_COMPANIA = c_nit;
      INSERT INTO UNIDADES_PRY (NIT_COMPANIA, CODIGO_UND, NOMBRE_UNIDAD, SIGLA)
      VALUES (c_nit, v, c_pref || p_name, p_initials);
    END IF;
    RETURN v;
  END;

  -- Producto de la compañía (PRODUCTOS_PRY): el que exista con ese código o uno nuevo "SPD PRUEBA 2 ...".
  FUNCTION product(p_code VARCHAR2, p_name VARCHAR2, p_programa VARCHAR2) RETURN NUMBER IS
    v NUMBER;
  BEGIN
    SELECT MIN(ID) INTO v FROM PRODUCTOS_PRY WHERE NIT_COMPANIA = c_nit AND CODIGO = p_code;
    IF v IS NULL THEN
      INSERT INTO PRODUCTOS_PRY (NIT_COMPANIA, CODIGO, NOMBRE, DESCRIPCION, PROGRAMA)
      VALUES (c_nit, p_code, c_pref || p_name, 'Producto de prueba SPD PRUEBA 2', p_programa)
      RETURNING ID INTO v;
    END IF;
    RETURN v;
  END;

  FUNCTION plan_level(p_code VARCHAR2, p_name VARCHAR2, p_level NUMBER, p_parent NUMBER,
                      p_sector VARCHAR2 DEFAULT NULL) RETURN NUMBER IS
    v NUMBER;
  BEGIN
    INSERT INTO SPD_DEV_PLAN_LEVEL (NIT_COMPANIA, PLAN, CODE, NAME, "LEVEL", PARENT_ID, WEIGHTING, SECTOR_CODE)
    VALUES (c_nit, v_plan, p_code, c_pref || p_name, p_level, p_parent, 50, p_sector)
    RETURNING ID INTO v;
    RETURN v;
  END;

  FUNCTION new_goal(p_type VARCHAR2, p_code VARCHAR2, p_name VARCHAR2, p_indicator VARCHAR2,
                    p_level NUMBER, p_parent NUMBER, p_entity NUMBER, p_accum VARCHAR2,
                    p_base NUMBER, p_value NUMBER, p_unit NUMBER,
                    p_project VARCHAR2 DEFAULT NULL, p_product NUMBER DEFAULT NULL) RETURN NUMBER IS
    v NUMBER;
  BEGIN
    INSERT INTO SPD_GOAL
      (NIT_COMPANIA, PARENT_GOAL_ID, PLAN, DEV_PLAN_LEVEL_ID, ENTITY_ID, GOAL_TYPE, CODE, NAME,
       INDICATOR, DESCRIPTION, ACCUMULATION_TYPE, BASE_VALUE, GOAL_VALUE, UNITS_FACTOR, UNIT_CODE,
       PRODUCT_ID, WEIGHTING, PROJECT_CODE, START_DATE, END_DATE, CREATED_BY)
    VALUES
      (c_nit, p_parent, v_plan, p_level, p_entity, p_type, c_code || p_code, c_pref || p_name,
       p_indicator, 'Meta de prueba SPD PRUEBA 2', p_accum, p_base, p_value, 1, p_unit,
       p_product, 100, p_project, TIMESTAMP '2024-01-01 00:00:00 -05:00',
       TIMESTAMP '2027-12-31 00:00:00 -05:00', v_user)
    RETURNING ID INTO v;
    INSERT INTO SPD_GOAL_HISTORY (GOAL_ID, EVENT, DESCRIPTION, CREATED_AT, CREATED_BY)
    VALUES (v, 'CREATED', 'Meta creada', TIMESTAMP '2024-03-01 08:00:00 -05:00', v_user);
    RETURN v;
  END;

  PROCEDURE add_history(p_goal NUMBER, p_rec NUMBER, p_event VARCHAR2, p_desc VARCHAR2, p_days NUMBER) IS
  BEGIN
    INSERT INTO SPD_GOAL_HISTORY (GOAL_ID, MONITORING_RECORD_ID, EVENT, DESCRIPTION, CREATED_AT, CREATED_BY)
    VALUES (p_goal, p_rec, p_event, p_desc, SYSTIMESTAMP - NUMTODSINTERVAL(p_days, 'DAY'), v_user);
  END;

  PROCEDURE add_resource(p_rec NUMBER, p_type VARCHAR2, p_total NUMBER, p_ind NUMBER) IS
  BEGIN
    INSERT INTO SPD_MONITORING_RECORD_RESOURCE
      (MONITORING_RECORD_ID, RESOURCE_TYPE, RP, SGP_FREE_INVESTMENT, SGR, CN, FINANCIAL_INDICATOR, CREATED_BY)
    VALUES (p_rec, p_type, ROUND(p_total * 0.50, -3), ROUND(p_total * 0.20, -3),
            ROUND(p_total * 0.20, -3), ROUND(p_total * 0.10, -3), p_ind, v_user);
  END;

  -- Registro de seguimiento de la meta, con recursos e historial según el estado:
  -- PLANNED, REPORTED, VALIDATED o REVIEWED. p_exec = fracción ejecutada del presupuesto (compromisos).
  FUNCTION add_record(p_cfg NUMBER, p_sub NUMBER, p_goal NUMBER, p_status VARCHAR2, p_prog NUMBER,
                      p_achieved NUMBER, p_budget NUMBER, p_exec NUMBER DEFAULT 0.8) RETURN NUMBER IS
    v     NUMBER;
    rep   BOOLEAN := p_status IN ('REPORTED','VALIDATED','REVIEWED');
    rep_s VARCHAR2(1) := CASE WHEN p_status IN ('REPORTED','VALIDATED','REVIEWED') THEN 'S' ELSE 'N' END;
    phys  NUMBER;
    d0    NUMBER := CASE WHEN p_sub = 4 THEN 0 ELSE 90 END;   -- antigüedad del historial
  BEGIN
    IF rep THEN
      phys := LEAST(ROUND(p_achieved / p_prog, 4), 1);
    END IF;
    INSERT INTO SPD_MONITORING_RECORD
      (MONITORING_CONFIG_ID, GOAL_ID, PERIOD, GOAL_VALUE, FROM_MONTH, TO_MONTH, GOAL_ACHIEVED_VALUE,
       RECORD_STATUS, WEIGHTING, PHYSICAL_INDICATOR, TOTAL_PEOPLE, NOTES,
       QUESTION_HOW, QUESTION_RESULT, QUESTION_EVIDENCE, QUESTION_PROBLEM, CREATED_BY, UPDATED_BY)
    VALUES
      (p_cfg, p_goal, 2026, p_prog, (p_sub - 1) * 3 + 1, p_sub * 3, CASE WHEN rep_s = 'S' THEN p_achieved END,
       p_status, 100, phys, CASE WHEN rep_s = 'S' THEN 180 END,
       CASE WHEN rep_s = 'S' THEN 'SPD PRUEBA 2 Avance del trimestre ' || p_sub || ' de 2026.' END,
       CASE WHEN rep_s = 'S' THEN 'Se ejecutaron las actividades programadas para el trimestre.' END,
       CASE WHEN rep_s = 'S' THEN 'Se logró ' || ROUND(phys * 100) || '% de lo programado.' END,
       CASE WHEN rep_s = 'S' THEN 'Actas, registro fotográfico e informe de supervisión.' END,
       CASE WHEN rep_s = 'S' AND phys < 0.8 THEN 'Retrasos en la contratación por trámites presupuestales.' END,
       v_user, v_user)
    RETURNING ID INTO v;

    add_resource(v, 'DEFINITIVE', p_budget, NULL);   -- apropiado
    add_history(p_goal, v, 'SCHEDULED', 'Meta programada para 2026-' || p_sub, d0 + 9);
    IF rep THEN
      add_resource(v, 'COMMITMENT', p_budget * p_exec, p_exec);
      add_resource(v, 'OBLIGATION', p_budget * p_exec * 0.7, ROUND(p_exec * 0.7, 4));
      add_resource(v, 'PAYMENT',    p_budget * p_exec * 0.5, ROUND(p_exec * 0.5, 4));
      add_history(p_goal, v, 'MONITORED', 'Avance reportado', d0 + 6);
    END IF;
    IF p_status IN ('VALIDATED','REVIEWED') THEN
      add_history(p_goal, v, 'VALIDATED', 'Avance validado por la oficina de planeación', d0 + 4);
    END IF;
    IF p_status = 'REVIEWED' THEN
      add_history(p_goal, v, 'REVIEWED', 'Avance revisado', d0 + 2);
    END IF;
    RETURN v;
  END;

  FUNCTION new_config(p_sub NUMBER, p_active VARCHAR2, p_status VARCHAR2, p_dates VARCHAR2) RETURN NUMBER IS
    v NUMBER;
  BEGIN
    INSERT INTO SPD_MONITORING_CONFIG
      (USED_FOR, NIT_COMPANIA, IS_ACTIVE, PLAN, PERIOD, SUBPERIOD, PERIODICITY, SPENT_DOCS, WEIGHTING_TYPE,
       DATES_CONFIG, COLORS_CONFIG, STATUS, MONITORING_RESOURCES_ORIGIN, SUPPORT_PRODUCT_MONITORING,
       SGP_DISCRIMINATED, GOAL_TYPES, CREATED_BY)
    VALUES
      ('DEVELOPMENT_PLANS', c_nit, p_active, v_plan, 2026, p_sub, 3, '["COMMITMENT","OBLIGATION","PAYMENT"]',
       'FINANCIAL', p_dates,
       '[{"fromValue":0,"toValue":25,"includeFromValue":true,"includeToValue":true,"color":"#000000","label":"Ineficiente"},'
       || '{"fromValue":25,"toValue":50,"includeFromValue":false,"includeToValue":true,"color":"#f5222d","label":"Bajo"},'
       || '{"fromValue":50,"toValue":80,"includeFromValue":false,"includeToValue":true,"color":"#fadb14","label":"Medio"},'
       || '{"fromValue":80,"toValue":100,"includeFromValue":false,"includeToValue":true,"color":"#52c41a","label":"Alto"}]',
       p_status, 'FINANCIAL', 'S', 'S',
       '["IMPACT","RESULT","PRODUCT","PROJECT","ACTIVITY","ACTION_PLAN"]', v_user)
    RETURNING ID INTO v;
    RETURN v;
  END;

BEGIN
  SELECT COUNT(*) INTO n FROM COMPANIA WHERE NIT_COMPANIA = c_nit;
  IF n = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'No existe la compañía ' || c_nit || ' en COMPANIA');
  END IF;

  /* ================================================================ limpieza (solo datos "SPD PRUEBA 2") */
  SELECT MIN(PLAN) INTO v_plan FROM PLAN_DESARROLLO WHERE NIT_COMPANIA = c_nit AND NOMBRE = c_plan_name;

  -- metas de prueba: las "SPDP2-..." y cualquier otra creada dentro del plan de prueba
  DELETE FROM SPD_GOAL_HISTORY
   WHERE GOAL_ID IN (SELECT ID FROM SPD_GOAL WHERE NIT_COMPANIA = c_nit AND (CODE LIKE 'SPDP2-%' OR PLAN = v_plan))
      OR MONITORING_RECORD_ID IN (SELECT r.ID FROM SPD_MONITORING_RECORD r
                                  WHERE r.GOAL_ID IN (SELECT ID FROM SPD_GOAL WHERE NIT_COMPANIA = c_nit
                                                       AND (CODE LIKE 'SPDP2-%' OR PLAN = v_plan))
                                     OR r.MONITORING_CONFIG_ID IN (SELECT ID FROM SPD_MONITORING_CONFIG
                                                                   WHERE NIT_COMPANIA = c_nit AND PLAN = v_plan));
  FOR r IN (SELECT ID FROM SPD_MONITORING_RECORD
             WHERE GOAL_ID IN (SELECT ID FROM SPD_GOAL WHERE NIT_COMPANIA = c_nit
                                AND (CODE LIKE 'SPDP2-%' OR PLAN = v_plan))
                OR MONITORING_CONFIG_ID IN (SELECT ID FROM SPD_MONITORING_CONFIG
                                            WHERE NIT_COMPANIA = c_nit AND PLAN = v_plan)) LOOP
    DELETE FROM SPD_MONITORING_RECORD_ATTACH   WHERE MONITORING_RECORD_ID = r.ID;
    DELETE FROM SPD_MONITORING_RECORD_RESOURCE WHERE MONITORING_RECORD_ID = r.ID;
    DELETE FROM SPD_MONITORING_RECORD          WHERE ID = r.ID;
  END LOOP;
  DELETE FROM SPD_MONITORING_CONFIG WHERE NIT_COMPANIA = c_nit AND PLAN = v_plan;
  DELETE FROM SPD_ACTIVITY_GOAL_ACTION WHERE ACTIVITY_GOAL_ID IN
    (SELECT ID FROM SPD_ACTIVITY_GOAL WHERE GOAL_ID IN
       (SELECT ID FROM SPD_GOAL WHERE NIT_COMPANIA = c_nit AND (CODE LIKE 'SPDP2-%' OR PLAN = v_plan)));
  DELETE FROM SPD_ACTIVITY_GOAL WHERE GOAL_ID IN
    (SELECT ID FROM SPD_GOAL WHERE NIT_COMPANIA = c_nit AND (CODE LIKE 'SPDP2-%' OR PLAN = v_plan));
  DELETE FROM SPD_GOAL_TO_ACTIVITY WHERE GOAL_ID IN
    (SELECT ID FROM SPD_GOAL WHERE NIT_COMPANIA = c_nit AND (CODE LIKE 'SPDP2-%' OR PLAN = v_plan));
  UPDATE SPD_GOAL SET PARENT_GOAL_ID = NULL
   WHERE NIT_COMPANIA = c_nit AND (CODE LIKE 'SPDP2-%' OR PLAN = v_plan);
  DELETE FROM SPD_GOAL WHERE NIT_COMPANIA = c_nit AND (CODE LIKE 'SPDP2-%' OR PLAN = v_plan);
  UPDATE SPD_DEV_PLAN_LEVEL SET PARENT_ID = NULL WHERE NIT_COMPANIA = c_nit AND PLAN = v_plan;
  DELETE FROM SPD_DEV_PLAN_LEVEL WHERE NIT_COMPANIA = c_nit AND PLAN = v_plan;

  DELETE FROM SPD_PUBLIC_POLITIC_TO_COMP
   WHERE PUBLIC_POLITIC_ID IN (SELECT ID FROM SPD_PUBLIC_POLITIC WHERE NIT_COMPANIA = c_nit AND NAME LIKE 'SPD PRUEBA 2 %')
      OR COMPONENT_ID IN (SELECT ID FROM SPD_PUBLIC_POLITIC_COMPONENT WHERE NIT_COMPANIA = c_nit AND NAME LIKE 'SPD PRUEBA 2 %');
  DELETE FROM SPD_PUBLIC_POLITIC           WHERE NIT_COMPANIA = c_nit AND NAME LIKE 'SPD PRUEBA 2 %';
  DELETE FROM SPD_PUBLIC_POLITIC_COMPONENT WHERE NIT_COMPANIA = c_nit AND NAME LIKE 'SPD PRUEBA 2 %';
  DELETE FROM SPD_MACRO_PROJECT            WHERE NIT_COMPANIA = c_nit AND NAME LIKE 'SPD PRUEBA 2 %';
  DELETE FROM SPD_GEO_LOCATION WHERE NIT_COMPANIA = c_nit AND NAME LIKE 'SPD PRUEBA 2 %' AND PARENT_LOCATION_ID IS NOT NULL;
  DELETE FROM SPD_GEO_LOCATION WHERE NIT_COMPANIA = c_nit AND NAME LIKE 'SPD PRUEBA 2 %';

  DELETE FROM PROYECTO        WHERE NIT_COMPANIA = c_nit AND USUARIO = c_user AND NOMBRE LIKE 'SPD PRUEBA 2 %';
  DELETE FROM USUARIOS        WHERE NIT_COMPANIA = c_nit AND USUARIO = c_user;
  siif_structure(p_delete => TRUE);
  DELETE FROM PLAN_DESARROLLO WHERE NIT_COMPANIA = c_nit AND NOMBRE = c_plan_name;
  DELETE FROM ENTIDADES_PRY   WHERE NIT_COMPANIA = c_nit AND CODIGO_ENT_PRY IN (c_ent_inf, c_ent_edu);

  /* ================================================================ SIIF: entidades, plan, usuario, proyectos */
  IF v_plan IS NULL THEN
    SELECT NVL(MAX(PLAN), 0) + 1 INTO v_plan FROM PLAN_DESARROLLO WHERE NIT_COMPANIA = c_nit;
  END IF;

  INSERT INTO ENTIDADES_PRY (NIT_COMPANIA, CODIGO_ENT_PRY, NOMBRE_ENT_PRY, ORDEN, SECRETARIO, TIPO_CARGO,
                             ENT_SIGLA, ACTIVA, SPD_PRESUPUESTO_MANUAL, SPD_FECHA_INICIO)
  VALUES (c_nit, c_ent_inf, c_pref || 'Secretaría de Infraestructura', 'M', 'Laura Gómez', 'Secretario(a)',
          'SPDP2INF', 'S', 'S', DATE '2024-01-01')
  RETURNING ID INTO v_inf;
  INSERT INTO ENTIDADES_PRY (NIT_COMPANIA, CODIGO_ENT_PRY, NOMBRE_ENT_PRY, ORDEN, SECRETARIO, TIPO_CARGO,
                             ENT_SIGLA, ACTIVA, SPD_PRESUPUESTO_MANUAL, SPD_FECHA_INICIO)
  VALUES (c_nit, c_ent_edu, c_pref || 'Secretaría de Educación', 'M', 'Carlos Ramírez', 'Secretario(a)',
          'SPDP2EDU', 'S', 'N', DATE '2024-01-01')
  RETURNING ID INTO v_edu;

  INSERT INTO PLAN_DESARROLLO (NIT_COMPANIA, PLAN, NOMBRE, FECHA_INICIO, FECHA_FIN, OBJETIVO, GOBERNANTE,
                               SPD_ACTIVO, SPD_INICIO_GOBIERNO, SPD_FIN_GOBIERNO, SPD_CONFIG,
                               SPD_ORIGEN_ACTIVIDADES)
  VALUES (c_nit, v_plan, c_plan_name, DATE '2024-06-01', DATE '2027-12-31',
          'Mejorar la conectividad vial y la calidad educativa del municipio.', 'Andrés Pérez', 'S',
          DATE '2024-01-01', DATE '2027-12-31',
          '{"levels":[{"number":1,"singularName":"Eje","pluralName":"Ejes","goalType":"IMPACT"},'
          || '{"number":2,"singularName":"Sector","pluralName":"Sectores","isSectorLevel":true},'
          || '{"number":3,"singularName":"Programa","pluralName":"Programas","goalType":"RESULT"},'
          || '{"number":4,"singularName":"Subprograma","pluralName":"Subprogramas","goalType":"PRODUCT"},'
          || '{"number":5,"singularName":"Plan de acción","pluralName":"Planes de acción","goalType":"ACTION_PLAN"}]}',
          'SIIF');

  siif_structure(p_delete => FALSE);

  INSERT INTO USUARIOS (NIT_COMPANIA, USUARIO, DESCRIPCION, USERTYPE, ESTADO, EMAIL, CEDULA,
                        CODIGO_ENT_PRY, CARGO, ORIGEN_CREACION)
  VALUES (c_nit, c_user, c_pref || 'Usuario de prueba', 'CONSULTA', 'V', 'spdp2.demo@spd.local', '1000000002',
          c_ent_inf, 'Profesional de planeación', 'AU')
  RETURNING ID INTO v_user;

  SELECT NVL(MAX(PROYECTO), 0) + 1 INTO v_pry1 FROM PROYECTO WHERE NIT_COMPANIA = c_nit;
  v_pry2 := v_pry1 + 1;
  INSERT INTO PROYECTO (PLAN, PROGRAMA, SECTOR, EJE, NIT_COMPANIA, PROYECTO, NOMBRE, ANO, CODIGO,
                        FECHA_REGISTRO, OBJETIVOS, VALOR, ESTADO, CODIGO_ENT_PRY, ESTADO_PROCESO,
                        USUARIO, FECHA_CREACION)
  VALUES (v_plan, 1, 1, 1, c_nit, v_pry1, c_pref || 'Mejoramiento de vías terciarias', 2026,
          'SPDP2-2026-0001', DATE '2026-01-20', 'Mejorar 30 km de vías terciarias.', 2400000000, 'A',
          c_ent_inf, 'REGISTRADO', c_user, SYSDATE);
  INSERT INTO PROYECTO (PLAN, PROGRAMA, SECTOR, EJE, NIT_COMPANIA, PROYECTO, NOMBRE, ANO, CODIGO,
                        FECHA_REGISTRO, OBJETIVOS, VALOR, ESTADO, CODIGO_ENT_PRY, ESTADO_PROCESO,
                        USUARIO, FECHA_CREACION)
  VALUES (v_plan, 2, 2, 2, c_nit, v_pry2, c_pref || 'Adecuación de sedes educativas rurales', 2026,
          'SPDP2-2026-0002', DATE '2026-02-10', 'Adecuar 12 sedes educativas rurales.', 1500000000, 'A',
          c_ent_edu, 'REGISTRADO', c_user, SYSDATE);

  /* ================================================================ catálogos */
  v_ods4  := ods('Educación de calidad');
  v_ods9  := ods('Industria, innovación e infraestructura');
  v_ods11 := ods('Ciudades y comunidades sostenibles');
  v_km   := unit('Kilómetros', 'Km');
  v_num  := unit('Número', 'Nro');
  v_pct  := unit('Porcentaje', '%');
  v_min  := unit('Minutos', 'Min');
  v_tasa := unit('Tasa', 'Tasa');
  -- productos (sector DNP = 2 primeros dígitos del programa: 24 Transporte, 22 Educación)
  p_via      := product('2402041', 'Vía terciaria mejorada', '2402');
  p_placa    := product('2402042', 'Placa huella construida', '2402');
  p_puente   := product('2402043', 'Puente de la red vial terciaria mantenido', '2402');
  p_aula     := product('2201068', 'Sede educativa mejorada', '2201');
  p_dotacion := product('2201069', 'Sede educativa dotada', '2201');
  p_docentes := product('2201070', 'Docentes formados', '2201');

  /* ================================================================ estructura del plan (5 niveles) */
  t1 := plan_level('1',         'Territorio conectado', 1, NULL);
  t2 := plan_level('1.24',      'Transporte', 2, t1, '24');
  t3 := plan_level('1.24.1',    'Vías para la competitividad', 3, t2);
  t4 := plan_level('1.24.1.1',  'Red vial terciaria', 4, t3);
  t5 := plan_level('1.24.1.1.1', 'Plan de acción de infraestructura', 5, t4);
  e1 := plan_level('2',         'Educación de calidad', 1, NULL);
  e2 := plan_level('2.22',      'Educación', 2, e1, '22');
  e3 := plan_level('2.22.1',    'Calidad y fomento de la educación', 3, e2);
  e4 := plan_level('2.22.1.1',  'Ambientes escolares rurales', 4, e3);
  e5 := plan_level('2.22.1.1.1', 'Plan de acción de educación', 5, e4);

  /* ================================================================ políticas, macroproyecto, ubicaciones */
  INSERT INTO SPD_PUBLIC_POLITIC_COMPONENT (NIT_COMPANIA, CODE, NAME, DESCRIPTION, CREATED_BY)
  VALUES (c_nit, 'SPDP2-C-01', c_pref || 'Movilidad rural', 'Acceso de la población rural a bienes y servicios', v_user)
  RETURNING ID INTO v_comp;
  INSERT INTO SPD_PUBLIC_POLITIC (NIT_COMPANIA, CATEGORY, CODE, NAME, DESCRIPTION)
  VALUES (c_nit, 'PEACE', 'SPDP2-PAZ-01', c_pref || 'Reforma rural integral', 'Punto 1 del Acuerdo de Paz')
  RETURNING ID INTO v_peace;
  INSERT INTO SPD_PUBLIC_POLITIC (NIT_COMPANIA, CATEGORY, CODE, NAME, DESCRIPTION)
  VALUES (c_nit, 'VICTIMS', 'SPDP2-VIC-01', c_pref || 'Reparación integral', 'Medidas de reparación a víctimas')
  RETURNING ID INTO v_victims;
  INSERT INTO SPD_PUBLIC_POLITIC (NIT_COMPANIA, CATEGORY, CODE, NAME, DESCRIPTION, FROM_YEAR, TO_YEAR)
  VALUES (c_nit, 'TERRITORY', 'SPDP2-PPT-01', c_pref || 'Política pública de desarrollo rural',
          'Acuerdo municipal 012 de 2024', 2024, 2034)
  RETURNING ID INTO v_territ;
  INSERT INTO SPD_PUBLIC_POLITIC_TO_COMP (PUBLIC_POLITIC_ID, COMPONENT_ID) VALUES (v_territ, v_comp);

  INSERT INTO SPD_MACRO_PROJECT (NIT_COMPANIA, CODE, NAME, DESCRIPTION, CREATED_BY)
  VALUES (c_nit, 'SPDP2-MAC-01', c_pref || 'Corredor vial rural', 'Agrupa las obras viales de la zona rural', v_user)
  RETURNING ID INTO v_macro;

  INSERT INTO SPD_GEO_LOCATION (NIT_COMPANIA, CODE, NAME, LOCATION_TYPE)
  VALUES (c_nit, 'SPDP2-76834', c_pref || 'Tuluá', 'MUNICIPALITY') RETURNING ID INTO v_geo;
  INSERT INTO SPD_GEO_LOCATION (NIT_COMPANIA, CODE, NAME, LOCATION_TYPE, PARENT_LOCATION_ID)
  VALUES (c_nit, 'SPDP2-76834-C1', c_pref || 'Comuna 1 - Centro', 'DISTRICT', v_geo);
  INSERT INTO SPD_GEO_LOCATION (NIT_COMPANIA, CODE, NAME, LOCATION_TYPE, PARENT_LOCATION_ID)
  VALUES (c_nit, 'SPDP2-76834-R1', c_pref || 'Corregimiento Aguaclara', 'TOWNSHIP', v_geo);
  INSERT INTO SPD_GEO_LOCATION (NIT_COMPANIA, CODE, NAME, LOCATION_TYPE, PARENT_LOCATION_ID)
  VALUES (c_nit, 'SPDP2-76834-R2', c_pref || 'Corregimiento La Moralia', 'TOWNSHIP', v_geo);

  /* ================================================================ metas */
  -- nivel 1: impacto
  i1 := new_goal('IMPACT', 'MI-01', 'Aumentar la competitividad del territorio rural',
                 'Índice de competitividad municipal', t1, NULL, v_inf, 'STOCK', 4.8, 5.5, v_num);
  i2 := new_goal('IMPACT', 'MI-02', 'Mejorar la calidad de la educación rural',
                 'Puntaje promedio pruebas Saber 11 zona rural', e1, NULL, v_edu, 'STOCK', 230, 250, v_num);
  -- nivel 3: resultado
  r1 := new_goal('RESULT', 'MR-01', 'Reducir el tiempo de desplazamiento entre la zona rural y la cabecera',
                 'Tiempo promedio de desplazamiento', t3, i1, v_inf, 'REDUCTION', 90, 60, v_min);
  r2 := new_goal('RESULT', 'MR-02', 'Aumentar la red vial terciaria en buen estado',
                 'Porcentaje de vías terciarias en buen estado', t3, i1, v_inf, 'STOCK', 35, 60, v_pct);
  r3 := new_goal('RESULT', 'MR-03', 'Disminuir la deserción escolar rural',
                 'Tasa de deserción escolar rural', e3, i2, v_edu, 'REDUCTION', 6.5, 4, v_tasa);
  r4 := new_goal('RESULT', 'MR-04', 'Aumentar la cobertura en educación media rural',
                 'Tasa de cobertura neta en media rural', e3, i2, v_edu, 'STOCK', 42, 55, v_tasa);
  -- nivel 4: producto
  m1 := new_goal('PRODUCT', 'MP-01', 'Mejorar kilómetros de vías terciarias', 'Vía terciaria mejorada',
                 t4, r1, v_inf, 'ACCUMULATED', 0, 30, v_km, NULL, p_via);
  m2 := new_goal('PRODUCT', 'MP-02', 'Construir placa huella en vías rurales', 'Placa huella construida',
                 t4, r2, v_inf, 'ACCUMULATED', 0, 10, v_km, NULL, p_placa);
  m3 := new_goal('PRODUCT', 'MP-03', 'Mantener puentes vehiculares', 'Puentes mantenidos',
                 t4, r2, v_inf, 'ACCUMULATED', 2, 8, v_num, NULL, p_puente);
  m4 := new_goal('PRODUCT', 'MP-04', 'Mejorar sedes educativas rurales', 'Sedes educativas mejoradas',
                 e4, r3, v_edu, 'ACCUMULATED', 0, 12, v_num, NULL, p_aula);
  m5 := new_goal('PRODUCT', 'MP-05', 'Dotar sedes educativas rurales', 'Sedes educativas dotadas',
                 e4, r4, v_edu, 'ACCUMULATED', 0, 20, v_num, NULL, p_dotacion);
  m6 := new_goal('PRODUCT', 'MP-06', 'Formar docentes rurales', 'Docentes formados',
                 e4, r4, v_edu, 'ACCUMULATED', 0, 150, v_num, NULL, p_docentes);
  -- SPDP2-MP-01 con todos los vínculos del formulario de metas
  UPDATE SPD_GOAL
     SET ODS_IDS = '[' || v_ods9 || ',' || v_ods11 || ']',
         PUBLIC_POLITIC_ID = v_territ, PUBLIC_POLITIC_COMPONENT_ID = v_comp,
         PEACE_POLITIC_ID = v_peace, VICTIMS_POLITIC_ID = v_victims, MACRO_PROJECT_ID = v_macro,
         PI_BASE_VALUE = 0, PI_GOAL_VALUE = 30, PI_UNITS_FACTOR = 1, PI_UNIT_CODE = v_km
   WHERE ID = m1;
  UPDATE SPD_GOAL SET ODS_IDS = '[' || v_ods9 || ']', MACRO_PROJECT_ID = v_macro WHERE ID IN (m2, m3);
  UPDATE SPD_GOAL SET ODS_IDS = '[' || v_ods4 || ']' WHERE ID IN (m4, m5, m6, r3, r4, i2);

  -- proyectos y actividades (nivel 4)
  y1  := new_goal('PROJECT', 'PRY-01', 'Mejoramiento de vías terciarias', 'Porcentaje de avance del proyecto',
                  t4, NULL, v_inf, 'ACCUMULATED', 0, 100, v_pct, TO_CHAR(v_pry1));
  y1a := new_goal('ACTIVITY', 'PRY-01.A1', 'Estudios y diseños', 'Estudios entregados',
                  t4, y1, v_inf, 'ACCUMULATED', 0, 2, v_num, TO_CHAR(v_pry1));
  y1b := new_goal('ACTIVITY', 'PRY-01.A2', 'Ejecución de obras', 'Kilómetros intervenidos',
                  t4, y1, v_inf, 'ACCUMULATED', 0, 30, v_km, TO_CHAR(v_pry1));
  y2  := new_goal('PROJECT', 'PRY-02', 'Adecuación de sedes educativas rurales', 'Porcentaje de avance del proyecto',
                  e4, NULL, v_edu, 'ACCUMULATED', 0, 100, v_pct, TO_CHAR(v_pry2));
  y2a := new_goal('ACTIVITY', 'PRY-02.A1', 'Diagnóstico de infraestructura', 'Sedes diagnosticadas',
                  e4, y2, v_edu, 'ACCUMULATED', 0, 12, v_num, TO_CHAR(v_pry2));
  y2b := new_goal('ACTIVITY', 'PRY-02.A2', 'Obras de adecuación', 'Sedes adecuadas',
                  e4, y2, v_edu, 'ACCUMULATED', 0, 12, v_num, TO_CHAR(v_pry2));

  -- nivel 5: planes de acción
  a1  := new_goal('ACTION_PLAN', 'PA-01', 'Plan de acción 2026 - Secretaría de Infraestructura',
                  'Porcentaje de cumplimiento del plan', t5, NULL, v_inf, 'ACCUMULATED', 0, 100, v_pct);
  a1a := new_goal('ACTION_PLAN_ACTIVITY', 'PA-01.M1', 'Socializar las obras con las juntas de acción comunal',
                  'Jornadas realizadas', t5, a1, v_inf, 'ACCUMULATED', 0, 4, v_num);
  a1b := new_goal('ACTION_PLAN_ACTIVITY', 'PA-01.M2', 'Hacer seguimiento a los contratos de obra',
                  'Informes de seguimiento', t5, a1, v_inf, 'ACCUMULATED', 0, 12, v_num);
  a2  := new_goal('ACTION_PLAN', 'PA-02', 'Plan de acción 2026 - Secretaría de Educación',
                  'Porcentaje de cumplimiento del plan', e5, NULL, v_edu, 'ACCUMULATED', 0, 100, v_pct);
  a2a := new_goal('ACTION_PLAN_ACTIVITY', 'PA-02.M1', 'Realizar mesas de trabajo con rectores',
                  'Mesas realizadas', e5, a2, v_edu, 'ACCUMULATED', 0, 6, v_num);
  a2b := new_goal('ACTION_PLAN_ACTIVITY', 'PA-02.M2', 'Publicar informes de matrícula',
                  'Informes publicados', e5, a2, v_edu, 'ACCUMULATED', 0, 4, v_num);

  -- Otros > Metas de actividades y Metas por actividad
  INSERT INTO SPD_GOAL_TO_ACTIVITY (NIT_COMPANIA, GOAL_ID, ACTIVITY_ID, CREATED_BY) VALUES (c_nit, m1, y1b, v_user);
  INSERT INTO SPD_GOAL_TO_ACTIVITY (NIT_COMPANIA, GOAL_ID, ACTIVITY_ID, CREATED_BY) VALUES (c_nit, m4, y2b, v_user);
  INSERT INTO SPD_ACTIVITY_GOAL (NIT_COMPANIA, PROYECTO, CODIGO_ACT, GOAL_ID, WEIGHTING, CREATED_BY)
  VALUES (c_nit, v_pry1, 1, m1, 100, v_user) RETURNING ID INTO v_act_goal;
  INSERT INTO SPD_ACTIVITY_GOAL_ACTION (ACTIVITY_GOAL_ID, DESCRIPCION, CREATED_BY)
  VALUES (v_act_goal, c_pref || 'Contratar la interventoría de las obras', v_user);
  INSERT INTO SPD_ACTIVITY_GOAL (NIT_COMPANIA, PROYECTO, CODIGO_ACT, GOAL_ID, WEIGHTING, CREATED_BY)
  VALUES (c_nit, v_pry2, 1, m4, 100, v_user) RETURNING ID INTO v_act_goal;
  INSERT INTO SPD_ACTIVITY_GOAL_ACTION (ACTIVITY_GOAL_ID, DESCRIPCION, CREATED_BY)
  VALUES (v_act_goal, c_pref || 'Priorizar las sedes con mayor deterioro', v_user);

  /* ================================================================ seguimiento */
  -- 2026-3 cerrado: todo revisado (historia para los tableros)
  v_cfg_old := new_config(3, 'N', 'CLOSED',
    '{"scheduling":' || win(DATE '2026-06-15', 15) || ',"reporting":' || win(DATE '2026-10-01', 10)
    || ',"validating":' || win(DATE '2026-10-11', 5) || ',"reviewing":' || win(DATE '2026-10-16', 5) || '}');
  v_rec := add_record(v_cfg_old, 3, r1, 'REVIEWED', 80, 82,  0,          0.6);
  v_rec := add_record(v_cfg_old, 3, r2, 'REVIEWED', 40, 41,  0,          0.6);
  v_rec := add_record(v_cfg_old, 3, m1, 'REVIEWED', 6,  5,   500000000,  0.9);
  v_rec := add_record(v_cfg_old, 3, m2, 'REVIEWED', 2,  1,   400000000,  0.5);
  v_rec := add_record(v_cfg_old, 3, m4, 'REVIEWED', 3,  3,   350000000,  0.95);
  v_rec := add_record(v_cfg_old, 3, m6, 'REVIEWED', 40, 18,  60000000,   0.3);
  v_rec := add_record(v_cfg_old, 3, y1, 'REVIEWED', 20, 18,  800000000,  0.7);
  v_rec := add_record(v_cfg_old, 3, a1, 'REVIEWED', 25, 25,  30000000,   1);

  -- 2026-4 activo: todas las etapas abiertas hoy
  v_cfg := new_config(4, 'S', 'REPORTING',
    '{"scheduling":' || win(TRUNC(SYSDATE) - 10, 30) || ',"reporting":' || win(TRUNC(SYSDATE) - 10, 30)
    || ',"validating":' || win(TRUNC(SYSDATE) - 10, 30) || ',"reviewing":' || win(TRUNC(SYSDATE) - 10, 30) || '}');
  -- Metas: SPDP2-MI-01, SPDP2-MI-02 y SPDP2-MP-06 quedan sin programar
  v_rec := add_record(v_cfg, 4, r1, 'PLANNED',   75, NULL, 0);
  v_rec := add_record(v_cfg, 4, r2, 'REPORTED',  45, 44,   0,          0.6);
  v_rec := add_record(v_cfg, 4, r3, 'VALIDATED', 5.5, 5.8, 0,          0.6);
  v_rec := add_record(v_cfg, 4, r4, 'REVIEWED',  46, 47,   0,          0.6);
  v_rec := add_record(v_cfg, 4, m1, 'PLANNED',   8,  NULL, 650000000);
  v_rec := add_record(v_cfg, 4, m2, 'REPORTED',  3,  2,    550000000,  0.75);
  -- adjunto y focalización
  INSERT INTO SPD_MONITORING_RECORD_ATTACH (MONITORING_RECORD_ID, S3_PATH, NAME, DESCRIPTION, CREATED_BY)
  VALUES (v_rec, 'spd-pruebas/seguimiento/' || v_rec || '/acta_recibo.pdf', 'SPD PRUEBA 2 acta_recibo.pdf',
          'Acta de recibo parcial de obra', v_user);
  UPDATE SPD_MONITORING_RECORD
     SET TARGET_MATRIX =
           '{"ed":{"localizationTab0":{"localizationLabel":"SPD PRUEBA 2 Corregimiento Aguaclara","genre":{"h":70,"m":80},"zone":{"u":0,"r":150}},'
        || '"localizationTab1":{"localizationLabel":"SPD PRUEBA 2 Corregimiento La Moralia","genre":{"h":45,"m":55},"zone":{"u":0,"r":100}}},'
        || '"org":{"localizationTab0":{"localizationLabel":"SPD PRUEBA 2 Corregimiento Aguaclara","orgType":"Junta de Acción Comunal",'
        || '"orgObject":"Veeduría de la obra","numBeneficiaries":35,"populationDesc":"Habitantes de la vereda"}},'
        || '"re":{}}'
   WHERE ID = v_rec;
  v_rec := add_record(v_cfg, 4, m3, 'VALIDATED', 2,  2,    300000000,  0.85);
  v_rec := add_record(v_cfg, 4, m4, 'REVIEWED',  4,  4,    420000000,  0.9);
  v_rec := add_record(v_cfg, 4, m5, 'REVIEWED',  6,  3,    250000000,  0.4);

  -- Proyectos
  v_rec := add_record(v_cfg, 4, y1,  'REVIEWED',  30, 27,  900000000,  0.8);
  v_rec := add_record(v_cfg, 4, y1a, 'REVIEWED',  1,  1,   150000000,  1);
  v_rec := add_record(v_cfg, 4, y1b, 'REPORTED',  8,  5,   750000000,  0.6);
  v_rec := add_record(v_cfg, 4, y2,  'VALIDATED', 30, 30,  500000000,  0.7);
  v_rec := add_record(v_cfg, 4, y2a, 'REVIEWED',  6,  6,   80000000,   1);
  v_rec := add_record(v_cfg, 4, y2b, 'PLANNED',   3,  NULL, 420000000);

  -- Planes de acción
  v_rec := add_record(v_cfg, 4, a1,  'REVIEWED', 25, 25,  40000000,   0.9);
  v_rec := add_record(v_cfg, 4, a1a, 'REVIEWED', 1,  1,   15000000,   1);
  v_rec := add_record(v_cfg, 4, a1b, 'PLANNED',  3,  NULL, 25000000);
  v_rec := add_record(v_cfg, 4, a2,  'REPORTED', 25, 20,  30000000,   0.6);
  v_rec := add_record(v_cfg, 4, a2a, 'VALIDATED', 2, 2,   10000000,   0.8);
  v_rec := add_record(v_cfg, 4, a2b, 'REPORTED', 1,  1,   8000000,    0.5);

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Semilla SPD PRUEBA 2 cargada en ' || c_nit || ': plan ' || v_plan
                       || ', proyectos ' || v_pry1 || ' y ' || v_pry2 || ', usuario ' || v_user
                       || ', seguimientos ' || v_cfg_old || ' (cerrado) y ' || v_cfg || ' (activo)');
END;
/
