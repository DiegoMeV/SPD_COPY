prompt --application/shared_components/logic/application_items/g_apli_division
begin
--   Manifest
--     APPLICATION ITEM: G_APLI_DIVISION
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>154
,p_default_id_offset=>292021538769791282
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_flow_item(
 p_id=>wwv_flow_imp.id(873938761421521052)
,p_name=>'G_APLI_DIVISION'
,p_scope=>'GLOBAL'
,p_protection_level=>'I'
,p_version_scn=>40767580625
,p_created_on=>wwv_flow_imp.dz('20260826184222Z')
,p_updated_on=>wwv_flow_imp.dz('20260826184255Z')
,p_created_by=>'ANGELENCINALES.SOLINFO'
,p_updated_by=>'ANGELENCINALES.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
