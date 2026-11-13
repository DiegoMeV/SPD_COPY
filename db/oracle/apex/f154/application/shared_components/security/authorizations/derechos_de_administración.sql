prompt --application/shared_components/security/authorizations/derechos_de_administración
begin
--   Manifest
--     SECURITY SCHEME: Derechos de administración
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>154
,p_default_id_offset=>292021538769791282
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(644156198242067753)
,p_name=>unistr('Derechos de administraci\00F3n')
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>'return true;'
,p_error_message=>'Privilegios insuficientes. El usuario no es administrador.'
,p_version_scn=>35446683789
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
wwv_flow_imp.component_end;
end;
/
