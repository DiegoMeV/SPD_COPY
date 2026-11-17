/* =============================================================================
   SPD - Datos de demostración para las opciones de Seguimiento (solo local / pruebas)
   -----------------------------------------------------------------------------
   Compañía: Municipio de Palmira (8913800073), plan 5 "PALMIRA PA'LANTE".

   Crea, para poder recorrer Programación / Reporte / Validación / Revisión /
   Tableros de Metas, Proyectos y Planes de Acción:
     - 4 configuraciones de seguimiento 2024 (una por etapa):
         2024-1 REVIEWING, 2024-2 VALIDATING, 2024-3 REPORTING (activa),
         2024-4 SCHEDULING (recursos USER_AND_FINANCIAL -> "Programada Parcial").
     - 6 proyectos en PROYECTO, con su meta PROJECT y 2 metas ACTIVITY cada uno.
     - 5 metas ACTION_PLAN (planes de acción).
     - Registros de seguimiento en todos los estados, con recursos por fuente
       (DEFINITIVE / MANUAL / COMMITMENT / OBLIGATION / PAYMENT), adjuntos e historial.

   Marca: todas las filas SPD_* llevan CREATED_BY = 999999; los proyectos USUARIO = 'DEMO_SPD'
   y número 2024000001..; se puede re-ejecutar (primero borra lo que creó antes).
   Solo cambia datos existentes en un punto: deja la demo 2024-3 como única configuración
   activa de la compañía (la app React toma la primera activa). Ejecutar como SIIF.
   ============================================================================= */
SET SERVEROUTPUT ON
SET DEFINE OFF

DECLARE
  c_nit    CONSTANT VARCHAR2(15) := '8913800073';
  c_plan   CONSTANT NUMBER       := 5;
  c_demo   CONSTANT NUMBER       := 999999;
  c_types  CONSTANT VARCHAR2(200) :=
    '["PRODUCT","RESULT","WELL_BEING","IMPACT","PROJECT","ACTIVITY","ACTION_PLAN"]';

  TYPE t_cfg IS RECORD (id NUMBER, sub NUMBER, status VARCHAR2(20), origin VARCHAR2(30));
  TYPE t_cfgs IS TABLE OF t_cfg INDEX BY PLS_INTEGER;
  cfgs t_cfgs;

  v_colors CLOB;
  v_dates  VARCHAR2(1000);
  v_id     NUMBER;
  v_goal   NUMBER;
  v_level  NUMBER;
  n_rec    NUMBER := 0;
  n_goals  NUMBER := 0;

  -- Número pseudoaleatorio estable 0..99 a partir de dos enteros
  FUNCTION h(a NUMBER, b NUMBER) RETURN NUMBER IS
    v NUMBER;
  BEGIN
    SELECT ORA_HASH(TO_CHAR(a) || '-' || TO_CHAR(b), 99) INTO v FROM dual;   -- ORA_HASH solo existe en SQL
    RETURN v;
  END;

  -- Estado del registro según la etapa de la configuración
  FUNCTION status_for(p_status VARCHAR2, p_r NUMBER) RETURN VARCHAR2 IS
  BEGIN
    CASE p_status
      -- la mayoría revisadas, para que los tableros de control (que solo muestran REVIEWED) tengan datos;
      -- APPROVED no se usa: el original nunca lo asigna y lo muestra como 'Sin Programar'
      WHEN 'REVIEWING'  THEN RETURN CASE WHEN p_r < 8 THEN 'REPORTED'  WHEN p_r < 20 THEN 'VALIDATED'
                                         WHEN p_r < 92 THEN 'REVIEWED' ELSE 'REJECTED' END;
      WHEN 'VALIDATING' THEN RETURN CASE WHEN p_r < 50 THEN 'REPORTED'  WHEN p_r < 85 THEN 'VALIDATED'
                                         ELSE 'REJECTED' END;
      -- la activa (la que abren React y APEX por defecto) recorre todo el flujo para que Reporte,
      -- Validación, Revisión y los tableros tengan datos sin cambiar de seguimiento
      WHEN 'REPORTING'  THEN RETURN CASE WHEN p_r < 25 THEN 'PLANNED'   WHEN p_r < 45 THEN 'REPORTED'
                                         WHEN p_r < 65 THEN 'VALIDATED' WHEN p_r < 95 THEN 'REVIEWED'
                                         ELSE 'REJECTED' END;
      ELSE                   RETURN CASE WHEN p_r < 30 THEN 'COPIED'    ELSE 'PLANNED' END;
    END CASE;
  END;

  -- Ventana de fechas (arreglo JSON [inicio, fin]) de la etapa p_stage para una configuración
  -- que está en la etapa p_current (1 programación, 2 reporte, 3 validación, 4 revisión):
  -- la etapa actual va de hoy-10 a hoy+20 días (la app React solo habilita las acciones dentro
  -- de la ventana), las anteriores ya pasaron y las siguientes vienen después.
  FUNCTION win(p_stage NUMBER, p_current NUMBER) RETURN VARCHAR2 IS
    d DATE := TRUNC(SYSDATE) + (p_stage - p_current) * 30 - 10;
  BEGIN
    RETURN '["' || TO_CHAR(d, 'YYYY-MM-DD') || 'T05:00:00.000Z","'
                || TO_CHAR(d + 30, 'YYYY-MM-DD') || 'T04:59:59.000Z"]';
  END;

  PROCEDURE add_history(p_goal NUMBER, p_rec NUMBER, p_event VARCHAR2, p_desc VARCHAR2, p_days NUMBER) IS
  BEGIN
    INSERT INTO SPD_GOAL_HISTORY (GOAL_ID, MONITORING_RECORD_ID, EVENT, DESCRIPTION, CREATED_AT, CREATED_BY)
    VALUES (p_goal, p_rec, p_event, p_desc,
            TIMESTAMP '2024-01-01 08:00:00 -05:00' + NUMTODSINTERVAL(p_days, 'DAY'), c_demo);
  END;

  PROCEDURE add_resource(p_rec NUMBER, p_type VARCHAR2, p_base NUMBER, p_pct NUMBER, p_ind NUMBER) IS
    b NUMBER := ROUND(p_base * p_pct, -3);
  BEGIN
    INSERT INTO SPD_MONITORING_RECORD_RESOURCE
      (MONITORING_RECORD_ID, RESOURCE_TYPE, RP, SGP, SGP_EDUCATION, SGP_HEALTH, SGR, CN, CD,
       CREDIT, OTHERS, MANAGEMENT, OPERATION, FINANCIAL_INDICATOR, CREATED_BY)
    VALUES (p_rec, p_type,
            ROUND(b * 0.45, -3), 0, ROUND(b * 0.15, -3), ROUND(b * 0.10, -3), ROUND(b * 0.12, -3),
            ROUND(b * 0.10, -3), ROUND(b * 0.05, -3), ROUND(b * 0.03, -3), 0, 0, 0, p_ind, c_demo);
  END;

  -- Crea el registro de una meta en una configuración, con recursos, adjunto e historial
  PROCEDURE add_record(p_cfg t_cfg, p_goal NUMBER, p_goal_value NUMBER, p_accum VARCHAR2,
                       p_name VARCHAR2) IS
    r      NUMBER := h(p_goal, p_cfg.sub);   -- subperiodo (no el ID): mismo reparto en cada recarga
    st     VARCHAR2(20) := status_for(p_cfg.status, r);
    v_type SPD_GOAL.GOAL_TYPE%TYPE;
    prog   NUMBER;
    ach    NUMBER;
    phys   NUMBER;
    base   NUMBER;
    v_rec  NUMBER;
    d0     NUMBER := (p_cfg.sub - 1) * 91;   -- días desde 2024-01-01 al inicio del trimestre
    rep    BOOLEAN := st IN ('REPORTED','VALIDATED','REVIEWED','APPROVED','REJECTED');
  BEGIN
    -- activa: proyectos y planes de acción casi todos revisados (sus tableros se ven por entidad)
    SELECT GOAL_TYPE INTO v_type FROM SPD_GOAL WHERE ID = p_goal;
    IF p_cfg.status = 'REPORTING' AND v_type IN ('PROJECT','ACTION_PLAN') THEN
      st  := CASE WHEN r < 15 THEN 'VALIDATED' ELSE 'REVIEWED' END;
      rep := TRUE;
    END IF;
    prog := CASE WHEN p_accum = 'STOCK' THEN NVL(p_goal_value, 100)
                 ELSE ROUND(NVL(p_goal_value, 100) / 4, 2) END;
    IF prog = 0 THEN prog := 1; END IF;
    IF rep THEN
      ach  := ROUND(prog * (0.35 + MOD(r * 7, 80) / 100), 2);   -- 35%..114% de lo programado
      phys := LEAST(ROUND(ach / prog, 4), 1);
    END IF;

    INSERT INTO SPD_MONITORING_RECORD
      (MONITORING_CONFIG_ID, GOAL_ID, PERIOD, GOAL_VALUE, FROM_MONTH, TO_MONTH, GOAL_ACHIEVED_VALUE,
       RECORD_STATUS, PHYSICAL_INDICATOR, TOTAL_PEOPLE, NOTES,
       QUESTION_HOW, QUESTION_RESULT, QUESTION_EVIDENCE, QUESTION_PROBLEM,
       CREATED_AT, CREATED_BY, UPDATED_AT, UPDATED_BY)
    VALUES
      (p_cfg.id, p_goal, 2024, prog, (p_cfg.sub - 1) * 3 + 1, p_cfg.sub * 3, ach,
       st, phys, CASE WHEN rep THEN 50 + r * 37 END,
       CASE WHEN st = 'REJECTED' THEN 'Rechazado: la evidencia no soporta el avance reportado.'
            WHEN rep THEN 'Avance del trimestre ' || p_cfg.sub || ' de 2024.' END,
       CASE WHEN rep THEN 'Se ejecutaron las actividades programadas para "' || SUBSTR(p_name, 1, 200) || '".' END,
       CASE WHEN rep THEN 'Se logró ' || TO_CHAR(ROUND(phys * 100)) || '% de lo programado en el trimestre.' END,
       CASE WHEN rep THEN 'Actas, registro fotográfico e informe de supervisión.' END,
       CASE WHEN rep AND r < 40 THEN 'Retrasos en la contratación por trámites presupuestales.' END,
       TIMESTAMP '2024-01-01 08:00:00 -05:00' + NUMTODSINTERVAL(d0, 'DAY'), c_demo,
       TIMESTAMP '2024-01-01 08:00:00 -05:00' + NUMTODSINTERVAL(d0 + 60 + MOD(r, 25), 'DAY'), c_demo)
    RETURNING ID INTO v_rec;
    n_rec := n_rec + 1;

    -- Recursos: apropiación (DEFINITIVE) para todo lo programado; MANUAL cuando el origen lo pide
    base := (50 + MOD(r * 13, 750)) * 1000000;   -- 50 a 800 millones
    IF st <> 'COPIED' THEN
      add_resource(v_rec, 'DEFINITIVE', base, 1, NULL);
      IF p_cfg.origin = 'USER_AND_FINANCIAL' AND MOD(r, 2) = 0 THEN
        add_resource(v_rec, 'MANUAL', base, 0.95, NULL);
      END IF;
      add_history(p_goal, v_rec, 'SCHEDULED', 'Meta programada para 2024-' || p_cfg.sub, d0 + 5);
    END IF;
    IF rep THEN
      add_resource(v_rec, 'COMMITMENT', base, 0.40 + MOD(r, 55) / 100, 0.40 + MOD(r, 55) / 100);
      add_resource(v_rec, 'OBLIGATION', base, 0.25 + MOD(r, 50) / 100, 0.25 + MOD(r, 50) / 100);
      add_resource(v_rec, 'PAYMENT',    base, 0.15 + MOD(r, 40) / 100, 0.15 + MOD(r, 40) / 100);
      add_history(p_goal, v_rec, 'MONITORED', 'Avance reportado', d0 + 60 + MOD(r, 10));
      IF MOD(r, 3) = 0 THEN
        INSERT INTO SPD_MONITORING_RECORD_ATTACH (MONITORING_RECORD_ID, S3_PATH, NAME, DESCRIPTION, CREATED_BY)
        VALUES (v_rec, 'demo/seguimiento/' || v_rec || '/evidencia.pdf', 'evidencia.pdf',
                'Informe de supervisión del trimestre', c_demo);
      END IF;
    END IF;
    IF st IN ('VALIDATED','REVIEWED','APPROVED') THEN
      add_history(p_goal, v_rec, 'VALIDATED', 'Avance validado por la oficina de planeación', d0 + 72);
    END IF;
    IF st IN ('REVIEWED','APPROVED') THEN
      add_history(p_goal, v_rec, 'REVIEWED', CASE st WHEN 'APPROVED' THEN 'Avance revisado y aprobado'
                                                     ELSE 'Avance revisado' END, d0 + 80);
    END IF;
    IF st = 'REJECTED' THEN
      add_history(p_goal, v_rec, 'REJECTED', 'La evidencia no soporta el avance reportado', d0 + 75);
    END IF;
  END;

  FUNCTION new_goal(p_type VARCHAR2, p_code VARCHAR2, p_name VARCHAR2, p_indicator VARCHAR2,
                    p_entity NUMBER, p_level NUMBER, p_parent NUMBER, p_base NUMBER, p_value NUMBER,
                    p_units VARCHAR2, p_project VARCHAR2) RETURN NUMBER IS
    v NUMBER;
  BEGIN
    INSERT INTO SPD_GOAL
      (NIT_COMPANIA, PARENT_GOAL_ID, PLAN, DEV_PLAN_LEVEL_ID, ENTITY_ID, GOAL_TYPE, CODE, NAME, INDICATOR,
       DESCRIPTION, ACCUMULATION_TYPE, BASE_VALUE, GOAL_VALUE, UNITS_FACTOR, UNITS_NAME, PROJECT_CODE,
       START_DATE, END_DATE, CREATED_BY)
    VALUES
      (c_nit, p_parent, c_plan, p_level, p_entity, p_type, p_code, p_name, p_indicator,
       'Dato de demostración', 'ACCUMULATED', p_base, p_value, 1, p_units, p_project,
       TIMESTAMP '2024-01-01 00:00:00 -05:00', TIMESTAMP '2024-12-31 00:00:00 -05:00', c_demo)
    RETURNING ID INTO v;
    n_goals := n_goals + 1;
    RETURN v;
  END;

BEGIN
  /* ---------------------------------------------------------------- limpieza */
  -- también lo que se haya guardado desde las pantallas sobre las configuraciones / metas demo
  DELETE FROM SPD_GOAL_HISTORY WHERE CREATED_BY = c_demo
     OR GOAL_ID IN (SELECT ID FROM SPD_GOAL WHERE CREATED_BY = c_demo)
     OR MONITORING_RECORD_ID IN (SELECT ID FROM SPD_MONITORING_RECORD WHERE CREATED_BY = c_demo
        OR MONITORING_CONFIG_ID IN (SELECT ID FROM SPD_MONITORING_CONFIG WHERE CREATED_BY = c_demo));
  DELETE FROM SPD_MONITORING_RECORD_ATTACH WHERE MONITORING_RECORD_ID IN
    (SELECT ID FROM SPD_MONITORING_RECORD WHERE CREATED_BY = c_demo
        OR MONITORING_CONFIG_ID IN (SELECT ID FROM SPD_MONITORING_CONFIG WHERE CREATED_BY = c_demo));
  DELETE FROM SPD_MONITORING_RECORD_RESOURCE WHERE MONITORING_RECORD_ID IN
    (SELECT ID FROM SPD_MONITORING_RECORD WHERE CREATED_BY = c_demo
        OR MONITORING_CONFIG_ID IN (SELECT ID FROM SPD_MONITORING_CONFIG WHERE CREATED_BY = c_demo));
  DELETE FROM SPD_MONITORING_RECORD WHERE CREATED_BY = c_demo
     OR MONITORING_CONFIG_ID IN (SELECT ID FROM SPD_MONITORING_CONFIG WHERE CREATED_BY = c_demo);
  DELETE FROM SPD_MONITORING_CONFIG WHERE CREATED_BY = c_demo;
  -- metas hijas primero (actividades), luego las padre
  DELETE FROM SPD_GOAL WHERE CREATED_BY = c_demo AND PARENT_GOAL_ID IS NOT NULL;
  DELETE FROM SPD_GOAL WHERE CREATED_BY = c_demo;
  DELETE FROM PROYECTO WHERE NIT_COMPANIA = c_nit AND USUARIO = 'DEMO_SPD';
  -- ubicaciones demo (CODE 'DEMO-...'): hijos primero
  DELETE FROM SPD_GEO_LOCATION WHERE NIT_COMPANIA = c_nit AND CODE LIKE 'DEMO-%' AND PARENT_LOCATION_ID IS NOT NULL;
  DELETE FROM SPD_GEO_LOCATION WHERE NIT_COMPANIA = c_nit AND CODE LIKE 'DEMO-%';

  /* ---------------------------------------------------------------- ubicaciones (para la focalización) */
  INSERT INTO SPD_GEO_LOCATION (NIT_COMPANIA, CODE, NAME, LOCATION_TYPE)
  VALUES (c_nit, 'DEMO-76520', 'Palmira', 'MUNICIPALITY') RETURNING ID INTO v_id;
  FOR u IN (SELECT 'DEMO-C1' c, 'Comuna 1 - Zona Norte' n, 'DISTRICT' t FROM dual UNION ALL
            SELECT 'DEMO-C2', 'Comuna 2 - Zona Oriente', 'DISTRICT' FROM dual UNION ALL
            SELECT 'DEMO-C3', 'Comuna 3 - Centro', 'DISTRICT' FROM dual UNION ALL
            SELECT 'DEMO-C4', 'Comuna 4 - Zona Sur', 'DISTRICT' FROM dual UNION ALL
            SELECT 'DEMO-ROZO', 'Corregimiento Rozo', 'TOWNSHIP' FROM dual UNION ALL
            SELECT 'DEMO-AMAIME', 'Corregimiento Amaime', 'TOWNSHIP' FROM dual UNION ALL
            SELECT 'DEMO-TORRE', 'Corregimiento La Torre', 'TOWNSHIP' FROM dual UNION ALL
            SELECT 'DEMO-TIENDANUEVA', 'Corregimiento Tienda Nueva', 'TOWNSHIP' FROM dual) LOOP
    INSERT INTO SPD_GEO_LOCATION (NIT_COMPANIA, CODE, NAME, LOCATION_TYPE, PARENT_LOCATION_ID)
    VALUES (c_nit, u.c, u.n, u.t, v_id);
  END LOOP;

  /* ---------------------------------------------------------------- configuraciones */
  -- rangos de color completos (formato React, con etiqueta): algunos seguimientos de Palmira
  -- los tienen sin límites y todo saldría del último color
  v_colors := '[{"fromValue":0,"toValue":50,"includeFromValue":true,"includeToValue":true,"color":"#f5222d","label":"Bajo"},'
           || '{"fromValue":50,"toValue":80,"includeFromValue":false,"includeToValue":true,"color":"#fadb14","label":"Medio"},'
           || '{"fromValue":80,"toValue":100,"includeFromValue":false,"includeToValue":true,"color":"#52c41a","label":"Alto"}]';

  FOR i IN 1 .. 4 LOOP
    cfgs(i).sub    := i;
    cfgs(i).status := CASE i WHEN 1 THEN 'REVIEWING' WHEN 2 THEN 'VALIDATING'
                             WHEN 3 THEN 'REPORTING' ELSE 'SCHEDULING' END;
    cfgs(i).origin := CASE i WHEN 4 THEN 'USER_AND_FINANCIAL' ELSE 'FINANCIAL' END;
    v_dates := '{"scheduling":' || win(1, 5 - i) || ',"reporting":' || win(2, 5 - i)
            || ',"validating":' || win(3, 5 - i) || ',"reviewing":' || win(4, 5 - i) || '}';
    IF i = 3 THEN   -- activa: reporte, validación y revisión abiertas hoy (acciones habilitadas en React)
      v_dates := '{"scheduling":' || win(1, 2) || ',"reporting":' || win(2, 2)
              || ',"validating":' || win(2, 2) || ',"reviewing":' || win(2, 2) || '}';
    END IF;
    INSERT INTO SPD_MONITORING_CONFIG
      (USED_FOR, NIT_COMPANIA, IS_ACTIVE, PLAN, PERIOD, SUBPERIOD, PERIODICITY, SPENT_DOCS, WEIGHTING_TYPE,
       DATES_CONFIG, COLORS_CONFIG, STATUS, MONITORING_RESOURCES_ORIGIN, SUPPORT_PRODUCT_MONITORING,
       SGP_DISCRIMINATED, GOAL_TYPES, CREATED_BY)
    VALUES
      ('DEVELOPMENT_PLANS', c_nit, CASE i WHEN 3 THEN 'S' ELSE 'N' END, c_plan, 2024, i, 3,
       '["COMMITMENT","OBLIGATION"]', 'FINANCIAL',
       v_dates,
       v_colors, cfgs(i).status, cfgs(i).origin, 'N', 'N', c_types, c_demo)
    RETURNING ID INTO cfgs(i).id;
  END LOOP;

  -- La app React toma como "activa" la primera configuración con IS_ACTIVE = 'S' y la vuelve a
  -- fijar cada vez que recarga la lista: se deja solo la demo 2024-3 como activa de la compañía.
  -- (Único cambio sobre datos existentes; APEX no usa este indicador.)
  UPDATE SPD_MONITORING_CONFIG SET IS_ACTIVE = 'N'
  WHERE  NIT_COMPANIA = c_nit AND IS_ACTIVE = 'S' AND NVL(CREATED_BY, 0) <> c_demo;

  /* ---------------------------------------------------------------- proyectos y planes de acción */
  FOR p IN (SELECT ROW_NUMBER() OVER (ORDER BY x.k) AS n, e.ID AS ENTITY_ID, e.CODIGO_ENT_PRY, x.NOMBRE, x.VALOR
            FROM  (SELECT 1 k, '76520IRV'  c, 'Mejoramiento de la malla vial urbana de Palmira' NOMBRE, 4200000000 VALOR FROM dual UNION ALL
                   SELECT 2, '76520SGSC', 'Fortalecimiento de la convivencia y la seguridad ciudadana', 1350000000 FROM dual UNION ALL
                   SELECT 3, '76520SPS',  'Ampliación de la cobertura de vacunación en zona rural', 980000000 FROM dual UNION ALL
                   SELECT 4, '76520SE',   'Dotación de sedes educativas oficiales', 2100000000 FROM dual UNION ALL
                   SELECT 5, '76520C',    'Formación artística en escuelas de música', 640000000 FROM dual UNION ALL
                   SELECT 6, '76520SIS',  'Atención integral al adulto mayor', 1120000000 FROM dual) x
            JOIN  ENTIDADES_PRY e ON e.NIT_COMPANIA = c_nit AND e.CODIGO_ENT_PRY = x.c
            ORDER BY x.k) LOOP
    INSERT INTO PROYECTO (PLAN, PROGRAMA, SECTOR, EJE, NIT_COMPANIA, PROYECTO, NOMBRE, ANO, CODIGO,
                          FECHA_REGISTRO, VALOR, ESTADO, CODIGO_ENT_PRY, ESTADO_PROCESO, USUARIO, FECHA_CREACION)
    VALUES (c_plan, 1, 1, 1, c_nit, 2024000000 + p.n, p.NOMBRE, 2024, '2024765200' || LPAD(p.n, 2, '0'),
            DATE '2024-01-15', p.VALOR, 'A', p.CODIGO_ENT_PRY, 'REGISTRADO', 'DEMO_SPD', SYSDATE);

    -- nivel del plan: el de alguna meta de producto de la misma entidad
    SELECT MAX(DEV_PLAN_LEVEL_ID) INTO v_level FROM SPD_GOAL
    WHERE  NIT_COMPANIA = c_nit AND PLAN = c_plan AND ENTITY_ID = p.ENTITY_ID AND GOAL_TYPE = 'PRODUCT';

    v_goal := new_goal('PROJECT', 'PRY-' || LPAD(p.n, 2, '0'), p.NOMBRE, 'Porcentaje de avance del proyecto',
                       p.ENTITY_ID, v_level, NULL, 0, 100, 'PORCENTAJE', TO_CHAR(2024000000 + p.n));
    FOR a IN 1 .. 2 LOOP
      v_id := new_goal('ACTIVITY', 'PRY-' || LPAD(p.n, 2, '0') || '.A' || a,
                       CASE a WHEN 1 THEN 'Estudios y diseños - ' ELSE 'Ejecución de obras y suministros - ' END
                         || p.NOMBRE,
                       'Actividades ejecutadas', p.ENTITY_ID, v_level, v_goal, 0, 4 * a, 'NÚMERO',
                       TO_CHAR(2024000000 + p.n));
    END LOOP;
  END LOOP;

  FOR a IN (SELECT ROW_NUMBER() OVER (ORDER BY x.k) AS n, e.ID AS ENTITY_ID, x.NOMBRE
            FROM  (SELECT 1 k, '76520SGSC' c, 'Plan de acción de gobierno y participación ciudadana' NOMBRE FROM dual UNION ALL
                   SELECT 2, '76520SPS',  'Plan de acción en salud pública' FROM dual UNION ALL
                   SELECT 3, '76520SE',   'Plan de acción de calidad educativa' FROM dual UNION ALL
                   SELECT 4, '76520IRV',  'Plan de acción de infraestructura y vivienda' FROM dual UNION ALL
                   SELECT 5, '76520ADR',  'Plan de acción de desarrollo rural' FROM dual) x
            JOIN  ENTIDADES_PRY e ON e.NIT_COMPANIA = c_nit AND e.CODIGO_ENT_PRY = x.c
            ORDER BY x.k) LOOP
    SELECT MAX(DEV_PLAN_LEVEL_ID) INTO v_level FROM SPD_GOAL
    WHERE  NIT_COMPANIA = c_nit AND PLAN = c_plan AND ENTITY_ID = a.ENTITY_ID AND GOAL_TYPE = 'PRODUCT';
    v_id := new_goal('ACTION_PLAN', 'PA-2024-' || LPAD(a.n, 2, '0'), a.NOMBRE, 'Porcentaje de cumplimiento del plan',
                     a.ENTITY_ID, v_level, NULL, 0, 100, 'PORCENTAJE', NULL);
    -- metas del plan de acción (ACTION_PLAN_ACTIVITY), que son las que se programan y reportan
    FOR m IN 1 .. 2 LOOP
      v_goal := new_goal('ACTION_PLAN_ACTIVITY', 'PA-2024-' || LPAD(a.n, 2, '0') || '.M' || m,
                         CASE m WHEN 1 THEN 'Jornadas de socialización - ' ELSE 'Seguimiento a compromisos - ' END || a.NOMBRE,
                         NULL, a.ENTITY_ID, v_level, v_id, 0, 6 * m, 'NÚMERO', NULL);
    END LOOP;
  END LOOP;

  /* ---------------------------------------------------------------- registros de seguimiento */
  FOR i IN 1 .. 4 LOOP
    FOR g IN (SELECT ID, GOAL_TYPE, GOAL_VALUE, ACCUMULATION_TYPE, NAME FROM SPD_GOAL
              WHERE  NIT_COMPANIA = c_nit AND PLAN = c_plan
              AND    GOAL_TYPE IN ('PRODUCT','PROJECT','ACTIVITY','ACTION_PLAN','ACTION_PLAN_ACTIVITY')) LOOP
      -- metas de producto: ~1 de cada 4 por trimestre, y todas en 2024-1 (revisión, para los tableros);
      -- proyectos y planes: todas
      IF g.GOAL_TYPE <> 'PRODUCT' OR i IN (1, 3) OR MOD(h(g.ID, 0) + i, 4) = 0 THEN
        add_record(cfgs(i), g.ID, g.GOAL_VALUE, g.ACCUMULATION_TYPE, g.NAME);
      END IF;
    END LOOP;
  END LOOP;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Configuraciones: ' || cfgs(1).id || ', ' || cfgs(2).id || ', ' || cfgs(3).id || ', ' || cfgs(4).id
                       || ' | metas nuevas: ' || n_goals || ' | registros: ' || n_rec);
END;
/
