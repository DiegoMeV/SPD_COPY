prompt --application/shared_components/security/authorizations/derechos_de_administracion
begin
--   Manifest
--     SECURITY SCHEME: Derechos de administracion
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>4267703994621115
,p_default_application_id=>160
,p_default_id_offset=>1641014699613402
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(645797212941681155)
,p_name=>'Derechos de administracion'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>'return true;'
,p_error_message=>'Privilegios insuficientes. El usuario no es administrador.'
,p_version_scn=>4036537
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
wwv_flow_imp.component_end;
end;
/
