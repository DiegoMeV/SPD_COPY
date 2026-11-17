prompt --application/shared_components/user_interface/lovs/spd_tipo_de_recurso
begin
--   Manifest
--     SPD - TIPO DE RECURSO
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
 p_id=>wwv_flow_imp.id(40767045706163573)
,p_lov_name=>'SPD - TIPO DE RECURSO'
,p_lov_query=>'.'||wwv_flow_imp.id(40767045706163573)||'.'
,p_location=>'STATIC'
,p_version_scn=>2578761
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40767187353163573)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Manual'
,p_lov_return_value=>'MANUAL'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40767303381163573)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Definitivo'
,p_lov_return_value=>'DEFINITIVE'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40767386811163573)
,p_lov_disp_sequence=>30
,p_lov_disp_value=>'Compromiso'
,p_lov_return_value=>'COMMITMENT'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40767453072163573)
,p_lov_disp_sequence=>40
,p_lov_disp_value=>unistr('Obligaci\00F3n')
,p_lov_return_value=>'OBLIGATION'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40767600592163573)
,p_lov_disp_sequence=>50
,p_lov_disp_value=>'Pago'
,p_lov_return_value=>'PAYMENT'
);
wwv_flow_imp.component_end;
end;
/
