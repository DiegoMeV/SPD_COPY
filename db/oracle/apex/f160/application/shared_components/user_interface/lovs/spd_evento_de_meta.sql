prompt --application/shared_components/user_interface/lovs/spd_evento_de_meta
begin
--   Manifest
--     SPD - EVENTO DE META
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
 p_id=>wwv_flow_imp.id(40767622266163573)
,p_lov_name=>'SPD - EVENTO DE META'
,p_lov_query=>'.'||wwv_flow_imp.id(40767622266163573)||'.'
,p_location=>'STATIC'
,p_version_scn=>2578761
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40767773843163573)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Creada'
,p_lov_return_value=>'CREATED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40767911672163573)
,p_lov_disp_sequence=>20
,p_lov_disp_value=>'Actualizada'
,p_lov_return_value=>'UPDATED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40767996235163573)
,p_lov_disp_sequence=>30
,p_lov_disp_value=>'Programada'
,p_lov_return_value=>'SCHEDULED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40768022992163573)
,p_lov_disp_sequence=>40
,p_lov_disp_value=>'Reportada'
,p_lov_return_value=>'MONITORED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40768172557163573)
,p_lov_disp_sequence=>50
,p_lov_disp_value=>'Validada'
,p_lov_return_value=>'VALIDATED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40768228705163573)
,p_lov_disp_sequence=>60
,p_lov_disp_value=>'Aprobada'
,p_lov_return_value=>'REVIEWED'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(40768374407163573)
,p_lov_disp_sequence=>70
,p_lov_disp_value=>'Rechazada'
,p_lov_return_value=>'REJECTED'
);
wwv_flow_imp.component_end;
end;
/
