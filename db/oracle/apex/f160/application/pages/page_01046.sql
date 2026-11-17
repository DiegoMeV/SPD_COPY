prompt --application/pages/page_01046
begin
--   Manifest
--     PAGE: 01046
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>4267703994621115
,p_default_application_id=>160
,p_default_id_offset=>1641014699613402
,p_default_owner=>'SIIF'
);
wwv_flow_imp_page.create_page(
 p_id=>1046
,p_name=>'SPD_Seguimiento'
,p_alias=>'SPD_SEGUIMIENTO'
,p_step_title=>unistr('Configuraci\00F3n de seguimiento')
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>'[["P1046_GOAL_TYPES_SEL", "P1046_GOAL_TYPES", []], ["P1046_SPENT_DOCS_SEL", "P1046_SPENT_DOCS", ["OBLIGATION"]]].forEach(function (x) { var v = apex.item(x[1]).getValue(), arr = x[2]; try { if (v) { arr = JSON.parse(v).map(String); } } catch (e) {} a'
||'pex.item(x[0]).setValue(arr); });'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40260449039163286)
,p_plug_name=>unistr('Configuraci\00F3n de seguimiento')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'SPD_MONITORING_CONFIG'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41230689181911807)
,p_plug_name=>'Colores de Indicadores'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>30
,p_query_type=>'SQL'
,p_plug_source=>'select POS, FROM_VALUE, INCLUDE_FROM, TO_VALUE, INCLUDE_TO, COLOR, LABEL from V_SPD_MONITORING_COLORS where ID = :P1046_ID'
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'POS'
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P1046_ID'
,p_prn_page_header=>'Colores de Indicadores'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41230798800911808)
,p_name=>'APEX$ROW_SELECTOR'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>10
,p_value_alignment=>'CENTER'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'enable_multi_select', 'Y',
  'hide_control', 'N',
  'show_select_all', 'Y')).to_clob
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41230861281911808)
,p_name=>'APEX$ROW_ACTION'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_label=>'Acciones'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41230970848911808)
,p_name=>'POS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'POS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>unistr('Posici\00F3n')
,p_label=>unistr('Posici\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_duplicate_value=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41231086789911808)
,p_name=>'FROM_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FROM_VALUE'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Desde'
,p_label=>'Desde'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
,p_is_required=>true
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41231125919911808)
,p_name=>'INCLUDE_FROM'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INCLUDE_FROM'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_YES_NO'
,p_heading=>'Incluye desde?'
,p_label=>'Incluye desde?'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'CENTER'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'off_label', 'No',
  'off_value', 'N',
  'on_label', unistr('S\00ED'),
  'on_value', 'S',
  'use_defaults', 'N')).to_clob
,p_is_required=>true
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'N'
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41231232629911808)
,p_name=>'TO_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TO_VALUE'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Hasta'
,p_label=>'Hasta'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
,p_is_required=>true
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41231349885911808)
,p_name=>'INCLUDE_TO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INCLUDE_TO'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_YES_NO'
,p_heading=>'Incluye hasta?'
,p_label=>'Incluye hasta?'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'off_label', 'No',
  'off_value', 'N',
  'on_label', unistr('S\00ED'),
  'on_value', 'S',
  'use_defaults', 'N')).to_clob
,p_is_required=>true
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'S'
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41231436657911808)
,p_name=>'COLOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COLOR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_COLOR_PICKER'
,p_heading=>'Color'
,p_label=>'Color'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
,p_is_required=>true
,p_max_length=>30
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41231556799911808)
,p_name=>'LABEL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LABEL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Etiqueta'
,p_label=>'Etiqueta'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>false
,p_max_length=>200
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(41231653058911808)
,p_internal_uid=>39590638359298406
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_add_row_if_empty=>false
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>false
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>false
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET'
,p_add_button_label=>'Nuevo'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>false
,p_enable_flashback=>false
,p_define_chart_view=>false
,p_enable_download=>false
,p_enable_mail_download=>false
,p_fixed_header=>'NONE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(41231764149911808)
,p_interactive_grid_id=>wwv_flow_imp.id(41231653058911808)
,p_static_id=>'39590749450298406'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>20
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(41231885928911808)
,p_report_id=>wwv_flow_imp.id(41231764149911808)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(23607000008)
,p_view_id=>wwv_flow_imp.id(41231885928911808)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(41230861281911808)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41231970585911808)
,p_view_id=>wwv_flow_imp.id(41231885928911808)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(41230970848911808)
,p_is_visible=>false
,p_is_frozen=>false
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41232015353911808)
,p_view_id=>wwv_flow_imp.id(41231885928911808)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(41231086789911808)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41232118367911808)
,p_view_id=>wwv_flow_imp.id(41231885928911808)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(41231125919911808)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41232279813911808)
,p_view_id=>wwv_flow_imp.id(41231885928911808)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(41231232629911808)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41232396275911808)
,p_view_id=>wwv_flow_imp.id(41231885928911808)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(41231349885911808)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41232420641911808)
,p_view_id=>wwv_flow_imp.id(41231885928911808)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(41231436657911808)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41232551396911808)
,p_view_id=>wwv_flow_imp.id(41231885928911808)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(41231556799911808)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40276749974163290)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Regresar'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:1045:&APP_SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-left'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41240493460911856)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'NUEVO'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Nuevo'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:1046:&APP_SESSION.::&DEBUG.:1046::'
,p_button_condition=>'P1046_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-file-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40278142730163290)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>wwv_flow_imp.id(39601281081162925)
,p_button_image_alt=>'Eliminar'
,p_button_position=>'DELETE'
,p_button_alignment=>'RIGHT'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P1046_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40278523063163290)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(39601281081162925)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aplicar Cambios'
,p_button_position=>'EDIT'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P1046_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40278988578163290)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(39601281081162925)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aplicar Cambios'
,p_button_position=>'EDIT'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P1046_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(41230565506911807)
,p_branch_name=>'Volver al reporte'
,p_branch_action=>'f?p=&APP_ID.:1045:&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40260846698163286)
,p_name=>'P1046_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_use_cache_before_default=>'NO'
,p_prompt=>'ID'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40261228652163286)
,p_name=>'P1046_USED_FOR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_default=>'DEVELOPMENT_PLANS'
,p_source=>'USED_FOR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40261670216163286)
,p_name=>'P1046_NIT_COMPANIA'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_default=>'G_NIT_COMPANIA'
,p_item_default_type=>'ITEM'
,p_prompt=>unistr('Compa\00F1\00EDa')
,p_source=>'NIT_COMPANIA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40262103330163286)
,p_name=>'P1046_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>1930
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_default=>'S'
,p_prompt=>'Activo'
,p_source=>'IS_ACTIVE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'off_label', 'No',
  'off_value', 'N',
  'on_label', unistr('S\00ED'),
  'on_value', 'S',
  'use_defaults', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40262442523163286)
,p_name=>'P1046_PLAN'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>1760
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_default=>'G_PLAN'
,p_item_default_type=>'ITEM'
,p_prompt=>'Plan de Desarrollo'
,p_source=>'PLAN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - PLANES DE DESARROLLO'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40262881931163286)
,p_name=>'P1046_PERIOD'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>1770
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_prompt=>'Periodo'
,p_source=>'PERIOD'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40263285629163287)
,p_name=>'P1046_SUBPERIOD'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>1780
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_prompt=>'Subperiodo'
,p_source=>'SUBPERIOD'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40263710202163287)
,p_name=>'P1046_PERIODICITY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_source=>'PERIODICITY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40264057370163287)
,p_name=>'P1046_SPENT_DOCS'
,p_data_type=>'CLOB'
,p_source_data_type=>'CLOB'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_source=>'SPENT_DOCS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40264470688163287)
,p_name=>'P1046_WEIGHTING_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>1820
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_default=>'FINANCIAL'
,p_prompt=>unistr('Ponderaci\00F3n')
,p_source=>'WEIGHTING_TYPE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - TIPO DE PONDERACION'
,p_lov=>'.'||wwv_flow_imp.id(40764775152163573)||'.'
,p_lov_display_null=>'YES'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40264839028163287)
,p_name=>'P1046_DATES_CONFIG'
,p_data_type=>'CLOB'
,p_source_data_type=>'CLOB'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_source=>'DATES_CONFIG'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40265654654163287)
,p_name=>'P1046_STATUS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_default=>'CREATED'
,p_source=>'STATUS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40266092634163287)
,p_name=>'P1046_MONITORING_RESOURCES_ORIGIN'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>1800
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_prompt=>'Origen de datos financieros'
,p_source=>'MONITORING_RESOURCES_ORIGIN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - ORIGEN DE RECURSOS'
,p_lov=>'.'||wwv_flow_imp.id(40765844368163573)||'.'
,p_lov_display_null=>'YES'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40266470204163287)
,p_name=>'P1046_SUPPORT_PRODUCT_MONITORING'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>1910
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_prompt=>unistr('Seguimiento Cat\00E1logo de Productos')
,p_source=>'SUPPORT_PRODUCT_MONITORING'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'off_label', 'No',
  'off_value', 'N',
  'on_label', unistr('S\00ED'),
  'on_value', 'S',
  'use_defaults', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40266873442163287)
,p_name=>'P1046_SGP_DISCRIMINATED'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>1920
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_prompt=>'SGP Discriminado'
,p_source=>'SGP_DISCRIMINATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'off_label', 'No',
  'off_value', 'N',
  'on_label', unistr('S\00ED'),
  'on_value', 'S',
  'use_defaults', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40267226144163288)
,p_name=>'P1046_GOAL_TYPES'
,p_data_type=>'CLOB'
,p_source_data_type=>'CLOB'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_source=>'GOAL_TYPES'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40267669586163288)
,p_name=>'P1046_CREATED_AT'
,p_source_data_type=>'TIMESTAMP_TZ'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_source=>'CREATED_AT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40268471692163288)
,p_name=>'P1046_CREATED_BY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_source=>'CREATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40268856414163288)
,p_name=>'P1046_UPDATED_AT'
,p_source_data_type=>'TIMESTAMP_TZ'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_source=>'UPDATED_AT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40269637964163288)
,p_name=>'P1046_UPDATED_BY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_source_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40778837363163613)
,p_name=>'P1046_SCHED_FROM'
,p_is_required=>true
,p_item_sequence=>1830
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_prompt=>unistr('Fecha inicio programaci\00F3n')
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40778978571163615)
,p_name=>'P1046_SCHED_TO'
,p_is_required=>true
,p_item_sequence=>1840
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_prompt=>unistr('Fecha fin programaci\00F3n')
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40779103598163616)
,p_name=>'P1046_REPORT_FROM'
,p_is_required=>true
,p_item_sequence=>1850
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_prompt=>'Fecha inicio reporte'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40779186154163617)
,p_name=>'P1046_REPORT_TO'
,p_is_required=>true
,p_item_sequence=>1860
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_prompt=>'Fecha fin reporte'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40779313949163619)
,p_name=>'P1046_VALID_FROM'
,p_is_required=>true
,p_item_sequence=>1870
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_prompt=>unistr('Fecha inicio validaci\00F3n')
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40779397383163620)
,p_name=>'P1046_VALID_TO'
,p_is_required=>true
,p_item_sequence=>1880
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_prompt=>unistr('Fecha fin validaci\00F3n')
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40779484141163621)
,p_name=>'P1046_REVIEW_FROM'
,p_is_required=>true
,p_item_sequence=>1890
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_prompt=>unistr('Fecha inicio de revisi\00F3n')
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40779569189163622)
,p_name=>'P1046_REVIEW_TO'
,p_is_required=>true
,p_item_sequence=>1900
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_prompt=>unistr('Fecha fin de revisi\00F3n')
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40779704152163624)
,p_name=>'P1046_GOAL_TYPES_SEL'
,p_is_required=>true
,p_item_sequence=>1790
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_prompt=>'Seguimiento para'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'SPD - SEGUIMIENTO PARA'
,p_lov=>'.'||wwv_flow_imp.id(40768766073163573)||'.'
,p_colspan=>12
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '2')).to_clob
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>':'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40779735586163625)
,p_name=>'P1046_SPENT_DOCS_SEL'
,p_is_required=>true
,p_item_sequence=>1810
,p_item_plug_id=>wwv_flow_imp.id(40260449039163286)
,p_item_default=>'OBLIGATION'
,p_prompt=>unistr('Documento de ejecuci\00F3n')
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'SPD - DOCUMENTO DE EJECUCION'
,p_lov=>'.'||wwv_flow_imp.id(40769420889163573)||'.'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '3')).to_clob
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>':'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41232696015911808)
,p_name=>'P1046_COLORS_PREVIEW'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(41230689181911807)
,p_prompt=>'Vista previa'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P1046_COLORS_PREVIEW'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'HTML',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(40268120493163288)
,p_validation_name=>'P1046_CREATED_AT must be timestamp'
,p_validation_sequence=>170
,p_validation=>'P1046_CREATED_AT'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_imp.id(40267669586163288)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(40269406677163288)
,p_validation_name=>'P1046_UPDATED_AT must be timestamp'
,p_validation_sequence=>190
,p_validation=>'P1046_UPDATED_AT'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_imp.id(40268856414163288)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(3701358698607388)
,p_name=>'SPD_G_PLAN'
,p_event_sequence=>900
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P1046_PLAN'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(3701490299607388)
,p_event_id=>wwv_flow_imp.id(3701358698607388)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'if :P1046_PLAN is not null then :G_PLAN := :P1046_PLAN; end if;'
,p_attribute_02=>'P1046_PLAN'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40779917649163627)
,p_process_sequence=>5
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Par\00E1metros: campos a JSON')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  function d(v varchar2) return varchar2 is',
'  begin',
'    return case when v is null then ''null'' else ''"'' || to_char(to_date(v, ''DD/MM/YYYY''), ''YYYY-MM-DD'') || ''T05:00:00.000Z"'' end;',
'  end;',
'begin',
'  :P1046_DATES_CONFIG := ''{"scheduling": ['' || d(:P1046_SCHED_FROM) || '', '' || d(:P1046_SCHED_TO) || ''], ''',
'    || ''"reporting": [''  || d(:P1046_REPORT_FROM) || '', '' || d(:P1046_REPORT_TO) || ''], ''',
'    || ''"validating": ['' || d(:P1046_VALID_FROM) || '', '' || d(:P1046_VALID_TO) || ''], ''',
'    || ''"reviewing": [''  || d(:P1046_REVIEW_FROM) || '', '' || d(:P1046_REVIEW_TO) || '']}'';',
'  :P1046_GOAL_TYPES := case when :P1046_GOAL_TYPES_SEL is null then null else ''["'' || replace(:P1046_GOAL_TYPES_SEL, '':'', ''","'') || ''"]'' end;',
'  :P1046_SPENT_DOCS := case when :P1046_SPENT_DOCS_SEL is null then null else ''["'' || replace(:P1046_SPENT_DOCS_SEL, '':'', ''","'') || ''"]'' end;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>39138902949550225
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40279720557163291)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(40260449039163286)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Monitoring Config'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>38638705857549889
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41232794158911808)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(41230689181911807)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Colores: guardar'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_doc clob;',
'  l_arr json_array_t;',
'  l_obj json_object_t := json_object_t();',
'begin',
'  select COLORS_CONFIG into l_doc from SPD_MONITORING_CONFIG where ID = :P1046_ID for update;',
'  if l_doc is null then l_arr := json_array_t(); else l_arr := json_array_t.parse(l_doc); end if;',
'  if :APEX$ROW_STATUS in (''C'', ''U'') then',
'    if :FROM_VALUE is null then l_obj.put_null(''fromValue''); else l_obj.put(''fromValue'', to_number(:FROM_VALUE)); end if;',
'    if :TO_VALUE is null then l_obj.put_null(''toValue''); else l_obj.put(''toValue'', to_number(:TO_VALUE)); end if;',
'    l_obj.put(''includeFromValue'', :INCLUDE_FROM = ''S'');',
'    l_obj.put(''includeToValue'', :INCLUDE_TO = ''S'');',
'    l_obj.put(''color'', :COLOR);',
'    if :LABEL is not null then l_obj.put(''label'', :LABEL); end if;',
'  end if;',
'  case :APEX$ROW_STATUS',
'    when ''C'' then l_arr.append(l_obj); :POS := l_arr.get_size;',
'    when ''U'' then l_arr.put(:POS - 1, l_obj, true);',
'    when ''D'' then l_arr.put_null(:POS - 1, true);',
'  end case;',
'  l_doc := l_arr.to_clob;',
'  update SPD_MONITORING_CONFIG set COLORS_CONFIG = l_doc where ID = :P1046_ID;',
'end;'))
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>39591779459298406
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41232874779911808)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Colores: quitar eliminados'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_doc clob;',
'  l_arr json_array_t;',
'  l_new json_array_t := json_array_t();',
'begin',
'  select COLORS_CONFIG into l_doc from SPD_MONITORING_CONFIG where ID = :P1046_ID;',
'  if l_doc is null then return; end if;',
'  l_arr := json_array_t.parse(l_doc);',
'  for i in 0 .. l_arr.get_size - 1 loop',
'    if not l_arr.get(i).is_null then l_new.append(json_element_t.parse(l_arr.get(i).to_clob)); end if;',
'  end loop;',
'  l_doc := l_new.to_clob;',
'  update SPD_MONITORING_CONFIG set COLORS_CONFIG = l_doc where ID = :P1046_ID;',
'exception when no_data_found then null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>39591860080298406
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40279404788163290)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(40260449039163286)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Monitoring Config'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>38638390088549888
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40779855649163627)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Par\00E1metros: JSON a campos')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  j json_object_t;',
'  function d(p_key varchar2, p_i pls_integer) return varchar2 is',
'    a json_array_t;',
'  begin',
'    if j is null or not j.has(p_key) then return null; end if;',
'    a := j.get_array(p_key);',
'    if a is null or a.get_size <= p_i or a.get(p_i).is_null then return null; end if;',
'    return to_char(to_date(substr(a.get_string(p_i), 1, 10), ''YYYY-MM-DD''), ''DD/MM/YYYY'');',
'  end;',
'begin',
'  if :P1046_DATES_CONFIG is not null then j := json_object_t.parse(:P1046_DATES_CONFIG); end if;',
'  :P1046_SCHED_FROM  := d(''scheduling'', 0); :P1046_SCHED_TO  := d(''scheduling'', 1);',
'  :P1046_REPORT_FROM := d(''reporting'', 0);  :P1046_REPORT_TO := d(''reporting'', 1);',
'  :P1046_VALID_FROM  := d(''validating'', 0); :P1046_VALID_TO  := d(''validating'', 1);',
'  :P1046_REVIEW_FROM := d(''reviewing'', 0);  :P1046_REVIEW_TO := d(''reviewing'', 1);',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>39138840949550225
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41233007008911808)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Colores: vista previa'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_html varchar2(32767);',
'begin',
'  for c in (select FROM_VALUE, TO_VALUE, COLOR, LABEL, INCLUDE_FROM from V_SPD_MONITORING_COLORS',
'             where ID = :P1046_ID and TO_VALUE is not null order by POS) loop',
'    l_html := l_html || ''<div style="flex:'' || to_char(greatest(nvl(c.TO_VALUE, 0) - nvl(c.FROM_VALUE, 0), 1), ''TM9'', ''NLS_NUMERIC_CHARACTERS=''''.,'''''')',
'           || '' 1 0;text-align:center"><div style="font-size:12px">''',
'           || apex_escape.html(c.LABEL) || case when c.LABEL is not null then '': '' end',
'           || case when c.INCLUDE_FROM = ''S'' then ''['' else ''('' end || c.FROM_VALUE || ''-'' || c.TO_VALUE || '']</div>''',
'           || ''<div style="height:22px;background:'' || apex_escape.html_attribute(c.COLOR) || ''"></div></div>'';',
'  end loop;',
'  :P1046_COLORS_PREVIEW := case when l_html is not null then ''<div style="display:flex;width:100%;min-width:800px;max-width:1200px">'' || l_html || ''</div>'' end;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>39591992309298406
);
wwv_flow_imp.component_end;
end;
/
