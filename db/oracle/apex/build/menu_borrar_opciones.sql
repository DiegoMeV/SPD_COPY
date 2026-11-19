/* =============================================================================
   SPD - Borra del menú de la app 160 (módulo SEGUIMIENTO_PRY) las opciones que ya no van
   Para bases donde ya se ejecutó una versión anterior de menu_inserts.sql (63 opciones).
   menu_inserts.sql ya no las crea (quedan 52).

   Opciones que borra:
     300101  Configuración - Usuarios                (los maneja el SIIF)
     300102  Configuración - Entidades               (los maneja el SIIF)
     300502  Otros - Niveles del plan
     300503  Otros - Metas de actividades
     300504  Otros - Metas por actividad
     300505  Otros - Macroproyectos
     300506  Otros - Ubicaciones
     300507  Otros - Componentes por política
     300508  Otros - Historial de metas
     300509  Otros - Avance de metas
     300510  Otros - Registros de seguimiento
   En "Otros" quedan Inicio (300501), Tablero de seguimiento (300511) y Tablero financiero (300512).

   Qué hace, en el esquema SIIF:
   - GEN_OPCIONES_SISTEMA (SIIF real): antes borra las filas que dependen de esas opciones en
     las tablas con FK hacia ella (p. ej. GEN_OPCIONES_COMPANIA / GEN_OPCIONES_USUARIO), las
     que encuentre en el diccionario, y las de sus propias tablas hijas.
   - GEN_OPCIONES_SISTEMA_LOCAL (solo local, siif_apex_local.sql), si existe.
   - OPCIONES_X_COMPANIA (no tiene FK), si existe.
   Muestra cuántas filas borra de cada tabla. Si algo falla, deshace todo.
   Se puede volver a ejecutar (si ya no están, no borra nada).
   Las páginas siguen en la app 160; solo salen del menú.
   ============================================================================= */
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT FAILURE ROLLBACK
ALTER SESSION SET CURRENT_SCHEMA = SIIF;

DECLARE
  c_modulo  CONSTANT VARCHAR2(30)  := 'SEGUIMIENTO_PRY';
  c_schema  CONSTANT VARCHAR2(128) := SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA');
  c_filtro  CONSTANT VARCHAR2(4000) :=
    'modulo = ''' || c_modulo || ''' AND opcion IN (''300101'', ''300102'', ''300502'', ''300503'', '
    || '''300504'', ''300505'', ''300506'', ''300507'', ''300508'', ''300509'', ''300510'')';

  FUNCTION existe(p_tabla VARCHAR2) RETURN BOOLEAN IS
    k NUMBER;
  BEGIN
    SELECT COUNT(*) INTO k FROM all_tables WHERE owner = c_schema AND table_name = p_tabla;
    RETURN k > 0;
  END;

  -- Lista "c1, c2, ..." de las columnas de una restricción, en orden.
  FUNCTION columnas(p_owner VARCHAR2, p_constraint VARCHAR2) RETURN VARCHAR2 IS
    l VARCHAR2(4000);
  BEGIN
    FOR c IN (SELECT column_name FROM all_cons_columns
               WHERE owner = p_owner AND constraint_name = p_constraint
               ORDER BY position) LOOP
      l := l || CASE WHEN l IS NOT NULL THEN ', ' END || '"' || c.column_name || '"';
    END LOOP;
    RETURN l;
  END;

  -- Borra las filas de p_owner.p_tabla que cumplen p_where, después de borrar sus hijas
  -- (en cualquier nivel). Las FK de una tabla hacia sí misma se omiten: si una opción a borrar
  -- tuviera hijas, el DELETE falla con ORA-02292 y se deshace todo.
  PROCEDURE borrar(p_owner VARCHAR2, p_tabla VARCHAR2, p_where VARCHAR2, p_nivel PLS_INTEGER := 0) IS
    l_where VARCHAR2(32767);
  BEGIN
    IF p_nivel > 5 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Demasiados niveles de FK desde ' || p_owner || '.' || p_tabla);
    END IF;
    FOR fk IN (SELECT h.owner, h.table_name, h.constraint_name, h.r_owner, h.r_constraint_name
                 FROM all_constraints h
                 JOIN all_constraints p ON p.owner = h.r_owner AND p.constraint_name = h.r_constraint_name
                WHERE h.constraint_type = 'R'
                  AND p.owner = p_owner AND p.table_name = p_tabla
                  AND NOT (h.owner = p_owner AND h.table_name = p_tabla)) LOOP
      l_where := '(' || columnas(fk.owner, fk.constraint_name) || ') IN (SELECT '
              || columnas(fk.r_owner, fk.r_constraint_name) || ' FROM "' || p_owner || '"."' || p_tabla
              || '" WHERE ' || p_where || ')';
      borrar(fk.owner, fk.table_name, l_where, p_nivel + 1);
    END LOOP;
    EXECUTE IMMEDIATE 'DELETE FROM "' || p_owner || '"."' || p_tabla || '" WHERE ' || p_where;
    DBMS_OUTPUT.PUT_LINE(RPAD(p_owner || '.' || p_tabla, 45) || SQL%ROWCOUNT || ' filas borradas');
  END;
BEGIN
  IF existe('GEN_OPCIONES_SISTEMA') THEN
    borrar(c_schema, 'GEN_OPCIONES_SISTEMA', c_filtro);
  END IF;
  IF existe('GEN_OPCIONES_SISTEMA_LOCAL') THEN
    borrar(c_schema, 'GEN_OPCIONES_SISTEMA_LOCAL', c_filtro);
  END IF;
  IF existe('OPCIONES_X_COMPANIA') THEN
    borrar(c_schema, 'OPCIONES_X_COMPANIA', c_filtro);
  END IF;
END;
/

COMMIT;

-- Verificación: deben quedar 52 opciones del módulo.
DECLARE
  n NUMBER;
BEGIN
  FOR t IN (SELECT table_name FROM all_tables
             WHERE owner = SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA')
               AND table_name IN ('GEN_OPCIONES_SISTEMA', 'GEN_OPCIONES_SISTEMA_LOCAL')) LOOP
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM ' || t.table_name || ' WHERE modulo = ''SEGUIMIENTO_PRY''' INTO n;
    DBMS_OUTPUT.PUT_LINE(RPAD(t.table_name, 45) || n || ' opciones de SEGUIMIENTO_PRY (deben ser 52)');
  END LOOP;
END;
/
