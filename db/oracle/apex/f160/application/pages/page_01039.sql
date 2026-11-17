prompt --application/pages/page_01039
begin
--   Manifest
--     PAGE: 01039
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
 p_id=>1039
,p_name=>'SPD_Tableros de control - Proyectos'
,p_alias=>'SPD_TABLERO_PROYECTOS'
,p_step_title=>'Tableros de Control'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'$(window).on("apexafterclosedialog", function (e, data) {',
'  apex.region("spd_list").refresh();',
'  if (data && data.successMessage && data.successMessage.text) apex.message.showPageSuccess(data.successMessage.text);',
'});'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'.spd-badge{display:inline-block;min-width:20px;padding:0 6px;margin-left:6px;border-radius:10px;font-size:11px;line-height:18px;color:#fff;text-align:center;background:#1677ff;vertical-align:middle}',
'.spd-st{display:inline-flex;align-items:center;justify-content:center;width:30px;height:30px;border-radius:50%;font-size:15px;border:1px solid transparent}',
'.spd-st--NEW{color:#0f1129;border-color:#0f1129}',
'.spd-st--SCH{color:#008000;border-color:#008000;background:rgba(0,128,0,.15)}',
'.spd-st--PAR{color:#f99c07;border-color:#f99c07;background:rgba(249,156,7,.15)}',
'.spd-st--REP{color:#008000;background:rgba(0,128,0,.15)}',
'.spd-st--NOREP{color:#1d2f4e;background:rgba(29,47,78,.12)}',
'.spd-st--VAL{color:#008000;border-color:#008000}',
'.spd-st--NOVAL{color:#1d2f4e;background:rgba(29,47,78,.08)}',
'.spd-st--REV{color:#008000;border-color:#008000;background:rgba(0,128,0,.4)}',
'.spd-st--NOREV{color:#ff0000;border-color:#008000}',
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
'.spd-tbl th{background:#fafafa;padding:8px;text-align:left;border-bottom:1px solid #f0f0f0}',
'.spd-tbl td{padding:8px;border-bottom:1px solid #f0f0f0;vertical-align:top}',
'.spd-empty{padding:24px;text-align:center;color:rgba(0,0,0,.35)}',
'.spd-empty .fa{font-size:32px;display:block;margin-bottom:6px}',
'.spd-form{border-collapse:separate;border-spacing:0 8px;width:100%}',
'.spd-form th{text-align:left;font-weight:normal;padding-right:16px;white-space:nowrap;width:1%}',
'.spd-form th:after{content:":"}',
'.spd-form th.spd-noc:after{content:""}',
'.spd-form td{padding-right:10px}',
'.spd-form input,.spd-form select,.spd-ta,.spd-tm input,.spd-tm select{height:32px;border:1px solid #d9d9d9;border-radius:6px;padding:0 8px}',
'.spd-form input[disabled],.spd-form input[readonly],.spd-ta[disabled],.spd-tm [disabled]{background:#f5f5f5;color:rgba(0,0,0,.45)}',
'.spd-num{width:170px;text-align:right}',
'.spd-money{width:100%;min-width:100px;max-width:200px;text-align:right}',
'.spd-colhead{text-align:center;font-weight:bold;font-size:14px}',
'.spd-total th{font-weight:bold;font-size:15px}',
'.spd-sgp-sub th{padding-left:28px}',
'.spd-sgp-toggle{cursor:pointer;margin-right:6px}',
'.spd-ta{width:100%;height:auto;padding:6px 8px;font-family:inherit}',
'.spd-q{margin-bottom:14px}.spd-q label{display:block;margin-bottom:4px}',
'.spd-hist{list-style:none;margin:0;padding:0}',
'.spd-hist li{display:flex;gap:16px;padding:12px 0;border-bottom:1px solid #f0f0f0}',
'.spd-avatar{flex:none;width:32px;height:32px;border-radius:50%;background:#87d068;color:#fff;display:flex;align-items:center;justify-content:center}',
'.spd-hist-title{font-weight:500}.spd-hist-desc{color:rgba(0,0,0,.45)}',
'.spd-bars{display:grid;grid-template-columns:max-content 1fr 60px;gap:8px 12px;align-items:center}',
'.spd-bar{height:8px;background:#f0f0f0;border-radius:4px;overflow:hidden}.spd-bar>i{display:block;height:100%}',
'.spd-gauge{--p:0;--c:#1677ff;width:84px;height:84px;border-radius:50%;background:conic-gradient(var(--c) calc(var(--p)*1%),#f0f0f0 0);display:inline-flex;align-items:center;justify-content:center;position:relative}',
'.spd-gauge::before{content:"";position:absolute;inset:9px;background:#fff;border-radius:50%}',
'.spd-gauge span{position:relative;font-size:13px;font-weight:500}',
'.spd-gauge--sm{width:56px;height:56px}.spd-gauge--sm::before{inset:6px}.spd-gauge--sm span{font-size:11px}',
'.spd-gauges{display:flex;gap:40px;flex-wrap:wrap;text-align:center}.spd-gauges>div>div{margin-top:6px}',
'.spd-gauge--lg{width:116px;height:116px}.spd-gauge--lg::before{inset:12px}.spd-gauge--lg span{font-size:20px;font-weight:600}',
'.spd-ind{display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:16px;padding:12px 0}',
'.spd-ind-card{background:#fff;border:1px solid #f0f0f0;border-radius:10px;padding:16px 18px;display:flex;flex-direction:column;align-items:center;gap:10px;box-shadow:0 1px 3px rgba(0,0,0,.05)}',
'.spd-ind-kicker{font-size:11px;letter-spacing:.06em;text-transform:uppercase;color:rgba(0,0,0,.45)}',
'.spd-ind-title{font-size:15px;font-weight:600;text-align:center;margin-top:-6px}',
'.spd-ind-chip{display:inline-flex;align-items:center;gap:6px;font-size:12px;padding:2px 10px;border-radius:12px;background:#fafafa;border:1px solid #f0f0f0;color:rgba(0,0,0,.75)}',
'.spd-ind-chip i{width:8px;height:8px;border-radius:50%;background:var(--c)}',
'.spd-ind-figs{align-self:stretch;border-top:1px solid #f0f0f0;padding-top:10px;display:grid;grid-template-columns:1fr auto;gap:4px 12px;font-size:12px;color:rgba(0,0,0,.55)}',
'.spd-ind-figs b{font-weight:500;color:rgba(0,0,0,.88);text-align:right;font-variant-numeric:tabular-nums}',
'.spd-tm-card{border:1px solid #d9d9d9;border-radius:8px;margin-bottom:12px}',
'.spd-tm-card>header{display:flex;gap:12px;align-items:center;padding:8px 12px;background:#fafafa;border-radius:8px 8px 0 0}',
'.spd-tm-card>header select{flex:1}',
'.spd-tm-body{padding:12px;display:flex;flex-wrap:wrap;gap:16px}',
'.spd-tm-group{border:1px solid #f0f0f0;border-radius:6px;padding:8px 12px}',
'.spd-tm-group>b{display:block;margin-bottom:6px}',
'.spd-tm-group label{display:inline-flex;flex-direction:column;margin:0 10px 6px 0;font-size:12px}',
'.spd-tm-group input{width:90px;text-align:right}.spd-tm-group input.spd-tm-text{width:220px;text-align:left}',
'.spd-alert{padding:10px 14px;border:1px solid #91caff;background:#e6f4ff;border-radius:6px;margin-bottom:12px}',
'.spd-row-sel td{background:#e6f4ff !important}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3672620792607284)
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
 p_id=>wwv_flow_imp.id(3673203162607284)
,p_plug_name=>'Avance de Metas <span class="spd-badge">&P1039_TOTAL.</span>'
,p_region_name=>'spd_list'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'select x.*,',
'       to_char(x.PHYS, ''FM990D00'', ''NLS_NUMERIC_CHARACTERS=''''.,'''''') as PHYS_P,',
'       to_char(x.FIN, ''FM990D00'', ''NLS_NUMERIC_CHARACTERS=''''.,'''''') as FIN_P,',
'       coalesce((select c.COLOR from V_SPD_MONITORING_COLORS c where c.ID = x.MONITORING_CONFIG_ID',
'                    and x.PHYS >= c.FROM_VALUE * x.SUBPERIOD / 4 and x.PHYS <= c.TO_VALUE * x.SUBPERIOD / 4',
'                  order by c.POS fetch first 1 row only),',
'                (select max(c.COLOR) keep (dense_rank last order by c.POS) from V_SPD_MONITORING_COLORS c',
'                  where c.ID = x.MONITORING_CONFIG_ID), ''#1677ff'') as PHYS_COLOR,',
'       coalesce((select c.COLOR from V_SPD_MONITORING_COLORS c where c.ID = x.MONITORING_CONFIG_ID',
'                    and x.FIN >= c.FROM_VALUE * x.SUBPERIOD / 4 and x.FIN <= c.TO_VALUE * x.SUBPERIOD / 4',
'                  order by c.POS fetch first 1 row only),',
'                (select max(c.COLOR) keep (dense_rank last order by c.POS) from V_SPD_MONITORING_COLORS c',
'                  where c.ID = x.MONITORING_CONFIG_ID), ''#1677ff'') as FIN_COLOR',
'  from (',
'select m.GOAL_ID, m.CODE, m.CODE || case when m.GOAL_TYPE <> ''ACTION_PLAN'' then '' - '' || m.NAME end as GOAL,',
'       m.ENTITY_CODE, m.ENTITY_NAME, m.DEV_PLAN_LEVEL_NAME,',
'       (select e.DISPLAY_VALUE from APEX_APPLICATION_LOV_ENTRIES e where e.APPLICATION_ID = :APP_ID',
'          and e.LIST_OF_VALUES_NAME = ''SPD - TIPO DE META'' and e.RETURN_VALUE = m.GOAL_TYPE) as GOAL_TYPE_LABEL,',
'       case m.ACCUMULATION_TYPE when ''ACCUMULATED'' then ''Acumulado'' when ''NO_ACCUMULATED'' then ''No Acumulado''',
unistr('            when ''ANNUAL_REDUCTION'' then ''Reducci\00F3n Anual'' when ''CAPACITY'' then ''Capacidad'' when ''FLOW'' then ''Flujo'''),
unistr('            when ''REDUCTION'' then ''Reducci\00F3n'' when ''STOCK'' then ''Stock'' end as ACCUMULATION,'),
'       m.BASE_VALUE, m.GOAL_VALUE, m.PROGRAMMED_VALUE, m.ACHIEVED_VALUE, m.APPROPRIATED, m.COMMITMENTS, m.OBLIGATIONS,',
'       m.MONITORING_CONFIG_ID, m.SUBPERIOD, m.REVIEW_STATUS as STATUS,',
'       nvl(m.PHYSICAL_PROGRESS, 0) as PHYS,',
'       nvl(case :P1039_SPENT when ''OBLIGATION'' then m.FIN_PROGRESS_OBLIGATION when ''PAYMENT'' then m.FIN_PROGRESS_PAYMENT',
'                else m.FIN_PROGRESS_COMMITMENT end, 0) as FIN',
'  from V_SPD_GOAL_MONITORING m',
' where m.NIT_COMPANIA = :G_NIT_COMPANIA and m.MONITORING_CONFIG_ID = :P1039_MC and m.GOAL_GROUP = ''PROYECTOS''',
'   and m.RECORD_STATUS in (''REVIEWED'', ''APPROVED'')) x'))
,p_plug_source_type=>'NATIVE_IR'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(3673380586607284)
,p_name=>'Avance de Metas'
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
,p_internal_uid=>3673380586607284
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3673442839607284)
,p_db_column_name=>'GOAL_ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_link=>'f?p=&APP_ID.:1064:&APP_SESSION.::&DEBUG.:1064:P1064_GOAL_ID,P1064_MC,P1064_MODE:#GOAL_ID#,&P1039_MC.,VIEW'
,p_column_linktext=>'#GOAL_ID#'
,p_column_link_attr=>'data-goal="#GOAL_ID#" title="Seguimiento Meta"'
,p_column_link_checksum_type=>'3'
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3673537215607284)
,p_db_column_name=>'CODE'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>unistr('C\00F3digo')
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3673696100607284)
,p_db_column_name=>'GOAL'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Meta'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3673717907607284)
,p_db_column_name=>'STATUS'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Estado'
,p_column_html_expression=>'<span class="spd-st spd-st--REV" title="#STATUS#"><span class="fa fa-check-square-o" aria-hidden="true"></span></span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3673814636607284)
,p_db_column_name=>'ENTITY_CODE'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Entidad'
,p_column_html_expression=>'<span title="#ENTITY_NAME#">#ENTITY_CODE#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3673995940607284)
,p_db_column_name=>'ENTITY_NAME'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Nombre de la entidad'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3674018699607284)
,p_db_column_name=>'DEV_PLAN_LEVEL_NAME'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Nivel Plan'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3674153269607284)
,p_db_column_name=>'GOAL_TYPE_LABEL'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Tipo'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3674269777607284)
,p_db_column_name=>'ACCUMULATION'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>unistr('Tipo de Acumulaci\00F3n')
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3674364207607284)
,p_db_column_name=>'BASE_VALUE'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Valor Base'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3674431999607284)
,p_db_column_name=>'GOAL_VALUE'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Valor Meta'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3674532737607284)
,p_db_column_name=>'PROGRAMMED_VALUE'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Programado Periodo'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FM999G999G999G990D00'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3674605378607284)
,p_db_column_name=>'ACHIEVED_VALUE'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Ejecutado Periodo'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FM999G999G999G990D00'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3674742725607284)
,p_db_column_name=>'APPROPRIATED'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Apropiado'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FM$999G999G999G999G990'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3674893466607284)
,p_db_column_name=>'COMMITMENTS'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Compromisos'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FM$999G999G999G999G990'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3674921379607284)
,p_db_column_name=>'OBLIGATIONS'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>'Obligaciones'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FM$999G999G999G999G990'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3675083872607284)
,p_db_column_name=>'PHYS'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>unistr('Avance F\00EDsico')
,p_column_html_expression=>'<div class="spd-gauge spd-gauge--sm" style="--p:#PHYS_P#;--c:#PHYS_COLOR#"><span>#PHYS_P#%</span></div>'
,p_column_type=>'NUMBER'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3675125161607284)
,p_db_column_name=>'FIN'
,p_display_order=>18
,p_column_identifier=>'R'
,p_column_label=>'Avance Financiero'
,p_column_html_expression=>'<div class="spd-gauge spd-gauge--sm" style="--p:#FIN_P#;--c:#FIN_COLOR#"><span>#FIN_P#%</span></div>'
,p_column_type=>'NUMBER'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3675247394607284)
,p_db_column_name=>'PHYS_P'
,p_display_order=>19
,p_column_identifier=>'S'
,p_column_label=>'PHYS_P'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3675375927607284)
,p_db_column_name=>'FIN_P'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>'FIN_P'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3675476220607284)
,p_db_column_name=>'PHYS_COLOR'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>'PHYS_COLOR'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3675572198607284)
,p_db_column_name=>'FIN_COLOR'
,p_display_order=>22
,p_column_identifier=>'V'
,p_column_label=>'FIN_COLOR'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3675653030607284)
,p_db_column_name=>'MONITORING_CONFIG_ID'
,p_display_order=>23
,p_column_identifier=>'W'
,p_column_label=>'MC'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(3675730420607284)
,p_db_column_name=>'SUBPERIOD'
,p_display_order=>24
,p_column_identifier=>'X'
,p_column_label=>'SUB'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(3675823267607284)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'SPD_1039'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>20
,p_report_columns=>'GOAL_ID:GOAL:STATUS:ENTITY_CODE:DEV_PLAN_LEVEL_NAME:GOAL_TYPE_LABEL:PROGRAMMED_VALUE:ACHIEVED_VALUE:APPROPRIATED:COMMITMENTS:OBLIGATIONS:PHYS:FIN'
,p_sort_column_1=>'CODE'
,p_sort_direction_1=>'ASC'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(3676193803607285)
,p_branch_name=>unistr('Volver a la p\00E1gina')
,p_branch_action=>'f?p=&APP_ID.:1039:&APP_SESSION.::&DEBUG.:::'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3672753618607284)
,p_name=>'P1039_MC'
,p_item_sequence=>2040
,p_item_plug_id=>wwv_flow_imp.id(3672620792607284)
,p_prompt=>'Seguimiento'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''('' || mc.PERIOD || ''-'' || mc.SUBPERIOD || '') '' || pd.NOMBRE as d, mc.ID as r',
'  from SPD_MONITORING_CONFIG mc',
'  left join PLAN_DESARROLLO pd on pd.NIT_COMPANIA = mc.NIT_COMPANIA and pd.PLAN = mc.PLAN',
' where mc.NIT_COMPANIA = :G_NIT_COMPANIA and nvl(mc.USED_FOR, ''DEVELOPMENT_PLANS'') = ''DEVELOPMENT_PLANS''',
' order by case when mc.IS_ACTIVE = ''S'' then 0 else 1 end, mc.PERIOD desc, mc.SUBPERIOD desc'))
,p_cSize=>30
,p_cHeight=>1
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'SUBMIT')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3672801177607284)
,p_name=>'P1039_SPENT'
,p_item_sequence=>2050
,p_item_plug_id=>wwv_flow_imp.id(3672620792607284)
,p_prompt=>'Avance Financiero'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select case d.DOC when ''COMMITMENT'' then ''Compromisos'' when ''OBLIGATION'' then ''Obligaciones'' else ''Pagos'' end as d, d.DOC as r',
'  from SPD_MONITORING_CONFIG mc, json_table(mc.SPENT_DOCS, ''$[*]'' columns (POS for ordinality, DOC varchar2(20) path ''$'')) d',
' where mc.ID = :P1039_MC order by d.POS'))
,p_cSize=>30
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'SUBMIT')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3672901528607284)
,p_name=>'P1039_DATE_OK'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(3672620792607284)
,p_prompt=>'DATE_OK'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3673006364607284)
,p_name=>'P1039_TOTAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(3672620792607284)
,p_prompt=>'TOTAL'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3673142705607284)
,p_name=>'P1039_SUBPERIOD'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(3672620792607284)
,p_prompt=>'SUBPERIOD'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3676029159607285)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cambiar documento'
,p_process_sql_clob=>'null;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P1039_SPENT'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>3676029159607285
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3699583142607387)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SPD Global: seguimiento elegido'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
'  select ID into :P1039_MC from SPD_MONITORING_CONFIG',
'   where ID = :G_SEGUIMIENTO and NIT_COMPANIA = :G_NIT_COMPANIA and nvl(USED_FOR, ''DEVELOPMENT_PLANS'') = ''DEVELOPMENT_PLANS'';',
'exception when no_data_found or value_error or invalid_number then null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>3699583142607387
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3675931340607284)
,p_process_sequence=>60
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cargar seguimiento'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin ',
'declare',
'  mc SPD_MONITORING_CONFIG%rowtype;',
'  function ts(v varchar2) return timestamp with time zone is',
'  begin',
'    return from_tz(to_timestamp(substr(v, 1, 23), ''YYYY-MM-DD"T"HH24:MI:SS.FF3''), ''UTC'');',
'  end;',
'begin',
'  if :P1039_MC is null then',
'    select max(ID) keep (dense_rank first order by case when IS_ACTIVE = ''S'' then 0 else 1 end, PERIOD desc, SUBPERIOD desc)',
'      into :P1039_MC from SPD_MONITORING_CONFIG',
'     where NIT_COMPANIA = :G_NIT_COMPANIA and nvl(USED_FOR, ''DEVELOPMENT_PLANS'') = ''DEVELOPMENT_PLANS'';',
'  end if;',
'  begin',
'    select * into mc from SPD_MONITORING_CONFIG where ID = :P1039_MC and NIT_COMPANIA = :G_NIT_COMPANIA;',
'  exception when no_data_found then :P1039_MC := null; :P1039_TOTAL := 0; return;',
'  end;',
'  :P1039_SUBPERIOD := mc.SUBPERIOD;',
'  :P1039_DATE_OK := ''N'';',
'  begin',
'    if systimestamp between ts(json_value(mc.DATES_CONFIG, ''$.reviewing[0]'')) and ts(json_value(mc.DATES_CONFIG, ''$.reviewing[1]'')) then',
'      :P1039_DATE_OK := ''S'';',
'    end if;',
'  exception when others then null;',
'  end;',
'  select count(*) into :P1039_TOTAL from V_SPD_GOAL_MONITORING m',
'   where m.NIT_COMPANIA = :G_NIT_COMPANIA and m.MONITORING_CONFIG_ID = mc.ID and m.GOAL_GROUP = ''PROYECTOS'' and m.RECORD_STATUS in (''REVIEWED'', ''APPROVED'');',
'end;',
'begin',
'  -- documento del avance financiero: el de la ruta, si es del seguimiento, o el primero configurado',
'  select coalesce(max(case when d.DOC = :P1039_SPENT then d.DOC end), max(d.DOC) keep (dense_rank first order by d.POS), ''COMMITMENT'')',
'    into :P1039_SPENT',
'    from SPD_MONITORING_CONFIG mc, json_table(mc.SPENT_DOCS, ''$[*]'' columns (POS for ordinality, DOC varchar2(20) path ''$'')) d',
'   where mc.ID = :P1039_MC;',
'end;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>3675931340607284
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3699683712607387)
,p_process_sequence=>9999
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SPD Global: guardar seguimiento'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
'  if :P1039_MC is not null then :G_SEGUIMIENTO := :P1039_MC; end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>3699683712607387
);
wwv_flow_imp.component_end;
end;
/
