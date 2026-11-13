prompt --application/shared_components/logic/application_items/g_vig_reg_ini
begin
--   Manifest
--     APPLICATION ITEM: G_VIG_REG_INI
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
 p_id=>wwv_flow_imp.id(275199023843081530)
,p_name=>'G_VIG_REG_INI'
,p_scope=>'GLOBAL'
,p_protection_level=>'I'
,p_version_scn=>40544797988
,p_created_on=>wwv_flow_imp.dz('20260806150904Z')
,p_updated_on=>wwv_flow_imp.dz('20260806150904Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
