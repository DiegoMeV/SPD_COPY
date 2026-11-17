prompt --application/shared_components/user_interface/lovs/spd_estado_del_seguimiento
begin
--   Manifest
--     SPD - ESTADO DEL SEGUIMIENTO
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
 p_id=>wwv_flow_imp.id(40765152687163573)
,p_lov_name=>'SPD - ESTADO DEL SEGUIMIENTO'
,p_lov_query=>'.'||wwv_flow_imp.id(40765152687163573)||'.'
,p_location=>'STATIC'
,p_version_scn=>2578761
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40765253769163573)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Creado'
,p_lov_return_value=>'CREATED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40765381890163573)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Programado'
,p_lov_return_value=>'SCHEDULING'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40765476412163573)
,p_lov_disp_sequence=>30
,p_lov_disp_value=>'Reportado'
,p_lov_return_value=>'REPORTING'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40765607902163573)
,p_lov_disp_sequence=>40
,p_lov_disp_value=>'Validado'
,p_lov_return_value=>'VALIDATING'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40765621354163573)
,p_lov_disp_sequence=>50
,p_lov_disp_value=>'Revisado'
,p_lov_return_value=>'REVIEWING'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40765749462163573)
,p_lov_disp_sequence=>60
,p_lov_disp_value=>'Cerrado'
,p_lov_return_value=>'CLOSED'
);
wwv_flow_imp.component_end;
end;
/
