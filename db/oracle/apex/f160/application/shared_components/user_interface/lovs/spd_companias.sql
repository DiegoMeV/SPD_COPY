prompt --application/shared_components/user_interface/lovs/spd_companias
begin
--   Manifest
--     SPD - COMPANIAS
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
 p_id=>wwv_flow_imp.id(39886983472163105)
,p_lov_name=>'SPD - COMPANIAS'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'COMPANIA'
,p_query_where=>'NIT_COMPANIA = :G_NIT_COMPANIA'
,p_return_column_name=>'NIT_COMPANIA'
,p_display_column_name=>'NOMBRE'
,p_default_sort_column_name=>'NOMBRE'
,p_default_sort_direction=>'ASC'
,p_version_scn=>2578465
);
wwv_flow_imp.component_end;
end;
/
