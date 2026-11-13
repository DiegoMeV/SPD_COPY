prompt --application/shared_components/logic/application_processes/validar_mfa
begin
--   Manifest
--     APPLICATION PROCESS: Validar MFA
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
 p_id=>wwv_flow_imp.id(365925035324982218)
,p_process_sequence=>2
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Validar MFA'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_nit varchar2(15) := sys_context(''APEX$SESSION'', ''APP_TENANT_ID'');',
'begin',
'  if not web_und_mfa_totp.acceso_permitido(l_nit, :APP_USER) then',
'    apex_util.redirect_url(',
'      apex_page.get_url(',
'        p_application => 106,',
'        p_page        => case when web_und_mfa_totp.tiene_mfa(l_nit, :APP_USER)',
'                              then 9996 else 9997 end));',
'  end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>':APP_USER <> ''nobody'' and :APP_PAGE_ID not in (9996, 9997, 9998, 9999)'
,p_process_when_type=>'EXPRESSION'
,p_process_when2=>'PLSQL'
,p_version_scn=>41638638849
,p_created_on=>wwv_flow_imp.dz('20261101162959Z')
,p_updated_on=>wwv_flow_imp.dz('20261101162959Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp.component_end;
end;
/
