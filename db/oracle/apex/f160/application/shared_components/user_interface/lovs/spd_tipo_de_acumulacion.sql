prompt --application/shared_components/user_interface/lovs/spd_tipo_de_acumulacion
begin
--   Manifest
--     SPD - TIPO DE ACUMULACION
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
 p_id=>wwv_flow_imp.id(40761645559163573)
,p_lov_name=>'SPD - TIPO DE ACUMULACION'
,p_lov_query=>'.'||wwv_flow_imp.id(40761645559163573)||'.'
,p_location=>'STATIC'
,p_version_scn=>2578761
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40761757531163573)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Acumulado'
,p_lov_return_value=>'ACCUMULATED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40761884759163573)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'No Acumulado'
,p_lov_return_value=>'NO_ACCUMULATED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40761991560163573)
,p_lov_disp_sequence=>30
,p_lov_disp_value=>'Stock'
,p_lov_return_value=>'STOCK'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40762023606163573)
,p_lov_disp_sequence=>40
,p_lov_disp_value=>'Capacidad'
,p_lov_return_value=>'CAPACITY'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40762115784163573)
,p_lov_disp_sequence=>50
,p_lov_disp_value=>'Flujo'
,p_lov_return_value=>'FLOW'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40762224935163573)
,p_lov_disp_sequence=>60
,p_lov_disp_value=>unistr('Reducci\00F3n')
,p_lov_return_value=>'REDUCTION'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40762369889163573)
,p_lov_disp_sequence=>70
,p_lov_disp_value=>unistr('Reducci\00F3n Anual')
,p_lov_return_value=>'ANNUAL_REDUCTION'
);
wwv_flow_imp.component_end;
end;
/
