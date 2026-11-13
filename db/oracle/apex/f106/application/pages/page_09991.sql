prompt --application/pages/page_09991
begin
--   Manifest
--     PAGE: 09991
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>106
,p_default_id_offset=>30000697869459781
,p_default_owner=>'SIIF'
);
wwv_flow_imp_page.create_page(
 p_id=>9991
,p_name=>'Acceso Total Token'
,p_alias=>'ACCESO-TOTAL-TOKEN'
,p_step_title=>'Acceso Total Token'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>2979075366320325194
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'11'
,p_created_on=>wwv_flow_imp.dz('20261106204940Z')
,p_last_updated_on=>wwv_flow_imp.dz('20261106205347Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_last_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(550406781498970234)
,p_name=>'P9991_TOKEN'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20261106204940Z')
,p_updated_on=>wwv_flow_imp.dz('20261106204940Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(369728630172740307)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Autenticar por Token'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_token                VARCHAR2(100);',
'    l_tipo_token           VARCHAR2(20);',
'    l_items                VARCHAR2(4000);',
'    l_valores              VARCHAR2(4000);',
'    l_pagina               NUMBER;',
'',
'    -- Datos usuario/token',
'    l_usuario              VARCHAR2(100);',
'    l_nit_compania         VARCHAR2(50);',
'',
unistr('    -- Validaci\00F3n usuario'),
'    l_count                NUMBER;',
'',
'    -- Variables set_items_aplicacion',
'    l_nombre               VARCHAR2(150);',
'    l_usertype             VARCHAR2(50);',
'    l_cambiar_pwd          VARCHAR2(1);',
'    l_division             NUMBER;',
'',
'    l_reports_server       VARCHAR2(500);',
'    l_reports_server_name  VARCHAR2(100);',
'',
'BEGIN',
'',
'    -- =========================================================',
'    -- OBTENER TOKEN',
'    -- =========================================================',
'    l_token := apex_util.get_session_state(''P9991_TOKEN'');',
'',
'    IF l_token IS NULL THEN',
'        apex_error.add_error(',
'            p_message          => ''Acceso no autorizado. Token requerido.'',',
'            p_display_location => apex_error.c_inline_in_notification',
'        );',
'        RETURN;',
'    END IF;',
'',
'    -- =========================================================',
'    -- VALIDAR TOKEN Y OBTENER DATOS',
'    -- =========================================================',
'    BEGIN',
'',
'        SELECT usuario,',
'               nit_compania,',
'               tipo_token,',
'               variables,',
'               valores',
'          INTO l_usuario,',
'               l_nit_compania,',
'               l_tipo_token,',
'               l_items,',
'               l_valores',
'          FROM gen_apex_auth_tokens',
'         WHERE token        = l_token',
'           AND usado        = ''N''',
'           AND fecha_expira > SYSTIMESTAMP;',
'',
'    EXCEPTION',
'        WHEN NO_DATA_FOUND THEN',
'',
'            apex_error.add_error(',
unistr('                p_message          => ''Token inv\00E1lido o expirado.'','),
'                p_display_location => apex_error.c_inline_in_notification',
'            );',
'            RETURN;',
'',
'    END;',
'',
'    -- =========================================================',
'    -- VALIDAR USUARIO ACTIVO',
'    -- =========================================================',
'    SELECT COUNT(*)',
'      INTO l_count',
'      FROM usuarios',
'     WHERE LOWER(usuario) = LOWER(l_usuario)',
'       AND nit_compania   = l_nit_compania',
'       AND estado         = ''V'';',
'',
'    IF l_count = 0 THEN',
'',
'        apex_error.add_error(',
unistr('            p_message          => ''Usuario inv\00E1lido o inactivo.'','),
'            p_display_location => apex_error.c_inline_in_notification',
'        );',
'',
'        RETURN;',
'',
'    END IF;',
'',
'    -- =========================================================',
'    -- INVALIDAR TOKEN',
'    -- =========================================================',
'    UPDATE gen_apex_auth_tokens',
'       SET usado = ''S''',
'     WHERE token = l_token;',
'',
'    COMMIT;',
'',
'    -- =========================================================',
'    -- SETEAR TENANT',
'    -- =========================================================',
'    APEX_SESSION.SET_TENANT_ID(l_nit_compania);',
'',
'    -- =========================================================',
unistr('    -- CREAR SESI\00D3N AUTENTICADA'),
'    -- =========================================================',
'    apex_authentication.post_login(',
'        p_username => l_usuario,',
'        p_password => NULL',
'    );',
'',
'    -- =========================================================',
'    -- CARGAR DATOS USUARIO',
unistr('    -- (ANTES HAC\00CDA set_items_aplicacion)'),
'    -- =========================================================',
'    SELECT descripcion,',
'           division,',
'           usertype,',
'           cambiar_pwd',
'      INTO l_nombre,',
'           l_division,',
'           l_usertype,',
'           l_cambiar_pwd',
'      FROM usuarios',
'     WHERE UPPER(usuario) = UPPER(l_usuario)',
'       AND nit_compania = l_nit_compania;',
'',
'    APEX_UTIL.SET_SESSION_STATE(''G_USUARIO'', l_usuario);',
'    APEX_UTIL.SET_SESSION_STATE(''G_DIVISION'', l_division);',
'    APEX_UTIL.SET_SESSION_STATE(''G_USERTYPE'', l_usertype);',
'    APEX_UTIL.SET_SESSION_STATE(''G_NOMBRE_USUARIO'', l_nombre);',
'    APEX_UTIL.SET_SESSION_STATE(''G_CAMBIAR_PWD'', l_cambiar_pwd);',
'',
'    DBMS_SESSION.SET_IDENTIFIER(l_usuario);',
'',
'    -- =========================================================',
unistr('    -- DATOS COMPA\00D1\00CDA'),
'    -- =========================================================',
'    SELECT nombre',
'      INTO l_nombre',
'      FROM compania',
'     WHERE nit_compania = l_nit_compania;',
'',
'    APEX_UTIL.SET_SESSION_STATE(''G_NIT_COMPANIA'', l_nit_compania);',
'    APEX_UTIL.SET_SESSION_STATE(''G_NOMBRE_COMPANIA'', l_nombre);',
'',
'    -- =========================================================',
'    -- REPORT SERVER',
'    -- =========================================================',
'    SELECT NVL(UND_COMMOM.VALORPARAMETRO(',
'                   ''REPORTS_SERVER_SCHEME'',',
'                   l_nit_compania',
'               ), ''http'')',
'           || ''://''',
'           || NVL(UND_COMMOM.VALORPARAMETRO(',
'                      ''REPORTS_SERVER_NAME'',',
'                      l_nit_compania',
'                  ), ''noServerFound.info'')',
'           || '':''',
'           || NVL(UND_COMMOM.VALORPARAMETRO(',
'                      ''REPORTS_SERVER_PORT'',',
'                      l_nit_compania',
'                  ), ''noServerFound.info'')',
'           || ''/reports/rwservlet?'',',
'',
'           NVL(UND_COMMOM.VALORPARAMETRO(',
'                   ''REP_SERVER'',',
'                   l_nit_compania',
'               ), ''no_rep_server_name'')',
'',
'      INTO l_reports_server,',
'           l_reports_server_name',
'      FROM dual;',
'',
'    APEX_UTIL.SET_SESSION_STATE(',
'        ''G_REPORTS_SERVER'',',
'        l_reports_server',
'    );',
'',
'    APEX_UTIL.SET_SESSION_STATE(',
'        ''G_REPORTS_SERVER_NAME'',',
'        l_reports_server_name',
'    );',
'',
'    -- =========================================================',
'    -- REDIRECCIONAR',
'    -- =========================================================',
'    apex_util.redirect_url(',
'        apex_page.get_url(',
'            p_page   => 1',
'        )',
'    );',
'',
'EXCEPTION',
'',
'    WHEN NO_DATA_FOUND THEN',
'',
'        apex_error.add_error(',
unistr('            p_message          => ''No fue posible obtener informaci\00F3n del usuario.'','),
'            p_display_location => apex_error.c_inline_in_notification',
'        );',
'',
'    WHEN OTHERS THEN',
'',
'        apex_error.add_error(',
'            p_message          => ''Error autenticando por token: '' || SQLERRM,',
'            p_display_location => apex_error.c_inline_in_notification',
'        );',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>369728630172740307
,p_created_on=>wwv_flow_imp.dz('20261106204940Z')
,p_updated_on=>wwv_flow_imp.dz('20261106205347Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
