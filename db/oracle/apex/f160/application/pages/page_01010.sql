prompt --application/pages/page_01010
begin
--   Manifest
--     PAGE: 01010
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
 p_id=>1010
,p_name=>'SPD_Metas'
,p_alias=>'SPD_METAS'
,p_step_title=>'Metas'
,p_autocomplete_on_off=>'OFF'
,p_html_page_header=>'<style>.spd-badge{display:inline-block;min-width:20px;padding:0 6px;margin-left:6px;border-radius:10px;font-size:11px;line-height:18px;color:#fff;text-align:center;background:#13c2c2;vertical-align:middle}.spd-badge--PRODUCT{background:#9FD912}.spd-b'
||'adge--RESULT,.spd-badge--WELL_BEING,.spd-badge--IMPACT{background:#52c41a}.spd-badge--ACTIVITY{background:#1677ff}.spd-badge--PROJECT{background:green}.spd-badge--ACTION_PLAN{background:blueviolet}.spd-badge--ACTION_PLAN_ACTIVITY{background:orange}.s'
||'pd-badge--TOTAL{background:#1677ff}.spd-type-summary{display:flex;flex-wrap:wrap;gap:6px 16px;margin:0 0 8px}.spd-type-summary .spd-badge{margin:0 4px 0 0}.spd-type-badge{margin-left:0!important}</style>'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('var t = $("#spd_goal_tree"), L = {PRODUCT: "Producto", RESULT: "Resultado", WELL_BEING: "Bienestar", IMPACT: "Impacto", ACTIVITY: "Actividad", PROJECT: "Proyecto", ACTION_PLAN: "Plan de Acci\00F3n", ACTION_PLAN_ACTIVITY: "Meta de Plan de Acci\00F3n", PUBLIC_')
||unistr('POLITIC: "Pol\00EDtica P\00FAblica"};'),
'// badge con el total de metas del nodo (y sus hijos): la etiqueta trae el sufijo {{TOTAL:n}}',
'function spdBadges() { t.find(".a-TreeView-label").each(function () { var e = $(this), m = e.text().match(/^(.*) \{\{(.*)\}\}$/); if (m) { e.text(m[1]); m[2].split(",").forEach(function (x) { var p = x.split(":"); e.append($("<span>").addClass("spd-b'
||'adge spd-badge--" + p[0]).attr("title", p[0] === "TOTAL" ? p[1] + " metas" : p[1] + " metas de " + (L[p[0]] || p[0])).text(p[1])); }); } }); }',
't.on("treeviewexpansionstatechange", function () { setTimeout(spdBadges, 0); });',
'var s = t.treeView("getSelection"); if (s.length) { t.treeView("expand", s); }',
'spdBadges();'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>To find data enter a search term into the search dialog, or click on the column headings to limit the records returned.</p>',
'',
'<p>You can perform numerous functions by clicking the <strong>Actions</strong> button. This includes selecting the columns that are displayed / hidden and their display sequence, plus numerous data and format functions.  You can also define additiona'
||'l views of the data using the chart, group by, and pivot options.</p>',
'',
'<p>If you want to save your customizations select report, or click download to unload the data. Enter you email address and time frame under subscription to be sent the data on a regular basis.<p>',
'',
'<p>For additional information click Help at the bottom of the Actions menu.</p> ',
'',
'<p>Click the <strong>Reset</strong> button to reset the interactive report back to the default settings.</p>'))
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41225566984911762)
,p_plug_name=>'Metas'
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(39530989314162909)
,p_plug_display_sequence=>5
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39962130182163129)
,p_plug_name=>'Listado <span class="spd-badge spd-badge--TOTAL">&P1010_TOTAL.</span>'
,p_parent_plug_id=>wwv_flow_imp.id(41225566984911762)
,p_region_template_options=>'#DEFAULT#'
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'TABLE'
,p_query_table=>'SPD_GOAL'
,p_query_where=>'NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :P1010_PLAN'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P1010_PLAN'
,p_prn_page_header=>'Metas'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(39962248197163129)
,p_name=>'Metas'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_base_pk1=>'ID'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:1062:&APP_SESSION.::&DEBUG.:1062:P1062_ID:\#ID#\'
,p_detail_link_text=>'<span role="img" aria-label="Ver datos de la meta" class="fa fa-eye" title="Ver datos de la meta"></span>'
,p_owner=>'ADMIN'
,p_internal_uid=>38321233497549727
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39962993604163131)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39963335526163131)
,p_db_column_name=>'NIT_COMPANIA'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>unistr('Compa\00F1\00EDa')
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(39886983472163105)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39964953830163132)
,p_db_column_name=>'DEV_PLAN_LEVEL_ID'
,p_display_order=>2
,p_column_identifier=>'F'
,p_column_label=>'Nivel Plan'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(39904593833163110)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39963758339163131)
,p_db_column_name=>'PARENT_GOAL_ID'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Meta padre'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(40015751881163157)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39966565687163133)
,p_db_column_name=>'CODE'
,p_display_order=>3
,p_column_identifier=>'J'
,p_column_label=>unistr('C\00F3digo')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39964128520163131)
,p_db_column_name=>'IS_ACTIVE'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Activo'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(40760407243163572)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39966936122163133)
,p_db_column_name=>'NAME'
,p_display_order=>4
,p_column_identifier=>'K'
,p_column_label=>'Meta'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39964580441163131)
,p_db_column_name=>'PLAN'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Plan de desarrollo'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(39902708988163110)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39966139143163132)
,p_db_column_name=>'GOAL_TYPE'
,p_display_order=>5
,p_column_identifier=>'I'
,p_column_label=>'Tipo'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(40760655877163573)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39965358218163132)
,p_db_column_name=>'ENTITY_ID'
,p_display_order=>6
,p_column_identifier=>'G'
,p_column_label=>'Entidad'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(39845681099163092)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39965801286163132)
,p_db_column_name=>'EXTRA_ENTITY_IDS'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Entidades adicionales (JSON)'
,p_allow_sorting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'CLOB'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_show_filter_lov=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39967368417163133)
,p_db_column_name=>'INDICATOR'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Indicador'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39967786335163133)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>unistr('Descripci\00F3n')
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39968185929163134)
,p_db_column_name=>'ACCUMULATION_TYPE'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>unistr('Tipo de acumulaci\00F3n')
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(40761645559163573)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39968590592163134)
,p_db_column_name=>'BASE_VALUE'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>unistr('L\00EDnea base')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39968926644163134)
,p_db_column_name=>'GOAL_VALUE'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>'Meta'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39969391374163135)
,p_db_column_name=>'UNITS_FACTOR'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>'Factor de unidades'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39969794516163135)
,p_db_column_name=>'UNIT_CODE'
,p_display_order=>18
,p_column_identifier=>'R'
,p_column_label=>'Unidad de medida'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39970202263163135)
,p_db_column_name=>'IS_BASE_VALUE_NOT_AVAILABLE'
,p_display_order=>19
,p_column_identifier=>'S'
,p_column_label=>unistr('L\00EDnea base no disponible')
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(40760407243163572)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39970582219163135)
,p_db_column_name=>'ODS_IDS'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>'ODS (JSON)'
,p_allow_sorting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'CLOB'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_show_filter_lov=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39970996563163135)
,p_db_column_name=>'PUBLIC_POLITIC_ID'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>unistr('Pol\00EDtica p\00FAblica')
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(39934259545163120)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39971328976163135)
,p_db_column_name=>'PUBLIC_POLITIC_COMPONENT_ID'
,p_display_order=>22
,p_column_identifier=>'V'
,p_column_label=>unistr('Componente de pol\00EDtica')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(40108214019163221)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39971776932163136)
,p_db_column_name=>'PEACE_POLITIC_ID'
,p_display_order=>23
,p_column_identifier=>'W'
,p_column_label=>unistr('Pol\00EDtica de paz')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(39934259545163120)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39972206867163136)
,p_db_column_name=>'VICTIMS_POLITIC_ID'
,p_display_order=>24
,p_column_identifier=>'X'
,p_column_label=>unistr('Pol\00EDtica de v\00EDctimas')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(39934259545163120)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39972526561163136)
,p_db_column_name=>'PRODUCT_ID'
,p_display_order=>25
,p_column_identifier=>'Y'
,p_column_label=>'Producto'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(39905654405163111)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39972990071163136)
,p_db_column_name=>'WEIGHTING'
,p_display_order=>26
,p_column_identifier=>'Z'
,p_column_label=>unistr('Ponderaci\00F3n')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39973367012163136)
,p_db_column_name=>'PI_BASE_VALUE'
,p_display_order=>27
,p_column_identifier=>'AA'
,p_column_label=>unistr('L\00EDnea base (plan indicativo)')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39973755098163137)
,p_db_column_name=>'PI_GOAL_VALUE'
,p_display_order=>28
,p_column_identifier=>'AB'
,p_column_label=>'Meta (plan indicativo)'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39974196180163137)
,p_db_column_name=>'PI_UNITS_FACTOR'
,p_display_order=>29
,p_column_identifier=>'AC'
,p_column_label=>'Factor de unidades (plan indicativo)'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39974533990163137)
,p_db_column_name=>'PI_UNIT_CODE'
,p_display_order=>30
,p_column_identifier=>'AD'
,p_column_label=>'Unidad (plan indicativo)'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39974944487163137)
,p_db_column_name=>'START_DATE'
,p_display_order=>31
,p_column_identifier=>'AE'
,p_column_label=>'Fecha de inicio'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39975382344163137)
,p_db_column_name=>'END_DATE'
,p_display_order=>32
,p_column_identifier=>'AF'
,p_column_label=>'Fecha de fin'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39975737479163137)
,p_db_column_name=>'CREATED_AT'
,p_display_order=>33
,p_column_identifier=>'AG'
,p_column_label=>unistr('Fecha de creaci\00F3n')
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39976175511163137)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>34
,p_column_identifier=>'AH'
,p_column_label=>'Creado por'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39976546460163138)
,p_db_column_name=>'UPDATED_AT'
,p_display_order=>35
,p_column_identifier=>'AI'
,p_column_label=>unistr('Fecha de actualizaci\00F3n')
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39976945766163138)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>36
,p_column_identifier=>'AJ'
,p_column_label=>'Actualizado por'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39977390895163138)
,p_db_column_name=>'LINKED_GOAL_IDS'
,p_display_order=>37
,p_column_identifier=>'AK'
,p_column_label=>'Metas vinculadas (JSON)'
,p_allow_sorting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'CLOB'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_show_filter_lov=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39977814189163138)
,p_db_column_name=>'FORMULA'
,p_display_order=>38
,p_column_identifier=>'AL'
,p_column_label=>unistr('F\00F3rmula')
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39978049350163138)
,p_db_column_name=>'MACRO_PROJECT_ID'
,p_display_order=>39
,p_column_identifier=>'AM'
,p_column_label=>'Macroproyecto'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(39943362362163122)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39978503191163138)
,p_db_column_name=>'ACTIVITY_ID'
,p_display_order=>40
,p_column_identifier=>'AN'
,p_column_label=>'Actividad'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39978908452163138)
,p_db_column_name=>'PROJECT_CODE'
,p_display_order=>41
,p_column_identifier=>'AO'
,p_column_label=>unistr('C\00F3digo del proyecto')
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39979271991163139)
,p_db_column_name=>'ORIGIN_ID'
,p_display_order=>42
,p_column_identifier=>'AP'
,p_column_label=>'ID de origen'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(40540920626163434)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'389000'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ID:DEV_PLAN_LEVEL_ID:CODE:NAME:GOAL_TYPE:ENTITY_ID'
,p_sort_direction_1=>'ASC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41225619297911762)
,p_plug_name=>'Por Estructura del Plan'
,p_parent_plug_id=>wwv_flow_imp.id(41225566984911762)
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
 p_id=>wwv_flow_imp.id(41226158742911763)
,p_plug_name=>'Estructura del Plan de Desarrollo'
,p_parent_plug_id=>wwv_flow_imp.id(41225619297911762)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>30
,p_plug_grid_column_span=>5
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with r as (',
'  select connect_by_root ID as ROOT_ID, ID from SPD_DEV_PLAN_LEVEL',
'   start with NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :P1010_PLAN connect by prior ID = PARENT_ID),',
'cnt as (',
'  select r.ROOT_ID, count(*) as N from r join SPD_GOAL g on g.DEV_PLAN_LEVEL_ID = r.ID group by r.ROOT_ID',
'  union all',
'  select 0, count(*) from SPD_GOAL where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :P1010_PLAN having count(*) > 0),',
'sfx as (',
'  select ROOT_ID, '' {{TOTAL:'' || N || ''}}'' as SUFFIX from cnt),',
'n as (',
'  select 0 as VALUE, null as PARENT, NOMBRE as TITLE, null as CODE from PLAN_DESARROLLO',
'   where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :P1010_PLAN',
'  union all',
'  select ID, nvl(PARENT_ID, 0), CODE || '' '' || NAME, CODE from SPD_DEV_PLAN_LEVEL',
'   where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :P1010_PLAN)',
'select case when connect_by_isleaf = 1 then 0 when n.VALUE = 0 then 1 else -1 end as STATUS, level as LVL,',
'       n.TITLE || (select s.SUFFIX from sfx s where s.ROOT_ID = n.VALUE) as TITLE, null as ICON, n.VALUE, null as TOOLTIP,',
'       apex_page.get_url(p_items => ''P1010_NODE'', p_values => n.VALUE) as LINK',
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
  'selected_node_page_item', 'P1010_NODE',
  'static_tree_id', 'spd_goal_tree',
  'tree_hierarchy', 'LEVEL',
  'tree_tooltip', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41226290753911763)
,p_plug_name=>'Metas de &P1010_NODE_NAME.'
,p_parent_plug_id=>wwv_flow_imp.id(41225619297911762)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>7
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select g.ID, g.CODE, g.NAME, g.INDICATOR, g.BASE_VALUE, g.GOAL_VALUE,',
'       ''<span class="spd-badge spd-type-badge spd-badge--'' || g.GOAL_TYPE || ''">'' ||',
'       case g.GOAL_TYPE when ''PRODUCT'' then ''Producto'' when ''RESULT'' then ''Resultado''',
'                        when ''WELL_BEING'' then ''Bienestar'' when ''IMPACT'' then ''Impacto''',
'                        when ''ACTIVITY'' then ''Actividad'' when ''PROJECT'' then ''Proyecto''',
unistr('                        when ''ACTION_PLAN'' then ''Plan de Acci\00F3n'' when ''ACTION_PLAN_ACTIVITY'' then ''Meta de Plan de Acci\00F3n'''),
unistr('                        when ''PUBLIC_POLITIC'' then ''Pol\00EDtica P\00FAblica'' else g.GOAL_TYPE end || ''</span>'' as TYPE_HTML'),
'  from SPD_GOAL g',
' where g.NIT_COMPANIA = :G_NIT_COMPANIA and g.PLAN = :P1010_PLAN',
'   and (nvl(:P1010_NODE, ''0'') = ''0''',
'        or g.DEV_PLAN_LEVEL_ID = to_number(:P1010_NODE))'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P1010_PLAN,P1010_NODE'
,p_plug_header=>'<div class="spd-type-summary">&P1010_NODE_SUMMARY!RAW.</div>'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41226377176911763)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>'ID'
,p_label=>'ID'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41226505273911763)
,p_name=>'CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_LINK'
,p_heading=>unistr('C\00F3digo')
,p_label=>unistr('C\00F3digo')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_link_target=>'f?p=&APP_ID.:1062:&APP_SESSION.::&DEBUG.:1062:P1062_ID:&ID.'
,p_link_text=>'&CODE.'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41226527982911763)
,p_name=>'NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Nombre'
,p_label=>'Nombre'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y')).to_clob
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41226667300911763)
,p_name=>'INDICATOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INDICATOR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Indicador'
,p_label=>'Indicador'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y')).to_clob
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41226735540911763)
,p_name=>'BASE_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BASE_VALUE'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('L\00EDnea Base')
,p_label=>unistr('L\00EDnea Base')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y')).to_clob
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(41226892772911763)
,p_name=>'GOAL_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'GOAL_VALUE'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Meta'
,p_label=>'Meta'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y')).to_clob
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(51010000000000001)
,p_name=>'TYPE_HTML'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TYPE_HTML'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Tipo'
,p_label=>'Tipo'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>110
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'HTML',
  'send_on_page_submit', 'N')).to_clob
,p_enable_filter=>false
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(41227008271911763)
,p_internal_uid=>39585993572298361
,p_is_editable=>false
,p_add_row_if_empty=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>false
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET'
,p_add_button_label=>'Nuevo'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>false
,p_enable_flashback=>false
,p_define_chart_view=>false
,p_enable_download=>true
,p_enable_mail_download=>false
,p_fixed_header=>'NONE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(41227076871911763)
,p_interactive_grid_id=>wwv_flow_imp.id(41227008271911763)
,p_static_id=>'39586062172298361'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>15
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(41227125051911763)
,p_report_id=>wwv_flow_imp.id(41227076871911763)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41227295829911763)
,p_view_id=>wwv_flow_imp.id(41227125051911763)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(41226505273911763)
,p_is_visible=>true
,p_is_frozen=>false
,p_sort_order=>1
,p_sort_direction=>'ASC'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41227404292911763)
,p_view_id=>wwv_flow_imp.id(41227125051911763)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(41226527982911763)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41227509053911763)
,p_view_id=>wwv_flow_imp.id(41227125051911763)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(41226667300911763)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41227521321911763)
,p_view_id=>wwv_flow_imp.id(41227125051911763)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(41226735540911763)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(41227620573911763)
,p_view_id=>wwv_flow_imp.id(41227125051911763)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(41226892772911763)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(51010000000000002)
,p_view_id=>wwv_flow_imp.id(41227125051911763)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(51010000000000001)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>185
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(51010000000000010)
,p_plug_name=>'Plan de desarrollo'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>1
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39979776023163139)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Nuevo'
,p_button_position=>'CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:1011:&APP_SESSION.::&DEBUG.:1011::'
,p_icon_css_classes=>'fa-file-plus'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(41227965417911763)
,p_branch_name=>'Volver al listado'
,p_branch_action=>'f?p=&APP_ID.:1010:&APP_SESSION.::&DEBUG.:::'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41225800645911763)
,p_name=>'P1010_PLAN'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(51010000000000010)
,p_prompt=>'Plan de desarrollo'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - PLANES DE DESARROLLO'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'SUBMIT')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41225863395911763)
,p_name=>'P1010_NODE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(41225619297911762)
,p_prompt=>'Nodo'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41225928876911763)
,p_name=>'P1010_NODE_NAME'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(41225619297911762)
,p_prompt=>'Nodo'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41226069645911763)
,p_name=>'P1010_TOTAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(41225619297911762)
,p_prompt=>'Total'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51010000000000003)
,p_name=>'P1010_NODE_SUMMARY'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(41225619297911762)
,p_prompt=>'Metas por tipo'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39980095630163139)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(39962130182163129)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39980545811163139)
,p_event_id=>wwv_flow_imp.id(39980095630163139)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(39962130182163129)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41227863195911763)
,p_process_sequence=>120
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cambiar plan'
,p_process_sql_clob=>':P1010_NODE := ''0'';'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P1010_PLAN'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>39586848496298361
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3700790459607387)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SPD Global: plan elegido'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
'  select PLAN into :P1010_PLAN from PLAN_DESARROLLO',
'   where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :G_PLAN and rownum = 1;',
'exception when no_data_found or value_error or invalid_number then null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>3700790459607387
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41227783305911763)
,p_process_sequence=>110
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cargar estructura'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
unistr('  -- plan por defecto: el elegido en la sesi\00F3n (G_PLAN), el activo de la compa\00F1\00EDa o el m\00E1s reciente'),
'  :P1010_PLAN := nvl(:P1010_PLAN, :G_PLAN);',
'  if :P1010_PLAN is null then',
'    select max(PLAN) keep (dense_rank first order by case when SPD_ACTIVO = ''S'' then 0 else 1 end, PLAN desc)',
'      into :P1010_PLAN from PLAN_DESARROLLO where NIT_COMPANIA = :G_NIT_COMPANIA;',
'  end if;',
'  select count(*) into :P1010_TOTAL from SPD_GOAL where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :P1010_PLAN;',
'  :P1010_NODE := nvl(:P1010_NODE, ''0'');',
'  if :P1010_NODE <> ''0'' then',
'    begin',
'      select CODE || '' '' || NAME into :P1010_NODE_NAME from SPD_DEV_PLAN_LEVEL',
'       where ID = :P1010_NODE and NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :P1010_PLAN;',
'    exception when no_data_found then :P1010_NODE := ''0'';',
'    end;',
'  end if;',
'  if :P1010_NODE = ''0'' then',
'    select max(NOMBRE) into :P1010_NODE_NAME from PLAN_DESARROLLO where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :P1010_PLAN;',
'  end if;',
'  -- desglose por tipo de las metas del nodo elegido (solo ese nivel), arriba de la grilla "Metas de ..."',
'  :P1010_NODE_SUMMARY := null;',
'  for c in (select GOAL_TYPE, count(*) as N from SPD_GOAL g',
'             where g.NIT_COMPANIA = :G_NIT_COMPANIA and g.PLAN = :P1010_PLAN',
'               and (:P1010_NODE = ''0'' or g.DEV_PLAN_LEVEL_ID = to_number(:P1010_NODE))',
'             group by GOAL_TYPE',
'             order by decode(GOAL_TYPE, ''RESULT'', 1, ''WELL_BEING'', 2, ''IMPACT'', 3, ''PRODUCT'', 4, ''PROJECT'', 5,',
'                             ''ACTIVITY'', 6, ''ACTION_PLAN'', 7, ''ACTION_PLAN_ACTIVITY'', 8, 9)) loop',
'    :P1010_NODE_SUMMARY := :P1010_NODE_SUMMARY || ''<span><span class="spd-badge spd-badge--'' || c.GOAL_TYPE || ''">''',
'      || c.N || ''</span>'' || case c.GOAL_TYPE',
'           when ''PRODUCT'' then ''Producto'' when ''RESULT'' then ''Resultado'' when ''WELL_BEING'' then ''Bienestar''',
'           when ''IMPACT'' then ''Impacto'' when ''ACTIVITY'' then ''Actividad'' when ''PROJECT'' then ''Proyecto''',
unistr('           when ''ACTION_PLAN'' then ''Plan de Acci\00F3n'' when ''ACTION_PLAN_ACTIVITY'' then ''Meta de Plan de Acci\00F3n'''),
unistr('           when ''PUBLIC_POLITIC'' then ''Pol\00EDtica P\00FAblica'' else c.GOAL_TYPE end || ''</span>'';'),
'  end loop;',
'  if :P1010_NODE_SUMMARY is null then',
'    :P1010_NODE_SUMMARY := ''<span>Sin metas</span>'';',
'  end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>39586768606298361
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3700849380607387)
,p_process_sequence=>9999
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SPD Global: guardar plan'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
'  if :P1010_PLAN is not null then :G_PLAN := :P1010_PLAN; end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>3700849380607387
);
wwv_flow_imp.component_end;
end;
/
