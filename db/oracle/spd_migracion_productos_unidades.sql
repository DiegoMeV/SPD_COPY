/* =============================================================================
   SPD - Migración: productos y unidades del SIIF
   SPD_PRODUCT_CATALOG -> PRODUCTOS_PRY      SPD_UNIT -> UNIDADES_PRY

   Para bases donde ya se ejecutó una versión anterior de spd_schema.sql (desarrollo
   y locales). En una base nueva no hace falta: spd_schema.sql ya crea todo así.

   Requisitos: PRODUCTOS_PRY y UNIDADES_PRY existen (en el SIIF ya están; en local las
   crea siif_base_tables.sql). Conectado como el dueño del esquema (SIIF).

   Qué hace (se puede volver a ejecutar; cada paso revisa si ya está hecho):
   1. Agrega SPD_GOAL.PRODUCT_ID, UNIT_CODE, PI_UNIT_CODE y SPD_DEV_PLAN_LEVEL.SECTOR_CODE.
   2. Pasa los datos:
      - Unidades: cada texto de UNITS_NAME / PI_UNITS_NAME se busca en UNIDADES_PRY de la
        compañía de la meta (por nombre, sin importar mayúsculas ni espacios). Si no está,
        se crea con el siguiente CODIGO_UND (y la sigla de SPD_UNIT, si la tenía).
      - Productos: el producto de la meta (si la meta apuntaba a un indicador, el producto
        padre) se busca en PRODUCTOS_PRY de la compañía por CODIGO. Si no está, se crea con
        su programa DNP.
      - Sector de los niveles del plan: código del sector (raíz del catálogo).
   3. Borra las FK, columnas y tablas anteriores (SPD_UNIT, SPD_PRODUCT_CATALOG) y la vista
      V_SPD_PRODUCT_INDICATORS.
   4. Crea las FK nuevas hacia PRODUCTOS_PRY y UNIDADES_PRY, con sus índices.

   Después: ejecutar spd_views.sql y reinstalar la aplicación 160.
   Compatible con Oracle 12c+ (no usa BOOLEAN en SQL ni IF [NOT] EXISTS).
   ============================================================================= */
SET SERVEROUTPUT ON
SET DEFINE OFF
WHENEVER SQLERROR EXIT FAILURE ROLLBACK

DECLARE
  n NUMBER;

  FUNCTION tab_exists(p_table VARCHAR2) RETURN BOOLEAN IS
    k NUMBER;
  BEGIN
    SELECT COUNT(*) INTO k FROM USER_TABLES WHERE TABLE_NAME = p_table;
    RETURN k > 0;
  END;

  FUNCTION col_exists(p_table VARCHAR2, p_col VARCHAR2) RETURN BOOLEAN IS
    k NUMBER;
  BEGIN
    SELECT COUNT(*) INTO k FROM USER_TAB_COLUMNS WHERE TABLE_NAME = p_table AND COLUMN_NAME = p_col;
    RETURN k > 0;
  END;

  FUNCTION cons_exists(p_name VARCHAR2) RETURN BOOLEAN IS
    k NUMBER;
  BEGIN
    SELECT COUNT(*) INTO k FROM USER_CONSTRAINTS WHERE CONSTRAINT_NAME = p_name;
    RETURN k > 0;
  END;

  PROCEDURE run(p_sql VARCHAR2) IS
  BEGIN
    EXECUTE IMMEDIATE p_sql;
  END;

  PROCEDURE log(p_msg VARCHAR2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(p_msg);
  END;

  PROCEDURE add_col(p_table VARCHAR2, p_col VARCHAR2, p_type VARCHAR2) IS
  BEGIN
    IF NOT col_exists(p_table, p_col) THEN
      run('ALTER TABLE ' || p_table || ' ADD (' || p_col || ' ' || p_type || ')');
      log('+ ' || p_table || '.' || p_col);
    END IF;
  END;

  PROCEDURE drop_col(p_table VARCHAR2, p_col VARCHAR2) IS
  BEGIN
    IF col_exists(p_table, p_col) THEN
      run('ALTER TABLE ' || p_table || ' DROP COLUMN ' || p_col);
      log('- ' || p_table || '.' || p_col);
    END IF;
  END;

  PROCEDURE add_index(p_name VARCHAR2, p_def VARCHAR2) IS
    k NUMBER;
  BEGIN
    SELECT COUNT(*) INTO k FROM USER_INDEXES WHERE INDEX_NAME = p_name;
    IF k = 0 THEN
      run('CREATE INDEX ' || p_name || ' ON ' || p_def);
    END IF;
  END;

BEGIN
  IF NOT tab_exists('PRODUCTOS_PRY') OR NOT tab_exists('UNIDADES_PRY') THEN
    RAISE_APPLICATION_ERROR(-20001, 'Faltan PRODUCTOS_PRY o UNIDADES_PRY (en local se crean con siif_base_tables.sql)');
  END IF;
  IF NOT tab_exists('SPD_GOAL') THEN
    RAISE_APPLICATION_ERROR(-20002, 'No existe SPD_GOAL: en una base nueva ejecute spd_schema.sql en lugar de este script');
  END IF;

  /* 1. Columnas nuevas ------------------------------------------------------ */
  add_col('SPD_GOAL', 'PRODUCT_ID', 'NUMBER');
  add_col('SPD_GOAL', 'UNIT_CODE', 'NUMBER(3,0)');
  add_col('SPD_GOAL', 'PI_UNIT_CODE', 'NUMBER(3,0)');
  add_col('SPD_DEV_PLAN_LEVEL', 'SECTOR_CODE', 'VARCHAR2(20)');

  /* 2. Datos ------------------------------------------------------------------ */
  -- 2.1 Unidades que usan las metas y no están en UNIDADES_PRY de su compañía
  IF col_exists('SPD_GOAL', 'UNITS_NAME') AND col_exists('SPD_GOAL', 'PI_UNITS_NAME') THEN
    run(q'[
      INSERT INTO UNIDADES_PRY (NIT_COMPANIA, CODIGO_UND, NOMBRE_UNIDAD, SIGLA)
      SELECT x.NIT_COMPANIA,
             NVL((SELECT MAX(u.CODIGO_UND) FROM UNIDADES_PRY u WHERE u.NIT_COMPANIA = x.NIT_COMPANIA), 0)
               + ROW_NUMBER() OVER (PARTITION BY x.NIT_COMPANIA ORDER BY x.NAME),
             x.NAME, x.SIGLA
      FROM (SELECT g.NIT_COMPANIA, MIN(SUBSTRB(TRIM(g.NAME), 1, 255)) AS NAME,
                   MIN(]' || CASE WHEN tab_exists('SPD_UNIT') THEN 'SUBSTRB(s.INITIALS, 1, 15)' ELSE 'NULL' END || q'[) AS SIGLA
              FROM (SELECT NIT_COMPANIA, UNITS_NAME AS NAME FROM SPD_GOAL WHERE TRIM(UNITS_NAME) IS NOT NULL
                    UNION
                    SELECT NIT_COMPANIA, PI_UNITS_NAME FROM SPD_GOAL WHERE TRIM(PI_UNITS_NAME) IS NOT NULL) g
              ]' || CASE WHEN tab_exists('SPD_UNIT') THEN 'LEFT JOIN SPD_UNIT s ON UPPER(TRIM(s.NAME)) = UPPER(TRIM(g.NAME))' END || q'[
             WHERE NOT EXISTS (SELECT 1 FROM UNIDADES_PRY u
                                WHERE u.NIT_COMPANIA = g.NIT_COMPANIA
                                  AND UPPER(TRIM(u.NOMBRE_UNIDAD)) = UPPER(TRIM(g.NAME)))
             GROUP BY g.NIT_COMPANIA, UPPER(TRIM(g.NAME))) x]');
    n := SQL%ROWCOUNT;
    log('Unidades creadas en UNIDADES_PRY: ' || n);

    run(q'[
      UPDATE SPD_GOAL g
         SET UNIT_CODE = (SELECT MIN(u.CODIGO_UND) FROM UNIDADES_PRY u
                           WHERE u.NIT_COMPANIA = g.NIT_COMPANIA
                             AND UPPER(TRIM(u.NOMBRE_UNIDAD)) = UPPER(TRIM(g.UNITS_NAME)))
       WHERE TRIM(g.UNITS_NAME) IS NOT NULL AND g.UNIT_CODE IS NULL]');
    log('Metas con unidad: ' || SQL%ROWCOUNT);
  END IF;
  IF col_exists('SPD_GOAL', 'PI_UNITS_NAME') THEN
    run(q'[
      UPDATE SPD_GOAL g
         SET PI_UNIT_CODE = (SELECT MIN(u.CODIGO_UND) FROM UNIDADES_PRY u
                              WHERE u.NIT_COMPANIA = g.NIT_COMPANIA
                                AND UPPER(TRIM(u.NOMBRE_UNIDAD)) = UPPER(TRIM(g.PI_UNITS_NAME)))
       WHERE TRIM(g.PI_UNITS_NAME) IS NOT NULL AND g.PI_UNIT_CODE IS NULL]');
    log('Metas con unidad del plan indicativo: ' || SQL%ROWCOUNT);
  END IF;

  -- 2.2 Productos: ancestro de nivel 3 (Sector > Programa > Producto) del catálogo anterior
  IF tab_exists('SPD_PRODUCT_CATALOG') AND col_exists('SPD_GOAL', 'PRODUCT_CATALOG_ID') THEN
    IF tab_exists('SPD_TMP_GOAL_PRODUCT') THEN   -- de una ejecución anterior que falló
      run('TRUNCATE TABLE SPD_TMP_GOAL_PRODUCT');
      run('DROP TABLE SPD_TMP_GOAL_PRODUCT');
    END IF;
    run(q'[
      CREATE GLOBAL TEMPORARY TABLE SPD_TMP_GOAL_PRODUCT (
        CATALOG_ID NUMBER, CODIGO VARCHAR2(20), NOMBRE VARCHAR2(300),
        DESCRIPCION VARCHAR2(1000), PROGRAMA VARCHAR2(20)) ON COMMIT PRESERVE ROWS]');
    run(q'[
      INSERT INTO SPD_TMP_GOAL_PRODUCT (CATALOG_ID, CODIGO, NOMBRE, DESCRIPCION, PROGRAMA)
      SELECT a.START_ID,
             MAX(CASE WHEN a.DEPTH = 3 THEN SUBSTRB(a.CODE, 1, 20) END),
             MAX(CASE WHEN a.DEPTH = 3 THEN SUBSTRB(a.NAME, 1, 300) END),
             MAX(CASE WHEN a.DEPTH = 3 THEN SUBSTRB(a.DESCRIPTION, 1, 1000) END),
             MAX(CASE WHEN a.DEPTH = 2 THEN SUBSTRB(a.CODE, 1, 20) END)
      FROM (SELECT t.START_ID, t.CODE, t.NAME, t.DESCRIPTION,
                   MAX(t.UP) OVER (PARTITION BY t.START_ID) - t.UP + 1 AS DEPTH
              FROM (SELECT CONNECT_BY_ROOT c.ID AS START_ID, c.CODE, c.NAME, c.DESCRIPTION, LEVEL AS UP
                      FROM SPD_PRODUCT_CATALOG c
                     START WITH c.ID IN (SELECT PRODUCT_CATALOG_ID FROM SPD_GOAL)
                     CONNECT BY c.ID = PRIOR c.PARENT_ID) t) a
      GROUP BY a.START_ID]');

    run(q'[
      INSERT INTO PRODUCTOS_PRY (NIT_COMPANIA, CODIGO, NOMBRE, DESCRIPCION, PROGRAMA)
      SELECT DISTINCT g.NIT_COMPANIA, p.CODIGO, p.NOMBRE, p.DESCRIPCION, p.PROGRAMA
        FROM SPD_GOAL g
        JOIN SPD_TMP_GOAL_PRODUCT p ON p.CATALOG_ID = g.PRODUCT_CATALOG_ID
       WHERE p.CODIGO IS NOT NULL
         AND NOT EXISTS (SELECT 1 FROM PRODUCTOS_PRY x WHERE x.NIT_COMPANIA = g.NIT_COMPANIA AND x.CODIGO = p.CODIGO)]');
    log('Productos creados en PRODUCTOS_PRY: ' || SQL%ROWCOUNT);

    run(q'[
      UPDATE SPD_GOAL g
         SET PRODUCT_ID = (SELECT MIN(x.ID) FROM PRODUCTOS_PRY x, SPD_TMP_GOAL_PRODUCT p
                            WHERE p.CATALOG_ID = g.PRODUCT_CATALOG_ID
                              AND x.NIT_COMPANIA = g.NIT_COMPANIA AND x.CODIGO = p.CODIGO)
       WHERE g.PRODUCT_CATALOG_ID IS NOT NULL AND g.PRODUCT_ID IS NULL]');
    log('Metas con producto: ' || SQL%ROWCOUNT);

    run('TRUNCATE TABLE SPD_TMP_GOAL_PRODUCT');
    run('DROP TABLE SPD_TMP_GOAL_PRODUCT');
  END IF;

  -- 2.3 Sector DNP de los niveles del plan: raíz del catálogo anterior
  IF tab_exists('SPD_PRODUCT_CATALOG') AND col_exists('SPD_DEV_PLAN_LEVEL', 'PRODUCT_CATALOG_ID') THEN
    run(q'[
      UPDATE SPD_DEV_PLAN_LEVEL d
         SET SECTOR_CODE = (SELECT MAX(SUBSTRB(c.CODE, 1, 20)) KEEP (DENSE_RANK LAST ORDER BY LEVEL)
                              FROM SPD_PRODUCT_CATALOG c
                             START WITH c.ID = d.PRODUCT_CATALOG_ID
                             CONNECT BY c.ID = PRIOR c.PARENT_ID)
       WHERE d.PRODUCT_CATALOG_ID IS NOT NULL AND d.SECTOR_CODE IS NULL]');
    log('Niveles del plan con sector: ' || SQL%ROWCOUNT);
  END IF;

  /* 3. Estructura anterior ---------------------------------------------------- */
  FOR c IN (SELECT c.TABLE_NAME, c.CONSTRAINT_NAME
              FROM USER_CONSTRAINTS c
              JOIN USER_CONSTRAINTS r ON r.CONSTRAINT_NAME = c.R_CONSTRAINT_NAME
             WHERE c.CONSTRAINT_TYPE = 'R'
               AND r.TABLE_NAME IN ('SPD_PRODUCT_CATALOG', 'SPD_UNIT')
               AND c.TABLE_NAME NOT IN ('SPD_PRODUCT_CATALOG', 'SPD_UNIT')) LOOP
    run('ALTER TABLE ' || c.TABLE_NAME || ' DROP CONSTRAINT ' || c.CONSTRAINT_NAME);
    log('- FK ' || c.CONSTRAINT_NAME);
  END LOOP;
  drop_col('SPD_GOAL', 'PRODUCT_CATALOG_ID');
  drop_col('SPD_GOAL', 'UNITS_NAME');
  drop_col('SPD_GOAL', 'PI_UNITS_NAME');
  drop_col('SPD_DEV_PLAN_LEVEL', 'PRODUCT_CATALOG_ID');
  IF tab_exists('SPD_PRODUCT_CATALOG') THEN
    run('DROP TABLE SPD_PRODUCT_CATALOG CASCADE CONSTRAINTS PURGE');
    log('- SPD_PRODUCT_CATALOG');
  END IF;
  IF tab_exists('SPD_UNIT') THEN
    run('DROP TABLE SPD_UNIT CASCADE CONSTRAINTS PURGE');
    log('- SPD_UNIT');
  END IF;
  SELECT COUNT(*) INTO n FROM USER_VIEWS WHERE VIEW_NAME = 'V_SPD_PRODUCT_INDICATORS';
  IF n > 0 THEN
    run('DROP VIEW V_SPD_PRODUCT_INDICATORS');
  END IF;

  /* 4. Relaciones nuevas ------------------------------------------------------ */
  IF NOT cons_exists('SPD_GOAL_PROD_FK') THEN
    run('ALTER TABLE SPD_GOAL ADD CONSTRAINT SPD_GOAL_PROD_FK FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTOS_PRY (ID)');
    log('+ FK SPD_GOAL_PROD_FK');
  END IF;
  IF NOT cons_exists('SPD_GOAL_UNIT_FK') THEN
    run('ALTER TABLE SPD_GOAL ADD CONSTRAINT SPD_GOAL_UNIT_FK FOREIGN KEY (NIT_COMPANIA, UNIT_CODE) REFERENCES UNIDADES_PRY (NIT_COMPANIA, CODIGO_UND)');
    log('+ FK SPD_GOAL_UNIT_FK');
  END IF;
  IF NOT cons_exists('SPD_GOAL_PI_UNIT_FK') THEN
    run('ALTER TABLE SPD_GOAL ADD CONSTRAINT SPD_GOAL_PI_UNIT_FK FOREIGN KEY (NIT_COMPANIA, PI_UNIT_CODE) REFERENCES UNIDADES_PRY (NIT_COMPANIA, CODIGO_UND)');
    log('+ FK SPD_GOAL_PI_UNIT_FK');
  END IF;
  add_index('SPD_GOAL_PROD_I',    'SPD_GOAL (PRODUCT_ID)');
  add_index('SPD_GOAL_UNIT_I',    'SPD_GOAL (NIT_COMPANIA, UNIT_CODE)');
  add_index('SPD_GOAL_PI_UNIT_I', 'SPD_GOAL (NIT_COMPANIA, PI_UNIT_CODE)');

  run(q'[COMMENT ON COLUMN SPD_GOAL.PRODUCT_ID IS 'Producto en PRODUCTOS_PRY.ID']');
  run(q'[COMMENT ON COLUMN SPD_GOAL.UNIT_CODE IS 'Unidad de medida en UNIDADES_PRY (NIT_COMPANIA, CODIGO_UND)']');
  run(q'[COMMENT ON COLUMN SPD_GOAL.PI_UNIT_CODE IS 'Unidad de medida del plan indicativo en UNIDADES_PRY (NIT_COMPANIA, CODIGO_UND)']');
  run(q'[COMMENT ON COLUMN SPD_DEV_PLAN_LEVEL.SECTOR_CODE IS 'Sector DNP del nivel: 2 primeros dígitos de PRODUCTOS_PRY.PROGRAMA (sin FK: no hay tabla de sectores DNP)']');

  COMMIT;
  log('Migración terminada. Siguiente paso: spd_views.sql');
END;
/
