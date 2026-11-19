prompt --application/pages/page_01007
begin
--   Manifest
--     PAGE: 01007
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
 p_id=>1007
,p_name=>'SPD_Plan de desarrollo'
,p_alias=>'SPD_PLAN_DESARROLLO'
,p_step_title=>'Plan de desarrollo'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39865209641163099)
,p_plug_name=>'Plan de desarrollo'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'PLAN_DESARROLLO'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41218046487911626)
,p_plug_name=>'Niveles'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>15
,p_query_type=>'SQL'
,p_plug_source=>'select NUM, SINGULAR_NAME, PLURAL_NAME, GOAL_TYPE, IS_SECTOR from V_SPD_PLAN_LEVEL_CONFIG where NIT_COMPANIA = :P1007_NIT_COMPANIA and PLAN = :P1007_PLAN'
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'NUM'
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P1007_NIT_COMPANIA,P1007_PLAN'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P1007_ID'
,p_prn_page_header=>'Niveles'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41218210100911626)
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
 p_id=>wwv_flow_imp.id(41218250697911626)
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
 p_id=>wwv_flow_imp.id(41218319427911626)
,p_name=>'NUM'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NUM'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Nivel'
,p_label=>'Nivel'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y')).to_clob
,p_is_required=>false
,p_lov_display_extra=>false
,p_lov_display_null=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_duplicate_value=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41218456464911626)
,p_name=>'SINGULAR_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SINGULAR_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Nombre Singular'
,p_label=>'Nombre Singular'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>true
,p_max_length=>200
,p_lov_display_extra=>false
,p_lov_display_null=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41218609717911626)
,p_name=>'PLURAL_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PLURAL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Nombre Plural'
,p_label=>'Nombre Plural'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>true
,p_max_length=>200
,p_lov_display_extra=>false
,p_lov_display_null=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41218673069911626)
,p_name=>'GOAL_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'GOAL_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Tipo de meta'
,p_label=>'Tipo de meta'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>'select DISPLAY_VALUE d, RETURN_VALUE r from APEX_APPLICATION_LOV_ENTRIES where APPLICATION_ID = :APP_ID and LIST_OF_VALUES_NAME = ''SPD - TIPO DE META'' order by DISPLAY_SEQUENCE'
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_ajax_items_to_submit=>'P1007_NIT_COMPANIA,P1007_PLAN'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41218756618911627)
,p_name=>'IS_SECTOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_SECTOR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_YES_NO'
,p_heading=>'Asocia sector DNP?'
,p_label=>'Asocia sector DNP?'
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
,p_lov_display_extra=>false
,p_lov_display_null=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'N'
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(41218815917911627)
,p_internal_uid=>39577801218298225
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
 p_id=>wwv_flow_imp.id(41218997020911627)
,p_interactive_grid_id=>wwv_flow_imp.id(41218815917911627)
,p_static_id=>'39577982321298225'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>20
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(41219028047911627)
,p_report_id=>wwv_flow_imp.id(41218997020911627)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41219196384911627)
,p_view_id=>wwv_flow_imp.id(41219028047911627)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(41218319427911626)
,p_is_visible=>true
,p_is_frozen=>false
,p_sort_order=>1
,p_sort_direction=>'ASC'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41219229427911627)
,p_view_id=>wwv_flow_imp.id(41219028047911627)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(41218456464911626)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41219409642911627)
,p_view_id=>wwv_flow_imp.id(41219028047911627)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(41218609717911626)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41219465276911627)
,p_view_id=>wwv_flow_imp.id(41219028047911627)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(41218673069911626)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41219539128911627)
,p_view_id=>wwv_flow_imp.id(41219028047911627)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(41218756618911627)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39882747598163103)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Regresar'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:1006:&APP_SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-left'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41239689051911855)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'NUEVO'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Nuevo'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:1007:&APP_SESSION.::&DEBUG.:1007::'
,p_button_condition=>'P1007_PLAN'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-file-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39884158768163104)
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
,p_button_condition=>'P1007_PLAN'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39884577273163104)
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
,p_button_condition=>'P1007_PLAN'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39885012715163104)
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
,p_button_condition=>'P1007_PLAN'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(41217885332911626)
,p_branch_name=>'Ir al plan creado'
,p_branch_action=>'f?p=&APP_ID.:1007:&APP_SESSION.::&DEBUG.:1007:P1007_NIT_COMPANIA,P1007_PLAN:&P1007_NIT_COMPANIA.,&P1007_PLAN.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_branch_condition=>'CREATE'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(41217960386911626)
,p_branch_name=>'Volver al reporte'
,p_branch_action=>'f?p=&APP_ID.:1007:&APP_SESSION.::&DEBUG.:1007:P1007_NIT_COMPANIA,P1007_PLAN:&P1007_NIT_COMPANIA.,&P1007_PLAN.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>20
,p_branch_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_branch_condition=>'SAVE'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(41225270879911674)
,p_branch_name=>'Volver al reporte (eliminar)'
,p_branch_action=>'f?p=&APP_ID.:1006:&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>30
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39865544250163099)
,p_name=>'P1007_PLAN'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_is_primary_key=>true
,p_item_sequence=>1120
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('C\00F3digo plan')
,p_source=>'PLAN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_colspan=>3
,p_label_alignment=>'RIGHT'
,p_read_only_when=>'P1007_PLAN'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39865941718163099)
,p_name=>'P1007_NIT_COMPANIA'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_item_default=>'G_NIT_COMPANIA'
,p_item_default_type=>'ITEM'
,p_prompt=>unistr('Compa\00F1\00EDa')
,p_source=>'NIT_COMPANIA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_lov_display_null=>'YES'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39866350782163099)
,p_name=>'P1007_NOMBRE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>1130
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nombre plan'
,p_source=>'NOMBRE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>240
,p_begin_on_new_line=>'N'
,p_colspan=>9
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39866809346163099)
,p_name=>'P1007_FECHA_INICIO'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>1140
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Fecha inicio plan'
,p_source=>'FECHA_INICIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_colspan=>3
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_and_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_on', 'FOCUS',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39867134728163099)
,p_name=>'P1007_FECHA_FIN'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>1150
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Fecha fin plan'
,p_source=>'FECHA_FIN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_and_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_on', 'FOCUS',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39867597004163100)
,p_name=>'P1007_OBJETIVO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Objetivo'
,p_source=>'OBJETIVO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cMaxlength=>2000
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39867993433163100)
,p_name=>'P1007_GOBERNANTE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>1170
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nombre gobernante'
,p_source=>'GOBERNANTE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>240
,p_colspan=>6
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39868360188163100)
,p_name=>'P1007_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'ID'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39868788438163100)
,p_name=>'P1007_ETIQUETA_EJE_SINGULAR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Etiqueta eje (singular)'
,p_source=>'ETIQUETA_EJE_SINGULAR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39869199144163100)
,p_name=>'P1007_ETIQUETA_EJE_PLURAL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Etiqueta eje (plural)'
,p_source=>'ETIQUETA_EJE_PLURAL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39869546474163100)
,p_name=>'P1007_ETIQUETA_SECTOR_SINGULAR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Etiqueta sector (singular)'
,p_source=>'ETIQUETA_SECTOR_SINGULAR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39870007013163100)
,p_name=>'P1007_ETIQUETA_SECTOR_PLURAL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Etiqueta sector (plural)'
,p_source=>'ETIQUETA_SECTOR_PLURAL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39870330523163100)
,p_name=>'P1007_ETIQUETA_PROGRAMA_SINGULAR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Etiqueta programa (singular)'
,p_source=>'ETIQUETA_PROGRAMA_SINGULAR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39870746382163100)
,p_name=>'P1007_ETIQUETA_PROGRAMA_PLURAL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Etiqueta programa (plural)'
,p_source=>'ETIQUETA_PROGRAMA_PLURAL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39871124186163101)
,p_name=>'P1007_ETIQUETA_SUBPROGRAMA_SINGULAR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Etiqueta subprograma (singular)'
,p_source=>'ETIQUETA_SUBPROGRAMA_SINGULAR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39871538202163101)
,p_name=>'P1007_ETIQUETA_SUBPROGRAMA_PLURAL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Etiqueta subprograma (plural)'
,p_source=>'ETIQUETA_SUBPROGRAMA_PLURAL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39871922853163101)
,p_name=>'P1007_MANEJA_SECTOR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Maneja sector'
,p_source=>'MANEJA_SECTOR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39872351860163101)
,p_name=>'P1007_NIVEL_MR'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nivel de metas de resultado'
,p_source=>'NIVEL_MR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39872782367163101)
,p_name=>'P1007_NIVEL_MP'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nivel de metas de producto'
,p_source=>'NIVEL_MP'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39873161490163101)
,p_name=>'P1007_SPD_ACTIVO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Activo en SPD'
,p_source=>'SPD_ACTIVO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39873554127163101)
,p_name=>'P1007_SPD_INICIO_GOBIERNO'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>1180
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Fecha inicio gobernante'
,p_source=>'SPD_INICIO_GOBIERNO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_and_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_on', 'FOCUS',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39873981268163101)
,p_name=>'P1007_SPD_FIN_GOBIERNO'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>1190
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Fecha fin gobernante'
,p_source=>'SPD_FIN_GOBIERNO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_and_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_on', 'FOCUS',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39874765713163101)
,p_name=>'P1007_SPD_ORIGEN_ACTIVIDADES'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>1160
,p_item_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_item_source_plug_id=>wwv_flow_imp.id(39865209641163099)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Vinculaci\00F3n de actividades y metas')
,p_source=>'SPD_ORIGEN_ACTIVIDADES'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - ORIGEN DE ACTIVIDADES'
,p_lov=>'.'||wwv_flow_imp.id(40768452442163573)||'.'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>10
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(39885784546163104)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(39865209641163099)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Plan de desarrollo'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>38244769846549702
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41219661124911627)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(41218046487911626)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Guardar niveles del plan'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_doc    clob;',
'  l_cfg    json_object_t;',
'  l_levels json_array_t;',
'  l_new    json_array_t := json_array_t();',
'  l_lvl    json_object_t;',
'  l_max    number := 0;',
'  procedure set_fields(o in out nocopy json_object_t) is',
'  begin',
'    o.put(''singularName'', :SINGULAR_NAME);',
'    o.put(''pluralName'', :PLURAL_NAME);',
'    if :GOAL_TYPE is null then o.remove(''goalType''); else o.put(''goalType'', :GOAL_TYPE); end if;',
'    o.put(''isSectorLevel'', :IS_SECTOR = ''S'');',
'  end;',
'begin',
'  select SPD_CONFIG into l_doc from PLAN_DESARROLLO',
'   where NIT_COMPANIA = :P1007_NIT_COMPANIA and PLAN = :P1007_PLAN for update;',
'  if l_doc is null then l_cfg := json_object_t(); else l_cfg := json_object_t.parse(l_doc); end if;',
'  if l_cfg.has(''levels'') then l_levels := l_cfg.get_array(''levels''); else l_levels := json_array_t(); end if;',
'  for i in 0 .. l_levels.get_size - 1 loop',
'    l_lvl := json_object_t.parse(l_levels.get(i).to_clob);',
'    l_max := greatest(l_max, nvl(l_lvl.get_number(''number''), 0));',
'    if :APEX$ROW_STATUS in (''U'', ''D'') and l_lvl.get_number(''number'') = :NUM then',
'      if :APEX$ROW_STATUS = ''U'' then set_fields(l_lvl); l_new.append(l_lvl); end if;',
'    else',
'      l_new.append(l_lvl);',
'    end if;',
'  end loop;',
'  if :APEX$ROW_STATUS = ''C'' then',
'    l_lvl := json_object_t();',
'    l_lvl.put(''number'', l_max + 1);',
'    set_fields(l_lvl);',
'    l_new.append(l_lvl);',
'    :NUM := l_max + 1;',
'  end if;',
'  l_cfg.put(''levels'', l_new);',
'  l_doc := l_cfg.to_clob;',
'  update PLAN_DESARROLLO set SPD_CONFIG = l_doc',
'   where NIT_COMPANIA = :P1007_NIT_COMPANIA and PLAN = :P1007_PLAN;',
'end;'))
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>39578646425298225
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41219764468911627)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Renumerar niveles del plan'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_doc clob;',
'  l_cfg json_object_t;',
'  l_arr json_array_t;',
'  l_new json_array_t := json_array_t();',
'  l_obj json_object_t;',
'begin',
'  select SPD_CONFIG into l_doc from PLAN_DESARROLLO where NIT_COMPANIA = :P1007_NIT_COMPANIA and PLAN = :P1007_PLAN;',
'  if l_doc is null then return; end if;',
'  l_cfg := json_object_t.parse(l_doc);',
'  if not l_cfg.has(''levels'') then return; end if;',
'  l_arr := l_cfg.get_array(''levels'');',
'  for r in (select jt.POS from json_table(l_doc, ''$.levels[*]'' columns (POS for ordinality, NUM number path ''$.number'')) jt',
'             order by jt.NUM nulls last, jt.POS) loop',
'    l_obj := json_object_t.parse(l_arr.get(r.POS - 1).to_clob);',
'    l_obj.put(''number'', l_new.get_size + 1);',
'    l_new.append(l_obj);',
'  end loop;',
'  l_cfg.put(''levels'', l_new);',
'  l_doc := l_cfg.to_clob;',
'  update PLAN_DESARROLLO set SPD_CONFIG = l_doc where NIT_COMPANIA = :P1007_NIT_COMPANIA and PLAN = :P1007_PLAN;',
'exception when no_data_found then null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>'SAVE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>39578749769298225
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(39885316284163104)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(39865209641163099)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Plan de desarrollo'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>38244301584549702
);
wwv_flow_imp.component_end;
end;
/
