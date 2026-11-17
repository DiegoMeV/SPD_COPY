prompt --application/pages/page_01011
begin
--   Manifest
--     PAGE: 01011
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
 p_id=>1011
,p_name=>'SPD_Meta'
,p_alias=>'SPD_META'
,p_step_title=>'Meta'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>'[["P1011_ODS_IDS_SEL", "P1011_ODS_IDS", []]].forEach(function (x) { var v = apex.item(x[1]).getValue(), arr = x[2]; try { if (v) { arr = JSON.parse(v).map(String); } } catch (e) {} apex.item(x[0]).setValue(arr); });'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39925727427163117)
,p_plug_name=>'Meta'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'SPD_GOAL'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39958173172163127)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Regresar'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:1010:&APP_SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-left'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41239874104911855)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'NUEVO'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Nuevo'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:1011:&APP_SESSION.::&DEBUG.:1011::'
,p_button_condition=>'P1011_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-file-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39959604164163128)
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
,p_button_condition=>'P1011_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39959960516163128)
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
,p_button_condition=>'P1011_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39960380780163128)
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
,p_button_condition=>'P1011_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(41191049844896678)
,p_branch_name=>'Volver al reporte'
,p_branch_action=>'f?p=&APP_ID.:1010:&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39926169944163117)
,p_name=>'P1011_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
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
 p_id=>wwv_flow_imp.id(39926604249163118)
,p_name=>'P1011_NIT_COMPANIA'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_item_default=>'G_NIT_COMPANIA'
,p_item_default_type=>'ITEM'
,p_prompt=>unistr('Compa\00F1\00EDa')
,p_source=>'NIT_COMPANIA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>15
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39926973564163118)
,p_name=>'P1011_PARENT_GOAL_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>1350
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Meta padre'
,p_source=>'PARENT_GOAL_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - METAS'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39927334948163118)
,p_name=>'P1011_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Activo'
,p_source=>'IS_ACTIVE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39927777790163118)
,p_name=>'P1011_PLAN'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>1280
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_item_default=>'G_PLAN'
,p_item_default_type=>'ITEM'
,p_prompt=>'Plan de desarrollo'
,p_source=>'PLAN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - PLANES DE DESARROLLO'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_colspan=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39928191394163118)
,p_name=>'P1011_DEV_PLAN_LEVEL_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>1290
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nivel del plan'
,p_source=>'DEV_PLAN_LEVEL_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select NAME d, ID r from V_SPD_LOV_DEV_PLAN_LEVEL where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :P1011_PLAN order by NAME'
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P1011_PLAN'
,p_ajax_optimize_refresh=>'Y'
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
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39928530105163118)
,p_name=>'P1011_ENTITY_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>1330
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Entidad'
,p_source=>'ENTITY_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - ENTIDADES'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_colspan=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39928994197163118)
,p_name=>'P1011_EXTRA_ENTITY_IDS'
,p_data_type=>'CLOB'
,p_source_data_type=>'CLOB'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Entidades adicionales (JSON)'
,p_source=>'EXTRA_ENTITY_IDS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39929375841163118)
,p_name=>'P1011_GOAL_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>1300
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo de meta'
,p_source=>'GOAL_TYPE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - TIPO DE META'
,p_lov=>'.'||wwv_flow_imp.id(40760655877163573)||'.'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39929794834163118)
,p_name=>'P1011_CODE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>1310
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('C\00F3digo')
,p_source=>'CODE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>100
,p_begin_on_new_line=>'N'
,p_colspan=>2
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
 p_id=>wwv_flow_imp.id(39930192761163119)
,p_name=>'P1011_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>1320
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nombre'
,p_source=>'NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>4
,p_colspan=>12
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39930532204163119)
,p_name=>'P1011_INDICATOR'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>1360
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Indicador'
,p_source=>'INDICATOR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>4
,p_colspan=>6
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39931003912163119)
,p_name=>'P1011_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>1380
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Descripci\00F3n')
,p_source=>'DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>4
,p_colspan=>12
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39931332725163119)
,p_name=>'P1011_ACCUMULATION_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>1390
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_item_default=>'ACCUMULATED'
,p_prompt=>unistr('Tipo de acumulaci\00F3n')
,p_source=>'ACCUMULATION_TYPE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - TIPO DE ACUMULACION'
,p_lov=>'.'||wwv_flow_imp.id(40761645559163573)||'.'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>30
,p_colspan=>3
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39931714755163119)
,p_name=>'P1011_BASE_VALUE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>1410
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Valor base'
,p_source=>'BASE_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
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
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39932129586163119)
,p_name=>'P1011_GOAL_VALUE'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>1420
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Valor meta'
,p_source=>'GOAL_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
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
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39932525016163119)
,p_name=>'P1011_UNITS_FACTOR'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>1430
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_item_default=>'1'
,p_prompt=>'Factor meta'
,p_source=>'UNITS_FACTOR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_colspan=>3
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39932971834163119)
,p_name=>'P1011_UNITS_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>1440
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Unidad medida'
,p_source=>'UNITS_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - UNIDADES'
,p_lov_display_null=>'YES'
,p_cSize=>60
,p_cMaxlength=>500
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39933355056163119)
,p_name=>'P1011_IS_BASE_VALUE_NOT_AVAILABLE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('L\00EDnea base no disponible')
,p_source=>'IS_BASE_VALUE_NOT_AVAILABLE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39933750152163120)
,p_name=>'P1011_ODS_IDS'
,p_data_type=>'CLOB'
,p_source_data_type=>'CLOB'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'ODS (JSON)'
,p_source=>'ODS_IDS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39934189160163120)
,p_name=>'P1011_PUBLIC_POLITIC_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Pol\00EDtica p\00FAblica')
,p_source=>'PUBLIC_POLITIC_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_lov_display_null=>'YES'
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
 p_id=>wwv_flow_imp.id(39934881786163120)
,p_name=>'P1011_PUBLIC_POLITIC_COMPONENT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Componente de pol\00EDtica')
,p_source=>'PUBLIC_POLITIC_COMPONENT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_lov_display_null=>'YES'
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
 p_id=>wwv_flow_imp.id(39935296429163120)
,p_name=>'P1011_PEACE_POLITIC_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>1450
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Pol\00EDtica de Paz')
,p_source=>'PEACE_POLITIC_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - POLITICAS PUBLICAS'
,p_lov_display_null=>'YES'
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
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39935710506163120)
,p_name=>'P1011_VICTIMS_POLITIC_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>1460
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Pol\00EDtica de V\00EDctimas')
,p_source=>'VICTIMS_POLITIC_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - POLITICAS PUBLICAS'
,p_lov_display_null=>'YES'
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
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39936108348163120)
,p_name=>'P1011_PRODUCT_CATALOG_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>1470
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Indicador de Producto'
,p_source=>'PRODUCT_CATALOG_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - PRODUCTOS'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_colspan=>12
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39936464554163120)
,p_name=>'P1011_WEIGHTING'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>1400
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Ponderaci\00F3n')
,p_source=>'WEIGHTING'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
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
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39936845242163120)
,p_name=>'P1011_PI_BASE_VALUE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>1480
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Valor base (indicador de producto)'
,p_source=>'PI_BASE_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_colspan=>3
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39937279224163121)
,p_name=>'P1011_PI_GOAL_VALUE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>1490
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Valor meta (indicador de producto)'
,p_source=>'PI_GOAL_VALUE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
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
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39937696247163121)
,p_name=>'P1011_PI_UNITS_FACTOR'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>1500
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Factor meta (indicador de producto)'
,p_source=>'PI_UNITS_FACTOR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
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
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39938047519163121)
,p_name=>'P1011_PI_UNITS_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>1510
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Unidad medida (indicador de producto)'
,p_source=>'PI_UNITS_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - UNIDADES'
,p_lov_display_null=>'YES'
,p_cSize=>60
,p_cMaxlength=>500
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39938501490163121)
,p_name=>'P1011_START_DATE'
,p_source_data_type=>'TIMESTAMP_TZ'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Fecha de inicio'
,p_source=>'START_DATE'
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
 p_id=>wwv_flow_imp.id(39939238125163121)
,p_name=>'P1011_END_DATE'
,p_source_data_type=>'TIMESTAMP_TZ'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Fecha de fin'
,p_source=>'END_DATE'
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
 p_id=>wwv_flow_imp.id(39940110329163121)
,p_name=>'P1011_CREATED_AT'
,p_source_data_type=>'TIMESTAMP_TZ'
,p_is_required=>true
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Fecha de creaci\00F3n')
,p_source=>'CREATED_AT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39940881494163121)
,p_name=>'P1011_CREATED_BY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Creado por'
,p_source=>'CREATED_BY'
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
 p_id=>wwv_flow_imp.id(39941280157163122)
,p_name=>'P1011_UPDATED_AT'
,p_source_data_type=>'TIMESTAMP_TZ'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Fecha de actualizaci\00F3n')
,p_source=>'UPDATED_AT'
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
 p_id=>wwv_flow_imp.id(39942096172163122)
,p_name=>'P1011_UPDATED_BY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Actualizado por'
,p_source=>'UPDATED_BY'
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
 p_id=>wwv_flow_imp.id(39942439699163122)
,p_name=>'P1011_LINKED_GOAL_IDS'
,p_data_type=>'CLOB'
,p_source_data_type=>'CLOB'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Metas vinculadas (JSON)'
,p_source=>'LINKED_GOAL_IDS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cHeight=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39942832161163122)
,p_name=>'P1011_FORMULA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>1370
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('F\00F3rmula')
,p_source=>'FORMULA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>4
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39943242240163122)
,p_name=>'P1011_MACRO_PROJECT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>1340
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Macro Proyecto'
,p_source=>'MACRO_PROJECT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - MACROPROYECTOS'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39944009106163122)
,p_name=>'P1011_ACTIVITY_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Actividad'
,p_source=>'ACTIVITY_ID'
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
 p_id=>wwv_flow_imp.id(39944379445163123)
,p_name=>'P1011_PROJECT_CODE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('C\00F3digo del proyecto')
,p_source=>'PROJECT_CODE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>30
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39944812567163123)
,p_name=>'P1011_ORIGIN_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_item_source_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'ID de origen'
,p_source=>'ORIGIN_ID'
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
 p_id=>wwv_flow_imp.id(40778709250163610)
,p_name=>'P1011_ODS_IDS_SEL'
,p_data_type=>'CLOB'
,p_item_sequence=>1520
,p_item_plug_id=>wwv_flow_imp.id(39925727427163117)
,p_prompt=>'ODS'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'SPD - ODS'
,p_cSize=>60
,p_cHeight=>4
,p_colspan=>12
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '2')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(39939013290163121)
,p_validation_name=>'P1011_START_DATE must be timestamp'
,p_validation_sequence=>300
,p_validation=>'P1011_START_DATE'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_imp.id(39938501490163121)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(39939793398163121)
,p_validation_name=>'P1011_END_DATE must be timestamp'
,p_validation_sequence=>310
,p_validation=>'P1011_END_DATE'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_imp.id(39939238125163121)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(39940579066163121)
,p_validation_name=>'P1011_CREATED_AT must be timestamp'
,p_validation_sequence=>320
,p_validation=>'P1011_CREATED_AT'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_imp.id(39940110329163121)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(39941750774163122)
,p_validation_name=>'P1011_UPDATED_AT must be timestamp'
,p_validation_sequence=>340
,p_validation=>'P1011_UPDATED_AT'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_imp.id(39941280157163122)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(3701198763607388)
,p_name=>'SPD_G_PLAN'
,p_event_sequence=>900
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P1011_PLAN'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(3701257949607388)
,p_event_id=>wwv_flow_imp.id(3701198763607388)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'if :P1011_PLAN is not null then :G_PLAN := :P1011_PLAN; end if;'
,p_attribute_02=>'P1011_PLAN'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40778803439163612)
,p_process_sequence=>5
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'ODS: casillas a JSON'
,p_process_sql_clob=>'begin :P1011_ODS_IDS := case when :P1011_ODS_IDS_SEL is null then null else ''['' || replace(:P1011_ODS_IDS_SEL, '':'', '','') || '']'' end; end;'
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>39137788739550210
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(39961182740163128)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(39925727427163117)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Meta'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>38320168040549726
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(39960804309163128)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(39925727427163117)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Meta'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>38319789609549726
);
wwv_flow_imp.component_end;
end;
/
