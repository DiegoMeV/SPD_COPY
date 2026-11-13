prompt --application/create_application
begin
--   Manifest
--     FLOW: 106
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>106
,p_default_id_offset=>30000697869459781
,p_default_owner=>'SIIF'
);
wwv_imp_workspace.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'SIIF')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'SIIF Web')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'SIIF-MAIN')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'1DF711F687702B26A38D6C80F84F924256801D60FE1C5CCB3AD07F027E483741'
,p_bookmark_checksum_function=>'SH512'
,p_on_max_session_timeout_url=>'f?p=106:LOGIN:0::::P9999_NIT_COMPANIA:&G_NIT_COMPANIA.'
,p_max_session_idle_sec=>900
,p_on_max_idle_timeout_url=>'f?p=106:LOGIN:0::::P9999_NIT_COMPANIA:&G_NIT_COMPANIA.'
,p_session_timeout_warning_sec=>300
,p_compatibility_mode=>'24.2'
,p_flow_language=>'es'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_allow_feedback_yn=>'Y'
,p_date_format=>'DS'
,p_timestamp_format=>'DS'
,p_timestamp_tz_format=>'DS'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_documentation_banner=>unistr('Aplicaci\00F3n Principal en la cual se Gestionan los Componentes Compartidos que son usados por las dem\00E1s Aplicaciones')
,p_authentication_id=>wwv_flow_imp.id(56155919980935831)
,p_application_tab_set=>0
,p_logo_type=>'IT'
,p_logo=>'	#APP_FILES#icons/app-icon-256-rounded.png'
,p_logo_text=>'&G_NOMBRE_COMPANIA.'
,p_public_user=>'APEX_PUBLIC_USER'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>unistr('SIIF Web - &G_MODULO. | Versi\00F3n 1.0.0')
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_flow_unavailable_text=>unistr('Esta aplicaci\00F3n no est\00E1 disponible en este momento.')
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_http_response_headers=>'Content-Security-Policy: frame-ancestors ''self'' https://siifweb.com https://*.siifweb.com https://synchrox.com https://*.synchrox.com http://localhost:* https://localhost:* http://127.0.0.1:*'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_auto_time_zone=>'N'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>unistr('SIIF Web - Portal Autenticaci\00F3n')
,p_last_updated_on=>wwv_flow_imp.dz('20261111154737Z')
,p_last_updated_by=>'DIEGOM.SOLINFO'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>40
,p_version_scn=>41709318129
,p_print_server_type=>'NATIVE'
,p_file_storage=>'DB'
,p_is_pwa=>'Y'
,p_pwa_is_installable=>'N'
,p_pwa_is_push_enabled=>'N'
);
wwv_flow_imp.component_end;
end;
/
