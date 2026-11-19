prompt --application/shared_components/logic/application_processes/spd_global_plan_y_seguimiento_elegidos
begin
--   Manifest
--     APPLICATION PROCESS: SPD Global: plan y seguimiento elegidos
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>4267703994621115
,p_default_application_id=>160
,p_default_id_offset=>1641014699613402
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_flow_process(
 p_id=>wwv_flow_imp.id(3697637873607385)
,p_process_sequence=>1
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SPD Global: plan y seguimiento elegidos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
'  if :APP_PAGE_ID between 1030 and 1044 and v(''P'' || :APP_PAGE_ID || ''_MC'') is not null then',
'    :G_SEGUIMIENTO := v(''P'' || :APP_PAGE_ID || ''_MC'');',
'  end if;',
'  if :APP_PAGE_ID in (1009, 1010, 1011, 1028, 1029, 1046) and v(''P'' || :APP_PAGE_ID || ''_PLAN'') is not null then',
'    :G_PLAN := v(''P'' || :APP_PAGE_ID || ''_PLAN'');',
'  end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_version_scn=>4003097
);
wwv_flow_imp.component_end;
end;
/
