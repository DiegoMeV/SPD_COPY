prompt --application/shared_components/user_interface/lovs/spd_seguimiento_para
begin
--   Manifest
--     SPD - SEGUIMIENTO PARA
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
 p_id=>wwv_flow_imp.id(40768766073163573)
,p_lov_name=>'SPD - SEGUIMIENTO PARA'
,p_lov_query=>'.'||wwv_flow_imp.id(40768766073163573)||'.'
,p_location=>'STATIC'
,p_version_scn=>2578761
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40768910997163573)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Metas de Producto'
,p_lov_return_value=>'PRODUCT'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40768976949163573)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Metas de Resultado'
,p_lov_return_value=>'RESULT'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40769093776163573)
,p_lov_disp_sequence=>30
,p_lov_disp_value=>'Metas de Bienestar'
,p_lov_return_value=>'WELL_BEING'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40769188103163573)
,p_lov_disp_sequence=>40
,p_lov_disp_value=>'Proyectos y Actividades'
,p_lov_return_value=>'ACTIVITY'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40769233985163573)
,p_lov_disp_sequence=>50
,p_lov_disp_value=>'Metas Impacto'
,p_lov_return_value=>'IMPACT'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40769325910163573)
,p_lov_disp_sequence=>60
,p_lov_disp_value=>unistr('Planes de Acci\00F3n')
,p_lov_return_value=>'ACTION_PLAN'
);
wwv_flow_imp.component_end;
end;
/
