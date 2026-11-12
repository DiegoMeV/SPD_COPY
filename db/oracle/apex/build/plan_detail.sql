-- Plan de desarrollo: el formulario pasa de drawer (modal) a página normal, con la grilla "Niveles"
-- (definición de niveles del plan en SPD_CONFIG.levels), como el formulario del original.
-- Se ejecuta como APEX_240100 después de postprocess.sql (o sobre la app ya importada).
set serveroutput on size unlimited
set define off
whenever sqlerror exit failure

declare
  c_app      constant number := 100;
  l_sgid     number;
  l_form     number;   -- página del formulario
  l_ir       number;   -- página del reporte
  l_form_plg number;
  l_btn_plg  number;
  l_ig_plg   number;
  l_ig       number;
  l_rpt      number;
  l_view     number;
  l_tpl_std  number;
  l_tpl_ir   number;
  l_seq      pls_integer := 0;
  p          varchar2(30);  -- prefijo de ítems (P7_)

  type t_ids is table of number index by varchar2(30);
  l_col t_ids;

  procedure col(p_name varchar2, p_type varchar2, p_label varchar2, p_data_type varchar2 default 'VARCHAR2',
                p_required boolean default false, p_pk boolean default false, p_lov varchar2 default null,
                p_default_item varchar2 default null, p_default_static varchar2 default null,
                p_max_length number default null, p_align varchar2 default 'LEFT') is
    l_id number := wwv_flow_id.next_val;
  begin
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_region_column(
      p_id => l_id, p_flow_id => c_app, p_page_id => l_form, p_region_id => l_ig_plg,
      p_name => p_name, p_source_type => 'DB_COLUMN', p_source_expression => p_name,
      p_data_type => p_data_type, p_session_state_data_type => 'VARCHAR2',
      p_is_query_only => false, p_item_type => p_type,
      p_heading => p_label, p_label => p_label,
      p_heading_alignment => p_align, p_value_alignment => p_align, p_display_sequence => 20 + l_seq,
      p_attribute_01 => case p_type when 'NATIVE_HIDDEN' then 'Y' when 'NATIVE_TEXT_FIELD' then 'N' when 'NATIVE_DISPLAY_ONLY' then 'Y'
                                    when 'NATIVE_SELECT_LIST' then 'NONE' when 'NATIVE_YES_NO' then 'N' end,
      p_attribute_02 => case p_type when 'NATIVE_TEXT_FIELD' then 'N' when 'NATIVE_YES_NO' then 'S' when 'NATIVE_DISPLAY_ONLY' then 'VALUE' end,
      p_attribute_03 => case p_type when 'NATIVE_TEXT_FIELD' then 'N' when 'NATIVE_SELECT_LIST' then 'Y'
                                    when 'NATIVE_NUMBER_FIELD' then 'right' when 'NATIVE_YES_NO' then 'Sí' end,
      p_attribute_04 => case p_type when 'NATIVE_TEXT_FIELD' then 'TEXT' when 'NATIVE_NUMBER_FIELD' then 'decimal'
                                    when 'NATIVE_YES_NO' then 'N' end,
      p_attribute_05 => case p_type when 'NATIVE_TEXT_FIELD' then 'BOTH' when 'NATIVE_YES_NO' then 'No' when 'NATIVE_DISPLAY_ONLY' then 'PLAIN' end,
      p_is_required => p_required, p_max_length => p_max_length,
      p_lov_type => case when p_lov is not null then 'SQL_QUERY' end, p_lov_source => p_lov,
      p_lov_display_null => p_lov is not null, p_lov_display_extra => p_lov is not null,
      p_ajax_items_to_submit => case when p_lov is not null then p || 'NIT_COMPANIA,' || p || 'PLAN' end,
      p_default_type => case when p_default_item is not null then 'ITEM' when p_default_static is not null then 'STATIC' end,
      p_default_expression => coalesce(p_default_item, p_default_static),
      p_enable_filter => not p_pk, p_filter_is_required => false,
      p_filter_lov_type => case when p_lov is not null then 'LOV' else 'NONE' end,
      p_use_as_row_header => false, p_enable_sort_group => true, p_enable_control_break => false,
      p_enable_hide => true, p_enable_pivot => false, p_is_primary_key => p_pk,
      p_duplicate_value => not p_pk, p_include_in_export => true);
    l_col(p_name) := l_id;
  end;

  procedure special_col(p_name varchar2, p_type varchar2, p_seq number, p_label varchar2 default null) is
  begin
    wwv_flow_imp_page.create_region_column(
      p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_page_id => l_form, p_region_id => l_ig_plg,
      p_name => p_name, p_item_type => p_type, p_label => p_label, p_display_sequence => p_seq,
      p_heading_alignment => 'CENTER', p_value_alignment => 'CENTER',
      p_attribute_01 => case p_type when 'NATIVE_ROW_SELECTOR' then 'Y' end,
      p_attribute_02 => case p_type when 'NATIVE_ROW_SELECTOR' then 'Y' end,
      p_attribute_03 => case p_type when 'NATIVE_ROW_SELECTOR' then 'N' end,
      p_enable_hide => true, p_is_primary_key => false);
  end;

  procedure rpt_col(p_name varchar2, p_seq number, p_visible boolean default true,
                    p_sort_order number default null) is
  begin
    wwv_flow_imp_page.create_ig_report_column(
      p_id => wwv_flow_id.next_val, p_view_id => l_view, p_display_seq => p_seq,
      p_column_id => l_col(p_name), p_is_visible => p_visible, p_is_frozen => false,
      p_sort_order => p_sort_order, p_sort_direction => case when p_sort_order is not null then 'ASC' end);
  end;
begin
  l_sgid := apex_util.find_security_group_id(p_workspace => 'SPD');
  wwv_flow_security.g_security_group_id := l_sgid;
  wwv_flow_imp.import_begin(p_version_yyyy_mm_dd => '2024.05.31', p_release => '24.1.0',
    p_default_workspace_id => l_sgid, p_default_application_id => c_app, p_default_id_offset => 0,
    p_default_owner => 'SIIF');

  select page_id, id into l_form, l_form_plg from wwv_flow_page_plugs
   where flow_id = c_app and plug_source_type = 'NATIVE_FORM' and query_table = 'PLAN_DESARROLLO';
  p := 'P' || l_form || '_';

  -- la página del reporte es la que tiene el botón "Crear" hacia el formulario
  select min(flow_step_id) into l_ir from wwv_flow_step_buttons
   where flow_id = c_app and flow_step_id <> l_form and button_redirect_url like 'f?p=&APP_ID.:' || l_form || ':%';

  -- la región Buttons ya no existe si ui_standard.sql movió los botones al Breadcrumb Global
  select max(id) into l_btn_plg from wwv_flow_page_plugs
   where flow_id = c_app and page_id = l_form and plug_source_type = 'NATIVE_STATIC' and plug_name = 'Buttons';
  select id into l_tpl_std from wwv_flow_page_plug_templates where flow_id = c_app and page_plug_template_name = 'Standard';
  select id into l_tpl_ir  from wwv_flow_page_plug_templates where flow_id = c_app and page_plug_template_name = 'Interactive Report';

  -- re-ejecutable: quita lo que haya creado una ejecución anterior
  delete from wwv_flow_step_processing where flow_id = c_app and flow_step_id = l_form
     and (process_type = 'NATIVE_IG_DML' or process_name = 'Renumerar niveles del plan');
  delete from wwv_flow_step_branches   where flow_id = c_app and flow_step_id = l_form;
  delete from wwv_flow_page_plugs      where flow_id = c_app and page_id = l_form and plug_source_type = 'NATIVE_IG';

  -----------------------------------------------------------------------------
  -- Página normal en lugar de drawer
  -----------------------------------------------------------------------------
  update wwv_flow_steps
     set page_mode = 'NORMAL', step_template = null, page_template_options = '#DEFAULT#',
         dialog_chained = 'Y', dialog_width = null, dialog_height = null
   where flow_id = c_app and id = l_form;

  update wwv_flow_page_plugs set plug_template = l_tpl_std, plug_display_sequence = 10
   where id = l_form_plg and flow_id = c_app;
  -- botones debajo del formulario (la posición del pie del diálogo no existe en una página normal)
  update wwv_flow_page_plugs set plug_display_point = 'BODY', plug_display_sequence = 20
   where id = l_btn_plg and flow_id = c_app;

  -- Cancelar vuelve al reporte (antes cerraba el diálogo con una acción dinámica)
  update wwv_flow_step_buttons
     set button_action = 'REDIRECT_PAGE',
         button_redirect_url = 'f?p=&APP_ID.:' || l_ir || ':&APP_SESSION.::&DEBUG.:::'
   where flow_id = c_app and flow_step_id = l_form and button_name = 'CANCEL';
  delete from wwv_flow_page_da_actions
   where flow_id = c_app and event_id in (select id from wwv_flow_page_da_events
                                           where flow_id = c_app and page_id = l_form and name = 'Cancel Dialog');
  delete from wwv_flow_page_da_events where flow_id = c_app and page_id = l_form and name = 'Cancel Dialog';
  delete from wwv_flow_step_processing
   where flow_id = c_app and flow_step_id = l_form and process_type = 'NATIVE_CLOSE_WINDOW';

  -- al crear se queda en el plan (para cargar sus niveles); al guardar o eliminar vuelve al reporte
  wwv_flow_imp_page.create_page_branch(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => l_form,
    p_branch_name => 'Ir al plan creado', p_branch_point => 'AFTER_PROCESSING', p_branch_type => 'REDIRECT_URL',
    p_branch_action => 'f?p=&APP_ID.:' || l_form || ':&APP_SESSION.::&DEBUG.:' || l_form || ':'
                       || p || 'NIT_COMPANIA,' || p || 'PLAN:&' || p || 'NIT_COMPANIA.,&' || p || 'PLAN.&success_msg=#SUCCESS_MSG#',
    p_branch_sequence => 10, p_branch_condition_type => 'REQUEST_EQUALS_CONDITION', p_branch_condition => 'CREATE');
  wwv_flow_imp_page.create_page_branch(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => l_form,
    p_branch_name => 'Volver al reporte', p_branch_point => 'AFTER_PROCESSING', p_branch_type => 'REDIRECT_URL',
    p_branch_action => 'f?p=&APP_ID.:' || l_ir || ':&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#',
    p_branch_sequence => 20);

  -----------------------------------------------------------------------------
  -- Grilla "Niveles": definición de niveles del plan (SPD_CONFIG.levels), como en el formulario
  -- original (DevPlanLevelForm.tsx): Nivel, Nombre Singular, Nombre Plural, Tipo de meta, Asocia sector DNP.
  -- Los nodos del árbol (SPD_DEV_PLAN_LEVEL) se administran en la página Estructura.
  -- Se guarda con el botón del formulario: la grilla escribe el JSON fila por fila y luego se renumera 1..n.
  -----------------------------------------------------------------------------
  -- el formulario no debe escribir SPD_CONFIG (lo escribe la grilla)
  delete from wwv_flow_step_items where flow_id = c_app and flow_step_id = l_form and name = p || 'SPD_CONFIG';

  l_ig_plg := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_page_plug(p_id => l_ig_plg, p_flow_id => c_app, p_page_id => l_form,
    p_plug_name => 'Niveles', p_region_template_options => '#DEFAULT#',
    p_plug_template => l_tpl_std, p_plug_display_sequence => 15, p_plug_display_point => 'BODY',
    p_query_type => 'SQL', p_include_rowid_column => false,
    p_plug_source => 'select NUM, SINGULAR_NAME, PLURAL_NAME, GOAL_TYPE, IS_SECTOR from V_SPD_PLAN_LEVEL_CONFIG '
                  || 'where NIT_COMPANIA = :' || p || 'NIT_COMPANIA and PLAN = :' || p || 'PLAN',
    p_query_order_by_type => 'STATIC', p_query_order_by => 'NUM',
    p_ajax_items_to_submit => p || 'NIT_COMPANIA,' || p || 'PLAN',
    p_plug_source_type => 'NATIVE_IG', p_prn_page_header => 'Niveles',
    p_plug_display_condition_type => 'ITEM_IS_NOT_NULL', p_plug_display_when_condition => p || 'ID');

  special_col('APEX$ROW_SELECTOR', 'NATIVE_ROW_SELECTOR', 10);
  special_col('APEX$ROW_ACTION',   'NATIVE_ROW_ACTION',   20, 'Acciones');
  col('NUM', 'NATIVE_DISPLAY_ONLY', 'Nivel', 'NUMBER', p_pk => true, p_align => 'CENTER');
  col('SINGULAR_NAME', 'NATIVE_TEXT_FIELD', 'Nombre Singular', p_required => true, p_max_length => 200);
  col('PLURAL_NAME', 'NATIVE_TEXT_FIELD', 'Nombre Plural', p_required => true, p_max_length => 200);
  col('GOAL_TYPE', 'NATIVE_SELECT_LIST', 'Tipo de meta',
      p_lov => 'select DISPLAY_VALUE d, RETURN_VALUE r from APEX_APPLICATION_LOV_ENTRIES '
            || 'where APPLICATION_ID = :APP_ID and LIST_OF_VALUES_NAME = ''SPD - TIPO DE META'' order by DISPLAY_SEQUENCE');
  col('IS_SECTOR', 'NATIVE_YES_NO', 'Asocia sector DNP?', p_required => true, p_default_static => 'N', p_align => 'CENTER');

  l_ig := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_interactive_grid(p_id => l_ig, p_flow_id => c_app, p_page_id => l_form,
    p_region_id => l_ig_plg, p_internal_uid => l_ig,
    p_is_editable => true, p_edit_operations => 'i:u:d', p_lost_update_check_type => null,
    p_add_row_if_empty => true, p_submit_checked_rows => false, p_lazy_loading => false,
    p_requires_filter => false, p_select_first_row => false, p_fixed_row_height => true,
    p_pagination_type => 'SET', p_show_total_row_count => false, p_show_toolbar => true,
    p_toolbar_buttons => null,
    p_enable_save_public_report => false, p_enable_subscriptions => false, p_enable_flashback => false,
    p_define_chart_view => false, p_enable_download => false, p_enable_mail_download => false,
    p_fixed_header => 'NONE', p_show_icon_view => false, p_show_detail_view => false);

  l_rpt := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_ig_report(p_id => l_rpt, p_flow_id => c_app, p_page_id => l_form,
    p_interactive_grid_id => l_ig, p_static_id => to_char(l_rpt), p_type => 'PRIMARY',
    p_default_view => 'GRID', p_rows_per_page => 20, p_show_row_number => false,
    p_settings_area_expanded => false);
  l_view := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_ig_report_view(p_id => l_view, p_flow_id => c_app, p_page_id => l_form,
    p_report_id => l_rpt, p_view_type => 'GRID', p_srv_exclude_null_values => false,
    p_srv_only_display_columns => true, p_edit_mode => true);
  rpt_col('NUM', 1, p_sort_order => 1);
  rpt_col('SINGULAR_NAME', 2);
  rpt_col('PLURAL_NAME', 3);
  rpt_col('GOAL_TYPE', 4);
  rpt_col('IS_SECTOR', 5);

  -- cada fila modifica el arreglo SPD_CONFIG.levels (clave: el número de nivel original)
  wwv_flow_imp_page.create_page_process(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => l_form,
    p_process_sequence => 20, p_process_point => 'AFTER_SUBMIT', p_region_id => l_ig_plg,
    p_process_type => 'NATIVE_IG_DML', p_process_name => 'Guardar niveles del plan',
    p_attribute_01 => 'PLSQL_CODE', p_attribute_05 => 'N', p_attribute_06 => 'N', p_attribute_08 => 'Y',
    p_attribute_04 => replace(q'~
declare
  l_doc    clob;
  l_cfg    json_object_t;
  l_levels json_array_t;
  l_new    json_array_t := json_array_t();
  l_lvl    json_object_t;
  l_max    number := 0;
  procedure set_fields(o in out nocopy json_object_t) is
  begin
    o.put('singularName', :SINGULAR_NAME);
    o.put('pluralName', :PLURAL_NAME);
    if :GOAL_TYPE is null then o.remove('goalType'); else o.put('goalType', :GOAL_TYPE); end if;
    o.put('isSectorLevel', :IS_SECTOR = 'S');
  end;
begin
  select SPD_CONFIG into l_doc from PLAN_DESARROLLO
   where NIT_COMPANIA = :#P#NIT_COMPANIA and PLAN = :#P#PLAN for update;
  if l_doc is null then l_cfg := json_object_t(); else l_cfg := json_object_t.parse(l_doc); end if;
  if l_cfg.has('levels') then l_levels := l_cfg.get_array('levels'); else l_levels := json_array_t(); end if;
  for i in 0 .. l_levels.get_size - 1 loop
    l_lvl := json_object_t.parse(l_levels.get(i).to_clob);
    l_max := greatest(l_max, nvl(l_lvl.get_number('number'), 0));
    if :APEX$ROW_STATUS in ('U', 'D') and l_lvl.get_number('number') = :NUM then
      if :APEX$ROW_STATUS = 'U' then set_fields(l_lvl); l_new.append(l_lvl); end if;
    else
      l_new.append(l_lvl);
    end if;
  end loop;
  if :APEX$ROW_STATUS = 'C' then
    l_lvl := json_object_t();
    l_lvl.put('number', l_max + 1);
    set_fields(l_lvl);
    l_new.append(l_lvl);
    :NUM := l_max + 1;
  end if;
  l_cfg.put('levels', l_new);
  l_doc := l_cfg.to_clob;
  update PLAN_DESARROLLO set SPD_CONFIG = l_doc
   where NIT_COMPANIA = :#P#NIT_COMPANIA and PLAN = :#P#PLAN;
end;~', '#P#', p),
    p_error_display_location => 'INLINE_IN_NOTIFICATION');

  -- después de procesar todas las filas: numeración consecutiva 1..n, como el original
  wwv_flow_imp_page.create_page_process(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => l_form,
    p_process_sequence => 30, p_process_point => 'AFTER_SUBMIT', p_process_type => 'NATIVE_PLSQL',
    p_process_name => 'Renumerar niveles del plan', p_process_clob_language => 'PLSQL',
    p_process_sql_clob => replace(q'~
declare
  l_doc clob;
  l_cfg json_object_t;
  l_arr json_array_t;
  l_new json_array_t := json_array_t();
  l_obj json_object_t;
begin
  select SPD_CONFIG into l_doc from PLAN_DESARROLLO where NIT_COMPANIA = :#P#NIT_COMPANIA and PLAN = :#P#PLAN;
  if l_doc is null then return; end if;
  l_cfg := json_object_t.parse(l_doc);
  if not l_cfg.has('levels') then return; end if;
  l_arr := l_cfg.get_array('levels');
  for r in (select jt.POS from json_table(l_doc, '$.levels[*]' columns (POS for ordinality, NUM number path '$.number')) jt
             order by jt.NUM nulls last, jt.POS) loop
    l_obj := json_object_t.parse(l_arr.get(r.POS - 1).to_clob);
    l_obj.put('number', l_new.get_size + 1);
    l_new.append(l_obj);
  end loop;
  l_cfg.put('levels', l_new);
  l_doc := l_cfg.to_clob;
  update PLAN_DESARROLLO set SPD_CONFIG = l_doc where NIT_COMPANIA = :#P#NIT_COMPANIA and PLAN = :#P#PLAN;
exception when no_data_found then null;
end;~', '#P#', p),
    p_process_when_type => 'REQUEST_EQUALS_CONDITION', p_process_when => 'SAVE');

  wwv_flow_imp.import_end(p_auto_install_sup_obj => false);
  commit;
  dbms_output.put_line('PLAN DETALLE OK (formulario ' || l_form || ', reporte ' || l_ir || ')');
end;
/
exit
