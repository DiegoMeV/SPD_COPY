-- App 160: contexto global y organización de formularios. Corre como SYS (FREEPDB1) al final de
-- run_import_160.sh, después de schedule_goals_160.sql y track_160.sql (que recrean las páginas de
-- seguimiento). Es re-ejecutable.
--  1. Compañía: ningún formulario la muestra; el campo queda oculto y toma G_NIT_COMPANIA.
--  2. Ítems de aplicación G_PLAN (plan de desarrollo) y G_SEGUIMIENTO (configuración de seguimiento):
--     - se actualizan al elegir en cualquier lista de plan / seguimiento (proceso de aplicación al
--       enviar la página, y acción dinámica en los formularios donde la lista no envía la página);
--     - las páginas abren con ese valor (si es válido para la compañía) y lo dejan guardado.
--  3. Formularios con varios campos por fila (máximo 4, salvo interruptores / casillas).
set define off
whenever sqlerror exit failure
alter session set container = FREEPDB1;
-- esquema de APEX del contenedor local (APEX 24.2)
alter session set current_schema = APEX_240200;
set serveroutput on size unlimited

declare
  c_app   constant number := 160;
  l_ws    number;
  l_evt   number;
  l_n     pls_integer := 0;
  l_lay   pls_integer := 0;
  c_mark  constant varchar2(30) := 'SPD Global';     -- prefijo de lo que crea este script
  c_mc_pages   constant varchar2(200) := '1030,1031,1032,1033,1034,1035,1036,1037,1038,1039,1040,1041,1042,1043,1044';

  -- página | ítem (sin prefijo Pnnnn_) | Y = empieza fila | ancho (de 12)
  type t_lay is table of varchar2(100);
  l_layout t_lay := t_lay(
    -- Usuario
    '1003|USUARIO|Y|4', '1003|CEDULA|N|4', '1003|NRO_CELULAR|N|4',
    '1003|DESCRIPCION|Y|12',
    '1003|EMAIL|Y|4', '1003|CODIGO_ENT_PRY|N|6', '1003|ESTADO|N|2',
    -- Entidad
    '1005|CODIGO_ENT_PRY|Y|3', '1005|NOMBRE_ENT_PRY|N|9',
    '1005|SPD_PRESUPUESTO_MANUAL|Y|3', '1005|ACTIVA|N|3',
    -- Plan de desarrollo
    '1007|PLAN|Y|3', '1007|NOMBRE|N|9',
    '1007|FECHA_INICIO|Y|3', '1007|FECHA_FIN|N|3', '1007|SPD_ORIGEN_ACTIVIDADES|N|6',
    '1007|GOBERNANTE|Y|6', '1007|SPD_INICIO_GOBIERNO|N|3', '1007|SPD_FIN_GOBIERNO|N|3',
    -- Nivel del plan
    '1009|PLAN|Y|6', '1009|CODE|N|3', '1009|LEVEL|N|3',
    '1009|NAME|Y|12',
    '1009|PARENT_ID|Y|6', '1009|PRODUCT_CATALOG_ID|N|6',
    '1009|WEIGHTING|Y|3', '1009|IS_ACTIVE|N|3',
    -- Meta
    '1011|PLAN|Y|4', '1011|DEV_PLAN_LEVEL_ID|N|3', '1011|GOAL_TYPE|N|3', '1011|CODE|N|2',
    '1011|NAME|Y|12',
    '1011|ENTITY_ID|Y|4', '1011|MACRO_PROJECT_ID|N|4', '1011|PARENT_GOAL_ID|N|4',
    '1011|INDICATOR|Y|6', '1011|FORMULA|N|6',
    '1011|DESCRIPTION|Y|12',
    '1011|ACCUMULATION_TYPE|Y|3', '1011|WEIGHTING|N|3', '1011|BASE_VALUE|N|3', '1011|GOAL_VALUE|N|3',
    '1011|UNITS_FACTOR|Y|3', '1011|UNITS_NAME|N|3', '1011|PEACE_POLITIC_ID|N|3', '1011|VICTIMS_POLITIC_ID|N|3',
    '1011|PRODUCT_CATALOG_ID|Y|12',
    '1011|PI_BASE_VALUE|Y|3', '1011|PI_GOAL_VALUE|N|3', '1011|PI_UNITS_FACTOR|N|3', '1011|PI_UNITS_NAME|N|3',
    '1011|ODS_IDS_SEL|Y|12',
    -- Macroproyecto, políticas, componente, ubicación
    '1015|CODE|Y|3', '1015|IS_ACTIVE|N|3', '1015|NAME|Y|6', '1015|DESCRIPTION|N|6',
    '1017|CODE|Y|3', '1017|CATEGORY|N|6', '1017|IS_ACTIVE|N|3', '1017|NAME|Y|6', '1017|DESCRIPTION|N|6',
    '1019|CODE|Y|3', '1019|FROM_YEAR|N|3', '1019|TO_YEAR|N|3', '1019|IS_ACTIVE|N|3',
    '1019|NAME|Y|6', '1019|DESCRIPTION|N|6',
    '1021|CODE|Y|3', '1021|IS_ACTIVE|N|3', '1021|NAME|Y|6', '1021|DESCRIPTION|N|6',
    '1024|CODE|Y|3', '1024|LOCATION_TYPE|N|3', '1024|PARENT_LOCATION_ID|N|6', '1024|NAME|Y|12',
    -- Configuración de seguimiento
    '1046|PLAN|Y|6', '1046|PERIOD|N|3', '1046|SUBPERIOD|N|3',
    '1046|GOAL_TYPES_SEL|Y|12',
    '1046|MONITORING_RESOURCES_ORIGIN|Y|4', '1046|SPENT_DOCS_SEL|N|4', '1046|WEIGHTING_TYPE|N|4',
    '1046|SCHED_FROM|Y|3', '1046|SCHED_TO|N|3', '1046|REPORT_FROM|N|3', '1046|REPORT_TO|N|3',
    '1046|VALID_FROM|Y|3', '1046|VALID_TO|N|3', '1046|REVIEW_FROM|N|3', '1046|REVIEW_TO|N|3',
    '1046|SUPPORT_PRODUCT_MONITORING|Y|4', '1046|SGP_DISCRIMINATED|N|4', '1046|IS_ACTIVE|N|4',
    -- Estructura del plan (regiones angostas, 5 de 12: dos campos por fila)
    '1061|CODE|Y|4', '1061|NAME|N|8', '1061|SECTOR|Y|8', '1061|WEIGHTING|N|4',
    '1061|NEW_CODE|Y|4', '1061|NEW_NAME|N|8', '1061|NEW_SECTOR|Y|8', '1061|NEW_WEIGHTING|N|4',
    -- Tableros: seguimiento y avance financiero en la misma fila
    '1034|MC|Y|4', '1034|SPENT|N|3', '1039|MC|Y|4', '1039|SPENT|N|3', '1044|MC|Y|4', '1044|SPENT|N|3');

  procedure page_process(p_page number, p_seq number, p_name varchar2, p_code varchar2) is
  begin
    wwv_flow_imp_page.create_page_process(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => p_page,
      p_process_sequence => p_seq, p_process_point => 'BEFORE_HEADER', p_process_type => 'NATIVE_PLSQL',
      p_process_name => c_mark || ': ' || p_name, p_process_sql_clob => p_code, p_process_clob_language => 'PLSQL',
      p_error_display_location => 'INLINE_IN_NOTIFICATION');
  end;
begin
  l_ws := apex_util.find_security_group_id(p_workspace => 'SPD');
  apex_util.set_security_group_id(l_ws);
  wwv_flow_imp.import_begin(p_version_yyyy_mm_dd => '2024.11.30', p_release => '24.2.0',
    p_default_workspace_id => l_ws, p_default_application_id => c_app, p_default_id_offset => 0,
    p_default_owner => 'SIIF');

  ---------------------------------------------------------------------------- limpieza (re-ejecutable)
  execute immediate 'delete from wwv_flow_page_da_actions where flow_id = :1 and event_id in
     (select id from wwv_flow_page_da_events where flow_id = :2 and name like ''SPD_G_%'')' using c_app, c_app;
  execute immediate 'delete from wwv_flow_page_da_events where flow_id = :1 and name like ''SPD_G_%''' using c_app;
  execute immediate 'delete from wwv_flow_step_processing where flow_id = :1 and process_name like :2' using c_app, c_mark || '%';
  execute immediate 'delete from wwv_flow_processing where flow_id = :1 and process_name like :2' using c_app, c_mark || '%';
  execute immediate 'delete from wwv_flow_items where flow_id = :1 and name in (''G_PLAN'', ''G_SEGUIMIENTO'')' using c_app;

  ---------------------------------------------------------------------------- 1. compañía oculta
  for i in (select id, name from wwv_flow_step_items
             where flow_id = c_app and flow_step_id between 1000 and 1099
               and (name like 'P____\_NIT\_COMPANIA' escape '\' or name = 'P1060_COMPANIA')
               and display_as <> 'NATIVE_HIDDEN') loop
    execute immediate 'update wwv_flow_step_items
        set display_as = ''NATIVE_HIDDEN'', attributes = to_clob(''{"value_protected":"Y"}''),
            named_lov = null, lov = null, read_only_when = null, read_only_when_type = null
      where id = :1 and flow_id = :2' using i.id, c_app;
    l_n := l_n + 1;
  end loop;
  -- valor por defecto (al crear) siempre de la compañía de la sesión
  update wwv_flow_step_items set item_default = 'G_NIT_COMPANIA', item_default_type = 'ITEM'
   where flow_id = c_app and flow_step_id between 1000 and 1099
     and name like 'P____\_NIT\_COMPANIA' escape '\' and item_default is null;
  dbms_output.put_line('Compañía oculta en ' || l_n || ' formularios');

  ---------------------------------------------------------------------------- 2. G_PLAN y G_SEGUIMIENTO
  wwv_flow_imp_shared.create_flow_item(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_name => 'G_PLAN',
    p_protection_level => 'I', p_item_comment => 'Plan de desarrollo elegido en cualquier lista de plan.');
  wwv_flow_imp_shared.create_flow_item(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_name => 'G_SEGUIMIENTO',
    p_protection_level => 'I', p_item_comment => 'ID de la configuración de seguimiento elegida en cualquier lista de seguimiento.');
  -- G_PLAN inicial: el plan activo de la compañía (o el más reciente). G_SEGUIMIENTO arranca vacío y cada
  -- página de seguimiento toma la configuración activa, que queda como G_SEGUIMIENTO.
  execute immediate 'delete from wwv_flow_computations where flow_id = :1 and computation_item = ''G_PLAN''' using c_app;
  wwv_flow_imp_shared.create_flow_computation(p_id => wwv_flow_id.next_val, p_flow_id => c_app,
    p_computation_sequence => 20, p_computation_item => 'G_PLAN', p_computation_point => 'ON_NEW_INSTANCE',
    p_computation_type => 'QUERY', p_computation_processed => 'REPLACE_EXISTING',
    p_computation => 'select max(PLAN) keep (dense_rank first order by case when SPD_ACTIVO = ''S'' then 0 else 1 end, PLAN desc)'
                  || ' from PLAN_DESARROLLO where NIT_COMPANIA = :G_NIT_COMPANIA',
    p_computation_comment => 'Plan por defecto: el activo de la compañía');

  -- al enviar una página con lista de seguimiento / plan (las listas que envían la página al cambiar)
  wwv_flow_imp_shared.create_flow_process(p_id => wwv_flow_id.next_val, p_flow_id => c_app,
    p_process_sequence => 1, p_process_point => 'ON_SUBMIT_BEFORE_COMPUTATION', p_process_type => 'NATIVE_PLSQL',
    p_process_name => c_mark || ': plan y seguimiento elegidos', p_process_clob_language => 'PLSQL',
    p_process_sql_clob => q'~
begin
  if :APP_PAGE_ID between 1030 and 1044 and v('P' || :APP_PAGE_ID || '_MC') is not null then
    :G_SEGUIMIENTO := v('P' || :APP_PAGE_ID || '_MC');
  end if;
  if :APP_PAGE_ID in (1009, 1010, 1011, 1046) and v('P' || :APP_PAGE_ID || '_PLAN') is not null then
    :G_PLAN := v('P' || :APP_PAGE_ID || '_PLAN');
  end if;
end;~');

  -- páginas de seguimiento: abren con G_SEGUIMIENTO (si es de la compañía) y lo dejan guardado
  for p in (select to_number(column_value) pg from table(apex_string.split(c_mc_pages, ','))) loop
    page_process(p.pg, 1, 'seguimiento elegido', replace(q'~
begin
  select ID into :P#_MC from SPD_MONITORING_CONFIG
   where ID = :G_SEGUIMIENTO and NIT_COMPANIA = :G_NIT_COMPANIA and nvl(USED_FOR, 'DEVELOPMENT_PLANS') = 'DEVELOPMENT_PLANS';
exception when no_data_found or value_error or invalid_number then null;
end;~', '#', p.pg));
    page_process(p.pg, 9999, 'guardar seguimiento', replace(q'~
begin
  if :P#_MC is not null then :G_SEGUIMIENTO := :P#_MC; end if;
end;~', '#', p.pg));
  end loop;

  -- Metas por estructura (1010): abre con G_PLAN y lo deja guardado
  page_process(1010, 1, 'plan elegido', q'~
begin
  select PLAN into :P1010_PLAN from PLAN_DESARROLLO
   where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :G_PLAN and rownum = 1;
exception when no_data_found or value_error or invalid_number then null;
end;~');
  page_process(1010, 9999, 'guardar plan', q'~
begin
  if :P1010_PLAN is not null then :G_PLAN := :P1010_PLAN; end if;
end;~');

  -- formularios: al crear, el plan por defecto es G_PLAN; al cambiar la lista se actualiza G_PLAN
  for p in (select column_value pg from table(apex_string.split('1009,1011,1046', ','))) loop
    update wwv_flow_step_items set item_default = 'G_PLAN', item_default_type = 'ITEM'
     where flow_id = c_app and name = 'P' || p.pg || '_PLAN';
    l_evt := wwv_flow_id.next_val;
    wwv_flow_imp_page.create_page_da_event(p_id => l_evt, p_flow_id => c_app, p_page_id => to_number(p.pg),
      p_name => 'SPD_G_PLAN', p_event_sequence => 900, p_triggering_element_type => 'ITEM',
      p_triggering_element => 'P' || p.pg || '_PLAN', p_bind_type => 'bind', p_execution_type => 'IMMEDIATE',
      p_bind_event_type => 'change');
    wwv_flow_imp_page.create_page_da_action(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_page_id => to_number(p.pg),
      p_event_id => l_evt, p_event_result => 'TRUE', p_action_sequence => 10, p_execute_on_page_init => 'N',
      p_action => 'NATIVE_EXECUTE_PLSQL_CODE',
      p_attribute_01 => 'if :P' || p.pg || '_PLAN is not null then :G_PLAN := :P' || p.pg || '_PLAN; end if;',
      p_attribute_02 => 'P' || p.pg || '_PLAN', p_attribute_05 => 'PLSQL', p_wait_for_result => 'Y');
  end loop;

  ---------------------------------------------------------------------------- 3. filas de los formularios
  for i in 1 .. l_layout.count loop
    declare
      a apex_t_varchar2 := apex_string.split(l_layout(i), '|');
    begin
      update wwv_flow_step_items
         set begin_on_new_line = a(3), new_grid = 'N', grid_column = null,
             colspan = to_number(a(4)), item_sequence = 1000 + i * 10
       where flow_id = c_app and flow_step_id = to_number(a(1)) and name = 'P' || a(1) || '_' || a(2);
      if sql%rowcount = 0 then
        dbms_output.put_line('  (no existe) P' || a(1) || '_' || a(2));
      end if;
      l_lay := l_lay + sql%rowcount;
    end;
  end loop;
  dbms_output.put_line('Campos reubicados: ' || l_lay);
  -- listas de selección con altura > 1 se pintan como caja de lista (p. ej. "Unidad medida")
  update wwv_flow_step_items set cheight = null
   where flow_id = c_app and flow_step_id between 1000 and 1099
     and display_as = 'NATIVE_SELECT_LIST' and cheight > 1;
  dbms_output.put_line('Listas de selección corregidas: ' || sql%rowcount);

  wwv_flow_imp.import_end(p_auto_install_sup_obj => false);
  commit;
  dbms_output.put_line('FORMS OK (compañía oculta, G_PLAN, G_SEGUIMIENTO, filas de formularios)');
end;
/
exit
