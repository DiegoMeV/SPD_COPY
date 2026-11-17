prompt --application/shared_components/user_interface/themes
begin
--   Manifest
--     THEME: 160
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>4267703994621115
,p_default_application_id=>160
,p_default_id_offset=>1641014699613402
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_theme(
 p_id=>wwv_flow_imp.id(39689735231163015)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_version_identifier=>'24.1'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_current_theme_style_id=>wwv_flow_imp.id(646093196295178190)
,p_default_page_template=>wwv_flow_imp.id(39450937337162896)
,p_default_dialog_template=>wwv_flow_imp.id(39430577226162891)
,p_error_template=>wwv_flow_imp.id(39432065530162891)
,p_printer_friendly_template=>wwv_flow_imp.id(39450937337162896)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_imp.id(39432065530162891)
,p_default_button_template=>wwv_flow_imp.id(39601281081162925)
,p_default_region_template=>wwv_flow_imp.id(39534998195162909)
,p_default_chart_template=>wwv_flow_imp.id(39534998195162909)
,p_default_form_template=>wwv_flow_imp.id(39534998195162909)
,p_default_reportr_template=>wwv_flow_imp.id(39534998195162909)
,p_default_tabform_template=>wwv_flow_imp.id(39534998195162909)
,p_default_wizard_template=>wwv_flow_imp.id(39534998195162909)
,p_default_menur_template=>wwv_flow_imp.id(39495922021162904)
,p_default_listr_template=>wwv_flow_imp.id(39534998195162909)
,p_default_irr_template=>wwv_flow_imp.id(39482454929162902)
,p_default_report_template=>wwv_flow_imp.id(39562152770162914)
,p_default_label_template=>wwv_flow_imp.id(39596958012162922)
,p_default_menu_template=>wwv_flow_imp.id(39601334790162925)
,p_default_calendar_template=>wwv_flow_imp.id(39601474648162926)
,p_default_list_template=>wwv_flow_imp.id(39581156946162918)
,p_default_nav_list_template=>wwv_flow_imp.id(39592943422162921)
,p_default_top_nav_list_temp=>wwv_flow_imp.id(39592943422162921)
,p_default_side_nav_list_temp=>wwv_flow_imp.id(39587606269162920)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_imp.id(39487096731162903)
,p_default_dialogr_template=>wwv_flow_imp.id(39544800752162911)
,p_default_option_label=>wwv_flow_imp.id(39596958012162922)
,p_default_required_label=>wwv_flow_imp.id(39597068959162922)
,p_default_navbar_list_template=>wwv_flow_imp.id(39587165875162919)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#APEX_FILES#themes/theme_42/24.1/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_FILES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_FILES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
wwv_flow_imp.component_end;
end;
/
