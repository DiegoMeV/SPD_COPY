prompt --application/pages/page_01060
begin
--   Manifest
--     PAGE: 01060
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>4267703994621115
,p_default_application_id=>160
,p_default_id_offset=>1641014699613402
,p_default_owner=>'SIIF'
);
wwv_flow_imp_page.create_page(
 p_id=>1060
,p_name=>'SPD_Detalles del plan'
,p_alias=>'SPD_DETALLE_PLAN'
,p_step_title=>'Plan de Desarrollo'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'17'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41219950172911672)
,p_plug_name=>'Plan de Desarrollo'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>10
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41221434553911673)
,p_plug_name=>'Estructura del Plan'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>'select case when connect_by_isleaf = 1 then 0 when level <= 2 then 1 else -1 end as STATUS, level as LVL, TITLE, null as ICON, VALUE, null as TOOLTIP, null as LINK from (select 0 as VALUE, null as PARENT, NOMBRE as TITLE, null as CODE from PLAN_DESAR'
||'ROLLO where NIT_COMPANIA = :P1060_NIT_COMPANIA and PLAN = :P1060_PLAN union all select ID, nvl(PARENT_ID, 0), CODE || '' '' || NAME, CODE from SPD_DEV_PLAN_LEVEL where NIT_COMPANIA = :P1060_NIT_COMPANIA and PLAN = :P1060_PLAN) start with PARENT is null'
||' connect by prior VALUE = PARENT order siblings by nlssort(CODE, ''NLS_SORT=BINARY'')'
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_JSTREE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'activate_node_link_with', 'S',
  'default_icon_css_class', 'icon-tree-folder',
  'hierarchy_level_column', 'LVL',
  'icon_css_class_column', 'ICON',
  'link_column', 'LINK',
  'node_label_column', 'TITLE',
  'node_status_column', 'STATUS',
  'node_value_column', 'VALUE',
  'selected_node_page_item', '',
  'static_tree_id', 'spd_plan_tree_det',
  'tree_hierarchy', 'LEVEL',
  'tree_tooltip', 'N')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41221313715911673)
,p_button_sequence=>130
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'VOLVER'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Regresar'
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:1006:&APP_SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-left'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41221383094911673)
,p_button_sequence=>140
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'EDITAR'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Editar'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:1007:&APP_SESSION.::&DEBUG.:1007:P1007_NIT_COMPANIA,P1007_PLAN:&P1060_NIT_COMPANIA.,&P1060_PLAN.'
,p_icon_css_classes=>'fa-edit'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41221554829911673)
,p_button_sequence=>150
,p_button_plug_id=>wwv_flow_imp.id(41221434553911673)
,p_button_name=>'EDITAR_ESTRUCTURA'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Editar Estructura'
,p_button_position=>'TOP'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:1061:&APP_SESSION.::&DEBUG.:1061:P1061_NIT_COMPANIA,P1061_PLAN:&P1060_NIT_COMPANIA.,&P1060_PLAN.'
,p_icon_css_classes=>'fa-sitemap'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41220092277911673)
,p_name=>'P1060_NIT_COMPANIA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(41219950172911672)
,p_item_default=>'G_NIT_COMPANIA'
,p_item_default_type=>'ITEM'
,p_prompt=>'NIT'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41220163974911673)
,p_name=>'P1060_PLAN'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(41219950172911672)
,p_prompt=>'Plan'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41220216378911673)
,p_name=>'P1060_COMPANIA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(41219950172911672)
,p_prompt=>unistr('Compa\00F1\00EDa')
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41220394526911673)
,p_name=>'P1060_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(41219950172911672)
,p_prompt=>'ID'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41220414947911673)
,p_name=>'P1060_CODIGO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(41219950172911672)
,p_prompt=>unistr('C\00F3digo')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41220594576911673)
,p_name=>'P1060_NOMBRE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(41219950172911672)
,p_prompt=>'Nombre'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41220698734911673)
,p_name=>'P1060_GOBERNANTE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(41219950172911672)
,p_prompt=>'Nombre Gobernante'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41220726141911673)
,p_name=>'P1060_FECHA_INICIO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(41219950172911672)
,p_prompt=>'Fecha Inicio'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41220880650911673)
,p_name=>'P1060_FECHA_FIN'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(41219950172911672)
,p_prompt=>'Fecha Fin'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41220952505911673)
,p_name=>'P1060_INICIO_GOBIERNO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(41219950172911672)
,p_prompt=>'Fecha Inicio Gobierno'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41221077494911673)
,p_name=>'P1060_FIN_GOBIERNO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(41219950172911672)
,p_prompt=>'Fecha Fin Gobierno'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41221125512911673)
,p_name=>'P1060_NIVELES'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(41219950172911672)
,p_prompt=>'Niveles'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'HTML',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41221690410911673)
,p_process_sequence=>160
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cargar plan'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
'  select c.NOMBRE, p.ID, p.PLAN, p.NOMBRE, p.GOBERNANTE,',
'         to_char(p.FECHA_INICIO, ''DD/MM/YYYY''), to_char(p.FECHA_FIN, ''DD/MM/YYYY''),',
'         to_char(p.SPD_INICIO_GOBIERNO, ''DD/MM/YYYY''), to_char(p.SPD_FIN_GOBIERNO, ''DD/MM/YYYY'')',
'    into :P1060_COMPANIA, :P1060_ID, :P1060_CODIGO, :P1060_NOMBRE, :P1060_GOBERNANTE,',
'         :P1060_FECHA_INICIO, :P1060_FECHA_FIN, :P1060_INICIO_GOBIERNO, :P1060_FIN_GOBIERNO',
'    from PLAN_DESARROLLO p left join COMPANIA c on c.NIT_COMPANIA = p.NIT_COMPANIA',
'   where p.NIT_COMPANIA = :P1060_NIT_COMPANIA and p.PLAN = :P1060_PLAN;',
'  -- niveles configurados del plan (SPD_CONFIG.levels), como lista anidada',
'  select listagg(''<li>'' || apex_escape.html(jt.NUM || ''. '' || jt.PLURAL_NAME',
'                 || case when jt.GOAL_TYPE is not null then '' (Metas de ''',
'                    || nvl((select e.DISPLAY_VALUE from APEX_APPLICATION_LOV_ENTRIES e',
'                             where e.APPLICATION_ID = :APP_ID and e.LIST_OF_VALUES_NAME = ''SPD - TIPO DE META''',
'                               and e.RETURN_VALUE = jt.GOAL_TYPE), jt.GOAL_TYPE) || '')'' end) || ''<ul>'', '''')',
'           within group (order by jt.NUM)',
'         || rpad(''</ul></li>'', 10 * count(*), ''</ul></li>'')',
'    into :P1060_NIVELES',
'    from PLAN_DESARROLLO p,',
'         json_table(p.SPD_CONFIG, ''$.levels[*]'' columns (NUM number path ''$.number'',',
'                    PLURAL_NAME varchar2(200) path ''$.pluralName'', GOAL_TYPE varchar2(30) path ''$.goalType'')) jt',
'   where p.NIT_COMPANIA = :P1060_NIT_COMPANIA and p.PLAN = :P1060_PLAN;',
'  if :P1060_NIVELES is not null then :P1060_NIVELES := ''<ul class="spd-levels">'' || :P1060_NIVELES || ''</ul>''; end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>39580675711298271
);
wwv_flow_imp.component_end;
end;
/
