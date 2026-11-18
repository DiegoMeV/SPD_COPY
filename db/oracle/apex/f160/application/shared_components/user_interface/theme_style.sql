prompt --application/shared_components/user_interface/theme_style
begin
--   Manifest
--     THEME STYLE: 160
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>4267703994621115
,p_default_application_id=>160
,p_default_id_offset=>1641014699613402
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(39688792071163012)
,p_theme_id=>42
,p_name=>'Vita - Red'
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Vita-Red.less'
,p_theme_roller_output_file_url=>'#THEME_FILES#css/Vita-Red#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>1938457712423918173
);
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(39688932757163012)
,p_theme_id=>42
,p_name=>'Redwood Light'
,p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APEX_FILES#libraries/oracle-fonts/oraclesans-apex#MIN#.css?v=#APEX_VERSION#',
'#THEME_FILES#css/Redwood#MIN#.css?v=#APEX_VERSION#'))
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Redwood-Theme.less'
,p_theme_roller_output_file_url=>'#THEME_FILES#css/Redwood-Theme#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>2596426436825065489
);
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(39689191272163012)
,p_theme_id=>42
,p_name=>'Vita'
,p_is_public=>true
,p_is_accessible=>true
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Vita.less'
,p_theme_roller_output_file_url=>'#THEME_FILES#css/Vita#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>2719875314571594493
);
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(39689383438163012)
,p_theme_id=>42
,p_name=>'Vita - Slate'
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Vita-Slate.less'
,p_theme_roller_output_file_url=>'#THEME_FILES#css/Vita-Slate#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3291983347983194966
);
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(39689600070163012)
,p_theme_id=>42
,p_name=>'Vita - Dark'
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Vita-Dark.less'
,p_theme_roller_output_file_url=>'#THEME_FILES#css/Vita-Dark#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3543348412015319650
);
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(646093196295178190)
,p_theme_id=>42
,p_name=>'Vita (SIIF_WEB)'
,p_is_public=>true
,p_is_accessible=>true
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Vita.less'
,p_theme_roller_config=>'{"classes":[],"vars":{"@g_Nav_Style":"dark","@Nav-Exp":"300px","@g_Accent-BG":"#0e529a","@g_Header-BG":"#0e529a","@g_Header-FG":"#ffffff","@g_Nav-BG":"#122135","@g_Nav-FG":"#ededed","@g_Nav-Active-BG":"#122135","@g_Nav-Active-FG":"#fafafa"},"customCS'
||'S":":root {\n    --ut-hero-region-icon-container-size: 128px;\n    --ut-login-logo-size: 128px;\n}\n\n.t-Login-logo, .t-HeroRegion-icon {\n    background: rgb(255, 255, 255);\n}\n\n.t-TreeNav .a-TreeView-node--topLevel .a-TreeView-row.is-current, .t-'
||'TreeNav .a-TreeView-node--topLevel .a-TreeView-row.is-selected, .t-TreeNav .a-TreeView-node--topLevel .a-TreeView-row.is-current--top.is-selected {\n \n    background-color: var(--u-color-1) ;\n}","useCustomLess":"N"}'
,p_theme_roller_output_file_url=>'#THEME_DB_FILES#60454776860008683.css'
,p_theme_roller_read_only=>false
);
wwv_flow_imp.component_end;
end;
/
