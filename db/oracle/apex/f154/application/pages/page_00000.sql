prompt --application/pages/page_00000
begin
--   Manifest
--     PAGE: 00000
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>154
,p_default_id_offset=>292021538769791282
,p_default_owner=>'SIIF'
);
wwv_flow_imp_page.create_page(
 p_id=>0
,p_name=>unistr('P\00E1gina Global')
,p_step_title=>unistr('P\00E1gina Global')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'D'
,p_page_component_map=>'14'
,p_last_updated_on=>wwv_flow_imp.dz('20261110192114Z')
,p_last_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(371159357606848009)
,p_plug_name=>'SCRIPT_NAVIGATION'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_plug_display_point=>'AFTER_LOGO'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<style>.t-Header-branding,.t-Body-nav{display:none}</style>',
'<script>',
'document.addEventListener(''DOMContentLoaded'', function () {',
'  document.querySelectorAll(''.t-Header-branding, .t-Body-nav'')',
'    .forEach(function (el) { el.remove(); });',
'',
'  document.body.classList.remove(',
'    ''t-PageBody--leftNav'', ''js-navExpanded'', ''js-navCollapsed'', ''t-PageBody--showLeft''',
'  );',
'  var main = document.querySelector(''.t-Body-main'');',
'  if (main) main.style.marginLeft = ''0'';',
'});',
'</script>'))
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'G_HIDE_NAV_COMPONENTS'
,p_plug_display_when_cond2=>'TRUE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261110192114Z')
,p_updated_on=>wwv_flow_imp.dz('20261110192114Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(371159409024848010)
,p_plug_name=>'OCULTAR_NAV'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>20
,p_plug_display_point=>'AFTER_LOGO'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<style>.t-Header-branding{display:none}</style>',
'<script>',
'document.addEventListener(''DOMContentLoaded'', function () {',
'  document.querySelectorAll(''.t-Header-branding'')',
'    .forEach(function (el) { el.remove(); });',
'});',
'</script>'))
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'G_HIDE_NAVBAR'
,p_plug_display_when_cond2=>'TRUE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261110192114Z')
,p_updated_on=>wwv_flow_imp.dz('20261110192114Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(644171683471333937)
,p_plug_name=>'Breadcrumb Global'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  FUNCTION get_apex_breadcrumb_html (',
'    p_modulo        IN VARCHAR2,',
'    p_opcion_menu   IN VARCHAR2,',
'    p_css_classes   IN VARCHAR2 DEFAULT NULL',
'  ) RETURN CLOB IS',
'',
'    l_path_opcion  v_gen_opciones_sistema_menu.path_opcion%TYPE;',
'    l_path_label   v_gen_opciones_sistema_menu.path_label%TYPE;',
'    l_levels       PLS_INTEGER;',
'    l_html         CLOB;',
'    l_en_101       VARCHAR2(1) := CASE',
'                                    WHEN :APP_ALIAS = ''SIIF-MAIN'' AND :APP_PAGE_ID = ''101''',
'                                    THEN ''S'' ELSE ''N''',
'                                  END;',
'  BEGIN',
unistr('    /* Ruta completa de la opci\00F3n actual */'),
'    SELECT path_opcion,',
'           path_label',
'      INTO l_path_opcion,',
'           l_path_label',
'      FROM v_gen_opciones_sistema_menu',
'     WHERE opcion = p_opcion_menu',
'       AND modulo = p_modulo;',
'',
'    l_levels := REGEXP_COUNT(l_path_opcion, ''/'');',
'',
'    /* Apertura breadcrumb */',
'    l_html := ''<ul class="t-Breadcrumb '' ||',
'              apex_escape.html_attribute(p_css_classes) || ''">'';',
'',
'    /* Renderiza cada nivel */',
'    FOR i IN 1 .. l_levels LOOP',
'      DECLARE',
'        l_opcion  VARCHAR2(4000);',
'        l_label   VARCHAR2(4000);',
'        l_target  VARCHAR2(4000);',
'      BEGIN',
'        l_opcion := REGEXP_SUBSTR(l_path_opcion, ''[^/]+'', 1, i);',
'        l_label  := REGEXP_SUBSTR(l_path_label,  ''[^/]+'', 1, i + 1);',
'',
'        IF l_opcion = p_opcion_menu THEN',
unistr('          /* Opci\00F3n actual: activa, sin enlace */'),
'          l_html := l_html ||',
'            ''<li class="t-Breadcrumb-item is-active" aria-current="page">'' ||',
'            ''<h1 class="t-Breadcrumb-label">'' ||',
'            apex_escape.html(l_label) ||',
'            ''</h1></li>'';',
'        ELSE',
'          /* Nodo navegable */',
'          SELECT CASE',
'                   -- Padre estando en SIIF-MAIN 101: sin recargar',
'                   WHEN tipo_llamada = ''PADRE'' AND l_en_101 = ''S'' THEN',
'                     ''javascript:irPadre('' || apex_escape.js_literal(p_modulo) || '',''',
'                                           || apex_escape.js_literal(l_opcion) || '');''',
unistr('                   -- Padre desde otra app o p\00E1gina: redirige a SIIF-MAIN 101'),
'                   WHEN tipo_llamada = ''PADRE'' THEN',
'                     APEX_PAGE.GET_URL(',
'                       p_application => ''SIIF-MAIN'',',
'                       p_page        => ''101'',',
'                       p_clear_cache => ''101'',',
'                       p_items       => ''P101_MODULO,P101_OPCION_MENU'',',
'                       p_values      => p_modulo || '','' || l_opcion',
'                     )',
'                   -- Hijo',
'                   ELSE',
'                     APEX_PAGE.GET_URL(',
'                       p_application => aplicacion,',
'                       p_page        => NVL(ejecutable, ''en-construccion''),',
'                       p_items       => ''G_MODULO,G_OPCION_MENU'',',
'                       p_values      => p_modulo || '','' || l_opcion',
'                     )',
'                 END',
'            INTO l_target',
'            FROM v_gen_opciones_sistema_menu',
'           WHERE opcion = l_opcion',
'             AND modulo = p_modulo;',
'',
'          l_html := l_html ||',
'            ''<li class="t-Breadcrumb-item">'' ||',
'            ''<a href="'' || apex_escape.html_attribute(l_target) || ''" class="t-Breadcrumb-label">'' ||',
'            apex_escape.html(l_label) ||',
'            ''</a></li>'';',
'        END IF;',
'      END;',
'    END LOOP;',
'',
'    /* Cierre breadcrumb */',
'    l_html := l_html || ''</ul>'';',
'',
'    RETURN l_html;',
'',
'  EXCEPTION',
'    WHEN NO_DATA_FOUND THEN',
'      RETURN NULL;',
'  END get_apex_breadcrumb_html;',
'',
'BEGIN',
'  IF :APP_ALIAS = ''SIIF-MAIN'' AND :APP_PAGE_ID = ''101'' THEN',
'    RETURN get_apex_breadcrumb_html(',
'             NVL(V(''P101_MODULO''),      :G_MODULO),',
'             NVL(V(''P101_OPCION_MENU''), :G_OPCION_MENU)',
'           );',
'  ELSE',
'    RETURN get_apex_breadcrumb_html(:G_MODULO, :G_OPCION_MENU);',
'  END IF;',
'END;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from apex_application_pages',
'where page_mode = ''Normal''',
'and page_id > 1',
'and page_id not between 9000 and 9999',
'and application_id = :APP_ID',
'and page_id = :APP_PAGE_ID'))
,p_updated_on=>wwv_flow_imp.dz('20261014182256Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(333300729958268905)
,p_name=>'P0_BUSCAR_OPCION'
,p_item_sequence=>20
,p_item_display_point=>'BEFORE_NAVIGATION_BAR'
,p_placeholder=>unistr('Buscar en la aplicaci\00F3n...')
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'  REGEXP_REPLACE(',
'    REGEXP_REPLACE(TRIM(m.path_label), ''^/\s*'', ''''),  -- quita el primer "/"',
'    ''\s*/\s*'', '' - ''                                  -- el resto "/" -> " - "',
'  ) AS d,',
'  APEX_PAGE.GET_URL(',
'    p_application => m.aplicacion,',
'    p_page        => CASE',
'                        WHEN m.tipo_llamada = ''URL'' THEN ''9086''',
'                        ELSE NVL(m.ejecutable, ''en-construccion'')',
'                      END,',
'    p_clear_cache => CASE',
'                        WHEN m.tipo_llamada = ''URL'' THEN ''9086''',
'                        ELSE NVL(m.ejecutable, ''en-construccion'')',
'                      END,',
'    p_items  => ''G_MODULO,G_OPCION_MENU,G_SOLO_LECTURA''',
'                || CASE WHEN m.tipo_llamada = ''URL'' THEN '',P9086_URL_BASE'' END',
'                || NVL2(m.parametros, '','' || m.parametros, ''''),',
'    p_values => m.modulo || '','' || m.opcion || '','' || NVL(v.solo_consulta, ''N'')',
'                || CASE WHEN m.tipo_llamada = ''URL'' THEN '','' || m.ejecutable END',
'                || NVL2(m.valores, '','' || REPLACE(m.valores, ''#G_NIT_COMPANIA#'', :G_NIT_COMPANIA), '''')',
'  ) AS r',
'FROM v_gen_opciones_sistema_menu m',
'JOIN v_gen_opciones_usuario_act v',
'  ON v.opcion       = m.opcion',
' AND v.modulo       = m.modulo',
' AND v.usuario      = :G_USUARIO',
' AND v.nit_compania = :G_NIT_COMPANIA',
'WHERE m.tipo_llamada <> ''PADRE''',
'  AND m.ejecutable IS NOT NULL',
'ORDER BY m.label'))
,p_cSize=>30
,p_field_template=>2040785906935475274
,p_item_icon_css_classes=>'fa-search'
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261001135602Z')
,p_updated_on=>wwv_flow_imp.dz('20261007180948Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(333300880326268906)
,p_name=>'IR_A_PAGE'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P0_BUSCAR_OPCION'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
,p_created_on=>wwv_flow_imp.dz('20261001135602Z')
,p_updated_on=>wwv_flow_imp.dz('20261001135602Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(333300958423268907)
,p_event_id=>wwv_flow_imp.id(333300880326268906)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var url = apex.item("P0_BUSCAR_OPCION").getValue();',
'if (url) {',
'  apex.navigation.redirect(url);',
'}'))
,p_created_on=>wwv_flow_imp.dz('20261001135602Z')
,p_updated_on=>wwv_flow_imp.dz('20261001135602Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
