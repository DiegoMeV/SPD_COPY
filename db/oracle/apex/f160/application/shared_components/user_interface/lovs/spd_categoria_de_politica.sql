prompt --application/shared_components/user_interface/lovs/spd_categoria_de_politica
begin
--   Manifest
--     SPD - CATEGORIA DE POLITICA
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
 p_id=>wwv_flow_imp.id(40762944741163573)
,p_lov_name=>'SPD - CATEGORIA DE POLITICA'
,p_lov_query=>'.'||wwv_flow_imp.id(40762944741163573)||'.'
,p_location=>'STATIC'
,p_version_scn=>2578761
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40763062303163573)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Entidad'
,p_lov_return_value=>'TERRITORY'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40763153950163573)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Paz'
,p_lov_return_value=>'PEACE'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40763253256163573)
,p_lov_disp_sequence=>30
,p_lov_disp_value=>unistr('V\00EDctimas')
,p_lov_return_value=>'VICTIMS'
);
wwv_flow_imp.component_end;
end;
/
