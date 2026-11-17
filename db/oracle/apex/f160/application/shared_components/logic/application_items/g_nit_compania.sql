prompt --application/shared_components/logic/application_items/g_nit_compania
begin
--   Manifest
--     APPLICATION ITEM: G_NIT_COMPANIA
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>4267703994621115
,p_default_application_id=>160
,p_default_id_offset=>1641014699613402
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_flow_item(
 p_id=>wwv_flow_imp.id(645820592589062635)
,p_name=>'G_NIT_COMPANIA'
,p_scope=>'GLOBAL'
,p_protection_level=>'I'
,p_reference_id=>56158581156021597
,p_version_scn=>35447146764
);
wwv_flow_imp.component_end;
end;
/
