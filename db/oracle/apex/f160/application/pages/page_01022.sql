prompt --application/pages/page_01022
begin
--   Manifest
--     PAGE: 01022
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
 p_id=>1022
,p_name=>unistr('SPD_Componentes por pol\00EDtica')
,p_alias=>'SPD_COMPONENTES_POR_POLITICA'
,p_step_title=>unistr('Componentes por pol\00EDtica')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>You can insert, update, and delete data directly within this interactive grid.<br>',
'  Insert a new row by clicking the Add Row button.<br>',
'  Double click into a cell, or click the <strong>Edit</strong> button to update data values, similar to editing data in a spreadsheet.</p>',
'',
'<p>Use the Row Actions menu ( <span class="fa fa-bars" aria-hidden="true"></span> ) at the top of the report to duplicate, delete, refresh or revert selected rows.<br> ',
'  Use the Row Actions menu on individual rows to also access the single row view or add a new row.</p>',
'',
'<p>To find data enter a search term into the search dialog, or click on the column headings to limit the records returned.</p>',
'',
'<p>You can perform numerous functions by clicking the <strong>Actions</strong> button. This includes selecting the columns that are displayed / hidden and their display sequence, plus numerous data and format functions.  You can also define an additi'
||'onal view of the data using the chart option.</p>',
'',
'<p>If you want to save your customizations select report, or click download to unload the data.<p>',
'',
'<p>For additional information click Help at the bottom of the Actions menu.</p> ',
'',
'<p>Click the <strong>Reset</strong> button to reset the interactive grid back to the default settings.</p>'))
,p_page_component_map=>'21'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40103033042163219)
,p_plug_name=>unistr('Componentes por pol\00EDtica')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39482454929162902)
,p_plug_display_sequence=>20
,p_query_type=>'TABLE'
,p_query_table=>'SPD_PUBLIC_POLITIC_TO_COMP'
,p_query_where=>'PUBLIC_POLITIC_ID in (select ID from SPD_PUBLIC_POLITIC where NIT_COMPANIA = :G_NIT_COMPANIA)'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_prn_page_header=>unistr('Componentes por pol\00EDtica')
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40104413911163220)
,p_name=>'APEX$ROW_SELECTOR'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'enable_multi_select', 'Y',
  'hide_control', 'N',
  'show_select_all', 'Y')).to_clob
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40104871543163220)
,p_name=>'APEX$ROW_ACTION'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_label=>'Actions'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40105891956163220)
,p_name=>'PUBLIC_POLITIC_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PUBLIC_POLITIC_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>unistr('Pol\00EDtica p\00FAblica')
,p_label=>unistr('Pol\00EDtica p\00FAblica')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'NONE')).to_clob
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(39934259545163120)
,p_enable_filter=>false
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(40106873241163221)
,p_name=>'COMPONENT_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMPONENT_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Componente'
,p_label=>'Componente'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(40108214019163221)
,p_enable_filter=>false
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(40103611589163219)
,p_internal_uid=>38462596889549817
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>false
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>false
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_add_button_label=>'Nuevo'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(40103915743163220)
,p_interactive_grid_id=>wwv_flow_imp.id(40103611589163219)
,p_static_id=>'384630'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(40104170353163220)
,p_report_id=>wwv_flow_imp.id(40103915743163220)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(40105243113163220)
,p_view_id=>wwv_flow_imp.id(40104170353163220)
,p_display_seq=>0
,p_column_id=>wwv_flow_imp.id(40104871543163220)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(40106233687163220)
,p_view_id=>wwv_flow_imp.id(40104170353163220)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(40105891956163220)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(40107234063163221)
,p_view_id=>wwv_flow_imp.id(40104170353163220)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(40106873241163221)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40108924705163221)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(40103033042163219)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>unistr('Componentes por pol\00EDtica - Save Interactive Grid Data')
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>38467910005549819
);
wwv_flow_imp.component_end;
end;
/
