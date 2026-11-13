prompt --application/shared_components/security/authorizations/puede_acceder
begin
--   Manifest
--     SECURITY SCHEME: puede_acceder
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>106
,p_default_id_offset=>30000697869459781
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(306171405738411067)
,p_name=>'puede_acceder'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return web_und_autorizacion.puede_acceder(',
'  p_nit_compania => :G_NIT_COMPANIA,',
'  p_username => :G_USUARIO,',
'  p_modulo => :G_MODULO,',
'  p_opcion => :G_OPCION_MENU',
');'))
,p_error_message=>unistr('No est\00E1 autorizado para acceder a esta p\00E1gina')
,p_version_scn=>41231803265
,p_caching=>'BY_USER_BY_PAGE_VIEW'
,p_created_on=>wwv_flow_imp.dz('20260909143003Z')
,p_updated_on=>wwv_flow_imp.dz('20260909143003Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp.component_end;
end;
/
