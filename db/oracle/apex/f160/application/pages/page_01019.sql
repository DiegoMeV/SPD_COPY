prompt --application/pages/page_01019
begin
--   Manifest
--     PAGE: 01019
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
 p_id=>1019
,p_name=>unistr('SPD_Pol\00EDtica territorial')
,p_alias=>'SPD_POLITICA_TERRITORIAL'
,p_step_title=>unistr('Pol\00EDtica p\00FAblica')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40060732497163173)
,p_plug_name=>unistr('Pol\00EDtica p\00FAblica')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'SPD_PUBLIC_POLITIC'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40070097730163208)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Regresar'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:1018:&APP_SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-left'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41240144817911855)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'NUEVO'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Nuevo'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:1019:&APP_SESSION.::&DEBUG.:1019::'
,p_button_condition=>'P1019_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-file-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40071441928163208)
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
,p_button_condition=>'P1019_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40071868194163208)
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
,p_button_condition=>'P1019_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40072241519163208)
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
,p_button_condition=>'P1019_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(41190468104896677)
,p_branch_name=>'Volver al reporte'
,p_branch_action=>'f?p=&APP_ID.:1018:&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40061120623163173)
,p_name=>'P1019_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_item_source_plug_id=>wwv_flow_imp.id(40060732497163173)
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
 p_id=>wwv_flow_imp.id(40061550291163205)
,p_name=>'P1019_NIT_COMPANIA'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_item_source_plug_id=>wwv_flow_imp.id(40060732497163173)
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
 p_id=>wwv_flow_imp.id(40061995991163205)
,p_name=>'P1019_CATEGORY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_item_source_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_use_cache_before_default=>'NO'
,p_item_default=>'TERRITORY'
,p_prompt=>unistr('Categor\00EDa')
,p_source=>'CATEGORY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>20
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40062372636163205)
,p_name=>'P1019_CODE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>1620
,p_item_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_item_source_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('C\00F3digo')
,p_source=>'CODE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>50
,p_colspan=>3
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
 p_id=>wwv_flow_imp.id(40062728182163206)
,p_name=>'P1019_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>1660
,p_item_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_item_source_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nombre'
,p_source=>'NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>1000
,p_cHeight=>4
,p_colspan=>6
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40063186823163206)
,p_name=>'P1019_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>1670
,p_item_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_item_source_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Descripci\00F3n')
,p_source=>'DESCRIPTION'
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
 p_id=>wwv_flow_imp.id(40063543113163206)
,p_name=>'P1019_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>1650
,p_item_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_item_source_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_use_cache_before_default=>'NO'
,p_item_default=>'S'
,p_prompt=>'Activa'
,p_source=>'IS_ACTIVE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_cSize=>32
,p_cMaxlength=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_label_alignment=>'RIGHT'
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
 p_id=>wwv_flow_imp.id(40063925062163206)
,p_name=>'P1019_FROM_YEAR'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>1630
,p_item_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_item_source_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('A\00F1o Inicial')
,p_source=>'FROM_YEAR'
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
 p_id=>wwv_flow_imp.id(40064385976163206)
,p_name=>'P1019_TO_YEAR'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>1640
,p_item_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_item_source_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('A\00F1o Final')
,p_source=>'TO_YEAR'
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
 p_id=>wwv_flow_imp.id(40064797243163206)
,p_name=>'P1019_CREATED_AT'
,p_source_data_type=>'TIMESTAMP_TZ'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_item_source_plug_id=>wwv_flow_imp.id(40060732497163173)
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
 p_id=>wwv_flow_imp.id(40065526020163206)
,p_name=>'P1019_UPDATED_AT'
,p_source_data_type=>'TIMESTAMP_TZ'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(40060732497163173)
,p_item_source_plug_id=>wwv_flow_imp.id(40060732497163173)
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
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(40065238629163206)
,p_validation_name=>'P1019_CREATED_AT must be timestamp'
,p_validation_sequence=>90
,p_validation=>'P1019_CREATED_AT'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_imp.id(40064797243163206)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(40066059801163206)
,p_validation_name=>'P1019_UPDATED_AT must be timestamp'
,p_validation_sequence=>100
,p_validation=>'P1019_UPDATED_AT'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_imp.id(40065526020163206)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40073023385163208)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(40060732497163173)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Public Politic'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>38432008685549806
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40072627423163208)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(40060732497163173)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Public Politic'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>38431612723549806
);
wwv_flow_imp.component_end;
end;
/
