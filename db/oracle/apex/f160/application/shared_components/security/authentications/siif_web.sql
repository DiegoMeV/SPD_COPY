prompt --application/shared_components/security/authentications/siif_web
begin
--   Manifest
--     AUTHENTICATION: siif_web
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>4267703994621115
,p_default_application_id=>160
,p_default_id_offset=>1641014699613402
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_authentication(
 p_id=>wwv_flow_imp.id(645817931413976869)
,p_name=>'siif_web'
,p_scheme_type=>'NATIVE_CUSTOM'
,p_attribute_03=>'siif_web_usuarios.validar_credenciales'
,p_attribute_05=>'N'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PROCEDURE set_items_aplicacion AS',
'BEGIN',
'  siif_web_usuarios.set_items_aplicacion(:APP_USER);',
'  web_und_mfa_totp.limpiar_sesion;',
'END;',
'',
'PROCEDURE post_logout AS',
'BEGIN',
'  web_und_mfa_totp.limpiar_sesion;',
'END;',
'/*PROCEDURE set_items_aplicacion AS',
'BEGIN',
'  siif_web_usuarios.set_items_aplicacion(:APP_USER);',
'END;*/'))
,p_invalid_session_type=>'URL'
,p_invalid_session_url=>'f?p=106:LOGIN:0::::P9999_NIT_COMPANIA:&G_NIT_COMPANIA.'
,p_logout_url=>'f?p=106:LOGIN:0::::P9999_NIT_COMPANIA:&G_NIT_COMPANIA.'
,p_post_auth_process=>'set_items_aplicacion'
,p_cookie_name=>'&WORKSPACE_COOKIE.'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
,p_reference_id=>56155919980935831
,p_version_scn=>41638755520
);
wwv_flow_imp.component_end;
end;
/
