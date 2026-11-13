prompt --application/pages/page_00002
begin
--   Manifest
--     PAGE: 00002
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>106
,p_default_id_offset=>30000697869459781
,p_default_owner=>'SIIF'
);
wwv_flow_imp_page.create_page(
 p_id=>2
,p_name=>unistr('Cambiar Contrase\00F1a')
,p_alias=>'CAMBIO-CONTRASENA-VOL'
,p_step_title=>unistr('Cambiar Contrase\00F1a')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4072355960268175073
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'17'
,p_created_on=>wwv_flow_imp.dz('20261022192807Z')
,p_last_updated_on=>wwv_flow_imp.dz('20261023142731Z')
,p_created_by=>'WISAZA'
,p_last_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(412171008697557246)
,p_plug_name=>unistr('Cambiar Contrase\00F1a')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2674157997338192145
,p_plug_display_sequence=>10
,p_location=>null
,p_region_image=>'#APP_FILES#icons/app-icon-512.png'
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261022192807Z')
,p_updated_on=>wwv_flow_imp.dz('20261022192807Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(356022439109650990)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(412171008697557246)
,p_button_name=>'SUBMIT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Cambiar Contrase\00F1a')
,p_button_position=>'NEXT'
,p_created_on=>wwv_flow_imp.dz('20261022192807Z')
,p_updated_on=>wwv_flow_imp.dz('20261023142207Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(356026636851651016)
,p_branch_name=>'Ir a Inicio'
,p_branch_action=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(356022439109650990)
,p_branch_sequence=>10
,p_created_on=>wwv_flow_imp.dz('20261022192807Z')
,p_updated_on=>wwv_flow_imp.dz('20261023142313Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(350995248632045833)
,p_name=>'P2_PASSWORD_ACTUAL'
,p_is_required=>true
,p_item_sequence=>25
,p_item_plug_id=>wwv_flow_imp.id(412171008697557246)
,p_prompt=>unistr('Contrase\00F1a Actual')
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'submit_when_enter_pressed', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261023142207Z')
,p_updated_on=>wwv_flow_imp.dz('20261023142207Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(412171903351557276)
,p_name=>'P2_PASSWORD'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(412171008697557246)
,p_prompt=>'Nuevo Password'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'submit_when_enter_pressed', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261022192807Z')
,p_updated_on=>wwv_flow_imp.dz('20261023142207Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(412172022979557278)
,p_name=>'P2_CONFIRMAR_PASSWORD'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(412171008697557246)
,p_prompt=>'Confirmar Password'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'submit_when_enter_pressed', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261022192807Z')
,p_updated_on=>wwv_flow_imp.dz('20261023142207Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(412172615228557284)
,p_name=>'P2_USERNAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(412171008697557246)
,p_item_default=>'G_USUARIO'
,p_item_default_type=>'ITEM'
,p_prompt=>'Usuario'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261022192807Z')
,p_updated_on=>wwv_flow_imp.dz('20261023142207Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(412172746698557285)
,p_name=>'P2_NIT_COMPANIA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(412171008697557246)
,p_item_default=>'G_NIT_COMPANIA'
,p_item_default_type=>'ITEM'
,p_prompt=>unistr('Compa\00F1ia')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261022192807Z')
,p_updated_on=>wwv_flow_imp.dz('20261023142207Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(350995325710045834)
,p_validation_name=>unistr('Contrase\00F1a Actual Correcta')
,p_validation_sequence=>5
,p_validation=>'siif_web_usuarios.validar_password_actual(:G_USUARIO, :G_NIT_COMPANIA, :P2_PASSWORD_ACTUAL)'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>unistr('La contrase\00F1a actual no es correcta')
,p_associated_item=>wwv_flow_imp.id(350995248632045833)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
,p_created_on=>wwv_flow_imp.dz('20261023142313Z')
,p_updated_on=>wwv_flow_imp.dz('20261023142313Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(356024354774651011)
,p_validation_name=>unistr('Contrase\00F1as son Iguales')
,p_validation_sequence=>10
,p_validation=>':P2_PASSWORD = :P2_CONFIRMAR_PASSWORD'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>unistr('La Contrase\00F1a y su confirmaci\00F3n deben coincidir')
,p_associated_item=>wwv_flow_imp.id(412172022979557278)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
,p_created_on=>wwv_flow_imp.dz('20261022192807Z')
,p_updated_on=>wwv_flow_imp.dz('20261022192807Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(356024640069651011)
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
,p_internal_uid=>356024640069651011
,p_created_on=>wwv_flow_imp.dz('20261022192807Z')
,p_updated_on=>wwv_flow_imp.dz('20261022192807Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(356025161663651013)
,p_page_process_id=>wwv_flow_imp.id(356024640069651011)
,p_page_id=>2
,p_name=>'p_username'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>10
,p_value_type=>'ITEM'
,p_value=>'P2_USERNAME'
,p_created_on=>wwv_flow_imp.dz('20261022192807Z')
,p_updated_on=>wwv_flow_imp.dz('20261022192807Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(356025647326651015)
,p_page_process_id=>wwv_flow_imp.id(356024640069651011)
,p_page_id=>2
,p_name=>'p_nit_compania'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>20
,p_value_type=>'ITEM'
,p_value=>'P2_NIT_COMPANIA'
,p_created_on=>wwv_flow_imp.dz('20261022192807Z')
,p_updated_on=>wwv_flow_imp.dz('20261022192807Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(356026174772651015)
,p_page_process_id=>wwv_flow_imp.id(356024640069651011)
,p_page_id=>2
,p_name=>'p_password'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>30
,p_value_type=>'ITEM'
,p_value=>'P2_PASSWORD'
,p_created_on=>wwv_flow_imp.dz('20261022192807Z')
,p_updated_on=>wwv_flow_imp.dz('20261022192807Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp.component_end;
end;
/
