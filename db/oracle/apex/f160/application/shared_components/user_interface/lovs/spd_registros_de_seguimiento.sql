prompt --application/shared_components/user_interface/lovs/spd_registros_de_seguimiento
begin
--   Manifest
--     SPD - REGISTROS DE SEGUIMIENTO
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>4267703994621115
,p_default_application_id=>160
,p_default_id_offset=>1641014699613402
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(40368333617163365)
,p_lov_name=>'SPD - REGISTROS DE SEGUIMIENTO'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'V_SPD_LOV_MONITORING_RECORD'
,p_query_where=>'NIT_COMPANIA = :G_NIT_COMPANIA'
,p_return_column_name=>'ID'
,p_display_column_name=>'NAME'
,p_default_sort_column_name=>'NAME'
,p_default_sort_direction=>'ASC'
,p_version_scn=>2578651
);
wwv_flow_imp.component_end;
end;
/
