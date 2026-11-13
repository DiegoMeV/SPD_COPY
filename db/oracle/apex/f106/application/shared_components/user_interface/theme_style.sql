prompt --application/shared_components/user_interface/theme_style
begin
--   Manifest
--     THEME STYLE: 106
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>106
,p_default_id_offset=>30000697869459781
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(56431184862137152)
,p_theme_id=>42
,p_name=>'Vita (SIIF_WEB)'
,p_is_public=>true
,p_is_accessible=>true
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Vita.less'
,p_theme_roller_config=>'{"classes":[],"vars":{"@g_Nav_Style":"dark","@Nav-Exp":"300px","@g_Accent-BG":"#0e529a","@g_Header-BG":"#0e529a","@g_Header-FG":"#ffffff","@g_Nav-BG":"#122135","@g_Nav-FG":"#ededed","@g_Nav-Active-BG":"#122135","@g_Nav-Active-FG":"#fafafa"},"customCS'
||'S":":root {\n    --ut-hero-region-icon-container-size: 128px;\n    --ut-login-logo-size: 128px;\n}\n\n.t-Login-logo, .t-HeroRegion-icon {\n    background: rgb(255, 255, 255);\n}\n\n.t-TreeNav .a-TreeView-node--topLevel .a-TreeView-row.is-current, .t-'
||'TreeNav .a-TreeView-node--topLevel .a-TreeView-row.is-selected, .t-TreeNav .a-TreeView-node--topLevel .a-TreeView-row.is-current--top.is-selected {\n \n    background-color: var(--u-color-1) ;\n}","useCustomLess":"N"}'
,p_theme_roller_output_file_url=>'#THEME_DB_FILES#56431184862137152.css'
,p_theme_roller_read_only=>false
,p_updated_on=>wwv_flow_imp.dz('20260930213720Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(325134638088832294)
,p_theme_id=>42
,p_name=>'Vita (Tema)'
,p_is_public=>true
,p_is_accessible=>true
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Vita.less'
,p_theme_roller_config=>'{"classes":[],"vars":{"@g_Nav_Style":"dark","@Nav-Exp":"300px","@g_Form-BorderRadius":"2px","@g_Nav-BG":"#132238","@g_Nav-FG":"#ebecee","@g_Nav-Icon":"#ebecee","@g_Nav-Icon-Active":"#ebecee","@g_Nav-Active-BG":"#171a1d","@g_Nav-Active-FG":"#ebecee","'
||'@g_Nav-Accent-BG":"#056ac8","@g_Nav-Accent-FG":"#ebecee","@g_Nav-Badge-BG":"#056ac8","@g_Nav-Badge-FG":"#ebecee","@g_NavBarMenu-BG":"#ebecee","@g_NavBarMenu-FG":"#262626","@g_NavBarMenu-Active-BG":"#056ac8","@g_NavBarMenu-Active-FG":"#ebecee"},"custo'
||'mCSS":":root {\n    --ut-hero-region-icon-container-size: 128px;\n    --ut-login-logo-size: 128px;\n}\n\n.t-Login-logo, .t-HeroRegion-icon {\n    background: rgba(255, 255, 255, 0.5);\n}\n\n.t-TreeNav .a-TreeView-node--topLevel .a-TreeView-row.is-cur'
||'rent, .t-TreeNav .a-TreeView-node--topLevel .a-TreeView-row.is-selected, .t-TreeNav .a-TreeView-node--topLevel .a-TreeView-row.is-current--top.is-selected {\n \n    background-color: var(--u-color-1) ;\n}","useCustomLess":"N"}'
,p_theme_roller_output_file_url=>'#THEME_DB_FILES#325134638088832294.css'
,p_theme_roller_read_only=>false
,p_created_on=>wwv_flow_imp.dz('20260929161336Z')
,p_updated_on=>wwv_flow_imp.dz('20260930164013Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
