prompt --application/pages/page_09998
begin
--   Manifest
--     PAGE: 09998
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
 p_id=>9998
,p_name=>unistr('Cambiar Contrase\00F1a')
,p_alias=>'CAMBIAR-CONTRASENA'
,p_step_title=>unistr('Cambiar Contrase\00F1a')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_imp.id(39432065530162891)
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'17'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(645811130714947324)
,p_plug_name=>unistr('Cambiar Contrase\00F1a')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39519412671162907)
,p_plug_display_sequence=>10
,p_location=>null
,p_region_image=>'#APP_FILES#icons/app-icon-512.png'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(645811360664947326)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(645811130714947324)
,p_button_name=>'SUBMIT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(39601281081162925)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Cambiar Contrase\00F1a')
,p_button_position=>'NEXT'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(645812519158947338)
,p_branch_name=>'Logout'
,p_branch_action=>'apex_authentication.logout(:SESSION, :APP_ID)'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'PLSQL'
,p_branch_when_button_id=>wwv_flow_imp.id(645811360664947326)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(645811099081947323)
,p_name=>'P9998_PASSWORD'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(645811130714947324)
,p_prompt=>'Nuevo Password'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39597968306162923)
,p_item_template_options=>'#DEFAULT#'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(645811218709947325)
,p_name=>'P9998_CONFIRMAR_PASSWORD'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(645811130714947324)
,p_prompt=>'Confirmar Password'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39597968306162923)
,p_item_template_options=>'#DEFAULT#'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(645811810958947331)
,p_name=>'P9998_USERNAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(645811130714947324)
,p_item_default=>'G_USUARIO'
,p_item_default_type=>'ITEM'
,p_prompt=>'Usuario'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39597826564162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(645811942428947332)
,p_name=>'P9998_NIT_COMPANIA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(645811130714947324)
,p_item_default=>'G_NIT_COMPANIA'
,p_item_default_type=>'ITEM'
,p_prompt=>unistr('Compa\00F1ia')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_imp.id(39597826564162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'format', 'PLAIN',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(645812417928947337)
,p_validation_name=>unistr('Contrase\00F1as son Iguales')
,p_validation_sequence=>10
,p_validation=>':P9998_PASSWORD = :P9998_CONFIRMAR_PASSWORD'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>unistr('La Contrase\00F1a y si confirmaci\00F3n deben coincidir')
,p_associated_item=>wwv_flow_imp.id(645811218709947325)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(645812043944947333)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_INVOKE_API'
,p_process_name=>unistr('Cambiar Contrase\00F1a')
,p_attribute_01=>'PLSQL_PACKAGE'
,p_attribute_03=>'SIIF_WEB_USUARIOS'
,p_attribute_04=>'CAMBIAR_PASSWORD'
,p_process_error_message=>unistr('No se puede cambiar la Contrase\00F1a')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('Contrase\00F1a Cambiada Exitosamente')
,p_internal_uid=>26149334642446514
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(645812196757947334)
,p_page_process_id=>wwv_flow_imp.id(645812043944947333)
,p_page_id=>9998
,p_name=>'p_username'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>10
,p_value_type=>'ITEM'
,p_value=>'P9998_USERNAME'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(645812283540947335)
,p_page_process_id=>wwv_flow_imp.id(645812043944947333)
,p_page_id=>9998
,p_name=>'p_nit_compania'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>20
,p_value_type=>'ITEM'
,p_value=>'P9998_NIT_COMPANIA'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(645812389045947336)
,p_page_process_id=>wwv_flow_imp.id(645812043944947333)
,p_page_id=>9998
,p_name=>'p_password'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>30
,p_value_type=>'ITEM'
,p_value=>'P9998_PASSWORD'
);
wwv_flow_imp.component_end;
end;
/
