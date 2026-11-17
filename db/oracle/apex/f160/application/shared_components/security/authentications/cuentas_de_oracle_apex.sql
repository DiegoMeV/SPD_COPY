prompt --application/shared_components/security/authentications/cuentas_de_oracle_apex
begin
--   Manifest
--     AUTHENTICATION: Cuentas de Oracle APEX
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
 p_id=>wwv_flow_imp.id(645791722611681120)
,p_name=>'Cuentas de Oracle APEX'
,p_scheme_type=>'NATIVE_APEX_ACCOUNTS'
,p_invalid_session_type=>'LOGIN'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
,p_version_scn=>35446683761
);
wwv_flow_imp.component_end;
end;
/
