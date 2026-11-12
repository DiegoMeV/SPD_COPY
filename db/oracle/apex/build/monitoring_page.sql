-- Configuración de seguimiento: el formulario pasa de drawer (modal) a página normal y se agrega la
-- tabla "Colores de Indicadores" (SPD_MONITORING_CONFIG.COLORS_CONFIG), como en el original
-- (client/components/MonitoringConfig/MonitoringConfigColorsForm.tsx): Desde, Incluye desde?, Hasta,
-- Incluye hasta?, Color, Etiqueta. Debajo, la barra de colores (MonitoringConfigColors.tsx).
-- Se ejecuta como APEX_240100 después de goals_pages.sql. Es re-ejecutable.
set serveroutput on size unlimited
set define off
whenever sqlerror exit failure

declare
  c_app      constant number := 100;
  l_sgid     number;
  l_form     number;
  l_ir       number;
  l_form_plg number;
  l_btn_plg  number;
  l_ig_plg   number;
  l_ig       number;
  l_rpt      number;
  l_view     number;
  l_tpl_std  number;
  l_ft_above number;
  l_seq      pls_integer := 0;
  p          varchar2(30);
  type t_ids is table of number index by varchar2(30);
  l_col t_ids;

  procedure col(p_name varchar2, p_type varchar2, p_label varchar2, p_data_type varchar2 default 'VARCHAR2',
                p_required boolean default false, p_pk boolean default false,
                p_default_static varchar2 default null, p_max_length number default null,
                p_align varchar2 default 'LEFT') is
    l_id number := wwv_flow_id.next_val;
  begin
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_region_column(
      p_id => l_id, p_flow_id => c_app, p_page_id => l_form, p_region_id => l_ig_plg,
      p_name => p_name, p_source_type => 'DB_COLUMN', p_source_expression => p_name,
      p_data_type => p_data_type, p_session_state_data_type => 'VARCHAR2', p_is_query_only => false,
      p_item_type => p_type, p_heading => p_label, p_label => p_label,
      p_heading_alignment => p_align, p_value_alignment => p_align, p_display_sequence => 20 + l_seq,
      p_attribute_01 => case p_type when 'NATIVE_HIDDEN' then 'Y' when 'NATIVE_TEXT_FIELD' then 'N'
                                    when 'NATIVE_YES_NO' then 'N' when 'NATIVE_COLOR_PICKER' then 'Y' end,
      p_attribute_02 => case p_type when 'NATIVE_TEXT_FIELD' then 'N' when 'NATIVE_YES_NO' then 'S' end,
      p_attribute_03 => case p_type when 'NATIVE_TEXT_FIELD' then 'N' when 'NATIVE_NUMBER_FIELD' then 'right'
                                    when 'NATIVE_YES_NO' then 'Sí' end,
      p_attribute_04 => case p_type when 'NATIVE_TEXT_FIELD' then 'TEXT' when 'NATIVE_NUMBER_FIELD' then 'decimal'
                                    when 'NATIVE_YES_NO' then 'N' end,
      p_attribute_05 => case p_type when 'NATIVE_TEXT_FIELD' then 'BOTH' when 'NATIVE_YES_NO' then 'No' end,
      p_is_required => p_required, p_max_length => p_max_length,
      p_default_type => case when p_default_static is not null then 'STATIC' end,
      p_default_expression => p_default_static,
      p_enable_filter => false, p_filter_is_required => false, p_filter_lov_type => 'NONE',
      p_use_as_row_header => false, p_enable_sort_group => false, p_enable_control_break => false,
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

  procedure rpt_col(p_name varchar2, p_seq number, p_visible boolean default true, p_sort boolean default false) is
  begin
    wwv_flow_imp_page.create_ig_report_column(
      p_id => wwv_flow_id.next_val, p_view_id => l_view, p_display_seq => p_seq,
      p_column_id => l_col(p_name), p_is_visible => p_visible, p_is_frozen => false,
      p_sort_order => case when p_sort then 1 end, p_sort_direction => case when p_sort then 'ASC' end);
  end;
begin
  l_sgid := apex_util.find_security_group_id(p_workspace => 'SPD');
  wwv_flow_security.g_security_group_id := l_sgid;
  wwv_flow_imp.import_begin(p_version_yyyy_mm_dd => '2024.05.31', p_release => '24.1.0',
    p_default_workspace_id => l_sgid, p_default_application_id => c_app, p_default_id_offset => 0,
    p_default_owner => 'SIIF');

  select page_id, id into l_form, l_form_plg from wwv_flow_page_plugs
   where flow_id = c_app and plug_source_type = 'NATIVE_FORM' and query_table = 'SPD_MONITORING_CONFIG';
  p := 'P' || l_form || '_';
  select min(flow_step_id) into l_ir from wwv_flow_step_buttons
   where flow_id = c_app and flow_step_id <> l_form and button_redirect_url like 'f?p=&APP_ID.:' || l_form || ':%';
  -- la región Buttons ya no existe si ui_standard.sql movió los botones al Breadcrumb Global
  select max(id) into l_btn_plg from wwv_flow_page_plugs
   where flow_id = c_app and page_id = l_form and plug_source_type = 'NATIVE_STATIC' and plug_name = 'Buttons';
  select id into l_tpl_std  from wwv_flow_page_plug_templates where flow_id = c_app and page_plug_template_name = 'Standard';
  select id into l_ft_above from wwv_flow_field_templates where flow_id = c_app and template_name = 'Optional - Above';

  -- re-ejecutable
  delete from wwv_flow_step_processing where flow_id = c_app and flow_step_id = l_form
     and (process_type = 'NATIVE_IG_DML' or process_name in ('Colores: quitar eliminados', 'Colores: vista previa'));
  delete from wwv_flow_step_branches where flow_id = c_app and flow_step_id = l_form;
  delete from wwv_flow_step_items where flow_id = c_app and flow_step_id = l_form and name = p || 'COLORS_PREVIEW';
  delete from wwv_flow_page_plugs where flow_id = c_app and page_id = l_form and plug_source_type = 'NATIVE_IG';

  -----------------------------------------------------------------------------
  -- Página normal en lugar de drawer
  -----------------------------------------------------------------------------
  update wwv_flow_steps
     set page_mode = 'NORMAL', step_template = null, page_template_options = '#DEFAULT#',
         dialog_chained = 'Y', dialog_width = null, dialog_height = null
   where flow_id = c_app and id = l_form;
  update wwv_flow_page_plugs set plug_template = l_tpl_std, plug_display_sequence = 10
   where id = l_form_plg and flow_id = c_app;
  update wwv_flow_page_plugs set plug_display_point = 'BODY', plug_display_sequence = 40
   where id = l_btn_plg and flow_id = c_app;
  update wwv_flow_step_buttons
     set button_action = 'REDIRECT_PAGE', button_redirect_url = 'f?p=&APP_ID.:' || l_ir || ':&APP_SESSION.::&DEBUG.:::'
   where flow_id = c_app and flow_step_id = l_form and button_name = 'CANCEL';
  delete from wwv_flow_page_da_actions
   where flow_id = c_app and event_id in (select id from wwv_flow_page_da_events
                                           where flow_id = c_app and page_id = l_form and name = 'Cancel Dialog');
  delete from wwv_flow_page_da_events where flow_id = c_app and page_id = l_form and name = 'Cancel Dialog';
  delete from wwv_flow_step_processing
   where flow_id = c_app and flow_step_id = l_form and process_type = 'NATIVE_CLOSE_WINDOW';
  wwv_flow_imp_page.create_page_branch(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => l_form,
    p_branch_name => 'Volver al reporte', p_branch_point => 'AFTER_PROCESSING', p_branch_type => 'REDIRECT_URL',
    p_branch_action => 'f?p=&APP_ID.:' || l_ir || ':&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#',
    p_branch_sequence => 10);

  -- el formulario no debe escribir COLORS_CONFIG (lo escribe la grilla)
  delete from wwv_flow_step_items where flow_id = c_app and flow_step_id = l_form and name = p || 'COLORS_CONFIG';

  -----------------------------------------------------------------------------
  -- Colores de Indicadores
  -----------------------------------------------------------------------------
  l_ig_plg := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_page_plug(p_id => l_ig_plg, p_flow_id => c_app, p_page_id => l_form,
    p_plug_name => 'Colores de Indicadores', p_region_template_options => '#DEFAULT#',
    p_plug_template => l_tpl_std, p_plug_display_sequence => 30, p_plug_display_point => 'BODY',
    p_query_type => 'SQL', p_include_rowid_column => false,
    p_plug_source => 'select POS, FROM_VALUE, INCLUDE_FROM, TO_VALUE, INCLUDE_TO, COLOR, LABEL '
                  || 'from V_SPD_MONITORING_COLORS where ID = :' || p || 'ID',
    p_query_order_by_type => 'STATIC', p_query_order_by => 'POS',
    p_ajax_items_to_submit => p || 'ID',
    p_plug_source_type => 'NATIVE_IG', p_prn_page_header => 'Colores de Indicadores');

  special_col('APEX$ROW_SELECTOR', 'NATIVE_ROW_SELECTOR', 10);
  special_col('APEX$ROW_ACTION',   'NATIVE_ROW_ACTION',   20, 'Acciones');
  col('POS', 'NATIVE_HIDDEN', 'Posición', 'NUMBER', p_pk => true);
  col('FROM_VALUE', 'NATIVE_NUMBER_FIELD', 'Desde', 'NUMBER', p_required => true, p_align => 'RIGHT');
  col('INCLUDE_FROM', 'NATIVE_YES_NO', 'Incluye desde?', p_required => true, p_default_static => 'N', p_align => 'CENTER');
  col('TO_VALUE', 'NATIVE_NUMBER_FIELD', 'Hasta', 'NUMBER', p_required => true, p_align => 'RIGHT');
  col('INCLUDE_TO', 'NATIVE_YES_NO', 'Incluye hasta?', p_required => true, p_default_static => 'S', p_align => 'CENTER');
  col('COLOR', 'NATIVE_COLOR_PICKER', 'Color', p_required => true, p_max_length => 30);
  col('LABEL', 'NATIVE_TEXT_FIELD', 'Etiqueta', p_max_length => 200);

  l_ig := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_interactive_grid(p_id => l_ig, p_flow_id => c_app, p_page_id => l_form,
    p_region_id => l_ig_plg, p_internal_uid => l_ig,
    p_is_editable => true, p_edit_operations => 'i:u:d', p_lost_update_check_type => null,
    p_add_row_if_empty => false, p_submit_checked_rows => false, p_lazy_loading => false,
    p_requires_filter => false, p_select_first_row => false, p_fixed_row_height => true,
    p_pagination_type => 'SET', p_show_total_row_count => false, p_show_toolbar => true,
    p_toolbar_buttons => null,
    p_enable_save_public_report => false, p_enable_subscriptions => false, p_enable_flashback => false,
    p_define_chart_view => false, p_enable_download => false, p_enable_mail_download => false,
    p_fixed_header => 'NONE', p_show_icon_view => false, p_show_detail_view => false);
  l_rpt := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_ig_report(p_id => l_rpt, p_flow_id => c_app, p_page_id => l_form,
    p_interactive_grid_id => l_ig, p_static_id => to_char(l_rpt), p_type => 'PRIMARY',
    p_default_view => 'GRID', p_rows_per_page => 20, p_show_row_number => false, p_settings_area_expanded => false);
  l_view := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_ig_report_view(p_id => l_view, p_flow_id => c_app, p_page_id => l_form,
    p_report_id => l_rpt, p_view_type => 'GRID', p_srv_exclude_null_values => false,
    p_srv_only_display_columns => true, p_edit_mode => true);
  rpt_col('POS', 0, p_visible => false, p_sort => true);
  rpt_col('FROM_VALUE', 1);
  rpt_col('INCLUDE_FROM', 2);
  rpt_col('TO_VALUE', 3);
  rpt_col('INCLUDE_TO', 4);
  rpt_col('COLOR', 5);
  rpt_col('LABEL', 6);

  -- barra de colores (vista previa), debajo de la grilla
  wwv_flow_imp_page.create_page_item(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => l_form,
    p_name => p || 'COLORS_PREVIEW', p_item_sequence => 10, p_item_plug_id => l_ig_plg, p_prompt => 'Vista previa',
    p_display_as => 'NATIVE_DISPLAY_ONLY', p_field_template => l_ft_above, p_item_template_options => '#DEFAULT#',
    p_use_cache_before_default => 'YES', p_is_persistent => 'N',
    p_display_when_type => 'ITEM_IS_NOT_NULL', p_display_when => p || 'COLORS_PREVIEW',
    p_attribute_01 => 'N', p_attribute_02 => 'VALUE', p_attribute_04 => 'Y', p_attribute_05 => 'HTML');

  -- cada fila: U reemplaza, D deja un null (las posiciones no cambian durante el guardado), C agrega
  wwv_flow_imp_page.create_page_process(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => l_form,
    p_process_sequence => 20, p_process_point => 'AFTER_SUBMIT', p_region_id => l_ig_plg,
    p_process_type => 'NATIVE_IG_DML', p_process_name => 'Colores: guardar',
    p_attribute_01 => 'PLSQL_CODE', p_attribute_05 => 'N', p_attribute_06 => 'N', p_attribute_08 => 'Y',
    p_attribute_04 => replace(q'~
declare
  l_doc clob;
  l_arr json_array_t;
  l_obj json_object_t := json_object_t();
begin
  select COLORS_CONFIG into l_doc from SPD_MONITORING_CONFIG where ID = :#P#ID for update;
  if l_doc is null then l_arr := json_array_t(); else l_arr := json_array_t.parse(l_doc); end if;
  if :APEX$ROW_STATUS in ('C', 'U') then
    if :FROM_VALUE is null then l_obj.put_null('fromValue'); else l_obj.put('fromValue', to_number(:FROM_VALUE)); end if;
    if :TO_VALUE is null then l_obj.put_null('toValue'); else l_obj.put('toValue', to_number(:TO_VALUE)); end if;
    l_obj.put('includeFromValue', :INCLUDE_FROM = 'S');
    l_obj.put('includeToValue', :INCLUDE_TO = 'S');
    l_obj.put('color', :COLOR);
    if :LABEL is not null then l_obj.put('label', :LABEL); end if;
  end if;
  case :APEX$ROW_STATUS
    when 'C' then l_arr.append(l_obj); :POS := l_arr.get_size;
    when 'U' then l_arr.put(:POS - 1, l_obj, true);
    when 'D' then l_arr.put_null(:POS - 1, true);
  end case;
  l_doc := l_arr.to_clob;
  update SPD_MONITORING_CONFIG set COLORS_CONFIG = l_doc where ID = :#P#ID;
end;~', '#P#', p),
    p_error_display_location => 'INLINE_IN_NOTIFICATION');

  wwv_flow_imp_page.create_page_process(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => l_form,
    p_process_sequence => 30, p_process_point => 'AFTER_SUBMIT', p_process_type => 'NATIVE_PLSQL',
    p_process_name => 'Colores: quitar eliminados', p_process_clob_language => 'PLSQL',
    p_process_sql_clob => replace(q'~
declare
  l_doc clob;
  l_arr json_array_t;
  l_new json_array_t := json_array_t();
begin
  select COLORS_CONFIG into l_doc from SPD_MONITORING_CONFIG where ID = :#P#ID;
  if l_doc is null then return; end if;
  l_arr := json_array_t.parse(l_doc);
  for i in 0 .. l_arr.get_size - 1 loop
    if not l_arr.get(i).is_null then l_new.append(json_element_t.parse(l_arr.get(i).to_clob)); end if;
  end loop;
  l_doc := l_new.to_clob;
  update SPD_MONITORING_CONFIG set COLORS_CONFIG = l_doc where ID = :#P#ID;
exception when no_data_found then null;
end;~', '#P#', p),
    p_process_when_type => 'REQUEST_IN_CONDITION', p_process_when => 'CREATE,SAVE');

  -- vista previa: un segmento por rango, ancho proporcional, con "Etiqueta: [desde-hasta]"
  wwv_flow_imp_page.create_page_process(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => l_form,
    p_process_sequence => 30, p_process_point => 'BEFORE_HEADER', p_process_type => 'NATIVE_PLSQL',
    p_process_name => 'Colores: vista previa', p_process_clob_language => 'PLSQL',
    p_process_sql_clob => replace(q'~
declare
  l_html varchar2(32767);
begin
  for c in (select FROM_VALUE, TO_VALUE, COLOR, LABEL, INCLUDE_FROM from V_SPD_MONITORING_COLORS
             where ID = :#P#ID and TO_VALUE is not null order by POS) loop
    l_html := l_html || '<div style="flex:' || to_char(greatest(nvl(c.TO_VALUE, 0) - nvl(c.FROM_VALUE, 0), 1), 'TM9', 'NLS_NUMERIC_CHARACTERS=''.,''')
           || ' 1 0;text-align:center"><div style="font-size:12px">'
           || apex_escape.html(c.LABEL) || case when c.LABEL is not null then ': ' end
           || case when c.INCLUDE_FROM = 'S' then '[' else '(' end || c.FROM_VALUE || '-' || c.TO_VALUE || ']</div>'
           || '<div style="height:22px;background:' || apex_escape.html_attribute(c.COLOR) || '"></div></div>';
  end loop;
  :#P#COLORS_PREVIEW := case when l_html is not null then '<div style="display:flex;width:100%;min-width:800px;max-width:1200px">' || l_html || '</div>' end;
end;~', '#P#', p));

  wwv_flow_imp.import_end(p_auto_install_sup_obj => false);
  commit;
  dbms_output.put_line('SEGUIMIENTO OK (formulario ' || l_form || ', reporte ' || l_ir || ')');
end;
/
exit
