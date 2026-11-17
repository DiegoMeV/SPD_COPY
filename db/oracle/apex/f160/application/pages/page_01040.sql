prompt --application/pages/page_01040
begin
--   Manifest
--     PAGE: 01040
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
 p_id=>1040
,p_name=>unistr('SPD_Programaci\00F3n de planes de acci\00F3n')
,p_alias=>'SPD_PROGRAMACION_PLANES_ACCION'
,p_step_title=>unistr('Programaci\00F3n de Planes de Acci\00F3n')
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
unistr('// al cerrar el di\00E1logo de programaci\00F3n se refresca el listado y las metas del nodo'),
'$(window).on("apexafterclosedialog", function (e, data) {',
'  apex.region("spd_list").refresh();',
'  if ($("#spd_node_goals").length) apex.region("spd_node_goals").refresh();',
'  if (data && data.successMessage && data.successMessage.text) apex.message.showPageSuccess(data.successMessage.text);',
'});',
unistr('var t = $("#spd_sched_tree"), L = {PRODUCT: "Producto", RESULT: "Resultado", WELL_BEING: "Bienestar", IMPACT: "Impacto", ACTIVITY: "Actividad", PROJECT: "Proyecto", ACTION_PLAN: "Plan de Acci\00F3n", ACTION_PLAN_ACTIVITY: "Meta de Plan de Acci\00F3n", PUBLIC')
||unistr('_POLITIC: "Pol\00EDtica P\00FAblica"};'),
'function spdBadges() { t.find(".a-TreeView-label").each(function () { var e = $(this), m = e.text().match(/^(.*) \{\{(.*)\}\}$/); if (m) { e.text(m[1]); m[2].split(",").forEach(function (x) { var p = x.split(":"); e.append($("<span>").addClass("spd-b'
||'adge spd-badge--" + p[0]).attr("title", p[1] + " metas de " + (L[p[0]] || p[0])).text(p[1])); }); } }); }',
'if (t.length) { t.on("treeviewexpansionstatechange", function () { setTimeout(spdBadges, 0); }); var s = t.treeView("getSelection"); if (s.length) { t.treeView("expand", s); } spdBadges(); }'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'.spd-badge{display:inline-block;min-width:20px;padding:0 6px;margin-left:6px;border-radius:10px;font-size:11px;line-height:18px;color:#fff;text-align:center;background:#1677ff;vertical-align:middle}',
'.spd-badge--PRODUCT{background:#9FD912}.spd-badge--RESULT,.spd-badge--WELL_BEING,.spd-badge--IMPACT{background:#52c41a}',
'.spd-badge--ACTIVITY{background:#1677ff}.spd-badge--PROJECT{background:green}.spd-badge--ACTION_PLAN{background:blueviolet}.spd-badge--ACTION_PLAN_ACTIVITY{background:orange}',
'.spd-st{display:inline-flex;align-items:center;justify-content:center;width:30px;height:30px;border-radius:50%;font-size:15px;border:1px solid transparent}',
'.spd-st--NEW{color:#0f1129;border-color:#0f1129}',
'.spd-st--SCH{color:#008000;border-color:#008000;background:rgba(0,128,0,.15)}',
'.spd-st--PAR{color:#f99c07;border-color:#f99c07;background:rgba(249,156,7,.15)}',
'.spd-st--REP{color:#008000;background:rgba(0,128,0,.15)}',
'.spd-st--VAL{color:#008000;border-color:#008000}',
'.spd-st--REV{color:#008000;border-color:#008000;background:rgba(0,128,0,.4)}',
'.spd-st--REJ{color:#ef440b;background:rgba(239,68,11,.15)}',
'.spd-act{font-size:16px;color:#1677ff}',
'.spd-collapse{border:1px solid #d9d9d9;border-radius:8px;margin-bottom:10px;background:#fff}',
'.spd-collapse>summary{padding:12px 16px;cursor:pointer;background:#fafafa;border-radius:8px;list-style:none}',
'.spd-collapse>summary::before{content:"\203A";display:inline-block;width:16px;font-weight:bold;transition:transform .2s}',
'.spd-collapse[open]>summary::before{transform:rotate(90deg)}',
'.spd-collapse[open]>summary{border-bottom:1px solid #d9d9d9;border-radius:8px 8px 0 0}',
'.spd-collapse>div{padding:16px}',
'.spd-desc{width:100%;border-collapse:collapse;border:1px solid #f0f0f0}',
'.spd-desc th,.spd-desc td{border:1px solid #f0f0f0;padding:8px 16px;text-align:left;vertical-align:top;font-weight:normal}',
'.spd-desc th{background:#fafafa;color:rgba(0,0,0,.65);width:22%}',
'.spd-tbl{width:100%;border-collapse:collapse}',
'.spd-scroll{max-height:75vh;overflow:auto}',
'.spd-scroll .spd-tbl th{position:sticky;top:0;z-index:1}',
'.spd-tbl th{background:#fafafa;padding:8px;text-align:left;border-bottom:1px solid #f0f0f0}',
'.spd-tbl td{padding:8px;border-bottom:1px solid #f0f0f0;vertical-align:top}',
'.spd-empty{padding:24px;text-align:center;color:rgba(0,0,0,.35)}',
'.spd-empty .fa{font-size:32px;display:block;margin-bottom:6px}',
'.spd-form{border-collapse:separate;border-spacing:0 8px;width:100%}',
'.spd-form th{text-align:left;font-weight:normal;padding-right:16px;white-space:nowrap;width:1%}',
'.spd-form th:after{content:":"}',
'.spd-form th.spd-noc:after{content:""}',
'.spd-form td{padding-right:10px}',
'.spd-form input,.spd-form select{height:32px;border:1px solid #d9d9d9;border-radius:6px;padding:0 8px}',
'.spd-form input[disabled],.spd-form select[disabled],.spd-form input[readonly]{background:#f5f5f5;color:rgba(0,0,0,.45)}',
'.spd-num{width:170px;text-align:right}.spd-num--sm{width:70px}.spd-sel{width:200px}',
'.spd-money{width:100%;min-width:110px;max-width:240px;text-align:right}',
'.spd-colhead{text-align:center;font-weight:bold;font-size:15px}',
'.spd-total th{font-weight:bold;font-size:15px}',
'.spd-sgp-sub th{padding-left:28px}',
'.spd-sgp-toggle{cursor:pointer;margin-right:6px}',
'.spd-btns{text-align:center;margin-top:16px}',
'.spd-hist{list-style:none;margin:0;padding:0}',
'.spd-hist li{display:flex;gap:16px;padding:12px 0;border-bottom:1px solid #f0f0f0}',
'.spd-avatar{flex:none;width:32px;height:32px;border-radius:50%;background:#87d068;color:#fff;display:flex;align-items:center;justify-content:center}',
'.spd-hist-title{font-weight:500}.spd-hist-desc{color:rgba(0,0,0,.45)}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1821682168136875)
,p_plug_name=>'Seguimiento'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>5
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1823428783136875)
,p_plug_name=>unistr('Planes de Acci\00F3n')
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(39530989314162909)
,p_plug_display_sequence=>10
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1823545397136876)
,p_plug_name=>'Listado <span class="spd-badge">&P1040_TOTAL.</span>'
,p_region_name=>'spd_list'
,p_parent_plug_id=>wwv_flow_imp.id(1823428783136875)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'select m.GOAL_ID, m.CODE, m.NAME, m.INDICATOR, m.BASE_VALUE, m.ENTITY_CODE, m.ENTITY_NAME, m.GOAL_VALUE,',
'       m.SCHEDULE_STATUS,',
'       case m.SCHEDULE_STATUS when ''Sin Programar'' then ''NEW'' when ''Programada'' then ''SCH'' when ''Programada Parcial'' then ''PAR''',
'            when ''Reportada'' then ''REP'' when ''Validada'' then ''VAL'' when ''Revisada'' then ''REV'' when ''Rechazada'' then ''REJ'' end as ST_KEY,',
'       case when m.SCHEDULE_STATUS in (''Sin Programar'', ''Programada'', ''Programada Parcial'') then ''fa-usd''',
'            when m.SCHEDULE_STATUS = ''Reportada'' then ''fa-pencil-square-o'' when m.SCHEDULE_STATUS = ''Validada'' then ''fa-check-circle''',
'            when m.SCHEDULE_STATUS = ''Revisada'' then ''fa-check-square-o'' else ''fa-calendar-times-o'' end as ST_ICON,',
'       m.GOAL_ID as ACCIONES,',
'       case when :P1040_DATE_OK = ''S'' and m.SCHEDULE_STATUS not in (''Validada'', ''Revisada'') then ''fa-clipboard'' else ''fa-eye'' end as ACCION_ICON,',
'       case when :P1040_DATE_OK = ''S'' and m.SCHEDULE_STATUS not in (''Validada'', ''Revisada'') then ''Programar'' else ''Ver'' end as ACCION_TITLE',
'  from V_SPD_GOAL_MONITORING m',
' where m.NIT_COMPANIA = :G_NIT_COMPANIA and m.MONITORING_CONFIG_ID = :P1040_MC and m.GOAL_GROUP = ''PLANES'''))
,p_plug_source_type=>'NATIVE_IR'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(1823626104136876)
,p_name=>'Metas'
,p_max_row_count_message=>unistr('El reporte tiene m\00E1s de #MAX_ROW_COUNT# filas: aplique un filtro.')
,p_no_data_found_message=>'No hay datos'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'NONE'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_chart=>'N'
,p_show_group_by=>'N'
,p_show_pivot=>'N'
,p_show_calendar=>'N'
,p_show_flashback=>'N'
,p_download_formats=>'CSV:XLSX'
,p_enable_mail_download=>'N'
,p_owner=>'SIIF'
,p_internal_uid=>1823626104136876
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1823758354136876)
,p_db_column_name=>'GOAL_ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1823845546136876)
,p_db_column_name=>'CODE'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>unistr('C\00F3digo')
,p_column_link=>'f?p=&APP_ID.:1062:&APP_SESSION.::&DEBUG.:1062:P1062_ID:#GOAL_ID#'
,p_column_linktext=>'#CODE#'
,p_column_link_checksum_type=>'3'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1823989835136876)
,p_db_column_name=>'NAME'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Nombre'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1824060191136876)
,p_db_column_name=>'INDICATOR'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Indicador'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1824116881136876)
,p_db_column_name=>'BASE_VALUE'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>unistr('L\00EDnea Base')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1824214829136876)
,p_db_column_name=>'ENTITY_CODE'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Entidad'
,p_column_html_expression=>'<span title="#ENTITY_NAME#">#ENTITY_CODE#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1824370163136876)
,p_db_column_name=>'ENTITY_NAME'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Nombre de la entidad'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1824426095136876)
,p_db_column_name=>'GOAL_VALUE'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Meta'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1824592172136876)
,p_db_column_name=>'SCHEDULE_STATUS'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Estado'
,p_column_html_expression=>'<span class="spd-st spd-st--#ST_KEY#" title="#SCHEDULE_STATUS#"><span class="fa #ST_ICON#" aria-hidden="true"></span></span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1824632560136876)
,p_db_column_name=>'ST_KEY'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'ST_KEY'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1824720203136876)
,p_db_column_name=>'ST_ICON'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'ST_ICON'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1824837330136876)
,p_db_column_name=>'ACCIONES'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Acciones'
,p_column_link=>'f?p=&APP_ID.:1063:&APP_SESSION.::&DEBUG.:1063:P1063_GOAL_ID,P1063_MC:#GOAL_ID#,&P1040_MC.'
,p_column_linktext=>'<span class="fa #ACCION_ICON# spd-act" title="#ACCION_TITLE#" aria-label="#ACCION_TITLE#"></span>'
,p_column_link_attr=>'data-goal="#GOAL_ID#"'
,p_column_link_checksum_type=>'3'
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1824922858136876)
,p_db_column_name=>'ACCION_ICON'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'ACCION_ICON'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1825035224136876)
,p_db_column_name=>'ACCION_TITLE'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'ACCION_TITLE'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(1825184861136876)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'SPD_PROG_METAS'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>10
,p_report_columns=>'CODE:NAME:ENTITY_CODE:SCHEDULE_STATUS:ACCIONES'
,p_sort_column_1=>'CODE'
,p_sort_direction_1=>'ASC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1825210267136876)
,p_plug_name=>'Por Estructura del Plan'
,p_parent_plug_id=>wwv_flow_imp.id(1823428783136875)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1825318157136876)
,p_plug_name=>'Estructura del Plan de Desarrollo'
,p_parent_plug_id=>wwv_flow_imp.id(1825210267136876)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>5
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with r as (',
'  select connect_by_root ID as ROOT_ID, ID from SPD_DEV_PLAN_LEVEL',
'   start with NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :P1040_PLAN connect by prior ID = PARENT_ID),',
'cnt as (',
'  select r.ROOT_ID, g.GOAL_TYPE, count(*) as N from r join SPD_GOAL g on g.DEV_PLAN_LEVEL_ID = r.ID',
'   where g.GOAL_TYPE in (''ACTION_PLAN'', ''ACTION_PLAN_ACTIVITY'') group by r.ROOT_ID, g.GOAL_TYPE',
'  union all',
'  select 0, GOAL_TYPE, count(*) from SPD_GOAL where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :P1040_PLAN',
'     and GOAL_TYPE in (''ACTION_PLAN'', ''ACTION_PLAN_ACTIVITY'') group by GOAL_TYPE),',
'sfx as (',
'  select ROOT_ID, '' {{'' || listagg(GOAL_TYPE || '':'' || N, '','') within group (order by GOAL_TYPE) || ''}}'' as SUFFIX from cnt group by ROOT_ID),',
'n as (',
'  select 0 as VALUE, null as PARENT, NOMBRE as TITLE, null as CODE from PLAN_DESARROLLO',
'   where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :P1040_PLAN',
'  union all',
'  select ID, nvl(PARENT_ID, 0), CODE || '' '' || NAME, CODE from SPD_DEV_PLAN_LEVEL',
'   where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :P1040_PLAN)',
'select case when connect_by_isleaf = 1 then 0 when n.VALUE = 0 then 1 else -1 end as STATUS, level as LVL,',
'       n.TITLE || (select s.SUFFIX from sfx s where s.ROOT_ID = n.VALUE) as TITLE, null as ICON, n.VALUE, null as TOOLTIP,',
'       apex_page.get_url(p_items => ''P1040_NODE'', p_values => n.VALUE) as LINK',
'  from n',
' start with n.PARENT is null connect by prior n.VALUE = n.PARENT',
' order siblings by nlssort(n.CODE, ''NLS_SORT=BINARY'')'))
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
  'selected_node_page_item', 'P1040_NODE',
  'static_tree_id', 'spd_sched_tree',
  'tree_hierarchy', 'LEVEL',
  'tree_tooltip', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1825442277136876)
,p_plug_name=>unistr('Planes de Acci\00F3n de &P1040_NODE_NAME.')
,p_region_name=>'spd_node_goals'
,p_parent_plug_id=>wwv_flow_imp.id(1825210267136876)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'SUB_REGIONS'
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l clob;',
'  rw varchar2(32767);',
'  n pls_integer := 0;',
'begin',
unistr('  l := ''<div class="spd-scroll"><table class="spd-tbl"><tr><th>C\00F3digo</th><th>Nombre</th>'' || case when ''PLANES'' = ''METAS'' then ''<th>Indicador</th><th style="text-align:right">Meta</th>'' end'),
'    || ''<th style="text-align:center">Estado</th><th style="text-align:center">Acciones</th></tr>'';',
'  for m in (select m.GOAL_ID, m.CODE, m.NAME, m.INDICATOR, m.GOAL_VALUE, m.SCHEDULE_STATUS',
'              from V_SPD_GOAL_MONITORING m join SPD_GOAL g on g.ID = m.GOAL_ID',
'             where m.NIT_COMPANIA = :G_NIT_COMPANIA and m.MONITORING_CONFIG_ID = :P1040_MC and m.GOAL_GROUP = ''PLANES''',
'               and (nvl(:P1040_NODE, ''0'') = ''0''',
'                    or g.DEV_PLAN_LEVEL_ID in (select ID from SPD_DEV_PLAN_LEVEL start with ID = to_number(:P1040_NODE)',
'                                               connect by prior ID = PARENT_ID))',
'             order by nlssort(m.CODE, ''NLS_SORT=BINARY'')) loop',
'    n := n + 1;',
'    rw := ''<tr><td><a href="'' || apex_page.get_url(p_page => 1062, p_items => ''P1062_ID'', p_values => m.GOAL_ID, p_clear_cache => ''1062'')',
'      || ''">'' || apex_escape.html(m.CODE) || ''</a></td><td>'' || apex_escape.html(m.NAME) || ''</td>''',
'      || case when ''PLANES'' = ''METAS'' then ''<td>'' || apex_escape.html(m.INDICATOR) || ''</td><td style="text-align:right">'' || m.GOAL_VALUE || ''</td>'' end',
'      || ''<td style="text-align:center"><span class="spd-st spd-st--''',
'      || case m.SCHEDULE_STATUS when ''Sin Programar'' then ''NEW'' when ''Programada'' then ''SCH'' when ''Programada Parcial'' then ''PAR''',
'              when ''Reportada'' then ''REP'' when ''Validada'' then ''VAL'' when ''Revisada'' then ''REV'' else ''REJ'' end',
'      || ''" title="'' || m.SCHEDULE_STATUS || ''"><span class="fa ''',
'      || case when m.SCHEDULE_STATUS in (''Sin Programar'', ''Programada'', ''Programada Parcial'') then ''fa-usd''',
'              when m.SCHEDULE_STATUS = ''Reportada'' then ''fa-pencil-square-o'' when m.SCHEDULE_STATUS = ''Validada'' then ''fa-check-circle''',
'              when m.SCHEDULE_STATUS = ''Revisada'' then ''fa-check-square-o'' else ''fa-calendar-times-o'' end',
'      || ''"></span></span></td><td style="text-align:center"><a data-goal="'' || m.GOAL_ID || ''" href="''',
'      || apex_page.get_url(p_page => 1063, p_items => ''P1063_GOAL_ID,P1063_MC'', p_values => m.GOAL_ID || '','' || :P1040_MC,',
'                           p_clear_cache => ''1063'') || ''">''',
'      || case when :P1040_DATE_OK = ''S'' and m.SCHEDULE_STATUS not in (''Validada'', ''Revisada'')',
'              then ''<span class="fa fa-clipboard spd-act" title="Programar"></span>''',
'              else ''<span class="fa fa-eye spd-act" title="Ver"></span>'' end',
'      || ''</a></td></tr>'';',
'    l := l || rw;',
'  end loop;',
'  if n = 0 then',
'    return ''<div class="spd-empty"><span class="fa fa-inbox"></span>No hay datos</div>'';',
'  end if;',
'  return l || ''</table></div>'';',
'end;'))
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(1825743627136877)
,p_branch_name=>unistr('Volver a la p\00E1gina')
,p_branch_action=>'f?p=&APP_ID.:1040:&APP_SESSION.::&DEBUG.:::'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1821733367136875)
,p_name=>'P1040_MC'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'Seguimiento'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''('' || mc.PERIOD || ''-'' || mc.SUBPERIOD || '') '' || pd.NOMBRE as d, mc.ID as r',
'  from SPD_MONITORING_CONFIG mc',
'  left join PLAN_DESARROLLO pd on pd.NIT_COMPANIA = mc.NIT_COMPANIA and pd.PLAN = mc.PLAN',
' where mc.NIT_COMPANIA = :G_NIT_COMPANIA and nvl(mc.USED_FOR, ''DEVELOPMENT_PLANS'') = ''DEVELOPMENT_PLANS''',
' order by case when mc.IS_ACTIVE = ''S'' then 0 else 1 end, mc.PERIOD desc, mc.SUBPERIOD desc'))
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39597826564162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'SUBMIT')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1821815296136875)
,p_name=>'P1040_GOAL_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'GOAL_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1821996610136875)
,p_name=>'P1040_NODE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'NODE'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1822043370136875)
,p_name=>'P1040_NODE_NAME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'NODE_NAME'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1822146790136875)
,p_name=>'P1040_TOTAL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'TOTAL'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1822220197136875)
,p_name=>'P1040_PLAN'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'PLAN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1822339917136875)
,p_name=>'P1040_ORIGIN'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'ORIGIN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1822487402136875)
,p_name=>'P1040_WEIGHT_TYPE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'WEIGHT_TYPE'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1822591654136875)
,p_name=>'P1040_SGP_DISC'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'SGP_DISC'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1822651452136875)
,p_name=>'P1040_SUPPORT_PI'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'SUPPORT_PI'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1822767498136875)
,p_name=>'P1040_DATE_OK'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'DATE_OK'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1822821956136875)
,p_name=>'P1040_MANUAL_BUDGET'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'MANUAL_BUDGET'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1822951995136875)
,p_name=>'P1040_EDITABLE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'EDITABLE'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1823039068136875)
,p_name=>'P1040_REC_ID'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'REC_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1823137159136875)
,p_name=>'P1040_STATUS'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'STATUS'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1823264768136875)
,p_name=>'P1040_GOAL_TYPE'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'GOAL_TYPE'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1823359859136875)
,p_name=>'P1040_USER_ID'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(1821682168136875)
,p_prompt=>'USER_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(1825670766136876)
,p_process_sequence=>190
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cambiar seguimiento'
,p_process_sql_clob=>':P1040_NODE := ''0'';'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P1040_MC'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>1825670766136876
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3699769988607387)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SPD Global: seguimiento elegido'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
'  select ID into :P1040_MC from SPD_MONITORING_CONFIG',
'   where ID = :G_SEGUIMIENTO and NIT_COMPANIA = :G_NIT_COMPANIA and nvl(USED_FOR, ''DEVELOPMENT_PLANS'') = ''DEVELOPMENT_PLANS'';',
'exception when no_data_found or value_error or invalid_number then null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>3699769988607387
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(1825528115136876)
,p_process_sequence=>180
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cargar seguimiento'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  mc SPD_MONITORING_CONFIG%rowtype;',
'  function ts(v varchar2) return timestamp with time zone is',
'  begin',
'    return from_tz(to_timestamp(substr(v, 1, 23), ''YYYY-MM-DD"T"HH24:MI:SS.FF3''), ''UTC'');',
'  end;',
'begin',
'  if :P1040_MC is null then',
'    select max(ID) keep (dense_rank first order by case when IS_ACTIVE = ''S'' then 0 else 1 end, PERIOD desc, SUBPERIOD desc)',
'      into :P1040_MC from SPD_MONITORING_CONFIG',
'     where NIT_COMPANIA = :G_NIT_COMPANIA and nvl(USED_FOR, ''DEVELOPMENT_PLANS'') = ''DEVELOPMENT_PLANS'';',
'  end if;',
'  begin',
'    select * into mc from SPD_MONITORING_CONFIG where ID = :P1040_MC and NIT_COMPANIA = :G_NIT_COMPANIA;',
'  exception when no_data_found then',
'    :P1040_MC := null; :P1040_GOAL_ID := null; :P1040_TOTAL := 0; return;',
'  end;',
'  :P1040_PLAN := mc.PLAN;',
'  :P1040_ORIGIN := mc.MONITORING_RESOURCES_ORIGIN;',
'  :P1040_WEIGHT_TYPE := mc.WEIGHTING_TYPE;',
'  :P1040_SGP_DISC := mc.SGP_DISCRIMINATED;',
'  :P1040_SUPPORT_PI := mc.SUPPORT_PRODUCT_MONITORING;',
unistr('  -- ventana de programaci\00F3n (DATES_CONFIG.scheduling = [inicio, fin], en UTC)'),
'  :P1040_DATE_OK := ''N'';',
'  begin',
'    if systimestamp between ts(json_value(mc.DATES_CONFIG, ''$.scheduling[0]''))',
'                        and ts(json_value(mc.DATES_CONFIG, ''$.scheduling[1]'')) then',
'      :P1040_DATE_OK := ''S'';',
'    end if;',
'  exception when others then null;',
'  end;',
'  select count(*) into :P1040_TOTAL from V_SPD_GOAL_MONITORING',
'   where NIT_COMPANIA = :G_NIT_COMPANIA and MONITORING_CONFIG_ID = mc.ID and GOAL_GROUP = nvl(''PLANES'', GOAL_GROUP);',
'',
'  -- usuario actual (USUARIOS.ID = autor del historial) y presupuesto manual de su entidad',
'  select max(u.ID), max(e.SPD_PRESUPUESTO_MANUAL) into :P1040_USER_ID, :P1040_MANUAL_BUDGET',
'    from USUARIOS u',
'    left join ENTIDADES_PRY e on e.NIT_COMPANIA = u.NIT_COMPANIA and e.CODIGO_ENT_PRY = u.CODIGO_ENT_PRY',
'   where u.NIT_COMPANIA = :G_NIT_COMPANIA and (upper(u.USUARIO) = upper(:APP_USER) or upper(u.EMAIL) = upper(:APP_USER));',
'',
unistr('  -- nodo del \00E1rbol'),
'  :P1040_NODE := nvl(:P1040_NODE, ''0'');',
'  if :P1040_NODE <> ''0'' then',
'    begin',
'      select CODE || '' '' || NAME into :P1040_NODE_NAME from SPD_DEV_PLAN_LEVEL',
'       where ID = :P1040_NODE and NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = mc.PLAN;',
'    exception when no_data_found then :P1040_NODE := ''0'';',
'    end;',
'  end if;',
'  if :P1040_NODE = ''0'' then',
'    select max(NOMBRE) into :P1040_NODE_NAME from PLAN_DESARROLLO where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = mc.PLAN;',
'  end if;',
'',
'  -- meta seleccionada: estado en este seguimiento y si se puede programar',
'  :P1040_REC_ID := null; :P1040_STATUS := null; :P1040_GOAL_TYPE := null; :P1040_EDITABLE := ''N'';',
'  if :P1040_GOAL_ID is not null then',
'    begin',
'      select MONITORING_RECORD_ID, SCHEDULE_STATUS, GOAL_TYPE into :P1040_REC_ID, :P1040_STATUS, :P1040_GOAL_TYPE',
'        from V_SPD_GOAL_MONITORING',
'       where NIT_COMPANIA = :G_NIT_COMPANIA and MONITORING_CONFIG_ID = mc.ID and GOAL_ID = :P1040_GOAL_ID and GOAL_GROUP = nvl(''PLANES'', GOAL_GROUP);',
'      :P1040_EDITABLE := case when :P1040_DATE_OK = ''S'' and :P1040_STATUS not in (''Validada'', ''Revisada'')',
'                                and :P1040_GOAL_TYPE <> ''ACTION_PLAN'' then ''S'' else ''N'' end;',
'    exception when no_data_found then :P1040_GOAL_ID := null;',
'    end;',
'  end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>1825528115136876
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3699869685607387)
,p_process_sequence=>9999
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SPD Global: guardar seguimiento'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
'  if :P1040_MC is not null then :G_SEGUIMIENTO := :P1040_MC; end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>3699869685607387
);
wwv_flow_imp.component_end;
end;
/
