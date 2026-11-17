prompt --application/shared_components/user_interface/lovs/spd_si_no
begin
--   Manifest
--     SPD - SI/NO
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
 p_id=>wwv_flow_imp.id(40760407243163572)
,p_lov_name=>'SPD - SI/NO'
,p_lov_query=>'.'||wwv_flow_imp.id(40760407243163572)||'.'
,p_location=>'STATIC'
,p_version_scn=>2578755
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40760446104163572)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>unistr('S\00ED')
,p_lov_return_value=>'S'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40760527548163573)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'No'
,p_lov_return_value=>'N'
);
wwv_flow_imp.component_end;
end;
/
