-- Reporte / Validación / Revisión / Tableros de control de Metas, Proyectos y Planes de Acción (app 160),
-- como en el original (client/components/Monitoring/MonitoringTrack, MonitoringValidate, MonitoringReview,
-- Goals/GoalsTrackList, GoalsValidateList, GoalsReviewList, Dashboard/DashboardGoals):
--  * Listas (1031-1033, 1036-1038, 1041-1043): selector del seguimiento + reporte con estado de la etapa y la
--    acción Reportar / Validar / Revisar / Ver, que abre el diálogo 1064. El código abre "Datos de la Meta" (1062).
--      Reporte:    registros PLANNED, REPORTED, VALIDATED, REVIEWED y REJECTED (React no lista los rechazados; aquí
--                  sí, para poder volver a reportarlos) con los recursos programados completos.
--      Validación: REPORTED, VALIDATED, REVIEWED.   Revisión: VALIDATED, REVIEWED.
--  * Tableros (1034, 1039, 1044): metas revisadas con programado / ejecutado del periodo, apropiado, compromisos,
--    obligaciones, avance físico y financiero (medidores con los colores del seguimiento, escalados por trimestre);
--    el ID abre la ejecución en solo lectura.
--  * 1064 · "Ejecución meta" (P1064_MODE = REPORT | VALIDATE | REVIEW | VIEW): resumen, indicadores, actividades,
--    decisión (Validada / Sin Validar; Aprobada / Rechazada + observación) y pestañas Avance Cuantitativo, Avance
--    Cualitativo, Obs. Generales, Focalización E.D. / Org. / R.E. (IG de localizaciones + formulario modal 1065),
--    Evidencias, Indicadores e Historial.
--      Guardar (saveTrackingMonitoringRecord): REPORT → REPORTED; VALIDATE → VALIDATED o REPORTED (con los datos);
--      REVIEW → REVIEWED o REJECTED (solo la decisión y la observación, en el historial). Calcula el avance físico
--      (min(logro / programado, 1)) y el financiero por documento (min(ejecutado / apropiado, 1); en planes de acción
--      contra la programación MANUAL) y registra el evento en SPD_GOAL_HISTORY.
--      Se habilita dentro de la ventana de la etapa: Reporte si no está Validada / Revisada; Validación si no está
--      Revisada; Revisión siempre (puede revisarse de nuevo).
-- Se ejecuta como SIIF sobre la app 160 instalada (run_import_160.sh). Es re-ejecutable: reemplaza las páginas.
set serveroutput on size unlimited
set define off
whenever sqlerror exit failure

declare
  c_app    constant number := 160;
  c_det    constant number := 1062;
  c_dlg    constant number := 1064;
  g_page   number;
  g_group  varchar2(20);
  g_types  varchar2(200);
  g_stage  varchar2(20);
  l_ws     number;
  l_tpl_std   number;
  l_tpl_tabs  number;
  l_tpl_blank number;
  l_tpl_btn   number;
  l_tpl_btns  number;
  l_tpl_dlg   number;
  l_ft_opt    number;
  l_ft_above  number;
  l_seg    number;
  l_list   number;
  l_tabs   number;
  l_wsid   number;
  l_dummy  number;
  l_btn    number;
  l_evt    number;
  l_seq    pls_integer := 0;
  l_colseq pls_integer := 0;
  l_css    varchar2(32767);
  l_js     varchar2(32767);
  l_jslist varchar2(32767);
  l_status_cols varchar2(4000);
  l_hist   varchar2(32767);

  function r(p varchar2) return varchar2 is
  begin
    return replace(replace(replace(replace(p, '#P#', 'P' || g_page || '_'), '#GT#', g_types), '#G#', g_group), '#S#', g_stage);
  end;

  function tpl(p_type varchar2, p_name varchar2) return number is
    l number;
  begin
    select template_id into l from apex_application_templates
     where application_id = c_app and template_type = p_type and template_name = p_name;
    return l;
  end;

  function region(p_name varchar2, p_seq number, p_template number, p_type varchar2 default 'NATIVE_STATIC',
                  p_source clob default null, p_parent number default null, p_new_row boolean default true,
                  p_span number default null, p_options varchar2 default '#DEFAULT#', p_query boolean default false,
                  p_cond_type varchar2 default null, p_cond varchar2 default null, p_cond2 varchar2 default null,
                  p_static_id varchar2 default null, p_point varchar2 default null) return number is
    l_id number := wwv_flow_id.next_val;
  begin
    wwv_flow_imp_page.create_page_plug(p_id => l_id, p_flow_id => c_app, p_page_id => g_page,
      p_plug_name => p_name, p_region_name => p_static_id, p_region_template_options => p_options,
      p_plug_template => p_template, p_plug_display_sequence => p_seq,
      p_plug_display_point => coalesce(p_point, case when p_parent is not null then 'SUB_REGIONS' else 'BODY' end),
      p_parent_plug_id => p_parent, p_plug_new_grid_row => p_new_row, p_plug_grid_column_span => p_span,
      p_query_type => case when p_query then 'SQL' end,
      p_function_body_language => case when p_type = 'NATIVE_DYNAMIC_CONTENT' then 'PLSQL' end,
      p_plug_source => p_source, p_plug_source_type => p_type,
      p_plug_display_condition_type => p_cond_type, p_plug_display_when_condition => p_cond,
      p_plug_display_when_cond2 => p_cond2);
    return l_id;
  end;

  procedure item(p_plug number, p_name varchar2, p_label varchar2, p_type varchar2 default 'NATIVE_HIDDEN',
                 p_lov varchar2 default null, p_submit boolean default true, p_cond_type varchar2 default null,
                 p_cond varchar2 default null, p_cond2 varchar2 default null, p_ro_type varchar2 default null,
                 p_ro varchar2 default null, p_ro2 varchar2 default null,
                 p_new_line varchar2 default 'Y', p_span number default null) is
  begin
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_page_item(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
      p_name => r(p_name), p_item_sequence => l_seq, p_item_plug_id => p_plug, p_prompt => p_label,
      p_begin_on_new_line => p_new_line, p_colspan => p_span,
      p_display_as => p_type, p_use_cache_before_default => 'YES', p_cSize => 30,
      p_cHeight => case when p_type = 'NATIVE_TEXTAREA' then 4 else 1 end,
      p_lov => p_lov, p_lov_display_null => case when p_lov is not null then 'NO' end,
      p_field_template => case when p_type <> 'NATIVE_HIDDEN' then l_ft_above end,
      p_item_template_options => '#DEFAULT#', p_is_persistent => 'Y',
      p_display_when_type => p_cond_type, p_display_when => p_cond, p_display_when2 => p_cond2,
      p_read_only_when_type => p_ro_type, p_read_only_when => p_ro, p_read_only_when2 => p_ro2,
      p_attributes => case p_type
        when 'NATIVE_HIDDEN' then wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2('value_protected', 'N')).to_clob
        when 'NATIVE_SELECT_LIST' then wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
          'page_action_on_selection', case when p_submit then 'SUBMIT' else 'NONE' end)).to_clob
        when 'NATIVE_RADIOGROUP' then wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
          'number_of_columns', '2', 'page_action_on_selection', 'NONE')).to_clob
        when 'NATIVE_TEXTAREA' then wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
          'auto_height', 'N', 'character_counter', 'N', 'resizable', 'Y', 'trim_spaces', 'BOTH')).to_clob
        when 'NATIVE_TEXT_FIELD' then wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
          'disabled', 'N', 'submit_when_enter_pressed', 'N', 'subtype', 'TEXT', 'trim_spaces', 'BOTH')).to_clob
      end);
  end;

  procedure process(p_name varchar2, p_point varchar2, p_code varchar2, p_when_type varchar2 default null,
                    p_when varchar2 default null, p_success varchar2 default null) is
  begin
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_page_process(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
      p_process_sequence => l_seq, p_process_point => p_point, p_process_type => 'NATIVE_PLSQL',
      p_process_name => p_name, p_process_sql_clob => r(p_code), p_process_clob_language => 'PLSQL',
      p_error_display_location => 'INLINE_IN_NOTIFICATION', p_process_success_message => p_success,
      p_process_when_type => p_when_type, p_process_when => p_when);
  end;

  procedure wcol(p_name varchar2, p_label varchar2, p_type varchar2 default 'STRING', p_hidden boolean default false,
                 p_align varchar2 default 'LEFT', p_html varchar2 default null, p_link varchar2 default null,
                 p_link_text varchar2 default null, p_link_attr varchar2 default null, p_mask varchar2 default null) is
  begin
    l_colseq := l_colseq + 1;
    wwv_flow_imp_page.create_worksheet_column(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_page_id => g_page,
      p_worksheet_id => l_wsid, p_db_column_name => p_name, p_display_order => l_colseq,
      p_column_identifier => case when l_colseq <= 26 then chr(64 + l_colseq) else 'A' || chr(64 + l_colseq - 26) end,
      p_column_label => p_label, p_column_type => p_type,
      p_display_text_as => case when p_hidden then 'HIDDEN_ESCAPE_SC' when p_html is not null then 'WITHOUT_MODIFICATION' else 'ESCAPE_SC' end,
      p_column_html_expression => p_html, p_column_link => p_link, p_column_linktext => p_link_text,
      p_column_link_attr => p_link_attr, p_column_link_checksum_type => case when p_link is not null then '3' end,
      p_format_mask => p_mask,
      p_heading_alignment => p_align, p_column_alignment => p_align, p_tz_dependent => 'N', p_use_as_row_header => 'N');
  end;

  procedure worksheet(p_region number, p_name varchar2) is
  begin
    l_wsid := wwv_flow_id.next_val;
    l_colseq := 0;
    wwv_flow_imp_page.create_worksheet(p_id => l_wsid, p_flow_id => c_app, p_page_id => g_page, p_region_id => p_region,
      p_name => p_name, p_max_row_count_message => 'El reporte tiene más de #MAX_ROW_COUNT# filas: aplique un filtro.',
      p_no_data_found_message => 'No hay datos', p_pagination_type => 'ROWS_X_TO_Y', p_pagination_display_pos => 'BOTTOM_RIGHT',
      p_report_list_mode => 'NONE', p_lazy_loading => false, p_show_detail_link => 'N', p_show_notify => 'N',
      p_show_chart => 'N', p_show_group_by => 'N', p_show_pivot => 'N', p_show_calendar => 'N', p_show_flashback => 'N',
      p_allow_save_rpt_public => 'N', p_download_formats => 'CSV:XLSX', p_enable_mail_download => 'N',
      p_owner => 'SIIF', p_internal_uid => l_wsid);
  end;

  procedure ws_report(p_columns varchar2, p_rows number default 10) is
  begin
    wwv_flow_imp_page.create_worksheet_rpt(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_page_id => g_page,
      p_worksheet_id => l_wsid, p_application_user => 'APXWS_DEFAULT', p_report_seq => 10, p_report_alias => 'SPD_' || g_page,
      p_status => 'PUBLIC', p_is_default => 'Y', p_display_rows => p_rows, p_report_columns => p_columns,
      p_sort_column_1 => 'CODE', p_sort_direction_1 => 'ASC');
  end;

  -- selector del seguimiento y los ítems de estado de la página
  procedure header_items(p_extra varchar2 default null) is
  begin
    l_seg := region('Seguimiento', 5, l_tpl_blank);
    item(l_seg, '#P#MC', 'Seguimiento', 'NATIVE_SELECT_LIST', q'~select '(' || mc.PERIOD || '-' || mc.SUBPERIOD || ') ' || pd.NOMBRE as d, mc.ID as r
  from SPD_MONITORING_CONFIG mc
  left join PLAN_DESARROLLO pd on pd.NIT_COMPANIA = mc.NIT_COMPANIA and pd.PLAN = mc.PLAN
 where mc.NIT_COMPANIA = :G_NIT_COMPANIA and nvl(mc.USED_FOR, 'DEVELOPMENT_PLANS') = 'DEVELOPMENT_PLANS'
 order by case when mc.IS_ACTIVE = 'S' then 0 else 1 end, mc.PERIOD desc, mc.SUBPERIOD desc~');
    if p_extra is not null then
      item(l_seg, '#P#SPENT', 'Avance Financiero', 'NATIVE_SELECT_LIST', r(p_extra));
    end if;
    for h in (select column_value n from table(sys.odcivarchar2list('DATE_OK', 'TOTAL', 'SUBPERIOD'))) loop
      item(l_seg, '#P#' || h.n, h.n);
    end loop;
  end;

  -- proceso de carga de las listas: seguimiento por defecto, ventana de la etapa y total
  function list_load(p_window varchar2, p_filter varchar2) return varchar2 is
  begin
    return replace(replace(q'~
declare
  mc SPD_MONITORING_CONFIG%rowtype;
  function ts(v varchar2) return timestamp with time zone is
  begin
    return from_tz(to_timestamp(substr(v, 1, 23), 'YYYY-MM-DD"T"HH24:MI:SS.FF3'), 'UTC');
  end;
begin
  if :#P#MC is null then
    select max(ID) keep (dense_rank first order by case when IS_ACTIVE = 'S' then 0 else 1 end, PERIOD desc, SUBPERIOD desc)
      into :#P#MC from SPD_MONITORING_CONFIG
     where NIT_COMPANIA = :G_NIT_COMPANIA and nvl(USED_FOR, 'DEVELOPMENT_PLANS') = 'DEVELOPMENT_PLANS';
  end if;
  begin
    select * into mc from SPD_MONITORING_CONFIG where ID = :#P#MC and NIT_COMPANIA = :G_NIT_COMPANIA;
  exception when no_data_found then :#P#MC := null; :#P#TOTAL := 0; return;
  end;
  :#P#SUBPERIOD := mc.SUBPERIOD;
  :#P#DATE_OK := 'N';
  begin
    if systimestamp between ts(json_value(mc.DATES_CONFIG, '$.#W#[0]')) and ts(json_value(mc.DATES_CONFIG, '$.#W#[1]')) then
      :#P#DATE_OK := 'S';
    end if;
  exception when others then null;
  end;
  select count(*) into :#P#TOTAL from V_SPD_GOAL_MONITORING m
   where m.NIT_COMPANIA = :G_NIT_COMPANIA and m.MONITORING_CONFIG_ID = mc.ID and m.GOAL_GROUP = '#G#' and #F#;
end;~', '#W#', p_window), '#F#', p_filter);
  end;
  -- grilla (IG de solo lectura) de las localizaciones de una sección de TARGET_MATRIX, dentro de las pestañas del 1064
  procedure tm_grid(p_title varchar2, p_seq number, p_section varchar2) is
    l_tab  number := wwv_flow_id.next_val;   -- pestaña (contenedor)
    l_bar  number := wwv_flow_id.next_val;   -- barra de botones
    l_reg  number := wwv_flow_id.next_val;   -- grilla
    l_ig   number := wwv_flow_id.next_val;
    l_rpt  number := wwv_flow_id.next_val;
    l_view number := wwv_flow_id.next_val;
    l_cseq pls_integer := 0;
    l_rseq pls_integer := 0;
    l_cols varchar2(4000);
    l_url  varchar2(1000) := 'f?p=&APP_ID.:1065:&APP_SESSION.::&DEBUG.:1065:P1065_REC_ID,P1065_SECTION,P1065_POS,P1065_EDITABLE:';
    procedure c(p_name varchar2, p_label varchar2, p_type varchar2 default 'NATIVE_DISPLAY_ONLY', p_dt varchar2 default 'VARCHAR2',
                p_align varchar2 default 'LEFT', p_pk boolean default false, p_link varchar2 default null, p_text varchar2 default null) is
      l_id number := wwv_flow_id.next_val;
    begin
      l_cseq := l_cseq + 10;
      wwv_flow_imp_page.create_region_column(p_id => l_id, p_flow_id => c_app, p_page_id => g_page, p_region_id => l_reg,
        p_name => p_name, p_source_type => 'DB_COLUMN', p_source_expression => p_name, p_data_type => p_dt,
        p_session_state_data_type => 'VARCHAR2', p_is_query_only => false,
        p_item_type => p_type, p_heading => p_label, p_label => p_label, p_heading_alignment => p_align, p_value_alignment => p_align,
        p_display_sequence => l_cseq,
        p_attributes => case p_type
          when 'NATIVE_DISPLAY_ONLY' then wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2('based_on', 'VALUE', 'format', 'PLAIN', 'send_on_page_submit', 'N')).to_clob
          when 'NATIVE_HIDDEN' then wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2('value_protected', 'Y')).to_clob end,
        p_link_target => p_link, p_link_text => p_text,
        p_is_required => false, p_enable_filter => false, p_filter_is_required => false, p_filter_lov_type => 'NONE',
        p_use_as_row_header => false, p_enable_sort_group => p_type <> 'NATIVE_LINK', p_enable_control_break => false,
        p_enable_hide => true, p_enable_pivot => false, p_is_primary_key => p_pk, p_duplicate_value => true, p_include_in_export => true);
      if p_type not in ('NATIVE_HIDDEN') then
        l_rseq := l_rseq + 1;
        wwv_flow_imp_page.create_ig_report_column(p_id => wwv_flow_id.next_val, p_view_id => l_view, p_display_seq => l_rseq,
          p_column_id => l_id, p_is_visible => true, p_is_frozen => false);
      end if;
    end;
  begin
    l_cols := case p_section
      when 'ed'  then 'H, M, U, R, TOTAL_PEOPLE'
      when 'org' then 'ORG_TYPE, ORG_OBJECT, NUM_BENEFICIARIES, POPULATION_DESC'
      else            'CANINE, FELINE, OTHERS, FLORA' end;
    wwv_flow_imp_page.create_page_plug(p_id => l_tab, p_flow_id => c_app, p_page_id => g_page, p_plug_name => p_title,
      p_parent_plug_id => l_tabs, p_region_template_options => '#DEFAULT#', p_plug_template => l_tpl_blank,
      p_plug_display_sequence => p_seq, p_plug_display_point => 'SUB_REGIONS', p_plug_source_type => 'NATIVE_STATIC');
    wwv_flow_imp_page.create_page_plug(p_id => l_bar, p_flow_id => c_app, p_page_id => g_page, p_plug_name => p_title || ' - botones',
      p_parent_plug_id => l_tab, p_region_template_options => '#DEFAULT#', p_plug_template => l_tpl_btns,
      p_plug_display_sequence => 5, p_plug_display_point => 'SUB_REGIONS', p_plug_source_type => 'NATIVE_STATIC');
    wwv_flow_imp_page.create_page_plug(p_id => l_reg, p_flow_id => c_app, p_page_id => g_page, p_plug_name => p_title || ' - grilla',
      p_region_name => 'spd_tm_' || p_section, p_parent_plug_id => l_tab, p_region_template_options => '#DEFAULT#',
      p_plug_template => l_tpl_blank, p_plug_display_sequence => 10, p_plug_display_point => 'SUB_REGIONS',
      p_query_type => 'SQL', p_plug_source_type => 'NATIVE_IG', p_ajax_items_to_submit => 'P1064_REC_ID',
      p_plug_source => 'select RECORD_ID, SECTION, POS, null as EDITAR, LOCALIZATION_LABEL, ' || l_cols
        || ' from V_SPD_TARGET_MATRIX where RECORD_ID = :P1064_REC_ID and SECTION = ''' || p_section || '''');
    wwv_flow_imp_page.create_interactive_grid(p_id => l_ig, p_flow_id => c_app, p_page_id => g_page, p_region_id => l_reg,
      p_internal_uid => l_ig, p_is_editable => false, p_lazy_loading => false, p_requires_filter => false,
      p_select_first_row => false, p_fixed_row_height => true, p_pagination_type => 'SET', p_show_total_row_count => true,
      p_show_toolbar => true, p_toolbar_buttons => 'SEARCH_FIELD:ACTIONS_MENU', p_enable_save_public_report => false,
      p_enable_subscriptions => false, p_enable_flashback => false, p_define_chart_view => false, p_enable_download => false,
      p_enable_mail_download => false, p_fixed_header => 'NONE', p_show_icon_view => false, p_show_detail_view => false);
    wwv_flow_imp_page.create_ig_report(p_id => l_rpt, p_flow_id => c_app, p_page_id => g_page, p_interactive_grid_id => l_ig,
      p_static_id => to_char(l_rpt), p_type => 'PRIMARY', p_default_view => 'GRID', p_rows_per_page => 10,
      p_show_row_number => false, p_settings_area_expanded => false);
    wwv_flow_imp_page.create_ig_report_view(p_id => l_view, p_flow_id => c_app, p_page_id => g_page, p_report_id => l_rpt,
      p_view_type => 'GRID', p_srv_exclude_null_values => false, p_srv_only_display_columns => true, p_edit_mode => false);
    c('RECORD_ID', 'Registro', 'NATIVE_HIDDEN', 'NUMBER', p_pk => true);
    c('SECTION', 'Sección', 'NATIVE_HIDDEN', p_pk => true);
    c('POS', 'Posición', 'NATIVE_HIDDEN', 'NUMBER', p_pk => true);
    c('EDITAR', 'Acciones', 'NATIVE_LINK', p_align => 'CENTER',
      p_link => l_url || '&RECORD_ID.,&SECTION.,&POS.,&P1064_DATA_EDITABLE.',
      p_text => '<span class="fa fa-edit spd-act" aria-hidden="true" title="Editar"></span><span class="u-VisuallyHidden">Editar</span>');
    c('LOCALIZATION_LABEL', 'Localización');
    if p_section = 'ed' then
      c('H', 'Hombres', p_dt => 'NUMBER', p_align => 'RIGHT');
      c('M', 'Mujeres', p_dt => 'NUMBER', p_align => 'RIGHT');
      c('U', 'Urbano', p_dt => 'NUMBER', p_align => 'RIGHT');
      c('R', 'Rural', p_dt => 'NUMBER', p_align => 'RIGHT');
      c('TOTAL_PEOPLE', 'Total personas', p_dt => 'NUMBER', p_align => 'RIGHT');
    elsif p_section = 'org' then
      c('ORG_TYPE', 'Tipo de institución');
      c('ORG_OBJECT', 'Objeto de institución');
      c('NUM_BENEFICIARIES', 'Número de beneficiarios', p_dt => 'NUMBER', p_align => 'RIGHT');
      c('POPULATION_DESC', 'Total población /unidad');
    else
      c('CANINE', 'Caninos', p_dt => 'NUMBER', p_align => 'RIGHT');
      c('FELINE', 'Felinos', p_dt => 'NUMBER', p_align => 'RIGHT');
      c('OTHERS', 'Otra Especie', p_dt => 'NUMBER', p_align => 'RIGHT');
      c('FLORA', 'Flora');
    end if;
    -- Agregar localización (junto al buscador de la grilla), solo si los datos del reporte son editables
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_page_button(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
      p_button_sequence => l_seq, p_button_plug_id => l_bar, p_button_name => 'ADD_TM_' || upper(p_section),
      p_button_action => 'REDIRECT_URL', p_button_redirect_url => l_url || '&P1064_REC_ID.,' || p_section || ',,S',
      p_button_template_options => '#DEFAULT#:t-Button--iconLeft', p_button_template_id => tpl('Button', 'Text with Icon'),
      p_button_is_hot => 'Y', p_button_image_alt => 'Agregar localización', p_button_position => 'NEXT',
      p_icon_css_classes => 'fa-plus', p_warn_on_unsaved_changes => null,
      p_button_condition_type => 'VAL_OF_ITEM_IN_COND_EQ_COND2', p_button_condition => 'P1064_DATA_EDITABLE', p_button_condition2 => 'S');
  end;
begin
  apex_application_install.set_workspace('SIIFWEB');
  l_ws := apex_application_install.get_workspace_id;
  wwv_flow_imp.import_begin(p_version_yyyy_mm_dd => '2024.11.30', p_release => '24.2.0',
    p_default_workspace_id => l_ws, p_default_application_id => c_app, p_default_id_offset => 0,
    p_default_owner => 'SIIF');

  l_tpl_std   := tpl('Region', 'Standard');
  l_tpl_tabs  := tpl('Region', 'Tabs Container');
  l_tpl_blank := tpl('Region', 'Blank with Attributes');
  l_tpl_btns  := tpl('Region', 'Buttons Container');
  l_tpl_btn   := tpl('Button', 'Text');
  l_tpl_dlg   := tpl('Page', 'Modal Dialog');
  l_ft_opt    := tpl('Item Label', 'Optional');
  -- plantilla de etiqueta de los formularios de la app (etiqueta flotante)
  l_ft_above  := tpl('Item Label', 'Optional - Floating');

  l_css := q'~
.spd-badge{display:inline-block;min-width:20px;padding:0 6px;margin-left:6px;border-radius:10px;font-size:11px;line-height:18px;color:#fff;text-align:center;background:#1677ff;vertical-align:middle}
.spd-st{display:inline-flex;align-items:center;justify-content:center;width:30px;height:30px;border-radius:50%;font-size:15px;border:1px solid transparent}
.spd-st--NEW{color:#0f1129;border-color:#0f1129}
.spd-st--SCH{color:#008000;border-color:#008000;background:rgba(0,128,0,.15)}
.spd-st--PAR{color:#f99c07;border-color:#f99c07;background:rgba(249,156,7,.15)}
.spd-st--REP{color:#008000;background:rgba(0,128,0,.15)}
.spd-st--NOREP{color:#1d2f4e;background:rgba(29,47,78,.12)}
.spd-st--VAL{color:#008000;border-color:#008000}
.spd-st--NOVAL{color:#1d2f4e;background:rgba(29,47,78,.08)}
.spd-st--REV{color:#008000;border-color:#008000;background:rgba(0,128,0,.4)}
.spd-st--NOREV{color:#ff0000;border-color:#008000}
.spd-st--REJ{color:#ef440b;background:rgba(239,68,11,.15)}
.spd-act{font-size:16px;color:#1677ff}
.spd-collapse{border:1px solid #d9d9d9;border-radius:8px;margin-bottom:10px;background:#fff}
.spd-collapse>summary{padding:12px 16px;cursor:pointer;background:#fafafa;border-radius:8px;list-style:none}
.spd-collapse>summary::before{content:"\203A";display:inline-block;width:16px;font-weight:bold;transition:transform .2s}
.spd-collapse[open]>summary::before{transform:rotate(90deg)}
.spd-collapse[open]>summary{border-bottom:1px solid #d9d9d9;border-radius:8px 8px 0 0}
.spd-collapse>div{padding:16px}
.spd-desc{width:100%;border-collapse:collapse;border:1px solid #f0f0f0}
.spd-desc th,.spd-desc td{border:1px solid #f0f0f0;padding:8px 16px;text-align:left;vertical-align:top;font-weight:normal}
.spd-desc th{background:#fafafa;color:rgba(0,0,0,.65);width:22%}
.spd-tbl{width:100%;border-collapse:collapse}
.spd-tbl th{background:#fafafa;padding:8px;text-align:left;border-bottom:1px solid #f0f0f0}
.spd-tbl td{padding:8px;border-bottom:1px solid #f0f0f0;vertical-align:top}
.spd-empty{padding:24px;text-align:center;color:rgba(0,0,0,.35)}
.spd-empty .fa{font-size:32px;display:block;margin-bottom:6px}
.spd-form{border-collapse:separate;border-spacing:0 8px;width:100%}
.spd-form th{text-align:left;font-weight:normal;padding-right:16px;white-space:nowrap;width:1%}
.spd-form th:after{content:":"}
.spd-form th.spd-noc:after{content:""}
.spd-form td{padding-right:10px}
.spd-form input,.spd-form select,.spd-ta,.spd-tm input,.spd-tm select{height:32px;border:1px solid #d9d9d9;border-radius:6px;padding:0 8px}
.spd-form input[disabled],.spd-form input[readonly],.spd-ta[disabled],.spd-tm [disabled]{background:#f5f5f5;color:rgba(0,0,0,.45)}
.spd-num{width:170px;text-align:right}
.spd-money{width:100%;min-width:100px;max-width:200px;text-align:right}
.spd-colhead{text-align:center;font-weight:bold;font-size:14px}
.spd-total th{font-weight:bold;font-size:15px}
.spd-sgp-sub th{padding-left:28px}
.spd-sgp-toggle{cursor:pointer;margin-right:6px}
.spd-ta{width:100%;height:auto;padding:6px 8px;font-family:inherit}
.spd-q{margin-bottom:14px}.spd-q label{display:block;margin-bottom:4px}
.spd-hist{list-style:none;margin:0;padding:0}
.spd-hist li{display:flex;gap:16px;padding:12px 0;border-bottom:1px solid #f0f0f0}
.spd-avatar{flex:none;width:32px;height:32px;border-radius:50%;background:#87d068;color:#fff;display:flex;align-items:center;justify-content:center}
.spd-hist-title{font-weight:500}.spd-hist-desc{color:rgba(0,0,0,.45)}
.spd-bars{display:grid;grid-template-columns:max-content 1fr 60px;gap:8px 12px;align-items:center}
.spd-bar{height:8px;background:#f0f0f0;border-radius:4px;overflow:hidden}.spd-bar>i{display:block;height:100%}
.spd-gauge{--p:0;--c:#1677ff;width:84px;height:84px;border-radius:50%;background:conic-gradient(var(--c) calc(var(--p)*1%),#f0f0f0 0);display:inline-flex;align-items:center;justify-content:center;position:relative}
.spd-gauge::before{content:"";position:absolute;inset:9px;background:#fff;border-radius:50%}
.spd-gauge span{position:relative;font-size:13px;font-weight:500}
.spd-gauge--sm{width:56px;height:56px}.spd-gauge--sm::before{inset:6px}.spd-gauge--sm span{font-size:11px}
.spd-gauges{display:flex;gap:40px;flex-wrap:wrap;text-align:center}.spd-gauges>div>div{margin-top:6px}
.spd-gauge--lg{width:116px;height:116px}.spd-gauge--lg::before{inset:12px}.spd-gauge--lg span{font-size:20px;font-weight:600}
.spd-ind{display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:16px;padding:12px 0}
.spd-ind-card{background:#fff;border:1px solid #f0f0f0;border-radius:10px;padding:16px 18px;display:flex;flex-direction:column;align-items:center;gap:10px;box-shadow:0 1px 3px rgba(0,0,0,.05)}
.spd-ind-kicker{font-size:11px;letter-spacing:.06em;text-transform:uppercase;color:rgba(0,0,0,.45)}
.spd-ind-title{font-size:15px;font-weight:600;text-align:center;margin-top:-6px}
.spd-ind-chip{display:inline-flex;align-items:center;gap:6px;font-size:12px;padding:2px 10px;border-radius:12px;background:#fafafa;border:1px solid #f0f0f0;color:rgba(0,0,0,.75)}
.spd-ind-chip i{width:8px;height:8px;border-radius:50%;background:var(--c)}
.spd-ind-figs{align-self:stretch;border-top:1px solid #f0f0f0;padding-top:10px;display:grid;grid-template-columns:1fr auto;gap:4px 12px;font-size:12px;color:rgba(0,0,0,.55)}
.spd-ind-figs b{font-weight:500;color:rgba(0,0,0,.88);text-align:right;font-variant-numeric:tabular-nums}
.spd-tm-card{border:1px solid #d9d9d9;border-radius:8px;margin-bottom:12px}
.spd-tm-card>header{display:flex;gap:12px;align-items:center;padding:8px 12px;background:#fafafa;border-radius:8px 8px 0 0}
.spd-tm-card>header select{flex:1}
.spd-tm-body{padding:12px;display:flex;flex-wrap:wrap;gap:16px}
.spd-tm-group{border:1px solid #f0f0f0;border-radius:6px;padding:8px 12px}
.spd-tm-group>b{display:block;margin-bottom:6px}
.spd-tm-group label{display:inline-flex;flex-direction:column;margin:0 10px 6px 0;font-size:12px}
.spd-tm-group input{width:90px;text-align:right}.spd-tm-group input.spd-tm-text{width:220px;text-align:left}
.spd-alert{padding:10px 14px;border:1px solid #91caff;background:#e6f4ff;border-radius:6px;margin-bottom:12px}
.spd-row-sel td{background:#e6f4ff !important}~';

  -- columnas comunes de estado para las listas (clave CSS e ícono según la etiqueta de la etapa)
  l_status_cols := q'~
       case #ST# when 'Sin Programar' then 'NEW' when 'Programada' then 'SCH' when 'Programada Parcial' then 'PAR'
            when 'Reportada' then 'REP' when 'Sin Reportar' then 'NOREP' when 'Validada' then 'VAL' when 'Sin Validar' then 'NOVAL'
            when 'Revisada' then 'REV' when 'Sin Revisar' then 'NOREV' when 'Rechazada' then 'REJ' end as ST_KEY,
       case when #ST# in ('Sin Programar', 'Programada', 'Programada Parcial') then 'fa-usd'
            when #ST# in ('Reportada', 'Sin Reportar') then 'fa-pencil-square-o'
            when #ST# = 'Validada' then 'fa-check-circle' when #ST# = 'Sin Validar' then 'fa-exclamation-circle'
            when #ST# in ('Revisada', 'Sin Revisar') then 'fa-check-square-o' else 'fa-calendar-times-o' end as ST_ICON,~';

  l_jslist := q'~
$(window).on("apexafterclosedialog", function (e, data) {
  apex.region("spd_list").refresh();
  if (data && data.successMessage && data.successMessage.text) apex.message.showPageSuccess(data.successMessage.text);
});~';

  -- ==========================================================================
  -- Listas de Reporte / Validación / Revisión
  -- ==========================================================================
  for gx in (select regexp_substr(column_value, '[^|]+', 1, 1) as PG, regexp_substr(column_value, '[^|]+', 1, 2) as GRP,
                    regexp_substr(column_value, '[^|]+', 1, 3) as STAGE, regexp_substr(column_value, '[^|]+', 1, 4) as ALIAS,
                    regexp_substr(column_value, '[^|]+', 1, 5) as NAME, regexp_substr(column_value, '[^|]+', 1, 6) as TITLE,
                    regexp_substr(column_value, '[^|]+', 1, 7) as CARD
               from table(sys.odcivarchar2list(
  '1031|METAS|REPORT|SPD_REPORTE_METAS|SPD_Reporte de avance de metas|Reporte de Avance de Metas|Metas Programadas',
  '1032|METAS|VALIDATE|SPD_VALIDACION_METAS|SPD_Validación de avance de metas|Validación de Avance de Metas|Metas Reportadas',
  '1033|METAS|REVIEW|SPD_REVISION_METAS|SPD_Revisión de avance de metas|Revisión de Avance de Metas|Metas Validadas',
  '1036|PROYECTOS|REPORT|SPD_REPORTE_PROYECTOS|SPD_Reporte de seguimiento de proyectos|Reportar Seguimiento de Proyectos|Proyectos Programados',
  '1037|PROYECTOS|VALIDATE|SPD_VALIDACION_PROYECTOS|SPD_Validación de seguimiento de proyectos|Validar Seguimiento de Proyectos|Proyectos Reportados',
  '1038|PROYECTOS|REVIEW|SPD_REVISION_PROYECTOS|SPD_Revisión de seguimiento de proyectos|Revisar Seguimiento de Proyectos|Proyectos Validados',
  '1041|PLANES|REPORT|SPD_REPORTE_PLANES_ACCION|SPD_Reporte de seguimiento de planes de acción|Reportar Seguimiento de Planes de Acción|Planes de Acción Programados',
  '1042|PLANES|VALIDATE|SPD_VALIDACION_PLANES_ACCION|SPD_Validación de seguimiento de planes de acción|Validar Seguimiento de Planes de Acción|Planes de Acción Reportados',
  '1043|PLANES|REVIEW|SPD_REVISION_PLANES_ACCION|SPD_Revisión de seguimiento de planes de acción|Revisar Seguimiento de Planes de Acción|Planes de Acción Validados')))
  loop
    g_page := to_number(gx.PG); g_group := gx.GRP; g_stage := gx.STAGE; l_seq := 0;
    declare
      l_st     varchar2(30) := case g_stage when 'REPORT' then 'm.REPORT_STATUS' when 'VALIDATE' then 'm.VALIDATION_STATUS' else 'm.REVIEW_STATUS' end;
      l_filter varchar2(400) := case g_stage
        when 'REPORT'   then 'm.RECORD_STATUS in (''PLANNED'', ''REPORTED'', ''VALIDATED'', ''REVIEWED'', ''REJECTED'') and m.SCHEDULED_RESOURCES >= m.REQUIRED_RESOURCES'
        when 'VALIDATE' then 'm.RECORD_STATUS in (''REPORTED'', ''VALIDATED'', ''REVIEWED'') and m.SCHEDULED_RESOURCES >= m.REQUIRED_RESOURCES'
        else                 'm.RECORD_STATUS in (''VALIDATED'', ''REVIEWED'') and m.SCHEDULED_RESOURCES >= m.REQUIRED_RESOURCES' end;
      l_can    varchar2(400) := case g_stage
        when 'REPORT'   then ':#P#DATE_OK = ''S'' and ' || 'm.REPORT_STATUS not in (''Validada'', ''Revisada'')'
        when 'VALIDATE' then ':#P#DATE_OK = ''S'' and ' || 'm.VALIDATION_STATUS <> ''Revisada'''
        else                 ':#P#DATE_OK = ''S''' end;
      l_verb   varchar2(30) := case g_stage when 'REPORT' then 'Reportar' when 'VALIDATE' then 'Validar' else 'Revisar' end;
      l_icon   varchar2(30) := case g_stage when 'REPORT' then 'fa-pencil-square-o' when 'VALIDATE' then 'fa-check' else 'fa-check-square-o' end;
    begin
      wwv_flow_imp_page.remove_page(p_flow_id => c_app, p_page_id => g_page);
      wwv_flow_imp_page.create_page(p_id => g_page, p_flow_id => c_app, p_name => gx.NAME, p_alias => gx.ALIAS,
        p_step_title => gx.TITLE, p_autocomplete_on_off => 'OFF', p_page_template_options => '#DEFAULT#',
        p_protection_level => 'C', p_inline_css => l_css, p_javascript_code_onload => l_jslist);
      header_items;
      l_list := region(r(gx.CARD || ' <span class="spd-badge">&#P#TOTAL.</span>'), 10, l_tpl_std, 'NATIVE_IR',
        p_query => true, p_static_id => 'spd_list', p_source => r(replace(replace(replace(replace(replace(replace(q'~
select m.GOAL_ID, m.CODE, m.NAME, m.INDICATOR,
       case m.ACCUMULATION_TYPE when 'ACCUMULATED' then 'Acumulado' when 'NO_ACCUMULATED' then 'No Acumulado'
            when 'ANNUAL_REDUCTION' then 'Reducción Anual' when 'CAPACITY' then 'Capacidad' when 'FLOW' then 'Flujo'
            when 'REDUCTION' then 'Reducción' when 'STOCK' then 'Stock' end as ACCUMULATION,
       m.BASE_VALUE, m.GOAL_VALUE, m.ENTITY_CODE, m.ENTITY_NAME, #ST# as STATUS, #STC#
       m.GOAL_ID as ACCIONES,
       case when #CAN# then '#ICON#' else 'fa-eye' end as ACCION_ICON,
       case when #CAN# then '#VERB#' else 'Ver' end as ACCION_TITLE
  from V_SPD_GOAL_MONITORING m
 where m.NIT_COMPANIA = :G_NIT_COMPANIA and m.MONITORING_CONFIG_ID = :#P#MC and m.GOAL_GROUP = '#G#' and #F#~',
          '#STC#', replace(l_status_cols, '#ST#', l_st)), '#ST#', l_st), '#CAN#', l_can), '#F#', l_filter), '#ICON#', l_icon), '#VERB#', l_verb)
          ) -- r()
        );
      worksheet(l_list, gx.CARD);
      wcol('GOAL_ID', 'ID', 'NUMBER', p_hidden => true);
      wcol('CODE', 'Código', p_link => 'f?p=&APP_ID.:' || c_det || ':&APP_SESSION.::&DEBUG.:' || c_det || ':P' || c_det || '_ID:#GOAL_ID#',
           p_link_text => '#CODE#');
      wcol('NAME', 'Nombre');
      wcol('INDICATOR', 'Indicador', p_hidden => g_group <> 'METAS');
      wcol('ACCUMULATION', 'Tipo de Acumulación', p_hidden => g_group <> 'METAS');
      wcol('BASE_VALUE', 'Valor Base', 'NUMBER', p_hidden => g_group <> 'METAS', p_align => 'RIGHT');
      wcol('GOAL_VALUE', 'Valor Meta', 'NUMBER', p_hidden => g_group <> 'METAS', p_align => 'RIGHT');
      wcol('ENTITY_CODE', 'Entidad', p_html => '<span title="#ENTITY_NAME#">#ENTITY_CODE#</span>');
      wcol('ENTITY_NAME', 'Nombre de la entidad', p_hidden => true);
      wcol('STATUS', 'Estado', p_align => 'CENTER',
           p_html => '<span class="spd-st spd-st--#ST_KEY#" title="#STATUS#"><span class="fa #ST_ICON#" aria-hidden="true"></span></span>');
      wcol('ST_KEY', 'ST_KEY', p_hidden => true);
      wcol('ST_ICON', 'ST_ICON', p_hidden => true);
      wcol('ACCIONES', 'Acciones', 'NUMBER', p_align => 'CENTER',
           p_link => 'f?p=&APP_ID.:' || c_dlg || ':&APP_SESSION.::&DEBUG.:' || c_dlg || ':P' || c_dlg || '_GOAL_ID,P' || c_dlg
                     || '_MC,P' || c_dlg || '_MODE:#GOAL_ID#,&P' || g_page || '_MC.,' || g_stage,
           p_link_text => '<span class="fa #ACCION_ICON# spd-act" title="#ACCION_TITLE#" aria-label="#ACCION_TITLE#"></span>',
           p_link_attr => 'data-goal="#GOAL_ID#"');
      wcol('ACCION_ICON', 'ACCION_ICON', p_hidden => true);
      wcol('ACCION_TITLE', 'ACCION_TITLE', p_hidden => true);
      ws_report(case when g_group = 'METAS' then 'CODE:NAME:INDICATOR:ACCUMULATION:BASE_VALUE:GOAL_VALUE:ENTITY_CODE:STATUS:ACCIONES'
                     else 'CODE:NAME:ENTITY_CODE:STATUS:ACCIONES' end);
      process('Cargar seguimiento', 'BEFORE_HEADER',
              list_load(case g_stage when 'REPORT' then 'reporting' when 'VALIDATE' then 'validating' else 'reviewing' end, l_filter));
      wwv_flow_imp_page.create_page_branch(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
        p_branch_name => 'Volver a la página', p_branch_point => 'AFTER_PROCESSING', p_branch_type => 'REDIRECT_URL',
        p_branch_action => 'f?p=&APP_ID.:' || g_page || ':&APP_SESSION.::&DEBUG.:::', p_branch_sequence => 10);
    end;
  end loop;

  -- ==========================================================================
  -- Tableros de control
  -- ==========================================================================
  for gx in (select regexp_substr(column_value, '[^|]+', 1, 1) as PG, regexp_substr(column_value, '[^|]+', 1, 2) as GRP,
                    regexp_substr(column_value, '[^|]+', 1, 3) as ALIAS, regexp_substr(column_value, '[^|]+', 1, 4) as NAME,
                    regexp_substr(column_value, '[^|]+', 1, 5) as TITLE
               from table(sys.odcivarchar2list(
  '1034|METAS|SPD_TABLERO_METAS|SPD_Tableros de control - Metas|Tableros de Control',
  '1039|PROYECTOS|SPD_TABLERO_PROYECTOS|SPD_Tableros de control - Proyectos|Tableros de Control',
  '1044|PLANES|SPD_TABLERO_PLANES_ACCION|SPD_Tableros de control - Planes de acción|Tableros de Control')))
  loop
    g_page := to_number(gx.PG); g_group := gx.GRP; g_stage := 'VIEW'; l_seq := 0;
    wwv_flow_imp_page.remove_page(p_flow_id => c_app, p_page_id => g_page);
    wwv_flow_imp_page.create_page(p_id => g_page, p_flow_id => c_app, p_name => gx.NAME, p_alias => gx.ALIAS,
      p_step_title => gx.TITLE, p_autocomplete_on_off => 'OFF', p_page_template_options => '#DEFAULT#',
      p_protection_level => 'C', p_inline_css => l_css, p_javascript_code_onload => l_jslist);
    header_items(q'~select case d.DOC when 'COMMITMENT' then 'Compromisos' when 'OBLIGATION' then 'Obligaciones' else 'Pagos' end as d, d.DOC as r
  from SPD_MONITORING_CONFIG mc, json_table(mc.SPENT_DOCS, '$[*]' columns (POS for ordinality, DOC varchar2(20) path '$')) d
 where mc.ID = :#P#MC order by d.POS~');
    l_list := region(r('Avance de Metas <span class="spd-badge">&#P#TOTAL.</span>'), 10, l_tpl_std, 'NATIVE_IR',
      p_query => true, p_static_id => 'spd_list', p_source => r(q'~
select x.*,
       to_char(x.PHYS, 'FM990D00', 'NLS_NUMERIC_CHARACTERS=''.,''') as PHYS_P,
       to_char(x.FIN, 'FM990D00', 'NLS_NUMERIC_CHARACTERS=''.,''') as FIN_P,
       coalesce((select c.COLOR from V_SPD_MONITORING_COLORS c where c.ID = x.MONITORING_CONFIG_ID
                    and x.PHYS >= c.FROM_VALUE * x.SUBPERIOD / 4 and x.PHYS <= c.TO_VALUE * x.SUBPERIOD / 4
                  order by c.POS fetch first 1 row only),
                (select max(c.COLOR) keep (dense_rank last order by c.POS) from V_SPD_MONITORING_COLORS c
                  where c.ID = x.MONITORING_CONFIG_ID), '#1677ff') as PHYS_COLOR,
       coalesce((select c.COLOR from V_SPD_MONITORING_COLORS c where c.ID = x.MONITORING_CONFIG_ID
                    and x.FIN >= c.FROM_VALUE * x.SUBPERIOD / 4 and x.FIN <= c.TO_VALUE * x.SUBPERIOD / 4
                  order by c.POS fetch first 1 row only),
                (select max(c.COLOR) keep (dense_rank last order by c.POS) from V_SPD_MONITORING_COLORS c
                  where c.ID = x.MONITORING_CONFIG_ID), '#1677ff') as FIN_COLOR
  from (
select m.GOAL_ID, m.CODE, m.CODE || case when m.GOAL_TYPE <> 'ACTION_PLAN' then ' - ' || m.NAME end as GOAL,
       m.ENTITY_CODE, m.ENTITY_NAME, m.DEV_PLAN_LEVEL_NAME,
       (select e.DISPLAY_VALUE from APEX_APPLICATION_LOV_ENTRIES e where e.APPLICATION_ID = :APP_ID
          and e.LIST_OF_VALUES_NAME = 'SPD - TIPO DE META' and e.RETURN_VALUE = m.GOAL_TYPE) as GOAL_TYPE_LABEL,
       case m.ACCUMULATION_TYPE when 'ACCUMULATED' then 'Acumulado' when 'NO_ACCUMULATED' then 'No Acumulado'
            when 'ANNUAL_REDUCTION' then 'Reducción Anual' when 'CAPACITY' then 'Capacidad' when 'FLOW' then 'Flujo'
            when 'REDUCTION' then 'Reducción' when 'STOCK' then 'Stock' end as ACCUMULATION,
       m.BASE_VALUE, m.GOAL_VALUE, m.PROGRAMMED_VALUE, m.ACHIEVED_VALUE, m.APPROPRIATED, m.COMMITMENTS, m.OBLIGATIONS,
       m.MONITORING_CONFIG_ID, m.SUBPERIOD, m.REVIEW_STATUS as STATUS,
       nvl(m.PHYSICAL_PROGRESS, 0) as PHYS,
       nvl(case :#P#SPENT when 'OBLIGATION' then m.FIN_PROGRESS_OBLIGATION when 'PAYMENT' then m.FIN_PROGRESS_PAYMENT
                else m.FIN_PROGRESS_COMMITMENT end, 0) as FIN
  from V_SPD_GOAL_MONITORING m
 where m.NIT_COMPANIA = :G_NIT_COMPANIA and m.MONITORING_CONFIG_ID = :#P#MC and m.GOAL_GROUP = '#G#'
   and m.RECORD_STATUS in ('REVIEWED', 'APPROVED')) x~'));
    worksheet(l_list, 'Avance de Metas');
    wcol('GOAL_ID', 'ID', 'NUMBER', p_align => 'CENTER',
         p_link => 'f?p=&APP_ID.:' || c_dlg || ':&APP_SESSION.::&DEBUG.:' || c_dlg || ':P' || c_dlg || '_GOAL_ID,P' || c_dlg
                   || '_MC,P' || c_dlg || '_MODE:#GOAL_ID#,&P' || g_page || '_MC.,VIEW',
         p_link_text => '#GOAL_ID#', p_link_attr => 'data-goal="#GOAL_ID#" title="Seguimiento Meta"');
    wcol('CODE', 'Código', p_hidden => true);
    wcol('GOAL', 'Meta');
    wcol('STATUS', 'Estado', p_align => 'CENTER',
         p_html => '<span class="spd-st spd-st--REV" title="#STATUS#"><span class="fa fa-check-square-o" aria-hidden="true"></span></span>');
    wcol('ENTITY_CODE', 'Entidad', p_html => '<span title="#ENTITY_NAME#">#ENTITY_CODE#</span>');
    wcol('ENTITY_NAME', 'Nombre de la entidad', p_hidden => true);
    wcol('DEV_PLAN_LEVEL_NAME', 'Nivel Plan');
    wcol('GOAL_TYPE_LABEL', 'Tipo');
    wcol('ACCUMULATION', 'Tipo de Acumulación', p_hidden => g_group <> 'METAS');
    wcol('BASE_VALUE', 'Valor Base', 'NUMBER', p_hidden => g_group <> 'METAS', p_align => 'RIGHT');
    wcol('GOAL_VALUE', 'Valor Meta', 'NUMBER', p_hidden => g_group <> 'METAS', p_align => 'RIGHT');
    wcol('PROGRAMMED_VALUE', 'Programado Periodo', 'NUMBER', p_align => 'RIGHT', p_mask => 'FM999G999G999G990D00');
    wcol('ACHIEVED_VALUE', 'Ejecutado Periodo', 'NUMBER', p_align => 'RIGHT', p_mask => 'FM999G999G999G990D00');
    wcol('APPROPRIATED', 'Apropiado', 'NUMBER', p_align => 'RIGHT', p_mask => 'FM$999G999G999G999G990');
    wcol('COMMITMENTS', 'Compromisos', 'NUMBER', p_align => 'RIGHT', p_mask => 'FM$999G999G999G999G990');
    wcol('OBLIGATIONS', 'Obligaciones', 'NUMBER', p_align => 'RIGHT', p_mask => 'FM$999G999G999G999G990');
    wcol('PHYS', 'Avance Físico', 'NUMBER', p_align => 'CENTER',
         p_html => '<div class="spd-gauge spd-gauge--sm" style="--p:#PHYS_P#;--c:#PHYS_COLOR#"><span>#PHYS_P#%</span></div>');
    wcol('FIN', 'Avance Financiero', 'NUMBER', p_align => 'CENTER',
         p_html => '<div class="spd-gauge spd-gauge--sm" style="--p:#FIN_P#;--c:#FIN_COLOR#"><span>#FIN_P#%</span></div>');
    wcol('PHYS_P', 'PHYS_P', p_hidden => true);
    wcol('FIN_P', 'FIN_P', p_hidden => true);
    wcol('PHYS_COLOR', 'PHYS_COLOR', p_hidden => true);
    wcol('FIN_COLOR', 'FIN_COLOR', p_hidden => true);
    wcol('MONITORING_CONFIG_ID', 'MC', 'NUMBER', p_hidden => true);
    wcol('SUBPERIOD', 'SUB', 'NUMBER', p_hidden => true);
    ws_report(case when g_group = 'METAS'
                   then 'GOAL_ID:GOAL:STATUS:ENTITY_CODE:DEV_PLAN_LEVEL_NAME:GOAL_TYPE_LABEL:ACCUMULATION:BASE_VALUE:GOAL_VALUE:PROGRAMMED_VALUE:ACHIEVED_VALUE:APPROPRIATED:COMMITMENTS:OBLIGATIONS:PHYS:FIN'
                   else 'GOAL_ID:GOAL:STATUS:ENTITY_CODE:DEV_PLAN_LEVEL_NAME:GOAL_TYPE_LABEL:PROGRAMMED_VALUE:ACHIEVED_VALUE:APPROPRIATED:COMMITMENTS:OBLIGATIONS:PHYS:FIN' end, 20);
    process('Cargar seguimiento', 'BEFORE_HEADER', 'begin ' || list_load('reviewing', 'm.RECORD_STATUS in (''REVIEWED'', ''APPROVED'')')
      || q'~
begin
  -- documento del avance financiero: el de la ruta, si es del seguimiento, o el primero configurado
  select coalesce(max(case when d.DOC = :#P#SPENT then d.DOC end), max(d.DOC) keep (dense_rank first order by d.POS), 'COMMITMENT')
    into :#P#SPENT
    from SPD_MONITORING_CONFIG mc, json_table(mc.SPENT_DOCS, '$[*]' columns (POS for ordinality, DOC varchar2(20) path '$')) d
   where mc.ID = :#P#MC;
end;
end;~');
    process('Cambiar documento', 'AFTER_SUBMIT', 'null;', 'REQUEST_EQUALS_CONDITION', r('#P#SPENT'));
    wwv_flow_imp_page.create_page_branch(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
      p_branch_name => 'Volver a la página', p_branch_point => 'AFTER_PROCESSING', p_branch_type => 'REDIRECT_URL',
      p_branch_action => 'f?p=&APP_ID.:' || g_page || ':&APP_SESSION.::&DEBUG.:::', p_branch_sequence => 10);
  end loop;

  -- ==========================================================================
  -- 1064 · Ejecución meta (diálogo)
  -- ==========================================================================
  g_page := c_dlg; g_group := null; g_stage := null; l_seq := 0;
  l_js := q'~
function spdNum(v) { v = (v || "").replace(/\./g, "").replace(",", "."); var n = parseFloat(v); return isNaN(n) ? 0 : n; }
function spdFmt(n) { return n.toLocaleString("es-CO", {maximumFractionDigits: 2}); }
// totales por columna (y SGP = suma de las fuentes SGP cuando el seguimiento las discrimina)
function spdTotals() {
  var cols = {};
  $("[data-col]").each(function () { cols[$(this).data("col")] = 1; });
  Object.keys(cols).forEach(function (c) {
    if ($("#spd_sgp_disc").val() === "S") {
      var s = 0; $(".spd-sgp-sub [data-col='" + c + "']").each(function () { s += spdNum(this.value); });
      $("#" + c + "_SGP").val(spdFmt(s));
    }
    var t = 0; $("tr:not(.spd-sgp-sub) [data-col='" + c + "']").each(function () { t += spdNum(this.value); });
    $("#" + c + "_TOTAL").val(spdFmt(t));
  });
}
$(document).on("change keyup", "[data-col]", spdTotals);
$(document).on("click", ".spd-sgp-toggle", function () { $(".spd-sgp-sub").toggle(); $(this).toggleClass("fa-chevron-down fa-chevron-up"); });

// evidencias: eliminar
function spdDelAtt(id) { apex.message.confirm("Está seguro(a) que desea eliminar este archivo?", function (ok) { if (ok) apex.submit({request: "DELETE_ATT", set: {"P1064_ATT_ID": id}}); }); }~';

  wwv_flow_imp_page.remove_page(p_flow_id => c_app, p_page_id => g_page);
  wwv_flow_imp_page.create_page(p_id => g_page, p_flow_id => c_app, p_name => 'SPD_Ejecución de la meta',
    p_alias => 'SPD_EJECUCION_META', p_page_mode => 'MODAL', p_step_title => 'Ejecución meta',
    p_step_template => l_tpl_dlg, p_page_template_options => '#DEFAULT#', p_dialog_width => '1100',
    p_dialog_chained => 'Y', p_autocomplete_on_off => 'OFF', p_protection_level => 'C',
    p_inline_css => l_css, p_javascript_code => l_js, p_javascript_code_onload => 'spdTotals();' || chr(10)
      || '// al cerrar el formulario de focalización se refrescan las grillas' || chr(10)
      || '$(document).on("apexafterclosedialog", function (e, data) { ["spd_tm_ed", "spd_tm_org", "spd_tm_re"].forEach(function (id) { if ($("#" + id).length) apex.region(id).refresh(); });' || chr(10)
      || '  if (data && data.successMessage && data.successMessage.text) apex.message.showPageSuccess(data.successMessage.text); });');

  l_seg := region('Estado', 1, l_tpl_blank);
  for h in (select column_value n from table(sys.odcivarchar2list(
              'MC', 'GOAL_ID', 'MODE', 'ORIGIN', 'SGP_DISC', 'SUPPORT_PI', 'SPENT_DOCS', 'DATE_OK', 'MANUAL_BUDGET', 'EDITABLE',
              'DATA_EDITABLE', 'REC_ID', 'RECORD_STATUS', 'STATUS', 'GOAL_TYPE', 'USER_ID', 'SUBPERIOD', 'ATT_ID', 'MSG'))) loop
    item(l_seg, '#P#' || h.n, h.n);
  end loop;

  -- resumen (GoalSummary), indicadores (MonitoringTrackIndicatorsSummary) y actividades (GoalActivities)
  l_dummy := region('Resumen', 5, l_tpl_blank, 'NATIVE_DYNAMIC_CONTENT', p_source => r(q'~
declare
  l clob;
  procedure add(p varchar2) is begin l := l || p; end;
  function h(v varchar2) return varchar2 is begin return apex_escape.html(v); end;
  function fmt(n number) return varchar2 is
  begin
    return case when n is not null then rtrim(to_char(n, 'FM999G999G999G999G990D99999', 'NLS_NUMERIC_CHARACTERS='',.'''), ',') end;
  end;
  function lov(p_lov varchar2, p_value varchar2) return varchar2 is
    d varchar2(400);
  begin
    select max(DISPLAY_VALUE) into d from APEX_APPLICATION_LOV_ENTRIES
     where APPLICATION_ID = :APP_ID and LIST_OF_VALUES_NAME = p_lov and RETURN_VALUE = p_value;
    return coalesce(d, p_value);
  end;
  function color(p number) return varchar2 is
    c varchar2(30);
  begin
    select coalesce(
             (select c.COLOR from V_SPD_MONITORING_COLORS c where c.ID = :#P#MC
                 and p >= c.FROM_VALUE * :#P#SUBPERIOD / 4 and p <= c.TO_VALUE * :#P#SUBPERIOD / 4 order by c.POS fetch first 1 row only),
             (select max(c.COLOR) keep (dense_rank last order by c.POS) from V_SPD_MONITORING_COLORS c where c.ID = :#P#MC), '#1677ff')
      into c from dual;
    return c;
  end;
  procedure bar(p_label varchar2, p_value number) is
    p number := round(nvl(p_value, 0) * 100, 2);
  begin
    add('<span>' || p_label || '</span><div class="spd-bar"><i style="width:' || to_char(least(p, 100), 'FM990D00', 'NLS_NUMERIC_CHARACTERS=''.,''')
      || '%;background:' || color(p) || '"></i></div><span>' || fmt(p) || '%</span>');
  end;
begin
  if :#P#REC_ID is null then
    return '<div class="spd-alert">La meta no tiene programación en este seguimiento.</div>';
  end if;
  for g in (select g.*, e.CODIGO_ENT_PRY, e.NOMBRE_ENT_PRY, dl.CODE as L_CODE, dl.NAME as L_NAME,
                   (select c.SINGULAR_NAME from V_SPD_PLAN_LEVEL_CONFIG c
                     where c.NIT_COMPANIA = g.NIT_COMPANIA and c.PLAN = g.PLAN and c.NUM = dl."LEVEL") as LEVEL_LABEL
              from SPD_GOAL g
              left join ENTIDADES_PRY e on e.ID = g.ENTITY_ID
              left join SPD_DEV_PLAN_LEVEL dl on dl.ID = g.DEV_PLAN_LEVEL_ID
             where g.ID = :#P#GOAL_ID) loop
    add('<details class="spd-collapse"><summary><b>' || h(g.CODE) || case when g.GOAL_TYPE not in ('PROJECT', 'ACTION_PLAN') then ':</b> ' || h(g.NAME) else '</b>' end
      || '</summary><div><table class="spd-desc">'
      || '<tr><th>ID</th><td>' || g.ID || '</td><th>Código</th><td>' || h(g.CODE) || '</td></tr>'
      || '<tr><th>Meta</th><td colspan="3">' || h(g.NAME) || '</td></tr>'
      || '<tr><th>Entidad</th><td colspan="3">' || h(g.CODIGO_ENT_PRY || ' - ' || g.NOMBRE_ENT_PRY) || '</td></tr>'
      || '<tr><th>Tipo de meta</th><td>' || h(lov('SPD - TIPO DE META', g.GOAL_TYPE)) || '</td><th>'
      || h(coalesce(g.LEVEL_LABEL, 'Nivel del plan')) || '</th><td>' || h(g.L_CODE || ' - ' || g.L_NAME) || '</td></tr>'
      || case when g.GOAL_TYPE in ('PRODUCT', 'RESULT', 'IMPACT', 'WELL_BEING') then
           case when g.INDICATOR is not null then '<tr><th>Indicador</th><td colspan="3">' || h(g.INDICATOR) || '</td></tr>' end
           || '<tr><th>Unidades</th><td>' || h(g.UNITS_NAME) || '</td><th>Tipo de acumulación</th><td>'
           || h(lov('SPD - TIPO DE ACUMULACION', g.ACCUMULATION_TYPE)) || '</td></tr>'
           || '<tr><th>Valor base</th><td>' || fmt(g.BASE_VALUE) || '</td><th>Valor meta</th><td>' || fmt(g.GOAL_VALUE) || '</td></tr>' end
      || case when g.PROJECT_CODE is not null then '<tr><th>Proyecto</th><td colspan="3">' || h(g.PROJECT_CODE) || '</td></tr>' end
      || '</table></div></details>');
  end loop;

  -- indicadores (abierto por defecto)
  add('<details class="spd-collapse" open><summary><b>Indicadores</b></summary><div><div class="spd-bars">');
  for x in (select r.PHYSICAL_INDICATOR from SPD_MONITORING_RECORD r where r.ID = :#P#REC_ID) loop
    if :#P#GOAL_TYPE <> 'PROJECT' then bar('Avance Físico', x.PHYSICAL_INDICATOR); end if;
  end loop;
  for d in (select jt.DOC, jt.POS from SPD_MONITORING_CONFIG mc,
                   json_table(mc.SPENT_DOCS, '$[*]' columns (POS for ordinality, DOC varchar2(20) path '$')) jt
             where mc.ID = :#P#MC order by jt.POS) loop
    declare
      fi number;
    begin
      select max(FINANCIAL_INDICATOR) into fi from SPD_MONITORING_RECORD_RESOURCE
       where MONITORING_RECORD_ID = :#P#REC_ID and RESOURCE_TYPE = d.DOC;
      bar('Avance Financiero - ' || case d.DOC when 'COMMITMENT' then 'Compromisos' when 'OBLIGATION' then 'Obligaciones' else 'Pagos' end, fi);
    end;
  end loop;
  add('</div></div></details>');

  if :#P#GOAL_TYPE in ('PRODUCT', 'RESULT', 'IMPACT', 'WELL_BEING') then
    declare
      n pls_integer := 0;
      a clob := '<table class="spd-tbl"><tr><th>Proyecto</th><th>Actividad</th><th style="text-align:right">Ponderación</th></tr>';
    begin
      add('<details class="spd-collapse"><summary><b>Actividades</b></summary><div>');
      for x in (select PROYECTO, CODIGO_ACT, WEIGHTING from SPD_ACTIVITY_GOAL where GOAL_ID = :#P#GOAL_ID order by PROYECTO, CODIGO_ACT) loop
        n := n + 1;
        a := a || to_char('<tr><td>' || x.PROYECTO || '</td><td>' || x.CODIGO_ACT || '</td><td style="text-align:right">' || fmt(x.WEIGHTING) || '</td></tr>');
      end loop;
      if n = 0 then add('<div class="spd-empty"><span class="fa fa-inbox"></span>No hay datos</div>'); else l := l || a; add('</table>'); end if;
      add('</div></details>');
    end;
  end if;
  return l;
end;~'));

  -- decisión de validación / revisión
  l_dummy := region('Decisión', 6, l_tpl_std, p_cond_type => 'PLSQL_EXPRESSION',
    p_cond => r(':#P#MODE in (''VALIDATE'', ''REVIEW'') and :#P#REC_ID is not null'));
  item(l_dummy, '#P#VALIDATED', 'Validación', 'NATIVE_RADIOGROUP', 'STATIC2:Validada;VALIDATED,Sin Validar;REPORTED',
       p_cond_type => 'VAL_OF_ITEM_IN_COND_EQ_COND2', p_cond => r('#P#MODE'), p_cond2 => 'VALIDATE',
       p_ro_type => 'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2', p_ro => r('#P#EDITABLE'), p_ro2 => 'S');
  item(l_dummy, '#P#REVIEWED', 'Revisión', 'NATIVE_RADIOGROUP', 'STATIC2:Aprobada;REVIEWED,Rechazada;REJECTED',
       p_cond_type => 'VAL_OF_ITEM_IN_COND_EQ_COND2', p_cond => r('#P#MODE'), p_cond2 => 'REVIEW',
       p_ro_type => 'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2', p_ro => r('#P#EDITABLE'), p_ro2 => 'S');
  item(l_dummy, '#P#REVIEW_NOTES', 'Observación', 'NATIVE_TEXT_FIELD',
       p_cond_type => 'VAL_OF_ITEM_IN_COND_EQ_COND2', p_cond => r('#P#MODE'), p_cond2 => 'REVIEW',
       p_ro_type => 'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2', p_ro => r('#P#EDITABLE'), p_ro2 => 'S', p_span => 12);

  l_tabs := region('Pestañas', 10, l_tpl_tabs, p_options => '#DEFAULT#:t-TabsRegion-mod--simple',
                   p_cond_type => 'ITEM_IS_NOT_NULL', p_cond => r('#P#REC_ID'));

  -- Avance Cuantitativo (MonitoringTrackQuantitative)
  l_dummy := region('Avance Cuantitativo', 10, l_tpl_blank, 'NATIVE_DYNAMIC_CONTENT', p_parent => l_tabs, p_source => r(q'~
declare
  l      clob;
  dis    varchar2(20) := case when :#P#DATA_EDITABLE = 'S' then null else ' disabled' end;
  type t_res is table of varchar2(30);
  f  t_res := t_res('RP', 'SGP', 'SGP_EDUCATION', 'SGP_HEALTH', 'SGP_WATER', 'SGP_CULTURE', 'SGP_SPORT', 'SGP_FREE_INVESTMENT',
                    'SGP_FREE_DESTINATION', 'SGP_SCHOOL_FEEDING', 'SGP_MAGDALENA_RIVER', 'SGP_EARLY_CHILDHOOD',
                    'CN', 'CD', 'SGR', 'CREDIT', 'OTHERS', 'MANAGEMENT', 'OPERATION');
  lb t_res := t_res('Recursos Propios', 'Recursos SGP', 'Educación', 'Salud', 'Agua Potable', 'Cultura', 'Deporte', 'Libre Inversión',
                    'Libre Destinación', 'Alimentación Escolar', 'Río Magdalena', 'Primera Infancia',
                    'Recursos CN', 'Recursos CD', 'Recursos SGR', 'Recursos Crédito', 'Otros Recursos', 'Recursos Gestión',
                    'Recursos Funcionamiento');
  type t_rows is table of SPD_MONITORING_RECORD_RESOURCE%rowtype index by varchar2(20);
  res t_rows;
  rec SPD_MONITORING_RECORD%rowtype;
  type t_cols is table of varchar2(20);
  cols t_cols := t_cols();      -- tipos de recurso por columna
  heads t_cols := t_cols();
  keys t_cols := t_cols();      -- prefijo de los id (u, f, c1..c3)
  idx t_cols := t_cols();       -- nombre del arreglo fNN (solo las columnas de ejecución)
  edit t_cols := t_cols();      -- 'S' si la columna es editable
  sgp_disc boolean := :#P#SGP_DISC = 'S';
  is_plan boolean := :#P#GOAL_TYPE in ('ACTION_PLAN', 'ACTION_PLAN_ACTIVITY');
  n pls_integer := 0;
  procedure add(p varchar2) is begin l := l || p; end;
  function fmt(n number) return varchar2 is
  begin
    return case when n is not null then rtrim(to_char(n, 'FM999G999G999G999G990D99999', 'NLS_NUMERIC_CHARACTERS='',.'''), ',') end;
  end;
  function val(t varchar2, c varchar2) return number is
    r SPD_MONITORING_RECORD_RESOURCE%rowtype;
  begin
    if not res.exists(t) then return null; end if;
    r := res(t);
    return case c when 'RP' then r.RP when 'SGP' then r.SGP when 'SGP_EDUCATION' then r.SGP_EDUCATION
      when 'SGP_HEALTH' then r.SGP_HEALTH when 'SGP_WATER' then r.SGP_WATER when 'SGP_CULTURE' then r.SGP_CULTURE
      when 'SGP_SPORT' then r.SGP_SPORT when 'SGP_FREE_INVESTMENT' then r.SGP_FREE_INVESTMENT
      when 'SGP_FREE_DESTINATION' then r.SGP_FREE_DESTINATION when 'SGP_SCHOOL_FEEDING' then r.SGP_SCHOOL_FEEDING
      when 'SGP_MAGDALENA_RIVER' then r.SGP_MAGDALENA_RIVER when 'SGP_EARLY_CHILDHOOD' then r.SGP_EARLY_CHILDHOOD
      when 'CN' then r.CN when 'CD' then r.CD when 'SGR' then r.SGR when 'CREDIT' then r.CREDIT when 'OTHERS' then r.OTHERS
      when 'MANAGEMENT' then r.MANAGEMENT when 'OPERATION' then r.OPERATION end;
  end;
  procedure col(p_type varchar2, p_head varchar2, p_key varchar2, p_idx varchar2, p_edit varchar2) is
  begin
    cols.extend; heads.extend; keys.extend; idx.extend; edit.extend;
    cols(cols.count) := p_type; heads(cols.count) := p_head; keys(cols.count) := p_key; idx(cols.count) := p_idx; edit(cols.count) := p_edit;
  end;
begin
  select * into rec from SPD_MONITORING_RECORD where ID = :#P#REC_ID;
  for x in (select * from SPD_MONITORING_RECORD_RESOURCE where MONITORING_RECORD_ID = rec.ID) loop
    res(x.RESOURCE_TYPE) := x;
  end loop;
  -- programación (solo lectura): Programación (MANUAL) y/o Apropiado (DEFINITIVE; no en planes de acción)
  if :#P#ORIGIN in ('USER', 'USER_AND_FINANCIAL') then col('MANUAL', 'Programación', 'u', null, 'N'); end if;
  if :#P#ORIGIN in ('FINANCIAL', 'USER_AND_FINANCIAL') and not is_plan then col('DEFINITIVE', 'Apropiado', 'f', null, 'N'); end if;
  -- ejecución: una columna por documento del seguimiento; editable con presupuesto manual (o meta de plan de acción)
  for d in (select jt.DOC, jt.POS from SPD_MONITORING_CONFIG mc,
                   json_table(mc.SPENT_DOCS, '$[*]' columns (POS for ordinality, DOC varchar2(20) path '$')) jt
             where mc.ID = :#P#MC order by jt.POS) loop
    n := n + 1;
    exit when n > 3;
    col(d.DOC, case d.DOC when 'COMMITMENT' then 'Compromisos' when 'OBLIGATION' then 'Obligaciones' else 'Pagos' end,
        'c' || n, 'f' || to_char(5 + n, 'FM00'),
        case when dis is null and (:#P#MANUAL_BUDGET = 'S' or :#P#GOAL_TYPE = 'ACTION_PLAN_ACTIVITY') then 'S' else 'N' end);
  end loop;

  add('<input type="hidden" id="spd_sgp_disc" value="' || :#P#SGP_DISC || '"><table class="spd-form">'
    || '<tr><th class="spd-noc"></th><td class="spd-colhead">Programación</td><td class="spd-colhead">Ejecución</td></tr>');
  if :#P#GOAL_TYPE not in ('PROJECT', 'ACTION_PLAN') then
    add('<tr><th>Logro Meta</th><td><input type="text" class="spd-num" value="' || fmt(rec.GOAL_VALUE) || '" disabled></td>'
      || '<td><input type="text" name="f01" class="spd-num" value="' || fmt(rec.GOAL_ACHIEVED_VALUE) || '"' || dis || '></td></tr>');
  end if;
  if :#P#SUPPORT_PI = 'S' then
    add('<tr><th>Logro Indicador Producto</th><td><input type="text" class="spd-num" value="' || fmt(rec.PI_GOAL_VALUE) || '" disabled></td>'
      || '<td><input type="text" name="f02" class="spd-num" value="' || fmt(rec.PI_GOAL_ACHIEVED_VALUE) || '"' || dis || '></td></tr>');
  end if;
  add('</table><table class="spd-form"><tr><th>Origen Datos Financieros</th>');
  for c in 1 .. cols.count loop add('<td class="spd-colhead">' || heads(c) || '</td>'); end loop;
  add('</tr>');
  for i in 1 .. f.count loop
    add('<tr' || case when f(i) like 'SGP\_%' escape '\' then ' class="spd-sgp-sub" style="display:none"' end || '><th'
      || case when f(i) = 'SGP' and sgp_disc then ' class="spd-noc"' end || '>'
      || case when f(i) = 'SGP' and sgp_disc then '<span class="fa fa-chevron-down spd-sgp-toggle"></span><b>' || lb(i) || '</b>' else lb(i) end
      || '</th>');
    for c in 1 .. cols.count loop
      add('<td><input type="text"' || case when idx(c) is not null then ' name="' || idx(c) || '"' end
        || ' id="' || keys(c) || '_' || f(i) || '" data-col="' || keys(c) || '" class="spd-money" value="' || fmt(val(cols(c), f(i)))
        || '" placeholder="$"'
        || case when edit(c) = 'S' then case when f(i) = 'SGP' and sgp_disc then ' readonly' end
                when idx(c) is not null then ' readonly tabindex="-1"' else ' disabled' end || '></td>');
    end loop;
    add('</tr>');
  end loop;
  add('<tr class="spd-total"><th class="spd-noc">Total Recursos:</th>');
  for c in 1 .. cols.count loop
    add('<td><input type="text" id="' || keys(c) || '_TOTAL" class="spd-money" placeholder="$" disabled></td>');
  end loop;
  add('</tr></table>');
  return l;
end;~'));

  -- Avance Cualitativo, Obs. Generales
  l_dummy := region('Avance Cualitativo', 20, l_tpl_blank, 'NATIVE_DYNAMIC_CONTENT', p_parent => l_tabs, p_source => r(q'~
declare
  rec SPD_MONITORING_RECORD%rowtype;
  dis varchar2(20) := case when :#P#DATA_EDITABLE = 'S' then null else ' disabled' end;
  function q(p_name varchar2, p_label varchar2, p_value clob) return varchar2 is
  begin
    return '<div class="spd-q"><label>' || p_label || '</label><textarea name="' || p_name || '" rows="4" class="spd-ta"' || dis || '>'
      || apex_escape.html(dbms_lob.substr(p_value, 8000, 1)) || '</textarea></div>';
  end;
begin
  select * into rec from SPD_MONITORING_RECORD where ID = :#P#REC_ID;
  return q('f11', 'En qué consistió el logro del indicador/meta?', rec.QUESTION_HOW)
      || q('f12', 'Qué impacto, aspecto positivo o población beneficiada se logró?', rec.QUESTION_RESULT)
      || q('f13', 'Cómo se evidencia el logro o gestión?', rec.QUESTION_EVIDENCE)
      || q('f14', 'Qué dificultad de presentó para el logro del indicador/meta?', rec.QUESTION_PROBLEM);
end;~'));
  l_dummy := region('Obs. Generales', 30, l_tpl_blank, 'NATIVE_DYNAMIC_CONTENT', p_parent => l_tabs, p_source => r(q'~
declare
  rec SPD_MONITORING_RECORD%rowtype;
begin
  select * into rec from SPD_MONITORING_RECORD where ID = :#P#REC_ID;
  return '<div class="spd-q"><label>Notas Generales</label><textarea name="f15" rows="10" class="spd-ta"'
    || case when :#P#DATA_EDITABLE = 'S' then null else ' disabled' end || '>'
    || apex_escape.html(dbms_lob.substr(rec.NOTES, 8000, 1)) || '</textarea></div>';
end;~'));

  -- Focalización (MonitoringTrackTargetED / Org / RE): una grilla de localizaciones por sección; Agregar / editar abre el 1065
  tm_grid('Focalización E.D.', 40, 'ed');
  tm_grid('Focalización Org.', 50, 'org');
  tm_grid('Focalización R.E.', 60, 're');

  -- Evidencias (MonitoringTrackAttachments)
  l_dummy := region('Evidencias', 70, l_tpl_blank, 'NATIVE_DYNAMIC_CONTENT', p_parent => l_tabs, p_source => r(q'~
declare
  l clob := '<table class="spd-tbl"><tr><th>Archivo</th><th>Descripción</th><th>Fecha</th><th></th></tr>';
  rw varchar2(32767);
  n pls_integer := 0;
begin
  for a in (select ID, NAME, DESCRIPTION, S3_PATH, CREATED_AT from SPD_MONITORING_RECORD_ATTACH
             where MONITORING_RECORD_ID = :#P#REC_ID order by CREATED_AT) loop
    n := n + 1;
    rw := '<tr><td><span class="fa fa-file-o"></span> <span title="' || apex_escape.html_attribute(a.S3_PATH) || '">'
      || apex_escape.html(a.NAME) || '</span></td><td>' || apex_escape.html(a.DESCRIPTION) || '</td><td>'
      || to_char(a.CREATED_AT at time zone 'America/Bogota', 'YYYY-MM-DD HH24:MI') || '</td><td style="text-align:right">'
      || case when :#P#DATA_EDITABLE = 'S' then '<button type="button" class="t-Button t-Button--small t-Button--danger" onclick="spdDelAtt('
              || a.ID || ')"><span class="fa fa-trash-o"></span></button>' end || '</td></tr>';
    l := l || rw;
  end loop;
  return '<div class="spd-alert">Los archivos del original se guardan en S3: aquí se listan y se pueden eliminar; '
      || 'la carga de archivos queda pendiente de definir el almacenamiento en el SIIF.</div>'
      || case when n = 0 then '<div class="spd-empty"><span class="fa fa-inbox"></span>No hay datos</div>' else l || '</table>' end;
end;~'));

  -- Indicadores (MonitoringTrackIndicators)
  l_dummy := region('Indicadores', 80, l_tpl_blank, 'NATIVE_DYNAMIC_CONTENT', p_parent => l_tabs, p_source => r(q'~
declare
  -- tarjetas: anillo con el color del rango configurado en el seguimiento, etiqueta del rango y
  -- las cifras de las que sale el porcentaje (logro / programado, ejecutado / apropiado)
  l      clob := '<div class="spd-ind">';
  l_base varchar2(20) := case when :#P#GOAL_TYPE in ('ACTION_PLAN', 'ACTION_PLAN_ACTIVITY') then 'MANUAL' else 'DEFINITIVE' end;
  l_appr number;
  n      pls_integer := 0;
  function pct(p number) return varchar2 is
  begin
    return to_char(p, 'FM999G990D00', 'NLS_NUMERIC_CHARACTERS=''.,''') || '%';
  end;
  function fmt(v number) return varchar2 is
  begin
    return case when v is null then '—' else to_char(v, 'FM999G999G999G990D00', 'NLS_NUMERIC_CHARACTERS=''.,''') end;
  end;
  function money(v number) return varchar2 is
  begin
    return case when v is null then '—' else to_char(v, 'FM$999G999G999G999G990', 'NLS_NUMERIC_CHARACTERS=''.,''') end;
  end;
  function total(p_type varchar2) return number is
    t number;
  begin
    select sum(nvl(CAPITAL,0) + nvl(CD,0) + nvl(CN,0) + nvl(CREDIT,0) + nvl(DE,0) + nvl(OPERATION,0) + nvl(MANAGEMENT,0)
             + nvl(MONOPOLY,0) + nvl(OTHERS,0) + nvl(RP,0) + nvl(SGP,0) + nvl(SGR,0))
      into t from SPD_MONITORING_RECORD_RESOURCE where MONITORING_RECORD_ID = :#P#REC_ID and RESOURCE_TYPE = p_type;
    return t;
  end;
  function card(p_kicker varchar2, p_title varchar2, p_value number, p_figs varchar2) return varchar2 is
    p  number := round(nvl(p_value, 0) * 100, 2);
    c  varchar2(30);
    lb varchar2(200);
  begin
    -- rango de color (los límites se escalan al subperiodo, como en los tableros)
    begin
      select c.COLOR, c.LABEL into c, lb from V_SPD_MONITORING_COLORS c
       where c.ID = :#P#MC and p >= c.FROM_VALUE * :#P#SUBPERIOD / 4 and p <= c.TO_VALUE * :#P#SUBPERIOD / 4
       order by c.POS fetch first 1 row only;
    exception when no_data_found then
      select max(c.COLOR) keep (dense_rank last order by c.POS), max(c.LABEL) keep (dense_rank last order by c.POS)
        into c, lb from V_SPD_MONITORING_COLORS c where c.ID = :#P#MC;
    end;
    c := nvl(c, '#1677ff');
    n := n + 1;
    return '<div class="spd-ind-card"><div class="spd-ind-kicker">' || p_kicker || '</div>'
        || '<div class="spd-ind-title">' || p_title || '</div>'
        || '<div class="spd-gauge spd-gauge--lg" style="--p:' || to_char(least(p, 100), 'FM990D00', 'NLS_NUMERIC_CHARACTERS=''.,''')
        || ';--c:' || c || '"><span>' || pct(p) || '</span></div>'
        || case when lb is not null then '<span class="spd-ind-chip" style="--c:' || c || '"><i></i>' || apex_escape.html(lb) || '</span>' end
        || '<div class="spd-ind-figs">' || p_figs || '</div></div>';
  end;
begin
  if :#P#GOAL_TYPE <> 'PROJECT' then
    for x in (select PHYSICAL_INDICATOR, GOAL_VALUE, GOAL_ACHIEVED_VALUE from SPD_MONITORING_RECORD where ID = :#P#REC_ID) loop
      l := l || card('Avance físico', 'Logro de la meta', x.PHYSICAL_INDICATOR,
                     '<span>Programado</span><b>' || fmt(x.GOAL_VALUE) || '</b>'
                  || '<span>Logrado</span><b>' || fmt(x.GOAL_ACHIEVED_VALUE) || '</b>');
    end loop;
  end if;
  l_appr := total(l_base);
  if l_appr is null and l_base = 'MANUAL' then   -- plan sin programación manual: lo apropiado
    l_base := 'DEFINITIVE';
    l_appr := total(l_base);
  end if;
  for d in (select jt.DOC, jt.POS from SPD_MONITORING_CONFIG mc,
                   json_table(mc.SPENT_DOCS, '$[*]' columns (POS for ordinality, DOC varchar2(20) path '$')) jt
             where mc.ID = :#P#MC order by jt.POS) loop
    declare
      fi number;
    begin
      select max(FINANCIAL_INDICATOR) into fi from SPD_MONITORING_RECORD_RESOURCE where MONITORING_RECORD_ID = :#P#REC_ID and RESOURCE_TYPE = d.DOC;
      l := l || card('Avance financiero',
                     case d.DOC when 'COMMITMENT' then 'Compromisos' when 'OBLIGATION' then 'Obligaciones' else 'Pagos' end, fi,
                     '<span>' || case l_base when 'MANUAL' then 'Programado' else 'Apropiado' end || '</span><b>' || money(l_appr) || '</b>'
                  || '<span>Ejecutado</span><b>' || money(total(d.DOC)) || '</b>');
    end;
  end loop;
  if n = 0 then
    return '<div class="spd-empty"><span class="fa fa-inbox"></span>No hay indicadores para este seguimiento</div>';
  end if;
  return l || '</div>';
end;~'));

  -- Historial
  l_dummy := region('Historial', 90, l_tpl_blank, 'NATIVE_DYNAMIC_CONTENT', p_parent => l_tabs, p_source => r(q'~
declare
  l clob := '<ul class="spd-hist">';
  rw varchar2(32767);
  n pls_integer := 0;
begin
  for x in (select h.EVENT, h.DESCRIPTION, h.CREATED_AT, u.DESCRIPCION as USER_NAME
              from SPD_GOAL_HISTORY h
              left join SPD_MONITORING_RECORD r on r.ID = h.MONITORING_RECORD_ID
              left join USUARIOS u on u.ID = h.CREATED_BY and u.NIT_COMPANIA = :G_NIT_COMPANIA
             where h.GOAL_ID = :#P#GOAL_ID and (r.ID is null or r.MONITORING_CONFIG_ID = :#P#MC)
             order by h.CREATED_AT, h.ID) loop
    n := n + 1;
    rw := '<li><span class="spd-avatar" title="' || apex_escape.html_attribute(coalesce(x.USER_NAME, 'SPD')) || '">'
      || apex_escape.html(case when x.USER_NAME is null then 'S'
                               else upper(substr(x.USER_NAME, 1, 1) || substr(regexp_substr(x.USER_NAME, '\S+', 1, 2), 1, 1)) end)
      || '</span><div><div class="spd-hist-title">'
      || case x.EVENT when 'CREATED' then 'Creada' when 'MONITORED' then 'Reportada' when 'REJECTED' then 'Rechazada'
              when 'REVIEWED' then 'Aprobada' when 'SCHEDULED' then 'Programada' when 'UPDATED' then 'Actualizada'
              when 'VALIDATED' then 'Validada' end
      || ' - ' || to_char(x.CREATED_AT at time zone 'America/Bogota', 'YYYY-MM-DD HH24:MI:SS')
      || '</div><div class="spd-hist-desc">' || apex_escape.html(x.DESCRIPTION) || '</div></div></li>';
    l := l || rw;
  end loop;
  if n = 0 then
    return '<div class="spd-empty"><span class="fa fa-inbox"></span>No hay datos</div>';
  end if;
  return l || '</ul>';
end;~'));

  -- pie: Volver / Guardar
  l_seg := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_page_plug(p_id => l_seg, p_flow_id => c_app, p_page_id => g_page, p_plug_name => 'Botones',
    p_region_template_options => '#DEFAULT#', p_plug_template => l_tpl_btns, p_plug_display_sequence => 20,
    p_plug_display_point => 'REGION_POSITION_03', p_plug_source_type => 'NATIVE_STATIC');
  l_btn := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_page_button(p_id => l_btn, p_flow_id => c_app, p_flow_step_id => g_page,
    p_button_sequence => 10, p_button_plug_id => l_seg, p_button_name => 'VOLVER', p_button_action => 'DEFINED_BY_DA',
    p_button_template_options => '#DEFAULT#', p_button_template_id => l_tpl_btn, p_button_image_alt => 'Volver',
    p_button_position => 'CLOSE', p_warn_on_unsaved_changes => null);
  wwv_flow_imp_page.create_page_button(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
    p_button_sequence => 20, p_button_plug_id => l_seg, p_button_name => 'SAVE', p_button_action => 'SUBMIT',
    p_button_template_options => '#DEFAULT#', p_button_template_id => l_tpl_btn, p_button_is_hot => 'Y',
    p_button_image_alt => 'Guardar', p_button_position => 'NEXT',
    p_button_condition_type => 'VAL_OF_ITEM_IN_COND_EQ_COND2', p_button_condition => r('#P#EDITABLE'), p_button_condition2 => 'S');
  l_evt := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_page_da_event(p_id => l_evt, p_flow_id => c_app, p_page_id => g_page,
    p_name => 'Volver', p_event_sequence => 10, p_triggering_element_type => 'BUTTON',
    p_triggering_button_id => l_btn, p_bind_type => 'bind', p_execution_type => 'IMMEDIATE', p_bind_event_type => 'click');
  wwv_flow_imp_page.create_page_da_action(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_page_id => g_page,
    p_event_id => l_evt, p_event_result => 'TRUE', p_action_sequence => 10, p_execute_on_page_init => 'N',
    p_action => 'NATIVE_DIALOG_CANCEL');

  -- carga: estado de la meta en la etapa, ventana de fechas y permisos de edición
  process('Cargar ejecución', 'BEFORE_HEADER', q'~
declare
  mc SPD_MONITORING_CONFIG%rowtype;
  l_window varchar2(20);
  function ts(v varchar2) return timestamp with time zone is
  begin
    return from_tz(to_timestamp(substr(v, 1, 23), 'YYYY-MM-DD"T"HH24:MI:SS.FF3'), 'UTC');
  end;
begin
  :#P#MODE := nvl(:#P#MODE, 'VIEW');
  select * into mc from SPD_MONITORING_CONFIG where ID = :#P#MC and NIT_COMPANIA = :G_NIT_COMPANIA;
  :#P#ORIGIN := mc.MONITORING_RESOURCES_ORIGIN;
  :#P#SGP_DISC := mc.SGP_DISCRIMINATED;
  :#P#SUPPORT_PI := mc.SUPPORT_PRODUCT_MONITORING;
  :#P#SUBPERIOD := mc.SUBPERIOD;
  l_window := case :#P#MODE when 'REPORT' then 'reporting' when 'VALIDATE' then 'validating' when 'REVIEW' then 'reviewing' end;
  :#P#DATE_OK := 'N';
  if l_window is not null then
    begin
      if systimestamp between ts(json_value(mc.DATES_CONFIG, '$.' || l_window || '[0]'))
                          and ts(json_value(mc.DATES_CONFIG, '$.' || l_window || '[1]')) then
        :#P#DATE_OK := 'S';
      end if;
    exception when others then null;
    end;
  end if;
  select max(u.ID), max(e.SPD_PRESUPUESTO_MANUAL) into :#P#USER_ID, :#P#MANUAL_BUDGET
    from USUARIOS u
    left join ENTIDADES_PRY e on e.NIT_COMPANIA = u.NIT_COMPANIA and e.CODIGO_ENT_PRY = u.CODIGO_ENT_PRY
   where u.NIT_COMPANIA = :G_NIT_COMPANIA and (upper(u.USUARIO) = upper(:APP_USER) or upper(u.EMAIL) = upper(:APP_USER));

  select max(MONITORING_RECORD_ID), max(RECORD_STATUS), max(GOAL_TYPE),
         max(case :#P#MODE when 'REPORT' then REPORT_STATUS when 'VALIDATE' then VALIDATION_STATUS else REVIEW_STATUS end)
    into :#P#REC_ID, :#P#RECORD_STATUS, :#P#GOAL_TYPE, :#P#STATUS
    from V_SPD_GOAL_MONITORING
   where NIT_COMPANIA = :G_NIT_COMPANIA and MONITORING_CONFIG_ID = mc.ID and GOAL_ID = :#P#GOAL_ID;

  :#P#EDITABLE := case
    when :#P#REC_ID is null or :#P#DATE_OK <> 'S' then 'N'
    when :#P#MODE = 'REPORT'   and :#P#RECORD_STATUS not in ('VALIDATED', 'REVIEWED', 'APPROVED') then 'S'
    when :#P#MODE = 'VALIDATE' and :#P#RECORD_STATUS not in ('REVIEWED', 'APPROVED') then 'S'
    when :#P#MODE = 'REVIEW' then 'S'
    else 'N' end;
  -- en la revisión solo se decide; los datos del reporte quedan de solo lectura
  :#P#DATA_EDITABLE := case when :#P#EDITABLE = 'S' and :#P#MODE in ('REPORT', 'VALIDATE') then 'S' else 'N' end;
  :#P#VALIDATED := case when :#P#RECORD_STATUS in ('VALIDATED', 'REVIEWED', 'APPROVED') then 'VALIDATED' else 'REPORTED' end;
  :#P#REVIEWED := case when :#P#RECORD_STATUS = 'REJECTED' then 'REJECTED' else 'REVIEWED' end;
end;~');

  process('Eliminar evidencia', 'AFTER_SUBMIT', q'~
begin
  if :#P#DATA_EDITABLE = 'S' then
    delete from SPD_MONITORING_RECORD_ATTACH where ID = :#P#ATT_ID and MONITORING_RECORD_ID = :#P#REC_ID;
  end if;
end;~', 'REQUEST_EQUALS_CONDITION', 'DELETE_ATT');

  -- guardar = saveTrackingMonitoringRecord
  process('Guardar ejecución', 'AFTER_SUBMIT', q'~
declare
  rec    SPD_MONITORING_RECORD%rowtype;
  l_status varchar2(20);
  l_event  varchar2(20);
  l_sched  varchar2(20) := case when :#P#GOAL_TYPE in ('ACTION_PLAN', 'ACTION_PLAN_ACTIVITY') then 'MANUAL' else 'DEFINITIVE' end;
  v1 number; v2 number; h1 varchar2(1); h2 varchar2(1);
  q1 varchar2(32767); q2 varchar2(32767); q3 varchar2(32767); q4 varchar2(32767); q5 varchar2(32767);
  k1 varchar2(1); k2 varchar2(1); k3 varchar2(1); k4 varchar2(1); k5 varchar2(1);
  l_tm   clob;
  type t_res is table of varchar2(30);
  f  t_res := t_res('RP', 'SGP', 'SGP_EDUCATION', 'SGP_HEALTH', 'SGP_WATER', 'SGP_CULTURE', 'SGP_SPORT', 'SGP_FREE_INVESTMENT',
                    'SGP_FREE_DESTINATION', 'SGP_SCHOOL_FEEDING', 'SGP_MAGDALENA_RIVER', 'SGP_EARLY_CHILDHOOD',
                    'CN', 'CD', 'SGR', 'CREDIT', 'OTHERS', 'MANAGEMENT', 'OPERATION');
  function num(v varchar2) return number is
  begin
    if trim(v) is null then return null; end if;
    return to_number(replace(replace(trim(v), '.', ''), ',', '.'), '999999999999999999999D999999', 'NLS_NUMERIC_CHARACTERS=''.,''');
  exception when others then
    raise_application_error(-20001, 'Valor numérico no válido: ' || v);
  end;
  function txt(p apex_application_global.vc_arr2) return varchar2 is
  begin
    return case when p.exists(1) then p(1) end;
  end;
  -- total de un recurso: los mismos campos que calculateFinancialIndicator
  function total(p_rec number, p_type varchar2) return number is
    t number;
  begin
    select sum(CAPITAL + CD + CN + CREDIT + DE + OPERATION + MANAGEMENT + MONOPOLY + OTHERS + RP + SGP + SGR) into t
      from SPD_MONITORING_RECORD_RESOURCE where MONITORING_RECORD_ID = p_rec and RESOURCE_TYPE = p_type;
    return t;
  end;
  procedure save_res(p_type varchar2, p apex_application_global.vc_arr2) is
    v  apex_t_number := apex_t_number();
    l_sgp number;
    l_s number;
    l_t number;
  begin
    if p.count = 0 then return; end if;
    v.extend(f.count);
    for i in 1 .. f.count loop v(i) := case when p.exists(i) then nvl(num(p(i)), 0) else 0 end; end loop;
    l_sgp := case when :#P#SGP_DISC = 'S' then v(3) + v(4) + v(5) + v(6) + v(7) + v(8) + v(9) + v(10) + v(11) + v(12) else v(2) end;
    merge into SPD_MONITORING_RECORD_RESOURCE t
    using (select rec.ID as MONITORING_RECORD_ID, p_type as RESOURCE_TYPE from dual) s
       on (t.MONITORING_RECORD_ID = s.MONITORING_RECORD_ID and t.RESOURCE_TYPE = s.RESOURCE_TYPE)
     when matched then update set RP = v(1), SGP = l_sgp, SGP_EDUCATION = v(3), SGP_HEALTH = v(4), SGP_WATER = v(5),
          SGP_CULTURE = v(6), SGP_SPORT = v(7), SGP_FREE_INVESTMENT = v(8), SGP_FREE_DESTINATION = v(9),
          SGP_SCHOOL_FEEDING = v(10), SGP_MAGDALENA_RIVER = v(11), SGP_EARLY_CHILDHOOD = v(12), CN = v(13), CD = v(14),
          SGR = v(15), CREDIT = v(16), OTHERS = v(17), MANAGEMENT = v(18), OPERATION = v(19),
          UPDATED_AT = systimestamp, UPDATED_BY = :#P#USER_ID
     when not matched then insert (MONITORING_RECORD_ID, RESOURCE_TYPE, RP, SGP, SGP_EDUCATION, SGP_HEALTH, SGP_WATER,
          SGP_CULTURE, SGP_SPORT, SGP_FREE_INVESTMENT, SGP_FREE_DESTINATION, SGP_SCHOOL_FEEDING, SGP_MAGDALENA_RIVER,
          SGP_EARLY_CHILDHOOD, CN, CD, SGR, CREDIT, OTHERS, MANAGEMENT, OPERATION, CREATED_BY)
          values (rec.ID, p_type, v(1), l_sgp, v(3), v(4), v(5), v(6), v(7), v(8), v(9), v(10), v(11), v(12), v(13), v(14),
                  v(15), v(16), v(17), v(18), v(19), :#P#USER_ID);
  end;
begin
  if :#P#REC_ID is null then
    raise_application_error(-20001, 'No se encontró la programación de la meta');
  elsif :#P#EDITABLE <> 'S' then
    raise_application_error(-20001, 'La meta no se puede modificar en esta etapa (fechas o estado).');
  end if;
  select * into rec from SPD_MONITORING_RECORD where ID = :#P#REC_ID;

  if :#P#MODE = 'REVIEW' then
    -- revisión: solo la decisión; la observación queda en el historial
    l_status := nvl(:#P#REVIEWED, 'REVIEWED');
    update SPD_MONITORING_RECORD set RECORD_STATUS = l_status, UPDATED_AT = systimestamp, UPDATED_BY = :#P#USER_ID where ID = rec.ID;
    insert into SPD_GOAL_HISTORY (GOAL_ID, MONITORING_RECORD_ID, EVENT, DESCRIPTION, CREATED_BY)
    values (:#P#GOAL_ID, rec.ID, case l_status when 'REVIEWED' then 'REVIEWED' else 'REJECTED' end, :#P#REVIEW_NOTES, :#P#USER_ID);
    :#P#MSG := 'Revisión guardada';
    return;
  end if;

  l_status := case when :#P#MODE = 'VALIDATE' then nvl(:#P#VALIDATED, 'REPORTED') else 'REPORTED' end;
  if apex_application.g_f01.exists(1) then h1 := 'S'; v1 := num(apex_application.g_f01(1)); end if;
  if apex_application.g_f02.exists(1) then h2 := 'S'; v2 := num(apex_application.g_f02(1)); end if;
  -- textos (un campo deshabilitado no llega: se conserva lo guardado)
  if apex_application.g_f11.exists(1) then k1 := 'S'; q1 := apex_application.g_f11(1); end if;
  if apex_application.g_f12.exists(1) then k2 := 'S'; q2 := apex_application.g_f12(1); end if;
  if apex_application.g_f13.exists(1) then k3 := 'S'; q3 := apex_application.g_f13(1); end if;
  if apex_application.g_f14.exists(1) then k4 := 'S'; q4 := apex_application.g_f14(1); end if;
  if apex_application.g_f15.exists(1) then k5 := 'S'; q5 := apex_application.g_f15(1); end if;
  if apex_application.g_f16.exists(1) and trim(apex_application.g_f16(1)) is not null then
    l_tm := apex_application.g_f16(1);
    if l_tm is not json then l_tm := null; end if;
  end if;
  update SPD_MONITORING_RECORD
     set GOAL_ACHIEVED_VALUE    = case when h1 = 'S' then nvl(v1, 0) else nvl(GOAL_ACHIEVED_VALUE, 0) end,
         PI_GOAL_ACHIEVED_VALUE = case when h2 = 'S' then v2 else PI_GOAL_ACHIEVED_VALUE end,
         QUESTION_HOW      = case when k1 = 'S' then to_clob(q1) else QUESTION_HOW end,
         QUESTION_RESULT   = case when k2 = 'S' then to_clob(q2) else QUESTION_RESULT end,
         QUESTION_EVIDENCE = case when k3 = 'S' then to_clob(q3) else QUESTION_EVIDENCE end,
         QUESTION_PROBLEM  = case when k4 = 'S' then to_clob(q4) else QUESTION_PROBLEM end,
         NOTES             = case when k5 = 'S' then to_clob(q5) else NOTES end,
         TARGET_MATRIX     = nvl(l_tm, TARGET_MATRIX),
         RECORD_STATUS     = l_status,
         UPDATED_AT = systimestamp, UPDATED_BY = :#P#USER_ID
   where ID = rec.ID;
  -- avance físico = min(logro / programado, 1)
  update SPD_MONITORING_RECORD
     set PHYSICAL_INDICATOR = case when nvl(GOAL_VALUE, 0) <> 0 then round(least(nvl(GOAL_ACHIEVED_VALUE, 0) / GOAL_VALUE, 1), 4) else 0 end
   where ID = rec.ID;

  -- recursos de ejecución: una columna por documento del seguimiento (f06, f07, f08)
  for d in (select jt.DOC, jt.POS from SPD_MONITORING_CONFIG mc,
                   json_table(mc.SPENT_DOCS, '$[*]' columns (POS for ordinality, DOC varchar2(20) path '$')) jt
             where mc.ID = :#P#MC and jt.POS <= 3 order by jt.POS) loop
    if d.POS = 1 then save_res(d.DOC, apex_application.g_f06);
    elsif d.POS = 2 then save_res(d.DOC, apex_application.g_f07);
    else save_res(d.DOC, apex_application.g_f08);
    end if;
  end loop;
  -- avance financiero de cada documento = min(ejecutado / apropiado, 1)
  declare
    l_base number := total(rec.ID, l_sched);
    l_exec number;
  begin
    for x in (select RESOURCE_TYPE from SPD_MONITORING_RECORD_RESOURCE
               where MONITORING_RECORD_ID = rec.ID and RESOURCE_TYPE in ('COMMITMENT', 'OBLIGATION', 'PAYMENT')) loop
      l_exec := nvl(total(rec.ID, x.RESOURCE_TYPE), 0);
      update SPD_MONITORING_RECORD_RESOURCE
         set FINANCIAL_INDICATOR = case when nvl(l_base, 0) <> 0 then round(least(l_exec / l_base, 1), 4) else 0 end
       where MONITORING_RECORD_ID = rec.ID and RESOURCE_TYPE = x.RESOURCE_TYPE;
    end loop;
  end;

  l_event := case l_status when 'VALIDATED' then 'VALIDATED' else 'MONITORED' end;
  insert into SPD_GOAL_HISTORY (GOAL_ID, MONITORING_RECORD_ID, EVENT, DESCRIPTION, CREATED_BY)
  values (:#P#GOAL_ID, rec.ID, l_event, null, :#P#USER_ID);
  :#P#MSG := case when :#P#MODE = 'VALIDATE' then 'Validación guardada' else 'Seguimiento guardado' end;
end;~', 'REQUEST_EQUALS_CONDITION', 'SAVE');

  l_seq := l_seq + 10;
  wwv_flow_imp_page.create_page_process(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
    p_process_sequence => l_seq, p_process_point => 'AFTER_SUBMIT', p_process_type => 'NATIVE_CLOSE_WINDOW',
    p_process_name => 'Cerrar diálogo', p_process_when_type => 'REQUEST_EQUALS_CONDITION', p_process_when => 'SAVE',
    p_process_success_message => '&P1064_MSG.');
  wwv_flow_imp_page.create_page_branch(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
    p_branch_name => 'Volver al diálogo', p_branch_point => 'AFTER_PROCESSING', p_branch_type => 'REDIRECT_URL',
    p_branch_action => 'f?p=&APP_ID.:' || g_page || ':&APP_SESSION.::&DEBUG.:::', p_branch_sequence => 10,
    p_branch_condition_type => 'REQUEST_EQUALS_CONDITION', p_branch_condition => 'DELETE_ATT');

  -- ==========================================================================
  -- 1065 · Focalización (formulario modal sobre una localización de TARGET_MATRIX)
  -- ==========================================================================
  declare
    -- sección | región | ítem | ruta JSON | etiqueta | N (número) / T (texto)   (MonitoringTrackTagetEDForm / Org / RE)
    l_defs varchar2(32767) := q'~
ed|Género|ED_GENRE_H|genre.h|Hombres|N
ed|Género|ED_GENRE_M|genre.m|Mujeres|N
ed|Zona|ED_ZONE_U|zone.u|Urbano|N
ed|Zona|ED_ZONE_R|zone.r|Rural|N
ed|Ciclos de Edad|ED_AGE_PI|ageCycles.pi|Primera Infancia|N
ed|Ciclos de Edad|ED_AGE_ADOL|ageCycles.adol|Adolescencia|N
ed|Ciclos de Edad|ED_AGE_J|ageCycles.j|Juventud|N
ed|Ciclos de Edad|ED_AGE_AJ|ageCycles.aj|Adulto Joven|N
ed|Ciclos de Edad|ED_AGE_A|ageCycles.a|Adulto|N
ed|Ciclos de Edad|ED_AGE_AM|ageCycles.am|Adulto Mayor|N
ed|Condición|ED_COND_NOC|conditions.noC|Sin Condición|N
ed|Condición|ED_COND_D|conditions.d|Discapacidad|N
ed|Condición|ED_COND_DES|conditions.des|Desplazado|N
ed|Condición|ED_COND_VCA|conditions.vca|Victima Conf.|N
ed|Condición|ED_COND_MCH|conditions.mch|Mujer C. H.|N
ed|Condición|ED_COND_HC|conditions.hc|Hab. Calle|N
ed|Condición|ED_COND_MIG|conditions.mig|Migrante|N
ed|Etnia|ED_ETNIA_MZ|ageCycles.mz|Mestizo|N
ed|Etnia|ED_ETNIA_AFRO|ageCycles.afro|AfroCol|N
ed|Etnia|ED_ETNIA_I|ageCycles.i|Indígena|N
ed|Etnia|ED_ETNIA_P|ageCycles.p|Palenquero|N
ed|Etnia|ED_ETNIA_R|ageCycles.r|Raizal|N
ed|Etnia|ED_ETNIA_ROM|ageCycles.rom|ROM|N
org|Institución|ORG_TYPE|orgType|Tipo de institución|T
org|Institución|ORG_OBJECT|orgObject|Objeto de institución|T
org|Institución|ORG_NUM|numBeneficiaries|Número de beneficiarios|N
org|Institución|ORG_POP|populationDesc|Total población /unidad|T
re|Canino|RE_CANINE_M|canine.m|Macho|N
re|Canino|RE_CANINE_F|canine.f|Hembra|N
re|Felino|RE_FELINE_M|feline.m|Macho|N
re|Felino|RE_FELINE_F|feline.f|Hembra|N
re|Otra Especie|RE_OTHERS_M|others.m|Macho|N
re|Otra Especie|RE_OTHERS_F|others.f|Hembra|N
re|Flora|RE_FLORA|flora|Flora|T~';
    l_rows apex_t_varchar2;
    l_reg  number;
    l_prev varchar2(200);
    l_rseq pls_integer := 10;
    l_first boolean;
    l_idx  pls_integer;
    l_cnt  pls_integer;
    l_per  pls_integer;
    l_txt  boolean;
    -- tabla de definiciones para los procesos (misma lista, como SELECT)
    l_defsql varchar2(32767);
    function part(p varchar2, n number) return varchar2 is begin return regexp_substr(p, '[^|]+', 1, n); end;
  begin
    g_page := 1065; l_seq := 0;
    l_rows := apex_string.split(trim(chr(10) from l_defs), chr(10));
    for i in 1 .. l_rows.count loop
      l_defsql := l_defsql || case when i > 1 then ' union all ' end || 'select ''' || part(l_rows(i), 1) || ''' SEC, '''
        || part(l_rows(i), 3) || ''' ITEM, ''' || part(l_rows(i), 4) || ''' PATH, ''' || part(l_rows(i), 6) || ''' KIND from dual';
    end loop;

    wwv_flow_imp_page.remove_page(p_flow_id => c_app, p_page_id => g_page);
    wwv_flow_imp_page.create_page(p_id => g_page, p_flow_id => c_app, p_name => 'SPD_Focalización',
      p_alias => 'SPD_FOCALIZACION', p_page_mode => 'MODAL', p_step_title => 'Focalización',
      p_step_template => l_tpl_dlg, p_page_template_options => '#DEFAULT#', p_dialog_width => '900',
      p_dialog_chained => 'N', p_autocomplete_on_off => 'OFF', p_protection_level => 'C',
      p_read_only_when_type => 'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2', p_read_only_when => 'P1065_EDITABLE', p_read_only_when2 => 'S');

    l_seg := region('Estado', 1, l_tpl_blank);
    for h in (select column_value n from table(sys.odcivarchar2list('REC_ID', 'SECTION', 'POS', 'EDITABLE', 'KEY'))) loop
      item(l_seg, 'P1065_' || h.n, h.n);
    end loop;
    l_reg := region('Localización', 5, l_tpl_std);
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_page_item(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
      p_name => 'P1065_LOCALIZATION', p_item_sequence => l_seq, p_item_plug_id => l_reg, p_prompt => 'Localización',
      p_display_as => 'NATIVE_SHUTTLE', p_use_cache_before_default => 'YES', p_cHeight => 6,
      p_lov => 'select NAME || '' ('' || case LOCATION_TYPE when ''DEPARTMENT'' then ''Departamento'' when ''MUNICIPALITY'' then ''Municipio'''
            || ' when ''TOWNSHIP'' then ''Corregimiento'' when ''RURAL_SETTLEMENT'' then ''Vereda'' when ''DISTRICT'' then ''Comuna'''
            || ' when ''NEIGHBORHOOD'' then ''Barrio'' else ''Otro'' end || '')'' as d, ID as r'
            || ' from SPD_GEO_LOCATION where NIT_COMPANIA = :G_NIT_COMPANIA order by PARENT_LOCATION_ID nulls first, NAME',
      p_lov_display_null => 'NO', p_field_template => l_ft_above, p_item_template_options => '#DEFAULT#',
      p_is_persistent => 'N', p_attributes => wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2('show_controls', 'ALL')).to_clob);

    -- una región por grupo de campos, visible según la sección. Campos por fila según el tamaño del grupo:
    -- 2 → 2, 6 → 3, 7 → 4 (+3); si el grupo tiene textos, 2 por fila (1 si es un único campo).
    for i in 1 .. l_rows.count loop
      if part(l_rows(i), 1) || '|' || part(l_rows(i), 2) <> nvl(l_prev, '-') then
        l_rseq := l_rseq + 10;
        l_reg := region(part(l_rows(i), 2), l_rseq, l_tpl_std, p_cond_type => 'VAL_OF_ITEM_IN_COND_EQ_COND2',
                        p_cond => 'P1065_SECTION', p_cond2 => part(l_rows(i), 1));
        l_prev := part(l_rows(i), 1) || '|' || part(l_rows(i), 2);
        l_first := true;
        l_idx := 0; l_cnt := 0; l_txt := false;
        for j in i .. l_rows.count loop
          exit when part(l_rows(j), 1) || '|' || part(l_rows(j), 2) <> l_prev;
          l_cnt := l_cnt + 1;
          if part(l_rows(j), 6) = 'T' then l_txt := true; end if;
        end loop;
        l_per := case when l_cnt = 1 then 1 when l_txt then 2 when l_cnt <= 4 then l_cnt when l_cnt = 6 then 3 else 4 end;
      end if;
      l_seq := l_seq + 10;
      wwv_flow_imp_page.create_page_item(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
        p_name => 'P1065_' || part(l_rows(i), 3), p_item_sequence => l_seq, p_item_plug_id => l_reg,
        p_prompt => part(l_rows(i), 5),
        p_display_as => case part(l_rows(i), 6) when 'N' then 'NATIVE_NUMBER_FIELD' else 'NATIVE_TEXT_FIELD' end,
        p_use_cache_before_default => 'YES', p_cSize => 30,
        p_begin_on_new_line => case when mod(l_idx, l_per) = 0 then 'Y' else 'N' end, p_colspan => 12 / l_per,
        p_field_template => l_ft_above, p_item_template_options => '#DEFAULT#', p_is_persistent => 'N',
        p_attributes => case part(l_rows(i), 6)
          when 'N' then wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2('number_alignment', 'right', 'virtual_keyboard', 'decimal')).to_clob
          else wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2('disabled', 'N', 'submit_when_enter_pressed', 'N', 'subtype', 'TEXT', 'trim_spaces', 'BOTH')).to_clob end);
      l_first := false;
      l_idx := l_idx + 1;
    end loop;

    -- pie: Cancelar / Eliminar / Guardar
    l_reg := wwv_flow_id.next_val;
    wwv_flow_imp_page.create_page_plug(p_id => l_reg, p_flow_id => c_app, p_page_id => g_page, p_plug_name => 'Botones',
      p_region_template_options => '#DEFAULT#', p_plug_template => l_tpl_btns, p_plug_display_sequence => 500,
      p_plug_display_point => 'REGION_POSITION_03', p_plug_source_type => 'NATIVE_STATIC');
    l_btn := wwv_flow_id.next_val;
    wwv_flow_imp_page.create_page_button(p_id => l_btn, p_flow_id => c_app, p_flow_step_id => g_page,
      p_button_sequence => 10, p_button_plug_id => l_reg, p_button_name => 'CANCELAR', p_button_action => 'DEFINED_BY_DA',
      p_button_template_options => '#DEFAULT#', p_button_template_id => l_tpl_btn, p_button_image_alt => 'Cancelar',
      p_button_position => 'CLOSE', p_warn_on_unsaved_changes => null);
    wwv_flow_imp_page.create_page_button(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
      p_button_sequence => 20, p_button_plug_id => l_reg, p_button_name => 'DELETE', p_button_action => 'REDIRECT_URL',
      p_button_redirect_url => 'javascript:apex.confirm(''Eliminar focalización'', ''DELETE'');',
      p_button_template_options => '#DEFAULT#:t-Button--danger:t-Button--simple', p_button_template_id => l_tpl_btn,
      p_button_image_alt => 'Eliminar', p_button_position => 'DELETE', p_warn_on_unsaved_changes => null,
      p_button_execute_validations => 'N',
      p_button_condition_type => 'PLSQL_EXPRESSION', p_button_condition => ':P1065_POS is not null and :P1065_EDITABLE = ''S''');
    wwv_flow_imp_page.create_page_button(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
      p_button_sequence => 30, p_button_plug_id => l_reg, p_button_name => 'SAVE', p_button_action => 'SUBMIT',
      p_button_template_options => '#DEFAULT#', p_button_template_id => l_tpl_btn, p_button_is_hot => 'Y',
      p_button_image_alt => 'Guardar', p_button_position => 'NEXT',
      p_button_condition_type => 'VAL_OF_ITEM_IN_COND_EQ_COND2', p_button_condition => 'P1065_EDITABLE', p_button_condition2 => 'S');
    l_evt := wwv_flow_id.next_val;
    wwv_flow_imp_page.create_page_da_event(p_id => l_evt, p_flow_id => c_app, p_page_id => g_page,
      p_name => 'Cancelar', p_event_sequence => 10, p_triggering_element_type => 'BUTTON',
      p_triggering_button_id => l_btn, p_bind_type => 'bind', p_execution_type => 'IMMEDIATE', p_bind_event_type => 'click');
    wwv_flow_imp_page.create_page_da_action(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_page_id => g_page,
      p_event_id => l_evt, p_event_result => 'TRUE', p_action_sequence => 10, p_execute_on_page_init => 'N',
      p_action => 'NATIVE_DIALOG_CANCEL');

    -- carga: la localización POS de la sección (o vacía si es nueva)
    process('Cargar focalización', 'BEFORE_HEADER', replace(q'~
declare
  l_tm   clob;
  l_root json_object_t;
  l_sec  json_object_t;
  l_obj  json_object_t;
  l_keys json_key_list;
  l_arr  json_array_t;
  l_loc  varchar2(4000);
  function getp(o json_object_t, p varchar2) return varchar2 is
    g json_object_t;
  begin
    if instr(p, '.') > 0 then
      if not o.has(substr(p, 1, instr(p, '.') - 1)) then return null; end if;
      g := o.get_object(substr(p, 1, instr(p, '.') - 1));
      if g is null or not g.has(substr(p, instr(p, '.') + 1)) then return null; end if;
      return g.get_string(substr(p, instr(p, '.') + 1));
    end if;
    if not o.has(p) then return null; end if;
    return o.get_string(p);
  end;
begin
  select TARGET_MATRIX into l_tm from SPD_MONITORING_RECORD where ID = :P1065_REC_ID;
  :P1065_KEY := null;
  if :P1065_POS is not null and l_tm is not null then
    l_root := json_object_t.parse(l_tm);
    if l_root.has(:P1065_SECTION) then
      l_sec := l_root.get_object(:P1065_SECTION);
      l_keys := l_sec.get_keys;
      if to_number(:P1065_POS) <= l_keys.count then
        :P1065_KEY := l_keys(to_number(:P1065_POS));
        l_obj := l_sec.get_object(:P1065_KEY);
      end if;
    end if;
  end if;
  if l_obj is null then l_obj := json_object_t(); :P1065_POS := null; end if;
  if l_obj.has('localization') then
    l_arr := l_obj.get_array('localization');
    for i in 0 .. l_arr.get_size - 1 loop
      l_loc := l_loc || case when l_loc is not null then ':' end || l_arr.get_string(i);
    end loop;
  end if;
  :P1065_LOCALIZATION := l_loc;
  for d in (#DEFS#) loop
    if d.SEC = :P1065_SECTION then
      apex_util.set_session_state('P1065_' || d.ITEM, getp(l_obj, d.PATH));
    end if;
  end loop;
end;~', '#DEFS#', l_defsql));

    -- guardar: crea o actualiza la localización (claves localizationTabN, como el original)
    process('Guardar focalización', 'AFTER_SUBMIT', replace(q'~
declare
  l_tm    clob;
  l_root  json_object_t;
  l_sec   json_object_t;
  l_obj   json_object_t;
  l_arr   json_array_t := json_array_t();
  l_key   varchar2(100) := :P1065_KEY;
  l_label varchar2(4000);
  n       pls_integer := 0;
  procedure setp(o in out nocopy json_object_t, p varchar2, v varchar2, k varchar2) is
    g  json_object_t;
    gn varchar2(100);
    fn varchar2(100) := p;
  begin
    if instr(p, '.') > 0 then
      gn := substr(p, 1, instr(p, '.') - 1); fn := substr(p, instr(p, '.') + 1);
      g := case when o.has(gn) then o.get_object(gn) else json_object_t() end;
      if v is null then g.remove(fn); elsif k = 'N' then g.put(fn, to_number(v)); else g.put(fn, v); end if;
      if g.get_size = 0 then o.remove(gn); else o.put(gn, g); end if;
    else
      if v is null then o.remove(fn); elsif k = 'N' then o.put(fn, to_number(v)); else o.put(fn, v); end if;
    end if;
  end;
begin
  if :P1065_EDITABLE <> 'S' then
    raise_application_error(-20001, 'La focalización no se puede modificar en esta etapa.');
  end if;
  select TARGET_MATRIX into l_tm from SPD_MONITORING_RECORD where ID = :P1065_REC_ID for update;
  l_root := json_object_t.parse(nvl(l_tm, '{}'));
  l_sec := case when l_root.has(:P1065_SECTION) then l_root.get_object(:P1065_SECTION) else json_object_t() end;
  if l_key is not null and l_sec.has(l_key) then
    l_obj := l_sec.get_object(l_key);
  else
    while l_sec.has('localizationTab' || n) loop n := n + 1; end loop;
    l_key := 'localizationTab' || n;
    l_obj := json_object_t();
  end if;
  for x in (select to_number(column_value) as ID from table(apex_string.split(:P1065_LOCALIZATION, ':'))) loop
    if x.ID is not null then l_arr.append(x.ID); end if;
  end loop;
  select listagg(g.NAME, ' - ') within group (order by g.NAME) into l_label
    from SPD_GEO_LOCATION g
   where g.ID in (select to_number(column_value) from table(apex_string.split(:P1065_LOCALIZATION, ':')));
  l_obj.put('localization', l_arr);
  l_obj.put('localizationLabel', nvl(l_label, 'Localización?'));
  for d in (#DEFS#) loop
    if d.SEC = :P1065_SECTION then
      setp(l_obj, d.PATH, v('P1065_' || d.ITEM), d.KIND);
    end if;
  end loop;
  l_sec.put(l_key, l_obj);
  l_root.put(:P1065_SECTION, l_sec);
  l_tm := l_root.to_clob;
  update SPD_MONITORING_RECORD set TARGET_MATRIX = l_tm, UPDATED_AT = systimestamp where ID = :P1065_REC_ID;
end;~', '#DEFS#', l_defsql), 'REQUEST_EQUALS_CONDITION', 'SAVE', 'Focalización guardada');

    process('Eliminar focalización', 'AFTER_SUBMIT', q'~
declare
  l_tm   clob;
  l_root json_object_t;
  l_sec  json_object_t;
begin
  if :P1065_EDITABLE <> 'S' then
    raise_application_error(-20001, 'La focalización no se puede modificar en esta etapa.');
  end if;
  select TARGET_MATRIX into l_tm from SPD_MONITORING_RECORD where ID = :P1065_REC_ID for update;
  l_root := json_object_t.parse(nvl(l_tm, '{}'));
  if l_root.has(:P1065_SECTION) and :P1065_KEY is not null then
    l_sec := l_root.get_object(:P1065_SECTION);
    l_sec.remove(:P1065_KEY);
    l_root.put(:P1065_SECTION, l_sec);
    l_tm := l_root.to_clob;
    update SPD_MONITORING_RECORD set TARGET_MATRIX = l_tm, UPDATED_AT = systimestamp where ID = :P1065_REC_ID;
  end if;
end;~', 'REQUEST_EQUALS_CONDITION', 'DELETE', 'Focalización eliminada');

    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_page_process(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
      p_process_sequence => l_seq, p_process_point => 'AFTER_SUBMIT', p_process_type => 'NATIVE_CLOSE_WINDOW',
      p_process_name => 'Cerrar diálogo', p_process_when_type => 'REQUEST_IN_CONDITION', p_process_when => 'SAVE,DELETE');
  end;

  wwv_flow_imp.import_end(p_auto_install_sup_obj => false);
  commit;
  dbms_output.put_line('SEGUIMIENTO OK (listas 1031-1033, 1036-1038, 1041-1043; tableros 1034, 1039, 1044; diálogos ' || c_dlg || ' y 1065)');
end;
/
exit
