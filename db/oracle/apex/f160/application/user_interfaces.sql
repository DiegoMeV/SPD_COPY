prompt --application/user_interfaces
begin
--   Manifest
--     USER INTERFACES: 160
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>4267703994621115
,p_default_application_id=>160
,p_default_id_offset=>1641014699613402
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_user_interface(
 p_id=>wwv_flow_imp.id(160)
,p_theme_id=>42
,p_home_url=>'f?p=106:1:&APP_SESSION.::&DEBUG.:::'
,p_login_url=>'f?p=106:LOGIN:&APP_SESSION.::&DEBUG.:::'
,p_theme_style_by_user_pref=>false
,p_built_with_love=>false
,p_auto_dismiss_success_msg=>true
,p_global_page_id=>0
,p_navigation_list_id=>wwv_flow_imp.id(646365417583501157)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>wwv_flow_imp.id(39587606269162920)
,p_nav_list_template_options=>'js-addActions:js-navCollapsed--hidden:t-TreeNav--styleB'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_imp.id(645793702399681144)
,p_nav_bar_list_template_id=>wwv_flow_imp.id(39587165875162919)
,p_nav_bar_template_options=>'#DEFAULT#'
);
wwv_flow_imp.component_end;
end;
/
