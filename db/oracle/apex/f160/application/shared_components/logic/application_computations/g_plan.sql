prompt --application/shared_components/logic/application_computations/g_plan
begin
--   Manifest
--     APPLICATION COMPUTATION: G_PLAN
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>4267703994621115
,p_default_application_id=>160
,p_default_id_offset=>1641014699613402
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_flow_computation(
 p_id=>wwv_flow_imp.id(3697522512607385)
,p_computation_sequence=>20
,p_computation_item=>'G_PLAN'
,p_computation_point=>'ON_NEW_INSTANCE'
,p_computation_type=>'QUERY'
,p_computation_processed=>'REPLACE_EXISTING'
,p_computation=>'select max(PLAN) keep (dense_rank first order by case when SPD_ACTIVO = ''S'' then 0 else 1 end, PLAN desc) from PLAN_DESARROLLO where NIT_COMPANIA = :G_NIT_COMPANIA'
,p_computation_comment=>unistr('Plan por defecto: el activo de la compa\00F1\00EDa')
,p_version_scn=>4003097
);
wwv_flow_imp.component_end;
end;
/
