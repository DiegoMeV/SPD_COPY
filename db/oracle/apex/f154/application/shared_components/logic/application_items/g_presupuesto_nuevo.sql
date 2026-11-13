prompt --application/shared_components/logic/application_items/g_presupuesto_nuevo
begin
--   Manifest
--     APPLICATION ITEM: G_PRESUPUESTO_NUEVO
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
 p_id=>wwv_flow_imp.id(859208277642699078)
,p_name=>'G_PRESUPUESTO_NUEVO'
,p_scope=>'GLOBAL'
,p_protection_level=>'I'
,p_reference_id=>275199675349083468
,p_version_scn=>40544798241
,p_created_on=>wwv_flow_imp.dz('20260806151919Z')
,p_updated_on=>wwv_flow_imp.dz('20260806151919Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
