prompt --application/pages/page_09998
begin
--   Manifest
--     PAGE: 09998
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
 p_id=>9998
,p_name=>unistr('Cambiar Contrase\00F1a')
,p_alias=>'CAMBIAR-CONTRASENA'
,p_step_title=>unistr('Cambiar Contrase\00F1a')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>2101157952850466385
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'17'
,p_last_updated_on=>wwv_flow_imp.dz('20261023134633Z')
,p_last_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56149119281906286)
,p_plug_name=>unistr('Cambiar Contrase\00F1a')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2674157997338192145
,p_plug_display_sequence=>10
,p_location=>null
,p_region_image=>'#APP_FILES#icons/app-icon-512.png'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(350994962025045830)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56149119281906286)
,p_button_name=>'CANCELAR'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancelar'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:::'
,p_button_condition=>'NVL(:G_CAMBIAR_PWD, ''N'') <> ''S'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_created_on=>wwv_flow_imp.dz('20261022195932Z')
,p_updated_on=>wwv_flow_imp.dz('20261022195932Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56149349231906288)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(56149119281906286)
,p_button_name=>'CAMBIAR_PASSWORD'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Cambiar Contrase\00F1a')
,p_button_position=>'NEXT'
,p_show_processing=>'Y'
,p_updated_on=>wwv_flow_imp.dz('20261022195932Z')
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(56150507725906300)
,p_branch_name=>'Logout'
,p_branch_action=>'apex_authentication.logout(:SESSION, :APP_ID)'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'PLSQL'
,p_branch_when_button_id=>wwv_flow_imp.id(56149349231906288)
,p_branch_sequence=>10
,p_branch_condition_type=>'EXPRESSION'
,p_branch_condition=>'NVL(:G_CAMBIAR_PWD, ''N'') = ''S'''
,p_branch_condition_text=>'PLSQL'
,p_updated_on=>wwv_flow_imp.dz('20261022200212Z')
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(350995150859045832)
,p_branch_name=>'Ir a Inicio'
,p_branch_action=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(56149349231906288)
,p_branch_sequence=>20
,p_branch_condition_type=>'EXPRESSION'
,p_branch_condition=>'NVL(:G_CAMBIAR_PWD, ''N'') <> ''S'''
,p_branch_condition_text=>'PLSQL'
,p_created_on=>wwv_flow_imp.dz('20261022200212Z')
,p_updated_on=>wwv_flow_imp.dz('20261022200212Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56149087648906285)
,p_name=>'P9998_PASSWORD'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(56149119281906286)
,p_prompt=>'Nuevo Password'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'submit_when_enter_pressed', 'Y')).to_clob
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56149207276906287)
,p_name=>'P9998_CONFIRMAR_PASSWORD'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(56149119281906286)
,p_prompt=>'Confirmar Password'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'submit_when_enter_pressed', 'Y')).to_clob
,p_updated_on=>wwv_flow_imp.dz('20261022195932Z')
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56149799525906293)
,p_name=>'P9998_USERNAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(56149119281906286)
,p_item_default=>'G_USUARIO'
,p_item_default_type=>'ITEM'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56149930995906294)
,p_name=>'P9998_NIT_COMPANIA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56149119281906286)
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
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(350994815218045829)
,p_name=>'P9998_PASSWORD_ACTUAL'
,p_is_required=>true
,p_item_sequence=>25
,p_item_plug_id=>wwv_flow_imp.id(56149119281906286)
,p_prompt=>unistr('Contrase\00F1a Actual')
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>30
,p_display_when=>'NVL(:G_CAMBIAR_PWD, ''N'') <> ''S'''
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'submit_when_enter_pressed', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261022195932Z')
,p_updated_on=>wwv_flow_imp.dz('20261022195932Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(350995015044045831)
,p_validation_name=>unistr('Contrase\00F1a Actual Correcta')
,p_validation_sequence=>5
,p_validation=>'siif_web_usuarios.validar_password_actual(:G_USUARIO, :G_NIT_COMPANIA, :P9998_PASSWORD_ACTUAL)'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>unistr('La contrase\00F1a actual no es correcta')
,p_validation_condition=>'NVL(:G_CAMBIAR_PWD, ''N'') <> ''S'''
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
,p_when_button_pressed=>wwv_flow_imp.id(56149349231906288)
,p_associated_item=>wwv_flow_imp.id(350994815218045829)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
,p_created_on=>wwv_flow_imp.dz('20261022200212Z')
,p_updated_on=>wwv_flow_imp.dz('20261022200212Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(56150406495906299)
,p_validation_name=>unistr('Contrase\00F1as son Iguales')
,p_validation_sequence=>10
,p_validation=>':P9998_PASSWORD = :P9998_CONFIRMAR_PASSWORD'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>unistr('La Contrase\00F1a y su confirmaci\00F3n deben coincidir')
,p_when_button_pressed=>wwv_flow_imp.id(56149349231906288)
,p_associated_item=>wwv_flow_imp.id(56149207276906287)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
,p_updated_on=>wwv_flow_imp.dz('20261022200212Z')
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56150032511906295)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_INVOKE_API'
,p_process_name=>unistr('Cambiar Contrase\00F1a')
,p_attribute_01=>'PLSQL_PACKAGE'
,p_attribute_03=>'SIIF_WEB_USUARIOS'
,p_attribute_04=>'CAMBIAR_PASSWORD'
,p_process_error_message=>unistr('No se pudo cambiar la contrase\00F1a: #SQLERRM_TEXT#')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56149349231906288)
,p_process_success_message=>unistr('Contrase\00F1a Cambiada Exitosamente')
,p_internal_uid=>26149334642446514
,p_updated_on=>wwv_flow_imp.dz('20261022200212Z')
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(56150185324906296)
,p_page_process_id=>wwv_flow_imp.id(56150032511906295)
,p_page_id=>9998
,p_name=>'p_username'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>10
,p_value_type=>'ITEM'
,p_value=>'G_USUARIO'
,p_updated_on=>wwv_flow_imp.dz('20261022200212Z')
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(56150272107906297)
,p_page_process_id=>wwv_flow_imp.id(56150032511906295)
,p_page_id=>9998
,p_name=>'p_nit_compania'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>20
,p_value_type=>'ITEM'
,p_value=>'G_NIT_COMPANIA'
,p_updated_on=>wwv_flow_imp.dz('20261022200212Z')
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(56150377612906298)
,p_page_process_id=>wwv_flow_imp.id(56150032511906295)
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
