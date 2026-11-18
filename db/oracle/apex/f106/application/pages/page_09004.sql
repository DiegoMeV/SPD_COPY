prompt --application/pages/page_09004
begin
--   Manifest
--     PAGE: 09004
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
 p_id=>9004
,p_name=>'page_inactividad'
,p_alias=>'PAGE-INACTIVIDAD'
,p_step_title=>'page_inactividad'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>2979075366320325194
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_page_component_map=>'17'
,p_created_on=>wwv_flow_imp.dz('20261118120000Z')
,p_last_updated_on=>wwv_flow_imp.dz('20261118120000Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_last_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(371161613884849001)
,p_plug_name=>'Inactividad'
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
'.pe-btn{display:inline-flex;align-items:center;gap:8px;padding:9px 22px;border-radius:6px;font-size:14px;text-decoration:none;cursor:pointer;border:1px solid #0e529a;transition:.2s}',
'.pe-btn-primary{background:#0e529a;color:#fff!important}',
'.pe-btn-primary:hover{background:#0a3f77}',
'.pe-bar{width:200px;height:5px;border-radius:3px;background:#e1e4e8;overflow:hidden}',
'.pe-bar span{display:block;width:100%;height:100%;background:repeating-linear-gradient(-45deg,#0e529a 0 8px,#5b8fc7 8px 16px);background-size:200% 100%;animation:pe-move 2s linear infinite}',
'@keyframes pe-move{from{background-position:0 0}to{background-position:-45px 0}}',
'@keyframes pe-tick{from{transform:rotate(0)}to{transform:rotate(360deg)}}',
'.pe-hand{transform-origin:75px 65px;animation:pe-tick 6s linear infinite}',
'</style>',
'<div class="pe-wrap">',
unistr('  <h1 class="pe-page-title">Sesi\00F3n Inactiva</h1>'),
'  <div class="pe-circle">',
'    <svg width="150" height="130" viewBox="0 0 150 130" aria-hidden="true">',
'      <circle cx="75" cy="65" r="56" fill="#fff" stroke="#0e529a" stroke-width="8"/>',
'      <line x1="75" y1="65" x2="75" y2="35" stroke="#122135" stroke-width="7" stroke-linecap="round"/>',
'      <line class="pe-hand" x1="75" y1="65" x2="100" y2="65" stroke="#0e529a" stroke-width="5" stroke-linecap="round"/>',
'      <circle cx="75" cy="65" r="6" fill="#122135"/>',
'    </svg>',
'  </div>',
'  <h2 class="pe-title">&P9004_TITULO!HTML.</h2>',
'  <p class="pe-msg">&P9004_MENSAJE!HTML.</p>',
'  <div class="pe-actions">',
'    <button type="button" class="pe-btn pe-btn-primary" onclick="peRecargar();">',
'      <span class="fa fa-refresh" aria-hidden="true"></span> Recargar',
'    </button>',
'  </div>',
'  <div class="pe-bar"><span></span></div>',
'</div>',
'<script>',
'/* La pagina va embebida: se recarga la ventana contenedora, que vuelve a pedir su propia URL. */',
'function peRecargar() {',
'  try {',
'    window.top.location.reload();',
'  } catch (e) {',
'    /* Contenedor de otro dominio: el navegador bloquea la recarga, se le pide al host por postMessage. */',
'    window.parent.postMessage({ type: ''SIIF_SESION_INACTIVA'', action: ''reload'' }, ''*'');',
'  }',
'}',
'</script>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261118120000Z')
,p_updated_on=>wwv_flow_imp.dz('20261118120000Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(371161613884849002)
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
,p_created_on=>wwv_flow_imp.dz('20261118120000Z')
,p_updated_on=>wwv_flow_imp.dz('20261118120000Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(371161613884849003)
,p_name=>'P9004_TITULO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(371161613884849001)
,p_item_default=>unistr('Tu sesi\00F3n ha expirado')
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261118120000Z')
,p_updated_on=>wwv_flow_imp.dz('20261118120000Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(371161613884849004)
,p_name=>'P9004_MENSAJE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(371161613884849001)
,p_item_default=>unistr('Por seguridad, cerramos tu sesi\00F3n despu\00E9s de un periodo de inactividad. Recarga la p\00E1gina para volver a ingresar.')
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261118120000Z')
,p_updated_on=>wwv_flow_imp.dz('20261118120000Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
