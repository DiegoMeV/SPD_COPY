prompt --application/pages/page_00101
begin
--   Manifest
--     PAGE: 00101
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
 p_id=>101
,p_name=>unistr('Navegaci\00F3n')
,p_alias=>unistr('NAVEGACI\00D3N')
,p_step_title=>unistr('Navegaci\00F3n')
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function expandirRuta($contenido) {',
'  var $nav = apex.jQuery("#t_TreeNav");',
'  // el nodo y todas sus carpetas superiores',
'  var $ruta = $contenido.add(',
'    $contenido.parents("li.a-TreeView-node").children(".a-TreeView-content")',
'  );',
'  $nav.treeView("expand", $ruta);',
'}',
'',
'function expandirSeleccionado() {',
'  var $nav = apex.jQuery("#t_TreeNav");',
'  if (!$nav.length) return;',
'  try {',
'    expandirRuta($nav.treeView("getSelection"));',
'  } catch (e) {}',
'}',
'',
'function seleccionarEnSidebar(modulo, opcion) {',
'  var $nav = apex.jQuery("#t_TreeNav");',
'  if (!$nav.length) return;',
'  try {',
'    var $nodo = $nav.treeView("find", {',
'      depth: -1,',
'      match: function (n) {',
'        return n.link',
'            && n.link.indexOf("irPadre(") >= 0',
'            && n.link.indexOf("''" + modulo + "''") >= 0',
'            && n.link.indexOf("''" + opcion + "''") >= 0;',
'      }',
'    });',
'    if ($nodo.length) {',
'      // quitar las marcas del nodo anterior',
'      $nav.find(".is-current, .is-current--top")',
'          .removeClass("is-current is-current--top");',
'',
'      // marcar el nodo nuevo y su carpeta de primer nivel',
'      var $top = $nodo.parents("li.a-TreeView-node").last()',
'                      .children(".a-TreeView-content");',
'      if (!$top.length) $top = $nodo;   // el nodo ya es de primer nivel',
'      $nodo.addClass("is-current");',
'      $top.addClass("is-current--top");',
'',
'      $nav.treeView("setSelection", $nodo, false, true);',
'      expandirRuta($nodo);',
'    }',
'  } catch (e) {}',
'}',
'',
'function irPadre(modulo, opcion) {',
'  $s("P101_MODULO", modulo);',
'  $s("P101_OPCION_MENU", opcion);',
'  setTimeout(function () { seleccionarEnSidebar(modulo, opcion); }, 0);',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'23'
,p_created_on=>wwv_flow_imp.dz('20261014155503Z')
,p_last_updated_on=>wwv_flow_imp.dz('20261021200047Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_last_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(691437973951097656)
,p_plug_name=>'NAVEGACION_LOCAL'
,p_region_template_options=>'t-CardsRegion--hideHeader js-addHiddenHeadingRoleDesc'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2072724515482255512
,p_plug_display_sequence=>30
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'WITH prm_raw AS (',
'  SELECT UND_COMMOM.VALORPARAMETRO(''FORMS_SERVER_SCHEME'', :G_NIT_COMPANIA) AS scheme,',
'         UND_COMMOM.VALORPARAMETRO(''FORMS_SERVER_NAME'',   :G_NIT_COMPANIA) AS server_name,',
'         UND_COMMOM.VALORPARAMETRO(''FORMS_SERVER_PORT'',   :G_NIT_COMPANIA) AS server_port',
'  FROM dual',
'),',
'prm AS (',
'  SELECT scheme || ''://'' || server_name',
'         || NVL2(server_port, '':'' || server_port, NULL) AS forms_server',
'  FROM prm_raw',
')',
'SELECT',
'  1 AS lvl,',
'  v.label,',
'  CASE',
'    WHEN v.tipo_llamada = ''PADRE'' THEN',
'      ''javascript:irPadre('' || apex_escape.js_literal(v.modulo) || '',''',
'                            || apex_escape.js_literal(v.opcion) || '');''',
'    ELSE',
'      APEX_PAGE.GET_URL(',
'        p_application => v.aplicacion,',
'        p_page        => CASE',
'                            WHEN v.tipo_llamada = ''URL'' THEN ''9086''',
'                            ELSE NVL(v.ejecutable, ''en-construccion'')',
'                          END,',
'        p_items       => ''G_MODULO,G_OPCION_MENU,G_SOLO_LECTURA''',
'                         || CASE WHEN v.tipo_llamada = ''URL'' THEN '',P9086_URL'' END',
'                         || CASE',
'                              WHEN v.parametros IS NOT NULL',
'                               AND v.valores    IS NOT NULL THEN '','' || v.parametros',
'                            END,',
'        p_values      => v.modulo || '','' || v.opcion || '','' || NVL(u.solo_consulta, ''N'')',
'                         || CASE',
'                              WHEN v.tipo_llamada = ''URL''',
'                              THEN '','' || REPLACE(v.ejecutable, ''#FORMS_SERVER#'', p.forms_server)',
'                            END',
'                         || CASE',
'                              WHEN v.parametros IS NOT NULL',
'                               AND v.valores    IS NOT NULL',
'                              THEN '','' || REPLACE(v.valores, ''#G_NIT_COMPANIA#'', :G_NIT_COMPANIA)',
'                            END',
'      )',
'  END AS target,',
'  CASE',
'    WHEN v.opcion = :P101_OPCION_MENU',
'     AND v.modulo = :P101_MODULO',
'    THEN ''YES''',
'  END AS is_current,',
'  CASE',
'    WHEN v.menu_icon LIKE ''fa %''   THEN v.menu_icon',
'    WHEN v.menu_icon IS NOT NULL   THEN ''fa '' || v.menu_icon',
'    ELSE',
'      CASE v.tipo_llamada',
'        WHEN ''FORM''   THEN ''fa fa-window-pointer''',
'        WHEN ''REPORT'' THEN ''fa fa-file-text''',
'        WHEN ''PADRE''  THEN ''fa fa-folder''',
'        WHEN ''URL''    THEN ''fa fa-external-link''',
'        ELSE ''fa fa-circle-question''',
'      END',
'  END AS image',
'FROM siif.v_gen_opciones_sistema_menu v',
'JOIN siif.v_gen_opciones_usuario_act u',
'  ON u.opcion       = v.opcion',
' AND u.modulo       = v.modulo',
' AND u.usuario      = :G_USUARIO',
' AND u.nit_compania = :G_NIT_COMPANIA',
'CROSS JOIN prm p',
'WHERE v.modulo    = :P101_MODULO',
'  AND v.opc_padre = :P101_OPCION_MENU',
'  AND (v.tipo_llamada = ''PADRE'' OR v.ejecutable IS NOT NULL)',
'ORDER BY v.path_opcion'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CARDS'
,p_ajax_items_to_submit=>'P101_MODULO,P101_OPCION_MENU'
,p_plug_query_num_rows_type=>'SCROLL'
,p_show_total_row_count=>false
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20261014155503Z')
,p_updated_on=>wwv_flow_imp.dz('20261021200047Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_card(
 p_id=>wwv_flow_imp.id(346192559610321049)
,p_region_id=>wwv_flow_imp.id(691437973951097656)
,p_layout_type=>'GRID'
,p_grid_column_count=>3
,p_title_adv_formatting=>false
,p_title_column_name=>'LABEL'
,p_sub_title_adv_formatting=>false
,p_body_adv_formatting=>false
,p_second_body_adv_formatting=>false
,p_icon_source_type=>'DYNAMIC_CLASS'
,p_icon_class_column_name=>'IMAGE'
,p_icon_position=>'END'
,p_media_adv_formatting=>false
,p_updated_on=>wwv_flow_imp.dz('20261015185546Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_card_action(
 p_id=>wwv_flow_imp.id(346193016640321049)
,p_card_id=>wwv_flow_imp.id(346192559610321049)
,p_action_type=>'FULL_CARD'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'&TARGET.'
,p_updated_on=>wwv_flow_imp.dz('20261014155503Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(864727666217336444)
,p_plug_name=>'Navegacion'
,p_region_name=>'NAVIGATION_CARDS'
,p_region_template_options=>'t-CardsRegion--hideHeader js-addHiddenHeadingRoleDesc'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--basic:t-Cards--displayIcons:t-Cards--3cols:t-Cards--hideBody:t-Cards--animColorFill'
,p_plug_template=>2072724515482255512
,p_plug_display_sequence=>20
,p_location=>null
,p_list_id=>wwv_flow_imp.id(56942620063797636)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>2886769488667748277
,p_required_patch=>wwv_flow_imp.id(56129426527640081)
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20261014155503Z')
,p_updated_on=>wwv_flow_imp.dz('20261014155526Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(691439336144097654)
,p_name=>'P101_MODULO'
,p_item_sequence=>50
,p_source=>'G_MODULO'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20261014155503Z')
,p_updated_on=>wwv_flow_imp.dz('20261014155503Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(691439452256097655)
,p_name=>'P101_OPCION_MENU'
,p_item_sequence=>60
,p_source=>'G_OPCION_MENU'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20261014155503Z')
,p_updated_on=>wwv_flow_imp.dz('20261014155503Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(346194494670321053)
,p_name=>'DA_RECARGAR_NAVEGACION'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P101_OPCION_MENU,P101_MODULO'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
,p_created_on=>wwv_flow_imp.dz('20261014155503Z')
,p_updated_on=>wwv_flow_imp.dz('20261014160624Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(346196461053321055)
,p_event_id=>wwv_flow_imp.id(346194494670321053)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':G_MODULO := :P101_MODULO;',
':G_OPCION_MENU := :P101_OPCION_MENU;',
' '))
,p_attribute_02=>'P101_MODULO,P101_OPCION_MENU'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
,p_created_on=>wwv_flow_imp.dz('20261014155503Z')
,p_updated_on=>wwv_flow_imp.dz('20261014155503Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(346195457073321054)
,p_event_id=>wwv_flow_imp.id(346194494670321053)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(691437973951097656)
,p_attribute_01=>'N'
,p_created_on=>wwv_flow_imp.dz('20261014155503Z')
,p_updated_on=>wwv_flow_imp.dz('20261014155503Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(346195906595321054)
,p_event_id=>wwv_flow_imp.id(346194494670321053)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56150686737906301)
,p_attribute_01=>'N'
,p_created_on=>wwv_flow_imp.dz('20261014155503Z')
,p_updated_on=>wwv_flow_imp.dz('20261014155952Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
