prompt --application/shared_components/security/authentications/cuentas_de_oracle_apex
begin
--   Manifest
--     AUTHENTICATION: Cuentas de Oracle APEX
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>106
,p_default_id_offset=>30000697869459781
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_authentication(
 p_id=>wwv_flow_imp.id(56129711178640082)
,p_name=>'Cuentas de Oracle APEX'
,p_scheme_type=>'NATIVE_APEX_ACCOUNTS'
,p_invalid_session_type=>'LOGIN'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
,p_version_scn=>35446683761
,p_created_on=>wwv_flow_imp.dz('20251219165414Z')
,p_updated_on=>wwv_flow_imp.dz('20251219165414Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp.component_end;
end;
/
