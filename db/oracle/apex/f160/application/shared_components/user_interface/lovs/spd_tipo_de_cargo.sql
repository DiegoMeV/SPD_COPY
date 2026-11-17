prompt --application/shared_components/user_interface/lovs/spd_tipo_de_cargo
begin
--   Manifest
--     SPD - TIPO DE CARGO
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
 p_id=>wwv_flow_imp.id(40770972153163573)
,p_lov_name=>'SPD - TIPO DE CARGO'
,p_lov_query=>'.'||wwv_flow_imp.id(40770972153163573)||'.'
,p_location=>'STATIC'
,p_version_scn=>2578761
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40771092932163574)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Secretario(a)'
,p_lov_return_value=>'Secretario(a)'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40771213196163574)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Director(a)'
,p_lov_return_value=>'Director(a)'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40771272168163574)
,p_lov_disp_sequence=>30
,p_lov_disp_value=>'Gerente'
,p_lov_return_value=>'Gerente'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40771336755163574)
,p_lov_disp_sequence=>40
,p_lov_disp_value=>'Asesor(a)'
,p_lov_return_value=>'Asesor(a)'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40771443258163574)
,p_lov_disp_sequence=>50
,p_lov_disp_value=>'Jefe de Oficina'
,p_lov_return_value=>'Jefe de Oficina'
);
wwv_flow_imp.component_end;
end;
/
