prompt --application/shared_components/logic/application_items/g_ruta_archivo_adjunto
begin
--   Manifest
--     APPLICATION ITEM: G_RUTA_ARCHIVO_ADJUNTO
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
 p_id=>wwv_flow_imp.id(874702937049512700)
,p_name=>'G_RUTA_ARCHIVO_ADJUNTO'
,p_protection_level=>'S'
,p_version_scn=>40769618977
,p_created_on=>wwv_flow_imp.dz('20260827165419Z')
,p_updated_on=>wwv_flow_imp.dz('20260827165419Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
