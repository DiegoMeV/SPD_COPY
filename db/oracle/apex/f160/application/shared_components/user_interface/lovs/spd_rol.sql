prompt --application/shared_components/user_interface/lovs/spd_rol
begin
--   Manifest
--     SPD - ROL
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
 p_id=>wwv_flow_imp.id(40762512112163573)
,p_lov_name=>'SPD - ROL'
,p_lov_query=>'.'||wwv_flow_imp.id(40762512112163573)||'.'
,p_location=>'STATIC'
,p_version_scn=>2578761
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40762516915163573)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Operador de Seguimiento - Reporta'
,p_lov_return_value=>'OPERATOR'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40762659352163573)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Jefe de Oficina - Valida'
,p_lov_return_value=>'VALIDATOR'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40762743374163573)
,p_lov_disp_sequence=>30
,p_lov_disp_value=>'Administrador de Seguimiento - Revisa'
,p_lov_return_value=>'AUDITOR'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40762866785163573)
,p_lov_disp_sequence=>40
,p_lov_disp_value=>unistr('S\00FAper Administrador')
,p_lov_return_value=>'ADMIN'
);
wwv_flow_imp.component_end;
end;
/
