prompt --application/shared_components/user_interface/theme_style
begin
--   Manifest
--     THEME STYLE: 154
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>154
,p_default_id_offset=>292021538769791282
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(644452181595564788)
,p_theme_id=>42
,p_name=>'Vita (SIIF_WEB)'
,p_is_public=>true
,p_is_accessible=>true
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Vita.less'
,p_theme_roller_config=>'{"classes":[],"vars":{"@g_Nav_Style":"light","@Nav-Exp":"300px"},"customCSS":":root {\n    --ut-hero-region-icon-container-size: 128px;\n    --ut-login-logo-size: 128px;\n}\n\n.t-Login-logo, .t-HeroRegion-icon {\n    background: rgba(255, 255, 255, 0'
||'.5);\n}\n\n.t-TreeNav .a-TreeView-node--topLevel .a-TreeView-row.is-current, .t-TreeNav .a-TreeView-node--topLevel .a-TreeView-row.is-selected, .t-TreeNav .a-TreeView-node--topLevel .a-TreeView-row.is-current--top.is-selected {\n \n    background-col'
||'or: var(--u-color-1) ;\n}","useCustomLess":"N"}'
,p_theme_roller_output_file_url=>'#THEME_DB_FILES#60454776860008683.css'
,p_theme_roller_read_only=>false
,p_updated_on=>wwv_flow_imp.dz('20260520160703Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
