prompt --application/shared_components/navigation/lists/siif_navegacion_opcion
begin
--   Manifest
--     LIST: SIIF_NAVEGACION_OPCION
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>106
,p_default_id_offset=>30000697869459781
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(56942620063797636)
,p_name=>'SIIF_NAVEGACION_OPCION'
,p_list_type=>'SQL_QUERY'
,p_list_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'WITH prm_raw AS (',
'  SELECT UND_COMMOM.VALORPARAMETRO(''FORMS_SERVER_SCHEME'', :G_NIT_COMPANIA) AS scheme,',
'         UND_COMMOM.VALORPARAMETRO(''FORMS_SERVER_NAME'',   :G_NIT_COMPANIA) AS server_name,',
'         UND_COMMOM.VALORPARAMETRO(''FORMS_SERVER_PORT'',   :G_NIT_COMPANIA) AS server_port',
'  FROM dual',
'),',
'prm AS (',
'  SELECT scheme || ''://'' || server_name || NVL2(server_port, '':'' || server_port, NULL) AS forms_server',
'  FROM prm_raw',
')',
'SELECT',
'  1 AS lvl,',
'  m.label,',
'  APEX_PAGE.GET_URL(',
'    p_application => m.aplicacion,',
'    p_page        => CASE',
'                        WHEN m.tipo_llamada = ''PADRE'' THEN ''101''',
'                        WHEN m.tipo_llamada = ''URL''   THEN ''9086''',
'                        ELSE NVL(m.ejecutable, ''en-construccion'')',
'                      END,',
'    p_clear_cache => CASE',
'                        WHEN m.tipo_llamada = ''PADRE'' THEN ''101''',
'                        WHEN m.tipo_llamada = ''URL''   THEN ''9086''',
'                        ELSE NVL(m.ejecutable, ''en-construccion'')',
'                      END,',
'    p_items  => ''G_MODULO,G_OPCION_MENU,G_SOLO_LECTURA''',
'                || CASE WHEN m.tipo_llamada = ''URL'' THEN '',P9086_URL_BASE'' END',
'                || NVL2(m.parametros, '','' || m.parametros, ''''),',
'    p_values => m.modulo || '','' || m.opcion || '','' || NVL(v.solo_consulta, ''N'')',
'                || CASE WHEN m.tipo_llamada = ''URL''',
'                        THEN '','' || REPLACE(m.ejecutable, ''#FORMS_SERVER#'', p.forms_server)',
'                   END',
'                || NVL2(m.valores, '','' || REPLACE(m.valores, ''#G_NIT_COMPANIA#'', :G_NIT_COMPANIA), '''')',
'  ) AS target,',
'  CASE',
'    WHEN m.opcion = :G_OPCION_MENU',
'     AND m.modulo = :G_MODULO',
'    THEN ''YES''',
'  END AS is_current,',
'  NVL(',
'    m.menu_icon,',
'    CASE m.tipo_llamada',
'      WHEN ''FORM''   THEN ''fa-window-pointer''',
'      WHEN ''REPORT'' THEN ''fa-file-text''',
'      WHEN ''PADRE''  THEN ''fa-folder''',
'      WHEN ''URL''    THEN ''fa-external-link''',
'      ELSE ''fa-circle-question''',
'    END',
'  ) AS image',
'FROM siif.v_gen_opciones_sistema_menu m',
'JOIN siif.v_gen_opciones_usuario_act v',
'  ON v.opcion       = m.opcion',
' AND v.modulo       = m.modulo',
' AND v.usuario      = :G_USUARIO',
' AND v.nit_compania = :G_NIT_COMPANIA',
'CROSS JOIN prm p',
'WHERE m.modulo    = :G_MODULO',
'  AND m.opc_padre = :G_OPCION_MENU',
'  AND (m.tipo_llamada = ''PADRE'' OR m.ejecutable IS NOT NULL)',
'ORDER BY m.path_opcion'))
,p_list_status=>'PUBLIC'
,p_version_scn=>41475763811
,p_updated_on=>wwv_flow_imp.dz('20261014153811Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
