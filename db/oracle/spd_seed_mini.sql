/* =============================================================================
   SPD - Semilla mínima para Oracle (ambientes locales o de desarrollo)
   -----------------------------------------------------------------------------
   Pocos datos, pero suficientes para recorrer todas las opciones del menú de la
   app 160 (SIIF_SPD). Hay una semilla más completa: spd_seed_prueba2.sql (pueden estar las dos).

   Compañía: 891900853 (UCEVA). Debe existir: el script NO crea ni modifica COMPANIA.

   Todo lo que crea empieza por "SPD" para reconocerlo como dato de prueba:
     ENTIDADES_PRY    código SPDINF, nombre "SPD Secretaría de Infraestructura"
     PLAN_DESARROLLO  nombre "SPD Plan de Desarrollo Demo 2024 - 2027"
                      (número = el siguiente libre de la compañía, o el que ya tenía)
     EJE_ESTRUCTURANTE, SECTOR, PROGRAMA_PRY  eje 1 > sector 1 > programa 1 del plan de prueba
                      (PROYECTO tiene FK a PROGRAMA_PRY; se omiten si las tablas no existen)
     USUARIOS         usuario SPD_DEMO
     PROYECTO         nombre "SPD Mejoramiento de vías terciarias", USUARIO = SPD_DEMO
                      (número = el siguiente libre de la compañía)
     SPD_*            códigos "SPD-..." y nombres "SPD ..."
   Se puede volver a ejecutar: al empezar borra SOLO esos datos (y lo que se haya creado
   desde las pantallas dentro del plan "SPD ..."); el resto de la compañía no se toca.

   Qué crea, por opción del menú:
     Configuración
       Usuarios ............ 1 usuario, asociado a la entidad
       Entidades ........... 1 entidad (presupuesto manual)
       Planes de Desarrollo  1 plan 2024-2027 con 5 niveles (Eje > Sector > Programa >
                             Subprograma > Plan de acción) y 1 nodo por nivel
       Metas ............... 1 de resultado, 4 de producto, 1 proyecto con 2 actividades,
                             1 plan de acción con 2 actividades
       Proyectos ........... 1 proyecto en PROYECTO (V_PROYECTO)
       Seguimiento ......... 1 configuración activa 2026-4 con colores de indicadores
       Políticas ........... 1 componente, 1 política de paz, 1 de víctimas, 1 territorial
     Catálogos ............. ODS (tabla global), unidades (UNIDADES_PRY) y 1 producto
                             (PRODUCTOS_PRY) de la compañía: usa los registros que ya
                             existan (por nombre / código) y solo crea, con prefijo "SPD",
                             los que falten; no se borran.
     Seguimiento (Metas / Proyectos / Planes de Acción)
       Programación, Reporte, Validación, Revisión y Tableros: con todas las etapas
       abiertas hoy y una meta en cada estado:
         Metas:      SPD-MR-01 Sin Programar · SPD-MP-01 Programada (Sin Reportar)
                     SPD-MP-02 Reportada (Sin Validar) · SPD-MP-03 Validada (Sin Revisar)
                     SPD-MP-04 Revisada
         Proyectos:  SPD-PRY-01 y SPD-PRY-01.A1 Revisadas · SPD-PRY-01.A2 Reportada
         Planes:     SPD-PA-01 y SPD-PA-01.M1 Revisadas · SPD-PA-01.M2 Programada
       con recursos por fuente, 1 adjunto, focalización e historial.
     Otros ................. macroproyecto, ubicaciones, componentes por política,
                             metas de actividades, metas por actividad, historial,
                             registros y tableros (salen de los datos anteriores).

   Orden: después de spd_schema.sql y spd_views.sql. En local, luego siif_apex_local.sql
   (login con SPD_DEMO / Spd#2026). Ejecutar como SIIF.
   ============================================================================= */
SET SERVEROUTPUT ON
SET DEFINE OFF
WHENEVER SQLERROR EXIT FAILURE ROLLBACK

DECLARE
  c_nit    CONSTANT VARCHAR2(15) := '891900853';
  c_ent    CONSTANT VARCHAR2(20) := 'SPDINF';
  c_user   CONSTANT VARCHAR2(30) := 'SPD_DEMO';
  c_plan_name CONSTANT VARCHAR2(100) := 'SPD Plan de Desarrollo Demo 2024 - 2027';

  v_plan   NUMBER;   -- PLAN_DESARROLLO.PLAN
  v_pry_no NUMBER;   -- PROYECTO.PROYECTO
  v_user   NUMBER;   -- USUARIOS.ID, se usa como CREATED_BY
  v_ent    NUMBER;   -- ENTIDADES_PRY.ID
  v_cfg    NUMBER;   -- configuración de seguimiento
  v_id     NUMBER;
  n        NUMBER;

  -- estructura del plan
  v_l1 NUMBER; v_l2 NUMBER; v_l3 NUMBER; v_l4 NUMBER; v_l5 NUMBER;
  -- catálogos
  v_ods9 NUMBER; v_ods11 NUMBER;
  v_prod NUMBER;   -- PRODUCTOS_PRY.ID
  v_km   NUMBER;   -- UNIDADES_PRY.CODIGO_UND de Kilómetros
  -- políticas, macroproyecto
  v_comp NUMBER; v_peace NUMBER; v_victims NUMBER; v_territ NUMBER; v_macro NUMBER;
  -- metas
  v_r1 NUMBER; v_p1 NUMBER; v_p2 NUMBER; v_p3 NUMBER; v_p4 NUMBER;
  v_pry NUMBER; v_a1 NUMBER; v_a2 NUMBER;
  v_pa NUMBER; v_m1 NUMBER; v_m2 NUMBER;
  v_rec NUMBER;
  v_win VARCHAR2(200);
  v_act_goal NUMBER;

  /* ------------------------------------------------------------- utilidades */
  -- Ventana [inicio, fin] (formato de la app React) de hoy-10 a hoy+20 días
  FUNCTION win RETURN VARCHAR2 IS
    d DATE := TRUNC(SYSDATE) - 10;
  BEGIN
    RETURN '["' || TO_CHAR(d, 'YYYY-MM-DD') || 'T05:00:00.000Z","'
                || TO_CHAR(d + 30, 'YYYY-MM-DD') || 'T04:59:59.000Z"]';
  END;

  -- Estructura del plan en el SIIF (EJE_ESTRUCTURANTE > SECTOR > PROGRAMA_PRY): PROYECTO tiene FK
  -- (PROY_PROGRA_FK) a PROGRAMA_PRY. SQL dinámico y solo si la tabla existe: en el ambiente local
  -- (siif_base_tables.sql) estas tablas no se crean.
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
    ELSE               -- eje 1 > sector 1 > programa 1
      IF siif_table('EJE_ESTRUCTURANTE') THEN
        EXECUTE IMMEDIATE 'INSERT INTO EJE_ESTRUCTURANTE (NIT_COMPANIA, PLAN, EJE, NOMBRE) VALUES (:1, :2, 1, :3)'
          USING c_nit, v_plan, 'SPD Municipio conectado';
      END IF;
      IF siif_table('SECTOR') THEN
        EXECUTE IMMEDIATE 'INSERT INTO SECTOR (NIT_COMPANIA, PLAN, EJE, SECTOR, NOMBRE) VALUES (:1, :2, 1, 1, :3)'
          USING c_nit, v_plan, 'SPD Transporte';
      END IF;
      IF siif_table('PROGRAMA_PRY') THEN
        EXECUTE IMMEDIATE 'INSERT INTO PROGRAMA_PRY (NIT_COMPANIA, PLAN, EJE, SECTOR, PROGRAMA, NOMBRE) '
                       || 'VALUES (:1, :2, 1, 1, 1, :3)'
          USING c_nit, v_plan, 'SPD Vías para la competitividad';
      END IF;
    END IF;
  END;

  -- Catálogos globales: usa el registro existente (con o sin prefijo SPD) o lo crea con prefijo
  FUNCTION ods(p_name VARCHAR2) RETURN NUMBER IS
    v NUMBER;
  BEGIN
    SELECT MIN(ID) INTO v FROM SPD_ODS WHERE NAME IN (p_name, 'SPD ' || p_name);
    IF v IS NULL THEN
      INSERT INTO SPD_ODS (NAME) VALUES ('SPD ' || p_name) RETURNING ID INTO v;
    END IF;
    RETURN v;
  END;

  -- Unidad de medida de la compañía (UNIDADES_PRY): usa la que exista con ese nombre (con o sin
  -- prefijo SPD, sin importar mayúsculas) o la crea con prefijo SPD y el siguiente CODIGO_UND.
  -- Devuelve CODIGO_UND.
  FUNCTION unit(p_name VARCHAR2, p_initials VARCHAR2 DEFAULT NULL) RETURN NUMBER IS
    v NUMBER;
  BEGIN
    SELECT MIN(CODIGO_UND) INTO v FROM UNIDADES_PRY
     WHERE NIT_COMPANIA = c_nit AND UPPER(TRIM(NOMBRE_UNIDAD)) IN (UPPER(p_name), UPPER('SPD ' || p_name));
    IF v IS NULL THEN
      SELECT NVL(MAX(CODIGO_UND), 0) + 1 INTO v FROM UNIDADES_PRY WHERE NIT_COMPANIA = c_nit;
      INSERT INTO UNIDADES_PRY (NIT_COMPANIA, CODIGO_UND, NOMBRE_UNIDAD, SIGLA)
      VALUES (c_nit, v, 'SPD ' || p_name, p_initials);
    END IF;
    RETURN v;
  END;

  -- Producto de la compañía (PRODUCTOS_PRY): usa el que exista con ese código o lo crea con prefijo SPD.
  -- Devuelve PRODUCTOS_PRY.ID (lo asigna el trigger BI_PRODUCTOS_PRY).
  FUNCTION product(p_code VARCHAR2, p_name VARCHAR2, p_programa VARCHAR2) RETURN NUMBER IS
    v NUMBER;
  BEGIN
    SELECT MIN(ID) INTO v FROM PRODUCTOS_PRY WHERE NIT_COMPANIA = c_nit AND CODIGO = p_code;
    IF v IS NULL THEN
      INSERT INTO PRODUCTOS_PRY (NIT_COMPANIA, CODIGO, NOMBRE, DESCRIPCION, PROGRAMA)
      VALUES (c_nit, p_code, 'SPD ' || p_name, 'Producto de prueba SPD', p_programa)
      RETURNING ID INTO v;
    END IF;
    RETURN v;
  END;

  FUNCTION plan_level(p_code VARCHAR2, p_name VARCHAR2, p_level NUMBER, p_parent NUMBER,
                      p_sector VARCHAR2 DEFAULT NULL) RETURN NUMBER IS
    v NUMBER;
  BEGIN
    INSERT INTO SPD_DEV_PLAN_LEVEL (NIT_COMPANIA, PLAN, CODE, NAME, "LEVEL", PARENT_ID, WEIGHTING,
                                    SECTOR_CODE)
    VALUES (c_nit, v_plan, p_code, 'SPD ' || p_name, p_level, p_parent, 100, p_sector)
    RETURNING ID INTO v;
    RETURN v;
  END;

  FUNCTION new_goal(p_type VARCHAR2, p_code VARCHAR2, p_name VARCHAR2, p_indicator VARCHAR2,
                    p_level NUMBER, p_parent NUMBER, p_accum VARCHAR2, p_base NUMBER, p_value NUMBER,
                    p_units VARCHAR2, p_project VARCHAR2 DEFAULT NULL) RETURN NUMBER IS
    v NUMBER;
    u NUMBER := unit(p_units);
  BEGIN
    INSERT INTO SPD_GOAL
      (NIT_COMPANIA, PARENT_GOAL_ID, PLAN, DEV_PLAN_LEVEL_ID, ENTITY_ID, GOAL_TYPE, CODE, NAME,
       INDICATOR, DESCRIPTION, ACCUMULATION_TYPE, BASE_VALUE, GOAL_VALUE, UNITS_FACTOR, UNIT_CODE,
       WEIGHTING, PROJECT_CODE, START_DATE, END_DATE, CREATED_BY)
    VALUES
      (c_nit, p_parent, v_plan, p_level, v_ent, p_type, 'SPD-' || p_code, 'SPD ' || p_name,
       p_indicator, 'Meta de prueba SPD', p_accum, p_base, p_value, 1, u,
       100, p_project, TIMESTAMP '2024-01-01 00:00:00 -05:00', TIMESTAMP '2027-12-31 00:00:00 -05:00',
       v_user)
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

  -- Registro de seguimiento de la meta en la configuración de prueba, con recursos e historial
  -- según el estado: PLANNED, REPORTED, VALIDATED o REVIEWED.
  FUNCTION add_record(p_goal NUMBER, p_status VARCHAR2, p_prog NUMBER, p_achieved NUMBER,
                      p_budget NUMBER) RETURN NUMBER IS
    v    NUMBER;
    rep  BOOLEAN := p_status IN ('REPORTED','VALIDATED','REVIEWED');
    rep_s VARCHAR2(1) := CASE WHEN p_status IN ('REPORTED','VALIDATED','REVIEWED') THEN 'S' ELSE 'N' END;  -- BOOLEAN no se puede usar en SQL antes de Oracle 23
    phys NUMBER;
  BEGIN
    IF rep THEN
      phys := LEAST(ROUND(p_achieved / p_prog, 4), 1);
    END IF;
    INSERT INTO SPD_MONITORING_RECORD
      (MONITORING_CONFIG_ID, GOAL_ID, PERIOD, GOAL_VALUE, FROM_MONTH, TO_MONTH, GOAL_ACHIEVED_VALUE,
       RECORD_STATUS, WEIGHTING, PHYSICAL_INDICATOR, TOTAL_PEOPLE, NOTES,
       QUESTION_HOW, QUESTION_RESULT, QUESTION_EVIDENCE, QUESTION_PROBLEM, CREATED_BY, UPDATED_BY)
    VALUES
      (v_cfg, p_goal, 2026, p_prog, 10, 12, CASE WHEN rep_s = 'S' THEN p_achieved END,
       p_status, 100, phys, CASE WHEN rep_s = 'S' THEN 250 END,
       CASE WHEN rep_s = 'S' THEN 'SPD Avance del cuarto trimestre de 2026.' END,
       CASE WHEN rep_s = 'S' THEN 'Se ejecutaron las actividades programadas con el contratista de obra.' END,
       CASE WHEN rep_s = 'S' THEN 'Se logró ' || ROUND(phys * 100) || '% de lo programado en el trimestre.' END,
       CASE WHEN rep_s = 'S' THEN 'Actas de recibo parcial, registro fotográfico e informe de interventoría.' END,
       CASE WHEN rep_s = 'S' THEN 'Lluvias retrasaron dos semanas los frentes de obra.' END,
       v_user, v_user)
    RETURNING ID INTO v;

    add_resource(v, 'DEFINITIVE', p_budget, NULL);              -- apropiado
    add_history(p_goal, v, 'SCHEDULED', 'Meta programada para 2026-4', 9);
    IF rep THEN
      add_resource(v, 'COMMITMENT', p_budget * 0.80, 0.80);
      add_resource(v, 'OBLIGATION', p_budget * 0.55, 0.55);
      add_resource(v, 'PAYMENT',    p_budget * 0.40, 0.40);
      add_history(p_goal, v, 'MONITORED', 'Avance reportado', 6);
    END IF;
    IF p_status IN ('VALIDATED','REVIEWED') THEN
      add_history(p_goal, v, 'VALIDATED', 'Avance validado por la oficina de planeación', 4);
    END IF;
    IF p_status = 'REVIEWED' THEN
      add_history(p_goal, v, 'REVIEWED', 'Avance revisado', 2);
    END IF;
    RETURN v;
  END;

BEGIN
  SELECT COUNT(*) INTO n FROM COMPANIA WHERE NIT_COMPANIA = c_nit;
  IF n = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'No existe la compañía ' || c_nit || ' en COMPANIA');
  END IF;

  /* ================================================================ limpieza (solo datos "SPD") */
  -- plan de prueba de una ejecución anterior (se reutiliza su número)
  SELECT MIN(PLAN) INTO v_plan FROM PLAN_DESARROLLO WHERE NIT_COMPANIA = c_nit AND NOMBRE = c_plan_name;

  -- metas de prueba: las "SPD-..." y cualquier otra creada dentro del plan de prueba
  DELETE FROM SPD_GOAL_HISTORY
   WHERE GOAL_ID IN (SELECT ID FROM SPD_GOAL WHERE NIT_COMPANIA = c_nit AND (CODE LIKE 'SPD-%' OR PLAN = v_plan))
      OR MONITORING_RECORD_ID IN (SELECT r.ID FROM SPD_MONITORING_RECORD r
                                  WHERE r.GOAL_ID IN (SELECT ID FROM SPD_GOAL WHERE NIT_COMPANIA = c_nit
                                                       AND (CODE LIKE 'SPD-%' OR PLAN = v_plan))
                                     OR r.MONITORING_CONFIG_ID IN (SELECT ID FROM SPD_MONITORING_CONFIG
                                                                   WHERE NIT_COMPANIA = c_nit AND PLAN = v_plan));
  FOR r IN (SELECT ID FROM SPD_MONITORING_RECORD
             WHERE GOAL_ID IN (SELECT ID FROM SPD_GOAL WHERE NIT_COMPANIA = c_nit
                                AND (CODE LIKE 'SPD-%' OR PLAN = v_plan))
                OR MONITORING_CONFIG_ID IN (SELECT ID FROM SPD_MONITORING_CONFIG
                                            WHERE NIT_COMPANIA = c_nit AND PLAN = v_plan)) LOOP
    DELETE FROM SPD_MONITORING_RECORD_ATTACH   WHERE MONITORING_RECORD_ID = r.ID;
    DELETE FROM SPD_MONITORING_RECORD_RESOURCE WHERE MONITORING_RECORD_ID = r.ID;
    DELETE FROM SPD_MONITORING_RECORD          WHERE ID = r.ID;
  END LOOP;
  DELETE FROM SPD_MONITORING_CONFIG WHERE NIT_COMPANIA = c_nit AND PLAN = v_plan;
  DELETE FROM SPD_ACTIVITY_GOAL_ACTION WHERE ACTIVITY_GOAL_ID IN
    (SELECT ID FROM SPD_ACTIVITY_GOAL WHERE GOAL_ID IN
       (SELECT ID FROM SPD_GOAL WHERE NIT_COMPANIA = c_nit AND (CODE LIKE 'SPD-%' OR PLAN = v_plan)));
  DELETE FROM SPD_ACTIVITY_GOAL WHERE GOAL_ID IN
    (SELECT ID FROM SPD_GOAL WHERE NIT_COMPANIA = c_nit AND (CODE LIKE 'SPD-%' OR PLAN = v_plan));
  DELETE FROM SPD_GOAL_TO_ACTIVITY WHERE GOAL_ID IN
    (SELECT ID FROM SPD_GOAL WHERE NIT_COMPANIA = c_nit AND (CODE LIKE 'SPD-%' OR PLAN = v_plan));
  UPDATE SPD_GOAL SET PARENT_GOAL_ID = NULL
   WHERE NIT_COMPANIA = c_nit AND (CODE LIKE 'SPD-%' OR PLAN = v_plan);
  DELETE FROM SPD_GOAL WHERE NIT_COMPANIA = c_nit AND (CODE LIKE 'SPD-%' OR PLAN = v_plan);
  UPDATE SPD_DEV_PLAN_LEVEL SET PARENT_ID = NULL WHERE NIT_COMPANIA = c_nit AND PLAN = v_plan;
  DELETE FROM SPD_DEV_PLAN_LEVEL WHERE NIT_COMPANIA = c_nit AND PLAN = v_plan;

  DELETE FROM SPD_PUBLIC_POLITIC_TO_COMP
   WHERE PUBLIC_POLITIC_ID IN (SELECT ID FROM SPD_PUBLIC_POLITIC WHERE NIT_COMPANIA = c_nit AND NAME LIKE 'SPD %' AND NAME NOT LIKE 'SPD PRUEBA 2 %')
      OR COMPONENT_ID IN (SELECT ID FROM SPD_PUBLIC_POLITIC_COMPONENT WHERE NIT_COMPANIA = c_nit AND NAME LIKE 'SPD %' AND NAME NOT LIKE 'SPD PRUEBA 2 %');
  DELETE FROM SPD_PUBLIC_POLITIC           WHERE NIT_COMPANIA = c_nit AND NAME LIKE 'SPD %' AND NAME NOT LIKE 'SPD PRUEBA 2 %';
  DELETE FROM SPD_PUBLIC_POLITIC_COMPONENT WHERE NIT_COMPANIA = c_nit AND NAME LIKE 'SPD %' AND NAME NOT LIKE 'SPD PRUEBA 2 %';
  DELETE FROM SPD_MACRO_PROJECT            WHERE NIT_COMPANIA = c_nit AND NAME LIKE 'SPD %' AND NAME NOT LIKE 'SPD PRUEBA 2 %';
  DELETE FROM SPD_GEO_LOCATION WHERE NIT_COMPANIA = c_nit AND NAME LIKE 'SPD %' AND NAME NOT LIKE 'SPD PRUEBA 2 %' AND PARENT_LOCATION_ID IS NOT NULL;
  DELETE FROM SPD_GEO_LOCATION WHERE NIT_COMPANIA = c_nit AND NAME LIKE 'SPD %' AND NAME NOT LIKE 'SPD PRUEBA 2 %';

  DELETE FROM PROYECTO        WHERE NIT_COMPANIA = c_nit AND USUARIO = c_user AND NOMBRE LIKE 'SPD %' AND NOMBRE NOT LIKE 'SPD PRUEBA 2 %';
  DELETE FROM USUARIOS        WHERE NIT_COMPANIA = c_nit AND USUARIO = c_user;
  siif_structure(p_delete => TRUE);   -- eje / sector / programa del plan de prueba
  DELETE FROM PLAN_DESARROLLO WHERE NIT_COMPANIA = c_nit AND NOMBRE = c_plan_name;
  DELETE FROM ENTIDADES_PRY   WHERE NIT_COMPANIA = c_nit AND CODIGO_ENT_PRY = c_ent;

  /* ================================================================ SIIF: entidad, plan, usuario, proyecto */
  IF v_plan IS NULL THEN
    SELECT NVL(MAX(PLAN), 0) + 1 INTO v_plan FROM PLAN_DESARROLLO WHERE NIT_COMPANIA = c_nit;
  END IF;
  SELECT NVL(MAX(PROYECTO), 0) + 1 INTO v_pry_no FROM PROYECTO WHERE NIT_COMPANIA = c_nit;

  INSERT INTO ENTIDADES_PRY (NIT_COMPANIA, CODIGO_ENT_PRY, NOMBRE_ENT_PRY, ORDEN, SECRETARIO, TIPO_CARGO,
                             ENT_SIGLA, ACTIVA, SPD_PRESUPUESTO_MANUAL, SPD_FECHA_INICIO)
  VALUES (c_nit, c_ent, 'SPD Secretaría de Infraestructura', 'M', 'Laura Gómez', 'Secretario(a)',
          'SPDINF', 'S', 'S', DATE '2024-01-01')
  RETURNING ID INTO v_ent;

  INSERT INTO PLAN_DESARROLLO (NIT_COMPANIA, PLAN, NOMBRE, FECHA_INICIO, FECHA_FIN, OBJETIVO, GOBERNANTE,
                               SPD_ACTIVO, SPD_INICIO_GOBIERNO, SPD_FIN_GOBIERNO, SPD_CONFIG,
                               SPD_ORIGEN_ACTIVIDADES)
  VALUES (c_nit, v_plan, c_plan_name, DATE '2024-06-01', DATE '2027-12-31',
          'Mejorar la conectividad vial del municipio.', 'Andrés Pérez', 'S',
          DATE '2024-01-01', DATE '2027-12-31',
          '{"levels":[{"number":1,"singularName":"Eje","pluralName":"Ejes"},'
          || '{"number":2,"singularName":"Sector","pluralName":"Sectores","isSectorLevel":true},'
          || '{"number":3,"singularName":"Programa","pluralName":"Programas","goalType":"RESULT"},'
          || '{"number":4,"singularName":"Subprograma","pluralName":"Subprogramas","goalType":"PRODUCT"},'
          || '{"number":5,"singularName":"Plan de acción","pluralName":"Planes de acción","goalType":"ACTION_PLAN"}]}',
          'SIIF');

  siif_structure(p_delete => FALSE);  -- eje 1 > sector 1 > programa 1, que usa el proyecto

  INSERT INTO USUARIOS (NIT_COMPANIA, USUARIO, DESCRIPCION, USERTYPE, ESTADO, EMAIL, CEDULA,
                        CODIGO_ENT_PRY, CARGO, ORIGEN_CREACION)
  VALUES (c_nit, c_user, 'SPD Usuario de prueba', 'CONSULTA', 'V', 'spd.demo@spd.local', '1000000001',
          c_ent, 'Profesional de planeación', 'AU')
  RETURNING ID INTO v_user;

  INSERT INTO PROYECTO (PLAN, PROGRAMA, SECTOR, EJE, NIT_COMPANIA, PROYECTO, NOMBRE, ANO, CODIGO,
                        FECHA_REGISTRO, OBJETIVOS, VALOR, ESTADO, CODIGO_ENT_PRY, ESTADO_PROCESO,
                        USUARIO, FECHA_CREACION)
  VALUES (v_plan, 1, 1, 1, c_nit, v_pry_no, 'SPD Mejoramiento de vías terciarias', 2026,
          'SPD-2026-0001', DATE '2026-01-20', 'Mejorar 20 km de vías terciarias.', 1800000000, 'A',
          c_ent, 'REGISTRADO', c_user, SYSDATE);

  /* ================================================================ catálogos (globales) */
  v_ods9  := ods('Industria, innovación e infraestructura');
  v_ods11 := ods('Ciudades y comunidades sostenibles');
  v_id    := ods('Fin de la pobreza');
  -- unidades y producto de la compañía (UNIDADES_PRY / PRODUCTOS_PRY)
  v_km := unit('Kilómetros', 'Km');
  v_id := unit('Número', 'Nro');
  v_id := unit('Porcentaje', '%');
  v_id := unit('Minutos', 'Min');
  v_prod := product('2402041', 'Vía terciaria mejorada', '2402');   -- sector DNP 24 Transporte

  /* ================================================================ estructura del plan */
  v_l1 := plan_level('1',        'Municipio conectado', 1, NULL);
  v_l2 := plan_level('1.24',     'Transporte', 2, v_l1, '24');
  v_l3 := plan_level('1.24.1',   'Vías para la competitividad', 3, v_l2);
  v_l4 := plan_level('1.24.1.1', 'Red vial terciaria', 4, v_l3);
  v_l5 := plan_level('1.24.1.1.1', 'Plan de acción de infraestructura', 5, v_l4);

  /* ================================================================ políticas, macroproyecto, ubicaciones */
  INSERT INTO SPD_PUBLIC_POLITIC_COMPONENT (NIT_COMPANIA, CODE, NAME, DESCRIPTION, CREATED_BY)
  VALUES (c_nit, 'SPD-C-01', 'SPD Movilidad rural', 'Acceso de la población rural a bienes y servicios', v_user)
  RETURNING ID INTO v_comp;

  INSERT INTO SPD_PUBLIC_POLITIC (NIT_COMPANIA, CATEGORY, CODE, NAME, DESCRIPTION)
  VALUES (c_nit, 'PEACE', 'SPD-PAZ-01', 'SPD Reforma rural integral', 'Punto 1 del Acuerdo de Paz')
  RETURNING ID INTO v_peace;
  INSERT INTO SPD_PUBLIC_POLITIC (NIT_COMPANIA, CATEGORY, CODE, NAME, DESCRIPTION)
  VALUES (c_nit, 'VICTIMS', 'SPD-VIC-01', 'SPD Reparación integral', 'Medidas de reparación a víctimas')
  RETURNING ID INTO v_victims;
  INSERT INTO SPD_PUBLIC_POLITIC (NIT_COMPANIA, CATEGORY, CODE, NAME, DESCRIPTION, FROM_YEAR, TO_YEAR)
  VALUES (c_nit, 'TERRITORY', 'SPD-PPT-01', 'SPD Política pública de desarrollo rural',
          'Acuerdo municipal 012 de 2024', 2024, 2034)
  RETURNING ID INTO v_territ;
  INSERT INTO SPD_PUBLIC_POLITIC_TO_COMP (PUBLIC_POLITIC_ID, COMPONENT_ID) VALUES (v_territ, v_comp);

  INSERT INTO SPD_MACRO_PROJECT (NIT_COMPANIA, CODE, NAME, DESCRIPTION, CREATED_BY)
  VALUES (c_nit, 'SPD-MAC-01', 'SPD Corredor vial rural', 'Agrupa las obras viales de la zona rural', v_user)
  RETURNING ID INTO v_macro;

  INSERT INTO SPD_GEO_LOCATION (NIT_COMPANIA, CODE, NAME, LOCATION_TYPE)
  VALUES (c_nit, 'SPD-76834', 'SPD Tuluá', 'MUNICIPALITY') RETURNING ID INTO v_id;
  INSERT INTO SPD_GEO_LOCATION (NIT_COMPANIA, CODE, NAME, LOCATION_TYPE, PARENT_LOCATION_ID)
  VALUES (c_nit, 'SPD-76834-C1', 'SPD Comuna 1 - Centro', 'DISTRICT', v_id);
  INSERT INTO SPD_GEO_LOCATION (NIT_COMPANIA, CODE, NAME, LOCATION_TYPE, PARENT_LOCATION_ID)
  VALUES (c_nit, 'SPD-76834-R1', 'SPD Corregimiento Aguaclara', 'TOWNSHIP', v_id);

  /* ================================================================ metas (código SPD-..., nombre SPD ...) */
  v_r1 := new_goal('RESULT', 'MR-01', 'Reducir el tiempo de desplazamiento entre la zona rural y la cabecera',
                   'Tiempo promedio de desplazamiento', v_l3, NULL, 'REDUCTION', 90, 60, 'Minutos');

  v_p1 := new_goal('PRODUCT', 'MP-01', 'Mejorar kilómetros de vías terciarias', 'Vía terciaria mejorada',
                   v_l4, v_r1, 'ACCUMULATED', 0, 20, 'Kilómetros');
  v_p2 := new_goal('PRODUCT', 'MP-02', 'Construir placa huella en vías rurales', 'Placa huella construida',
                   v_l4, v_r1, 'ACCUMULATED', 0, 8, 'Kilómetros');
  v_p3 := new_goal('PRODUCT', 'MP-03', 'Mantener puentes vehiculares', 'Puentes mantenidos',
                   v_l4, v_r1, 'ACCUMULATED', 2, 6, 'Número');
  v_p4 := new_goal('PRODUCT', 'MP-04', 'Instalar señales de tránsito', 'Señales instaladas',
                   v_l4, v_r1, 'ACCUMULATED', 0, 400, 'Número');
  -- SPD-MP-01 con todos los vínculos del formulario de metas
  UPDATE SPD_GOAL
     SET ODS_IDS = '[' || v_ods9 || ',' || v_ods11 || ']', PRODUCT_ID = v_prod,
         PUBLIC_POLITIC_ID = v_territ, PUBLIC_POLITIC_COMPONENT_ID = v_comp,
         PEACE_POLITIC_ID = v_peace, VICTIMS_POLITIC_ID = v_victims, MACRO_PROJECT_ID = v_macro,
         PI_BASE_VALUE = 0, PI_GOAL_VALUE = 20, PI_UNITS_FACTOR = 1, PI_UNIT_CODE = v_km
   WHERE ID = v_p1;
  UPDATE SPD_GOAL SET ODS_IDS = '[' || v_ods9 || ']', MACRO_PROJECT_ID = v_macro WHERE ID = v_p2;

  v_pry := new_goal('PROJECT', 'PRY-01', 'Mejoramiento de vías terciarias',
                    'Porcentaje de avance del proyecto', v_l4, NULL, 'ACCUMULATED', 0, 100, 'Porcentaje',
                    TO_CHAR(v_pry_no));
  v_a1  := new_goal('ACTIVITY', 'PRY-01.A1', 'Estudios y diseños', 'Estudios entregados',
                    v_l4, v_pry, 'ACCUMULATED', 0, 2, 'Número', TO_CHAR(v_pry_no));
  v_a2  := new_goal('ACTIVITY', 'PRY-01.A2', 'Ejecución de obras', 'Kilómetros intervenidos',
                    v_l4, v_pry, 'ACCUMULATED', 0, 20, 'Kilómetros', TO_CHAR(v_pry_no));

  v_pa := new_goal('ACTION_PLAN', 'PA-01', 'Plan de acción 2026 - Secretaría de Infraestructura',
                   'Porcentaje de cumplimiento del plan', v_l5, NULL, 'ACCUMULATED', 0, 100, 'Porcentaje');
  v_m1 := new_goal('ACTION_PLAN_ACTIVITY', 'PA-01.M1', 'Socializar las obras con las juntas de acción comunal',
                   'Jornadas realizadas', v_l5, v_pa, 'ACCUMULATED', 0, 4, 'Número');
  v_m2 := new_goal('ACTION_PLAN_ACTIVITY', 'PA-01.M2', 'Hacer seguimiento a los contratos de obra',
                   'Informes de seguimiento', v_l5, v_pa, 'ACCUMULATED', 0, 12, 'Número');

  -- Otros > Metas de actividades (meta de producto <-> actividad del proyecto)
  INSERT INTO SPD_GOAL_TO_ACTIVITY (NIT_COMPANIA, GOAL_ID, ACTIVITY_ID, CREATED_BY)
  VALUES (c_nit, v_p1, v_a2, v_user);
  -- Otros > Metas por actividad (actividad 1 del proyecto SIIF) y su acción
  INSERT INTO SPD_ACTIVITY_GOAL (NIT_COMPANIA, PROYECTO, CODIGO_ACT, GOAL_ID, WEIGHTING, CREATED_BY)
  VALUES (c_nit, v_pry_no, 1, v_p1, 100, v_user) RETURNING ID INTO v_act_goal;
  INSERT INTO SPD_ACTIVITY_GOAL_ACTION (ACTIVITY_GOAL_ID, DESCRIPCION, CREATED_BY)
  VALUES (v_act_goal, 'SPD Contratar la interventoría de las obras', v_user);

  /* ================================================================ seguimiento */
  v_win := win;
  INSERT INTO SPD_MONITORING_CONFIG
    (USED_FOR, NIT_COMPANIA, IS_ACTIVE, PLAN, PERIOD, SUBPERIOD, PERIODICITY, SPENT_DOCS, WEIGHTING_TYPE,
     DATES_CONFIG, COLORS_CONFIG, STATUS, MONITORING_RESOURCES_ORIGIN, SUPPORT_PRODUCT_MONITORING,
     SGP_DISCRIMINATED, GOAL_TYPES, CREATED_BY)
  VALUES
    ('DEVELOPMENT_PLANS', c_nit, 'S', v_plan, 2026, 4, 3, '["COMMITMENT","OBLIGATION","PAYMENT"]', 'FINANCIAL',
     -- todas las etapas abiertas hoy: se pueden usar Programación, Reporte, Validación y Revisión
     '{"scheduling":' || v_win || ',"reporting":' || v_win || ',"validating":' || v_win || ',"reviewing":' || v_win || '}',
     '[{"fromValue":0,"toValue":50,"includeFromValue":true,"includeToValue":true,"color":"#f5222d","label":"SPD Bajo"},'
     || '{"fromValue":50,"toValue":80,"includeFromValue":false,"includeToValue":true,"color":"#fadb14","label":"SPD Medio"},'
     || '{"fromValue":80,"toValue":100,"includeFromValue":false,"includeToValue":true,"color":"#52c41a","label":"SPD Alto"}]',
     'REPORTING', 'FINANCIAL', 'N', 'S',
     '["PRODUCT","RESULT","PROJECT","ACTIVITY","ACTION_PLAN"]', v_user)
  RETURNING ID INTO v_cfg;

  -- Metas: SPD-MR-01 queda sin registro (Sin Programar)
  v_rec := add_record(v_p1, 'PLANNED',   5,   NULL, 450000000);
  v_rec := add_record(v_p2, 'REPORTED',  2,   1.5,  600000000);
  -- adjunto y focalización (Otros > Registros de seguimiento / diálogo de ejecución)
  INSERT INTO SPD_MONITORING_RECORD_ATTACH (MONITORING_RECORD_ID, S3_PATH, NAME, DESCRIPTION, CREATED_BY)
  VALUES (v_rec, 'spd-pruebas/seguimiento/' || v_rec || '/acta_recibo.pdf', 'SPD acta_recibo.pdf',
          'Acta de recibo parcial de obra', v_user);
  UPDATE SPD_MONITORING_RECORD
     SET TARGET_MATRIX =
           '{"ed":{"localizationTab0":{"localizationLabel":"SPD Corregimiento Aguaclara","genre":{"h":70,"m":80},"zone":{"u":0,"r":150}},'
        || '"localizationTab1":{"localizationLabel":"SPD Comuna 1 - Centro","genre":{"h":45,"m":55},"zone":{"u":100,"r":0}}},'
        || '"org":{"localizationTab0":{"localizationLabel":"SPD Corregimiento Aguaclara","orgType":"Junta de Acción Comunal",'
        || '"orgObject":"Veeduría de la obra","numBeneficiaries":35,"populationDesc":"Habitantes de la vereda"}},'
        || '"re":{}}'
   WHERE ID = v_rec;
  v_rec := add_record(v_p3, 'VALIDATED', 2,   2,    300000000);
  v_rec := add_record(v_p4, 'REVIEWED',  100, 110,  120000000);

  -- Proyectos
  v_rec := add_record(v_pry, 'REVIEWED', 25, 22,  900000000);
  v_rec := add_record(v_a1,  'REVIEWED', 1,  1,   150000000);
  v_rec := add_record(v_a2,  'REPORTED', 5,  3.5, 750000000);

  -- Planes de acción
  v_rec := add_record(v_pa, 'REVIEWED', 25, 25, 40000000);
  v_rec := add_record(v_m1, 'REVIEWED', 1,  1,  15000000);
  v_rec := add_record(v_m2, 'PLANNED',  3,  NULL, 25000000);

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Semilla SPD cargada en ' || c_nit || ': plan ' || v_plan || ', proyecto ' || v_pry_no
                       || ', entidad ' || v_ent || ', usuario ' || v_user || ', seguimiento ' || v_cfg);
END;
/
