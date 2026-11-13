prompt --application/shared_components/logic/application_processes/cambiar_password
begin
--   Manifest
--     APPLICATION PROCESS: Cambiar Password
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>106
,p_default_id_offset=>30000697869459781
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_flow_process(
 p_id=>wwv_flow_imp.id(56958144539045270)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cambiar Password'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    IF :G_CAMBIAR_PWD = ''S''THEN',
'        ',
'        APEX_UTIL.REDIRECT_URL(',
'            p_url => APEX_PAGE.GET_URL(p_page => 9998)',
'        );',
'        ',
'    END IF;',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>':APP_PAGE_ID < 9000'
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_version_scn=>35471167395
);
wwv_flow_imp.component_end;
end;
/
