prompt --application/shared_components/user_interface/lovs/spd_estado_del_registro
begin
--   Manifest
--     SPD - ESTADO DEL REGISTRO
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
 p_id=>wwv_flow_imp.id(40766270330163573)
,p_lov_name=>'SPD - ESTADO DEL REGISTRO'
,p_lov_query=>'.'||wwv_flow_imp.id(40766270330163573)||'.'
,p_location=>'STATIC'
,p_version_scn=>2578761
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40766342277163573)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Copiado'
,p_lov_return_value=>'COPIED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40766436113163573)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Programado'
,p_lov_return_value=>'PLANNED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40766532209163573)
,p_lov_disp_sequence=>30
,p_lov_disp_value=>'Reportado'
,p_lov_return_value=>'REPORTED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40766657927163573)
,p_lov_disp_sequence=>40
,p_lov_disp_value=>'Validado'
,p_lov_return_value=>'VALIDATED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40766754691163573)
,p_lov_disp_sequence=>50
,p_lov_disp_value=>'Revisado'
,p_lov_return_value=>'REVIEWED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40766822113163573)
,p_lov_disp_sequence=>60
,p_lov_disp_value=>'Aprobado'
,p_lov_return_value=>'APPROVED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40766917297163573)
,p_lov_disp_sequence=>70
,p_lov_disp_value=>'Rechazado'
,p_lov_return_value=>'REJECTED'
);
wwv_flow_imp.component_end;
end;
/
