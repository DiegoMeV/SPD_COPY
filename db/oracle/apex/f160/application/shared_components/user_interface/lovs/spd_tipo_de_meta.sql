prompt --application/shared_components/user_interface/lovs/spd_tipo_de_meta
begin
--   Manifest
--     SPD - TIPO DE META
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
 p_id=>wwv_flow_imp.id(40760655877163573)
,p_lov_name=>'SPD - TIPO DE META'
,p_lov_query=>'.'||wwv_flow_imp.id(40760655877163573)||'.'
,p_location=>'STATIC'
,p_version_scn=>2578761
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40760719464163573)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Producto'
,p_lov_return_value=>'PRODUCT'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40760873309163573)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Resultado'
,p_lov_return_value=>'RESULT'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40760970977163573)
,p_lov_disp_sequence=>30
,p_lov_disp_value=>'Bienestar'
,p_lov_return_value=>'WELL_BEING'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40761112919163573)
,p_lov_disp_sequence=>40
,p_lov_disp_value=>'Impacto'
,p_lov_return_value=>'IMPACT'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40761162377163573)
,p_lov_disp_sequence=>50
,p_lov_disp_value=>'Actividad'
,p_lov_return_value=>'ACTIVITY'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40761228679163573)
,p_lov_disp_sequence=>60
,p_lov_disp_value=>'Proyecto'
,p_lov_return_value=>'PROJECT'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40761391529163573)
,p_lov_disp_sequence=>70
,p_lov_disp_value=>unistr('Plan de Acci\00F3n')
,p_lov_return_value=>'ACTION_PLAN'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40761485393163573)
,p_lov_disp_sequence=>80
,p_lov_disp_value=>unistr('Meta de Plan de Acci\00F3n')
,p_lov_return_value=>'ACTION_PLAN_ACTIVITY'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40761537734163573)
,p_lov_disp_sequence=>90
,p_lov_disp_value=>unistr('Pol\00EDtica P\00FAblica')
,p_lov_return_value=>'PUBLIC_POLITIC'
);
wwv_flow_imp.component_end;
end;
/
