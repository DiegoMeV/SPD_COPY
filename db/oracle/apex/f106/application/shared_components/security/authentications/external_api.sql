prompt --application/shared_components/security/authentications/external_api
begin
--   Manifest
--     AUTHENTICATION: External_API
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
 p_id=>wwv_flow_imp.id(369716244896984086)
,p_name=>'External_API'
,p_scheme_type=>'NATIVE_OPEN_DOOR'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
,p_version_scn=>41698490357
,p_created_on=>wwv_flow_imp.dz('20261106155658Z')
,p_updated_on=>wwv_flow_imp.dz('20261106155658Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
