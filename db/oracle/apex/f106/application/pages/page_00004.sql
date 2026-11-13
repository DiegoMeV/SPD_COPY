prompt --application/pages/page_00004
begin
--   Manifest
--     PAGE: 00004
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>106
,p_default_id_offset=>30000697869459781
,p_default_owner=>'SIIF'
);
wwv_flow_imp_page.create_page(
 p_id=>4
,p_name=>'page_error'
,p_alias=>'PAGE-ERROR'
,p_step_title=>'page_error'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>2979075366320325194
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'17'
,p_created_on=>wwv_flow_imp.dz('20261111150003Z')
,p_last_updated_on=>wwv_flow_imp.dz('20261111154737Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_last_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(371161613884848032)
,p_plug_name=>'Error'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<style>',
'.pe-wrap{display:flex;flex-direction:column;align-items:center;text-align:center;padding:40px 16px;font-family:inherit}',
'.pe-page-title{font-size:32px;font-weight:500;color:#1f1f1f;margin:0 0 70px}',
'.pe-circle{width:228px;height:228px;border-radius:50%;background:#f2f4f8;display:flex;align-items:center;justify-content:center;margin-bottom:80px}',
'.pe-title{font-size:32px;font-weight:700;color:#262626;margin:0 0 20px}',
'.pe-msg{font-size:17px;color:#5a5a5a;margin:0 0 30px;max-width:620px;line-height:1.5}',
'.pe-actions{display:flex;gap:12px;justify-content:center;flex-wrap:wrap;margin-bottom:24px}',
'.pe-btn{display:inline-block;padding:9px 22px;border-radius:6px;font-size:14px;text-decoration:none;cursor:pointer;border:1px solid #c9302c;transition:.2s}',
'.pe-btn-primary{background:#d9534f;color:#fff!important}',
'.pe-btn-primary:hover{background:#c9302c}',
'.pe-btn-sec{background:#fff;color:#c9302c!important}',
'.pe-btn-sec:hover{background:#fdf2f2}',
'.pe-bar{width:200px;height:5px;border-radius:3px;background:#e1e4e8;overflow:hidden}',
'.pe-bar span{display:block;width:100%;height:100%;background:repeating-linear-gradient(-45deg,#c9302c 0 8px,#e8716d 8px 16px);background-size:200% 100%;animation:pe-move 2s linear infinite}',
'@keyframes pe-move{from{background-position:0 0}to{background-position:-45px 0}}',
'@keyframes pe-shake{0%,90%,100%{transform:rotate(0)}93%{transform:rotate(-6deg)}96%{transform:rotate(6deg)}}',
'.pe-icon{animation:pe-shake 3s ease-in-out infinite}',
'</style>',
'<div class="pe-wrap">',
unistr('  <h1 class="pe-page-title">P\00E1gina de Error</h1>'),
'  <div class="pe-circle">',
'    <svg class="pe-icon" width="150" height="130" viewBox="0 0 150 130" aria-hidden="true">',
'      <path d="M75 8 L142 122 H8 Z" fill="#e5534b" stroke="#c9302c" stroke-width="6" stroke-linejoin="round"/>',
'      <rect x="68" y="42" width="14" height="46" rx="7" fill="#fff"/>',
'      <circle cx="75" cy="104" r="8" fill="#fff"/>',
'    </svg>',
'  </div>',
'  <h2 class="pe-title">&P4_TITULO!HTML.</h2>',
'  <p class="pe-msg">&P4_MENSAJE!HTML.</p>',
'  <div class="pe-bar"><span></span></div>',
'</div>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261111150013Z')
,p_updated_on=>wwv_flow_imp.dz('20261111154737Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(371161781776848033)
,p_plug_name=>'OCULTAR_NAV_LOCAL'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>20
,p_plug_display_point=>'AFTER_LOGO'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<style>.t-Header-branding{display:none}</style>',
'<script>',
'document.addEventListener(''DOMContentLoaded'', function () {',
'  document.querySelectorAll(''.t-Header-branding'')',
'    .forEach(function (el) { el.remove(); });',
'});',
'</script>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261111150446Z')
,p_updated_on=>wwv_flow_imp.dz('20261111150458Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(371161869761848034)
,p_name=>'P4_TITULO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(371161613884848032)
,p_item_default=>'Ha ocurrido un error'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261111154705Z')
,p_updated_on=>wwv_flow_imp.dz('20261111154705Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(371161938550848035)
,p_name=>'P4_MENSAJE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(371161613884848032)
,p_item_default=>'No pudimos completar tu solicitud. Por favor, intenta nuevamente o contacta al administrador del sistema.'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261111154705Z')
,p_updated_on=>wwv_flow_imp.dz('20261111154705Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
