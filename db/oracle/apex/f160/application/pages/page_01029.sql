prompt --application/pages/page_01029
begin
--   Manifest
--     PAGE: 01029
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
 p_id=>1029
,p_name=>unistr('SPD_Planes de acci\00F3n')
,p_alias=>'SPD_PLANES_ACCION'
,p_step_title=>unistr('Planes de Acci\00F3n')
,p_autocomplete_on_off=>'OFF'
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
 p_id=>wwv_flow_imp.id(5110102900000010)
,p_plug_name=>'Plan de desarrollo'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>5
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40153637165163240)
,p_plug_name=>unistr('Planes de Acci\00F3n')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39482454929162902)
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * from (',
'select g.ID, l.CODE || '' '' || l.NAME as NIVEL_PLAN, g.CODE || '' - '' || g.NAME as PLAN_ACCION, g.PROJECT_CODE, e.CODIGO_ENT_PRY || '' - '' || e.NOMBRE_ENT_PRY as ENTIDAD, g.NIT_COMPANIA from SPD_GOAL g join ENTIDADES_PRY e on e.ID = g.ENTITY_ID left joi'
||'n SPD_DEV_PLAN_LEVEL l on l.ID = g.DEV_PLAN_LEVEL_ID where g.GOAL_TYPE = ''ACTION_PLAN'' and g.PLAN = :P1029_PLAN',
') where NIT_COMPANIA = :G_NIT_COMPANIA'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P1029_PLAN'
,p_prn_page_header=>unistr('Planes de Acci\00F3n')
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(40153795943163240)
,p_name=>unistr('Planes de Acci\00F3n')
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'ADMIN'
,p_internal_uid=>38512781243549838
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40154505970163240)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40154832669163240)
,p_db_column_name=>'NIVEL_PLAN'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Nivel Plan'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40155259738163240)
,p_db_column_name=>'PLAN_ACCION'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>unistr('Plan de Acci\00F3n')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40155638742163241)
,p_db_column_name=>'PROJECT_CODE'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Proyecto'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40156060209163241)
,p_db_column_name=>'ENTIDAD'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Entidad'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(40156468993163241)
,p_db_column_name=>'NIT_COMPANIA'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>unistr('Compa\00F1\00EDa')
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_imp.id(39886983472163105)
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(40796855501169215)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'391559'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ID:NIVEL_PLAN:PLAN_ACCION:PROJECT_CODE:ENTIDAD:NIT_COMPANIA'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40156886122163241)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(40153637165163240)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:1029:&APP_SESSION.::&DEBUG.:RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(5110102900000011)
,p_name=>'P1029_PLAN'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(5110102900000010)
,p_prompt=>'Plan de desarrollo'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SPD - PLANES DE DESARROLLO'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'SUBMIT')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(5110102900000012)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Plan por defecto'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  -- el elegido en la sesion (G_PLAN), el activo de la compania o el mas reciente',
'  :P1029_PLAN := nvl(:P1029_PLAN, :G_PLAN);',
'  if :P1029_PLAN is null then',
'    select max(PLAN) keep (dense_rank first order by case when SPD_ACTIVO = ''S'' then 0 else 1 end, PLAN desc)',
'      into :P1029_PLAN from PLAN_DESARROLLO where NIT_COMPANIA = :G_NIT_COMPANIA;',
'  end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>5110102900000012
);
wwv_flow_imp.component_end;
end;
/
