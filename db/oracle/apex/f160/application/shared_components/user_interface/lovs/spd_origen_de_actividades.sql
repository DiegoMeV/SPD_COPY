prompt --application/shared_components/user_interface/lovs/spd_origen_de_actividades
begin
--   Manifest
--     SPD - ORIGEN DE ACTIVIDADES
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
 p_id=>wwv_flow_imp.id(40768452442163573)
,p_lov_name=>'SPD - ORIGEN DE ACTIVIDADES'
,p_lov_query=>'.'||wwv_flow_imp.id(40768452442163573)||'.'
,p_location=>'STATIC'
,p_version_scn=>2578761
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40768583168163573)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Manual'
,p_lov_return_value=>'MANUAL'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40768620943163573)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Obtener de SIIF'
,p_lov_return_value=>'SIIF'
);
wwv_flow_imp.component_end;
end;
/
