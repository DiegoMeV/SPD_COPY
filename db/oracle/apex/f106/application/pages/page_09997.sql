prompt --application/pages/page_09997
begin
--   Manifest
--     PAGE: 09997
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
 p_id=>9997
,p_name=>'Activar Verificacion en Dos Pasos'
,p_alias=>'ACTIVAR-VERIFICACION-EN-DOS-PASOS'
,p_step_title=>unistr('Verificaci\00F3n en Dos Pasos')
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'const currentYear = new Date().getFullYear();',
'',
unistr('// Actualizar el contenido de la etiqueta span con el a\00F1o actual'),
'document.getElementById(''current-year'').textContent = currentYear;'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* ===== Fondo diagonal ===== */',
'body {',
'    background-color: #FFFFFF;',
'}',
'',
'.t-Body,',
'.t-Body-main,',
'.t-Body-content,',
'.t-Body-contentInner {',
'    background: transparent !important;',
'    padding: 0 !important;',
'    margin: 0 !important;',
'    min-height: 0 !important;',
'}',
'',
'body::before {',
'    content: "";',
'    position: fixed;',
'    top: 0;',
'    bottom: 0;',
'    right: 0;',
'    width: 55%;',
'    z-index: -1;',
'    pointer-events: none;',
'    clip-path: polygon(10% 0, 100% 0, 100% 100%, 0 100%);',
'    background:',
'        radial-gradient(rgba(255,255,255,.10) 1.2px, transparent 1.2px) 0 0 / 22px 22px,',
'        linear-gradient(150deg, #12203d 0%, #1d5aa8 120%);',
'}',
'',
'/* ===== Contenedores ===== */',
'.login-container .container {',
'    max-width: none !important;',
'    width: 100%;',
'    padding: 0 !important;',
'}',
'',
'.login-container .row {',
'    margin: 0 !important;',
'}',
'',
'.login-container .col {',
'    padding: 0 !important;',
'}',
'',
'.card-login {',
'    background: transparent;',
'    border-radius: 0;',
'}',
'',
'/* ===== Panel izquierdo (blanco) ===== */',
'.left-card {',
'    box-sizing: border-box;',
'    display: flex;',
'    flex-direction: column;',
'    align-items: center;',
'    justify-content: center;',
'    min-height: 100%;',
'}',
'',
'.left-card > .container {',
'    order: -1;',
'    width: auto;',
'}',
'',
'#P9997_LOGO_IMAGE_LEFT_CONTAINER .t-Form-labelContainer,',
'#P9997_LOGO_IMAGE_LEFT_DEFAULT_CONTAINER .t-Form-labelContainer {',
'    display: none;',
'}',
'',
'#P9997_LOGO_IMAGE_LEFT_CONTAINER img,',
'#P9997_LOGO_IMAGE_LEFT_DEFAULT_CONTAINER img {',
'    max-width: 240px;',
'    height: auto;',
'    display: block;',
'}',
'',
'.intro {',
'    max-width: 64%;',
'    color: #1a1f2b;',
'}',
'',
'.intro-kicker {',
'    display: inline-block;',
'    font-size: 12.5px;',
'    font-weight: 700;',
'    letter-spacing: 1px;',
'    text-transform: uppercase;',
'    color: #f39a2b;',
'}',
'',
'.intro h2 {',
'    font-size: 36px;',
'    line-height: 1.15;',
'    font-weight: 800;',
'    color: #123f80;',
'}',
'',
'.intro p {',
'    color: #5f6b7d;',
'    font-size: 15px;',
'}',
'',
'/* ===== Panel derecho (azul) ===== */',
'.right-card {',
'    box-sizing: border-box;',
'    display: flex;',
'    flex-direction: column;',
'    align-items: center;',
'    justify-content: center;',
'    min-height: 100%;',
'    background: transparent;',
'    border-radius: 0;',
'}',
'',
'.login-container .right-card > .container,',
'.right-card > * {',
'    width: 100%;',
'    max-width: 400px !important;',
'}',
'',
'#P9997_LOGO_IMAGE_CONTAINER .t-Form-labelContainer {',
'    display: none;',
'}',
'',
'#P9997_LOGO_IMAGE_CONTAINER img {',
'    max-width: 220px;',
'    height: auto;',
'    display: block;',
'    filter: brightness(0) invert(1);',
'}',
'',
'#welcome-text {',
'    font-size: 34px;',
'    font-weight: 800;',
'    color: #FFFFFF;',
'    line-height: 1.15;',
'}',
'',
'.welcome-sub {',
'    color: #c9d6ec;',
'}',
'',
'#P9997_REMEMBER_CONTAINER label {',
'    color: #FFFFFF;',
'}',
'',
'/* Derechos */',
'#derechos-container {',
'    color: #c9d6ec;',
'    font-size: 12.5px;',
'    display: flex;',
'    width: 100%;',
'    justify-content: center;',
'}',
'',
'/* ===== Sin scroll en computador ===== */',
'@media (min-width: 992px) and (min-height: 640px) {',
'    html,',
'    body {',
'        height: 100%;',
'        overflow: hidden;',
'    }',
'',
'    .left-card,',
'    .right-card {',
'        height: 100%;',
'        min-height: 0;',
'    }',
'}',
'',
'/* Pantallas de poca altura (por ejemplo 1920x1080 con zoom 125%) */',
'@media (min-width: 992px) and (max-height: 820px) {',
'    #P9997_LOGO_IMAGE_CONTAINER img {',
'        max-width: 170px;',
'    }',
'',
'    #P9997_LOGO_IMAGE_LEFT_CONTAINER img,',
'    #P9997_LOGO_IMAGE_LEFT_DEFAULT_CONTAINER img {',
'        max-width: 200px;',
'    }',
'',
'    #welcome-text {',
'        font-size: 28px;',
'    }',
'}',
'',
'/* ===== Celular y tablet vertical ===== */',
'@media (max-width: 991px) {',
'    body::before {',
'        left: 0;',
'        width: 100%;',
'        clip-path: none;',
'    }',
'',
'    .left-card {',
'        display: none;',
'    }',
'',
'    .card-login .row {',
'        flex-direction: column;',
'    }',
'',
'    .card-login .row > .col {',
'        flex: 0 0 100% !important;',
'        max-width: 100% !important;',
'        width: 100% !important;',
'    }',
'',
'    .right-card {',
'        min-height: 100%;',
'        background: transparent;',
'    }',
'',
'    .login-container .right-card > .container,',
'    .right-card > * {',
'        max-width: 90% !important;',
'    }',
'',
'    #P9997_LOGO_IMAGE_CONTAINER img {',
'        display: inline-block;',
'        max-width: 180px;',
'    }',
'',
'    #P9997_LOGO_IMAGE_CONTAINER,',
'    #welcome-text,',
'    .welcome-sub,',
'    #derechos-container {',
'        text-align: center;',
'    }',
'',
'    #welcome-text {',
'        font-size: 28px;',
'    }',
'}',
'',
'/* ===== MFA: textos legibles sobre fondo oscuro ===== */',
'#welcome-text ~ p { color: #ffffff !important; opacity: 0.9; }',
'#welcome-text ~ p b { color: #ffffff !important; }',
'.t-Button--link, .t-Button--link .t-Button-label { color: #ffffff !important; text-decoration: underline; }',
'#P9997_SECRETO_CONTAINER, #P9997_SECRETO_CONTAINER label, #P9997_SECRETO { color: #ffffff !important; }',
'#P9997_SECRETO { font-family: monospace; font-size: 16px; letter-spacing: 1px; }',
'/* QR sobre fondo blanco para que el celular lo lea */',
'#P9997_QR_CONTAINER .t-Form-inputContainer { text-align: center; }',
'#P9997_QR_CONTAINER img, #P9997_QR_CONTAINER svg { background: #ffffff; padding: 12px; border-radius: 8px; }',
''))
,p_step_template=>2101157952850466385
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'16'
,p_created_on=>wwv_flow_imp.dz('20261101165510Z')
,p_last_updated_on=>wwv_flow_imp.dz('20261101171224Z')
,p_created_by=>'WISAZA'
,p_last_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(628319010745990572)
,p_plug_name=>'LOGIN_CONTAINER'
,p_region_css_classes=>'login-container'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261101165510Z')
,p_updated_on=>wwv_flow_imp.dz('20261101165510Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(628319108555990573)
,p_plug_name=>'CARD_LOGIN'
,p_parent_plug_id=>wwv_flow_imp.id(628319010745990572)
,p_region_css_classes=>'card-login'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261101165510Z')
,p_updated_on=>wwv_flow_imp.dz('20261101165510Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(628319281309990575)
,p_plug_name=>'LEFT_CARD'
,p_parent_plug_id=>wwv_flow_imp.id(628319108555990573)
,p_region_css_classes=>'left-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_grid_column_css_classes=>'col-xs-12 col-sm-12 col-md-12 col-lg-6'
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261101165510Z')
,p_updated_on=>wwv_flow_imp.dz('20261101165510Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(661736912859744083)
,p_plug_name=>'RIGHT_CARD'
,p_parent_plug_id=>wwv_flow_imp.id(628319108555990573)
,p_region_css_classes=>'right-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_grid_column_css_classes=>'col-xs-12 col-sm-12 col-md-12 col-lg-6'
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261101165510Z')
,p_updated_on=>wwv_flow_imp.dz('20261101165510Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(628319645774990579)
,p_plug_name=>'WELCOME_MESSAGE'
,p_parent_plug_id=>wwv_flow_imp.id(661736912859744083)
,p_plug_display_sequence=>30
,p_location=>null
,p_plug_source=>unistr('<h2 id=''welcome-text''>Verificaci\00F3n en dos pasos</h2><p>Instale <b>Microsoft Authenticator</b> o <b>Google Authenticator</b> en su celular, toque <b>+</b>, escanee el c\00F3digo QR y digite el c\00F3digo de 6 d\00EDgitos que muestra la aplicaci\00F3n.</p>')
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261101165510Z')
,p_updated_on=>wwv_flow_imp.dz('20261101165825Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(628319793589990580)
,p_plug_name=>'DERECHOS_MESSAGE'
,p_parent_plug_id=>wwv_flow_imp.id(661736912859744083)
,p_plug_display_sequence=>140
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id=''derechos-container''>',
unistr('    <h4>\00A9 1996-<span id="current-year"></span> - Producto de Soluciones de Informaci\00F3n</h4>'),
'</div>'))
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261101165510Z')
,p_updated_on=>wwv_flow_imp.dz('20261101170122Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(365949864669133266)
,p_button_sequence=>120
,p_button_plug_id=>wwv_flow_imp.id(661736912859744083)
,p_button_name=>'CONFIRMAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--stretch:t-Button--padTop'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Activar'
,p_button_css_classes=>'btn-conectar'
,p_grid_new_row=>'Y'
,p_created_on=>wwv_flow_imp.dz('20261101165510Z')
,p_updated_on=>wwv_flow_imp.dz('20261101170122Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(350996852282045849)
,p_button_sequence=>130
,p_button_plug_id=>wwv_flow_imp.id(661736912859744083)
,p_button_name=>'CANCELAR'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--stretch:t-Button--padTop'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Cerrar Sesi\00F3n')
,p_button_redirect_url=>'&LOGOUT_URL.'
,p_button_css_classes=>'t-Button--link'
,p_grid_new_row=>'Y'
,p_created_on=>wwv_flow_imp.dz('20261101170122Z')
,p_updated_on=>wwv_flow_imp.dz('20261101170122Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(365965572441176601)
,p_branch_name=>'Ir a Inicio'
,p_branch_action=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(365949864669133266)
,p_branch_sequence=>10
,p_created_on=>wwv_flow_imp.dz('20261101170244Z')
,p_updated_on=>wwv_flow_imp.dz('20261101170244Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(350996615830045847)
,p_name=>'P9997_QR'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(661736912859744083)
,p_display_as=>'NATIVE_QRCODE'
,p_grid_column_css_classes=>'u-textCenter'
,p_field_template=>2040785906935475274
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'size', 'a-QRCode--md',
  'value_protected', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261101165825Z')
,p_updated_on=>wwv_flow_imp.dz('20261101165825Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(350996759606045848)
,p_name=>'P9997_SECRETO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(661736912859744083)
,p_prompt=>unistr('\00BFNo puede escanear? Ingrese esta clave')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column_css_classes=>'u-textCenter'
,p_field_template=>3031561666792084173
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261101165825Z')
,p_updated_on=>wwv_flow_imp.dz('20261101165825Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(365964286062158012)
,p_name=>'P9997_CODIGO'
,p_is_required=>true
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(661736912859744083)
,p_prompt=>unistr('C\00F3digo de 6 d\00EDgitos')
,p_placeholder=>unistr('C\00F3digo de 6 d\00EDgitos')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>6
,p_tag_attributes=>'autocomplete="one-time-code" inputmode="numeric" pattern="[0-9]*"'
,p_field_template=>1609121967514267634
,p_item_icon_css_classes=>'fa-mobile'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261101165917Z')
,p_updated_on=>wwv_flow_imp.dz('20261101170122Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(422098976299039549)
,p_name=>'P9997_NIT_COMPANIA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(661736912859744083)
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261101165510Z')
,p_updated_on=>wwv_flow_imp.dz('20261101165825Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(628322297221990583)
,p_name=>'P9997_LOGO_IMAGE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(661736912859744083)
,p_source=>'https://synchrox-cdn.s3.amazonaws.com/logo-solinfo.png'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'URL')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20261101165510Z')
,p_updated_on=>wwv_flow_imp.dz('20261101165510Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(699253837794402211)
,p_name=>'P9997_LOGO_IMAGE_LEFT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(628319281309990575)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_display_when=>'P9997_NIT_COMPANIA'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'SQL',
  'sql_statement', 'SELECT LOGO FROM COMPANIA WHERE NIT_COMPANIA = :P9997_NIT_COMPANIA')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20261101165510Z')
,p_updated_on=>wwv_flow_imp.dz('20261101165510Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(699253903570402212)
,p_name=>'P9997_LOGO_IMAGE_LEFT_DEFAULT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(628319281309990575)
,p_source=>'https://synchrox-cdn.s3.amazonaws.com/logo-solinfo.png'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_display_when=>'P9997_NIT_COMPANIA'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'URL')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20261101165510Z')
,p_updated_on=>wwv_flow_imp.dz('20261101165510Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(724923467205826972)
,p_name=>'P9997_DEV_MODE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(661736912859744083)
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20261101165510Z')
,p_updated_on=>wwv_flow_imp.dz('20261101165510Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(350996991407045850)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Activar MFA'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'l_nit varchar2(15) := sys_context(''APEX$SESSION'', ''APP_TENANT_ID'');',
'begin',
'if web_und_mfa_totp.esta_bloqueado(l_nit, :APP_USER) then',
unistr('raise_application_error(-20910, ''Su usuario est\00E1 bloqueado por intentos fallidos. Comun\00EDquese con el administrador del sistema.'');'),
'end if;',
'if not web_und_mfa_totp.validar(l_nit, :APP_USER, :P9997_CODIGO, ''S'') then',
unistr('raise_application_error(-20911, ''C\00F3digo inv\00E1lido. Verifique que la hora de su celular est\00E9 en autom\00E1tico e intente de nuevo.'');'),
'end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(365949864669133266)
,p_internal_uid=>350996991407045850
,p_created_on=>wwv_flow_imp.dz('20261101170244Z')
,p_updated_on=>wwv_flow_imp.dz('20261101170244Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(365956394547133272)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Preparar Enrolamiento'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'l_nit varchar2(15) := sys_context(''APEX$SESSION'', ''APP_TENANT_ID'');',
'l_secreto varchar2(64);',
'begin',
'-- Si no se exige MFA, no hay nada que enrolar',
'if not web_und_mfa_totp.requiere_mfa(l_nit, :APP_USER) then',
'apex_util.redirect_url(apex_page.get_url(p_page => 1));',
'end if;',
unistr('-- Si ya tiene autenticador activo, no se permite re-enrolar desde aqu\00ED'),
'if web_und_mfa_totp.tiene_mfa(l_nit, :APP_USER) then',
'apex_util.redirect_url(apex_page.get_url(p_page => 9996));',
'end if;',
unistr('-- Compa\00F1\00EDa para los logos de la tarjeta'),
':P9997_NIT_COMPANIA := l_nit;',
'l_secreto := web_und_mfa_totp.secreto_enrolamiento(l_nit, :APP_USER);',
':P9997_QR := web_und_mfa_totp.uri_otpauth(l_secreto, l_nit, :APP_USER);',
':P9997_SECRETO := web_und_mfa_totp.secreto_legible(l_secreto);',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>365956394547133272
,p_created_on=>wwv_flow_imp.dz('20261101165510Z')
,p_updated_on=>wwv_flow_imp.dz('20261101170244Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp.component_end;
end;
/
