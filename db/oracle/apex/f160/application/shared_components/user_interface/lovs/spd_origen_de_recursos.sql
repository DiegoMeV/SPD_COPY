prompt --application/shared_components/user_interface/lovs/spd_origen_de_recursos
begin
--   Manifest
--     SPD - ORIGEN DE RECURSOS
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
 p_id=>wwv_flow_imp.id(40765844368163573)
,p_lov_name=>'SPD - ORIGEN DE RECURSOS'
,p_lov_query=>'.'||wwv_flow_imp.id(40765844368163573)||'.'
,p_location=>'STATIC'
,p_version_scn=>2578761
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40765966766163573)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>unistr('Integraci\00F3n Financiera')
,p_lov_return_value=>'FINANCIAL'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40766045575163573)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Digitados por el Usuario'
,p_lov_return_value=>'USER'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40766202346163573)
,p_lov_disp_sequence=>30
,p_lov_disp_value=>unistr('Digitados por el Usuario + Integraci\00F3n Financiera')
,p_lov_return_value=>'USER_AND_FINANCIAL'
);
wwv_flow_imp.component_end;
end;
/
