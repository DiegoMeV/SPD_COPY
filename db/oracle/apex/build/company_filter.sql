-- Compañía activa: ítem de aplicación G_NIT_COMPANIA (por defecto Municipio de Palmira) y filtro por
-- NIT_COMPANIA en reportes, grillas, gráficos y listas de valores. Los formularios toman la compañía
-- activa como valor por defecto. Se ejecuta como APEX_240100 después de plan_pages.sql. Es re-ejecutable.
set serveroutput on size unlimited
set define off
whenever sqlerror exit failure

declare
  c_app   constant number := 100;
  c_nit   constant varchar2(20) := '8913800073';   -- Municipio de Palmira
  c_cond  constant varchar2(100) := 'NIT_COMPANIA = :G_NIT_COMPANIA';
  l_sgid  number;
  l_n     pls_integer := 0;

  function has_nit(p_table varchar2) return boolean is
    l_c number;
  begin
    select count(*) into l_c from sys.dba_tab_columns
     where owner = 'SIIF' and table_name = p_table and column_name = 'NIT_COMPANIA';
    return l_c > 0;
  end;

  procedure add_where(p_plug number, p_cond varchar2) is
  begin
    update wwv_flow_page_plugs
       set query_where = case when query_where is null then p_cond
                              else '(' || query_where || ') and ' || p_cond end
     where id = p_plug and flow_id = c_app
       and (query_where is null or instr(query_where, ':G_NIT_COMPANIA') = 0);
    l_n := l_n + sql%rowcount;
  end;
begin
  l_sgid := apex_util.find_security_group_id(p_workspace => 'SPD');
  wwv_flow_security.g_security_group_id := l_sgid;
  wwv_flow_imp.import_begin(p_version_yyyy_mm_dd => '2024.05.31', p_release => '24.1.0',
    p_default_workspace_id => l_sgid, p_default_application_id => c_app, p_default_id_offset => 0,
    p_default_owner => 'SIIF');

  -----------------------------------------------------------------------------
  -- Ítem de aplicación + valor inicial en cada sesión nueva
  -----------------------------------------------------------------------------
  delete from wwv_flow_computations where flow_id = c_app and computation_item = 'G_NIT_COMPANIA';
  delete from wwv_flow_items where flow_id = c_app and name = 'G_NIT_COMPANIA';
  wwv_flow_imp_shared.create_flow_item(p_id => wwv_flow_id.next_val, p_flow_id => c_app,
    p_name => 'G_NIT_COMPANIA', p_protection_level => 'I',
    p_item_comment => 'NIT de la compañía activa; filtra los datos de toda la aplicación. Por defecto: Municipio de Palmira.');
  wwv_flow_imp_shared.create_flow_computation(p_id => wwv_flow_id.next_val, p_flow_id => c_app,
    p_computation_sequence => 10, p_computation_item => 'G_NIT_COMPANIA', p_computation_point => 'ON_NEW_INSTANCE',
    p_computation_type => 'STATIC_ASSIGNMENT', p_computation_processed => 'REPLACE_EXISTING',
    p_computation => c_nit, p_computation_comment => 'Compañía por defecto: Municipio de Palmira');

  -----------------------------------------------------------------------------
  -- Reportes y grillas sobre tablas / vistas con NIT_COMPANIA
  -----------------------------------------------------------------------------
  for r in (select id, query_table from wwv_flow_page_plugs
             where flow_id = c_app and query_type = 'TABLE' and plug_source_type in ('NATIVE_IR', 'NATIVE_IG')) loop
    if has_nit(r.query_table) then
      add_where(r.id, c_cond);
    elsif r.query_table = 'SPD_GOAL_HISTORY' then
      add_where(r.id, 'GOAL_ID in (select ID from SPD_GOAL where ' || c_cond || ')');
    elsif r.query_table = 'SPD_MONITORING_RECORD' then
      add_where(r.id, 'MONITORING_CONFIG_ID in (select ID from SPD_MONITORING_CONFIG where ' || c_cond || ')');
    elsif r.query_table = 'SPD_PUBLIC_POLITIC_TO_COMP' then
      add_where(r.id, 'PUBLIC_POLITIC_ID in (select ID from SPD_PUBLIC_POLITIC where ' || c_cond || ')');
    end if;
  end loop;

  -- reportes sobre consultas SQL que devuelven NIT_COMPANIA (seguimiento, proyectos, planes de acción)
  for r in (select p.id, p.plug_source from wwv_flow_page_plugs p join wwv_flow_worksheets w on w.region_id = p.id
             where p.flow_id = c_app and p.query_type = 'SQL' and p.plug_source_type = 'NATIVE_IR'
               and exists (select 1 from wwv_flow_worksheet_columns c where c.worksheet_id = w.id and c.db_column_name = 'NIT_COMPANIA')
               and dbms_lob.instr(p.plug_source, ':G_NIT_COMPANIA') = 0) loop
    update wwv_flow_page_plugs
       set plug_source = 'select * from (' || chr(10) || r.plug_source || chr(10) || ') where ' || c_cond
     where id = r.id and flow_id = c_app;
    l_n := l_n + 1;
  end loop;

  -- gráficos de los tableros (vistas V_SPD_* con NIT_COMPANIA)
  for r in (select s.id, s.data_source from wwv_flow_jet_chart_series s
             where s.flow_id = c_app and s.data_source_type = 'SQL'
               and dbms_lob.instr(s.data_source, ':G_NIT_COMPANIA') = 0
               and regexp_like(s.data_source, 'from\s+V_SPD_\w+\s+group', 'i')) loop
    update wwv_flow_jet_chart_series
       set data_source = regexp_replace(r.data_source, '(from\s+V_SPD_\w+)\s+(group)', '\1 where ' || c_cond || ' \2', 1, 1, 'i')
     where id = r.id;
    l_n := l_n + 1;
  end loop;

  -----------------------------------------------------------------------------
  -- Listas de valores: solo datos de la compañía activa
  -----------------------------------------------------------------------------
  for l in (select id, query_table, query_where from wwv_flow_lists_of_values$
             where flow_id = c_app and query_table is not null) loop
    if has_nit(l.query_table) and (l.query_where is null or instr(l.query_where, ':G_NIT_COMPANIA') = 0) then
      update wwv_flow_lists_of_values$
         set query_where = case when query_where is null then c_cond else '(' || query_where || ') and ' || c_cond end
       where id = l.id;
      l_n := l_n + 1;
    end if;
  end loop;

  -----------------------------------------------------------------------------
  -- Formularios y grillas: la compañía activa como valor por defecto
  -----------------------------------------------------------------------------
  update wwv_flow_step_items i
     set item_default = 'G_NIT_COMPANIA', item_default_type = 'ITEM'
   where flow_id = c_app and regexp_like(name, '^P[0-9]+_NIT_COMPANIA$')
     and exists (select 1 from wwv_flow_page_plugs p where p.id = i.item_plug_id and p.plug_source_type = 'NATIVE_FORM');
  update wwv_flow_region_columns c
     set default_type = 'ITEM', default_expression = 'G_NIT_COMPANIA'
   where flow_id = c_app and name = 'NIT_COMPANIA' and default_type is null;

  -- Formulario de metas: "Nivel del plan" en cascada con el plan elegido (refresco nativo de APEX)
  for i in (select l.id, l.flow_step_id pg from wwv_flow_step_items l
             where l.flow_id = c_app and regexp_like(l.name, '^P[0-9]+_DEV_PLAN_LEVEL_ID$')
               and exists (select 1 from wwv_flow_step_items pl where pl.flow_id = c_app
                            and pl.flow_step_id = l.flow_step_id and pl.name = 'P' || l.flow_step_id || '_PLAN')) loop
    update wwv_flow_step_items
       set named_lov = null,
           lov = 'select NAME d, ID r from V_SPD_LOV_DEV_PLAN_LEVEL where ' || c_cond
                 || ' and PLAN = :P' || i.pg || '_PLAN order by NAME',
           lov_cascade_parent_items = 'P' || i.pg || '_PLAN', ajax_optimize_refresh = 'Y',
           ajax_items_to_submit = null
     where id = i.id and flow_id = c_app;
  end loop;

  wwv_flow_imp.import_end(p_auto_install_sup_obj => false);
  commit;
  dbms_output.put_line('COMPANIA OK (' || l_n || ' filtros)');
end;
/
exit
