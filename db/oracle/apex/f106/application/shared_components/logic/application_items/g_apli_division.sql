prompt --application/shared_components/logic/application_items/g_apli_division
begin
--   Manifest
--     APPLICATION ITEM: G_APLI_DIVISION
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>106
,p_default_id_offset=>30000697869459781
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_flow_item(
 p_id=>wwv_flow_imp.id(285239130343821073)
,p_name=>'G_APLI_DIVISION'
,p_scope=>'GLOBAL'
,p_protection_level=>'I'
,p_version_scn=>40769351326
,p_created_on=>wwv_flow_imp.dz('20260821153220Z')
,p_updated_on=>wwv_flow_imp.dz('20260827134134Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'JOSEC.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
