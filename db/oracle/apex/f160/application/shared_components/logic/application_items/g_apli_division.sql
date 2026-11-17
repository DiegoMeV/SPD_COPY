prompt --application/shared_components/logic/application_items/g_apli_division
begin
--   Manifest
--     APPLICATION ITEM: G_APLI_DIVISION
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
 p_id=>wwv_flow_imp.id(875579776121134454)
,p_name=>'G_APLI_DIVISION'
,p_scope=>'GLOBAL'
,p_protection_level=>'I'
,p_version_scn=>40767580625
);
wwv_flow_imp.component_end;
end;
/
