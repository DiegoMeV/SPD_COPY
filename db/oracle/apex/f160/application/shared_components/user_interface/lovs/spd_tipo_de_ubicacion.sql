prompt --application/shared_components/user_interface/lovs/spd_tipo_de_ubicacion
begin
--   Manifest
--     SPD - TIPO DE UBICACION
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
 p_id=>wwv_flow_imp.id(40763678449163573)
,p_lov_name=>'SPD - TIPO DE UBICACION'
,p_lov_query=>'.'||wwv_flow_imp.id(40763678449163573)||'.'
,p_location=>'STATIC'
,p_version_scn=>2578761
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40763796173163573)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Departamento'
,p_lov_return_value=>'DEPARTMENT'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40763887939163573)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Municipio'
,p_lov_return_value=>'MUNICIPALITY'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40763962532163573)
,p_lov_disp_sequence=>30
,p_lov_disp_value=>'Corregimiento'
,p_lov_return_value=>'TOWNSHIP'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40764023048163573)
,p_lov_disp_sequence=>40
,p_lov_disp_value=>'Vereda'
,p_lov_return_value=>'RURAL_SETTLEMENT'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40764135166163573)
,p_lov_disp_sequence=>50
,p_lov_disp_value=>'Comuna'
,p_lov_return_value=>'DISTRICT'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40764254655163573)
,p_lov_disp_sequence=>60
,p_lov_disp_value=>'Barrio'
,p_lov_return_value=>'NEIGHBORHOOD'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40764347530163573)
,p_lov_disp_sequence=>70
,p_lov_disp_value=>'Otro'
,p_lov_return_value=>'OTHER'
);
wwv_flow_imp.component_end;
end;
/
