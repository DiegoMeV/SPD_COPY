prompt --application/pages/page_09999
begin
--   Manifest
--     PAGE: 09999
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
 p_id=>9999
,p_name=>unistr('P\00E1gina de Conexi\00F3n')
,p_alias=>'LOGIN'
,p_step_title=>unistr('SIIF Web - Portal Autenticaci\00F3n: Conectar')
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
'#P9999_LOGO_IMAGE_LEFT_CONTAINER .t-Form-labelContainer,',
'#P9999_LOGO_IMAGE_LEFT_DEFAULT_CONTAINER .t-Form-labelContainer {',
'    display: none;',
'}',
'',
'#P9999_LOGO_IMAGE_LEFT_CONTAINER img,',
'#P9999_LOGO_IMAGE_LEFT_DEFAULT_CONTAINER img {',
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
'#P9999_LOGO_IMAGE_CONTAINER .t-Form-labelContainer {',
'    display: none;',
'}',
'',
'#P9999_LOGO_IMAGE_CONTAINER img {',
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
'#P9999_REMEMBER_CONTAINER label {',
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
'    #P9999_LOGO_IMAGE_CONTAINER img {',
'        max-width: 170px;',
'    }',
'',
'    #P9999_LOGO_IMAGE_LEFT_CONTAINER img,',
'    #P9999_LOGO_IMAGE_LEFT_DEFAULT_CONTAINER img {',
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
'    #P9999_LOGO_IMAGE_CONTAINER img {',
'        display: inline-block;',
'        max-width: 180px;',
'    }',
'',
'    #P9999_LOGO_IMAGE_CONTAINER,',
'    #welcome-text,',
'    .welcome-sub,',
'    #derechos-container {',
'        text-align: center;',
'    }',
'',
'    #welcome-text {',
'        font-size: 28px;',
'    }',
'}'))
,p_step_template=>2101157952850466385
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_page_component_map=>'12'
,p_last_updated_on=>wwv_flow_imp.dz('20261026190915Z')
,p_last_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(262371575437857311)
,p_plug_name=>'LOGIN_CONTAINER'
,p_region_css_classes=>'login-container'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260814162150Z')
,p_updated_on=>wwv_flow_imp.dz('20261001150032Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(262371673247857312)
,p_plug_name=>'CARD_LOGIN'
,p_parent_plug_id=>wwv_flow_imp.id(262371575437857311)
,p_region_css_classes=>'card-login'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260814162150Z')
,p_updated_on=>wwv_flow_imp.dz('20261001150032Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(262371846001857314)
,p_plug_name=>'LEFT_CARD'
,p_parent_plug_id=>wwv_flow_imp.id(262371673247857312)
,p_region_css_classes=>'left-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_grid_column_css_classes=>'col-xs-12 col-sm-12 col-md-12 col-lg-6'
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260814162150Z')
,p_updated_on=>wwv_flow_imp.dz('20261001150032Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(295789477551610822)
,p_plug_name=>'RIGHT_CARD'
,p_parent_plug_id=>wwv_flow_imp.id(262371673247857312)
,p_region_css_classes=>'right-card'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_grid_column_css_classes=>'col-xs-12 col-sm-12 col-md-12 col-lg-6'
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260902140452Z')
,p_updated_on=>wwv_flow_imp.dz('20261001152259Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(262372210466857318)
,p_plug_name=>'WELCOME_MESSAGE'
,p_parent_plug_id=>wwv_flow_imp.id(295789477551610822)
,p_plug_display_sequence=>30
,p_location=>null
,p_plug_source=>'<h2 id=''welcome-text''>Bienvenidos<h2/>'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260814162921Z')
,p_updated_on=>wwv_flow_imp.dz('20261001150727Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(262372358281857319)
,p_plug_name=>'DERECHOS_MESSAGE'
,p_parent_plug_id=>wwv_flow_imp.id(295789477551610822)
,p_plug_display_sequence=>100
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id=''derechos-container''>',
unistr('    <h4>\00A9 1996-<span id="current-year"></span> - Producto de Soluciones de Informaci\00F3n</h4>'),
'</div>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260814162950Z')
,p_updated_on=>wwv_flow_imp.dz('20261026185832Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56137806847640129)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_imp.id(295789477551610822)
,p_button_name=>'LOGIN'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--stretch:t-Button--padTop'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Conectar'
,p_button_css_classes=>'btn-conectar'
,p_grid_new_row=>'Y'
,p_updated_on=>wwv_flow_imp.dz('20261026185832Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56136618577640129)
,p_name=>'P9999_USERNAME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(295789477551610822)
,p_prompt=>'Nombre de Usuario'
,p_placeholder=>'Nombre de Usuario'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_tag_attributes=>'autocomplete="username"'
,p_field_template=>1609121967514267634
,p_item_icon_css_classes=>'fa-user'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
,p_updated_on=>wwv_flow_imp.dz('20261001150727Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56137086715640129)
,p_name=>'P9999_PASSWORD'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(295789477551610822)
,p_prompt=>unistr('Contrase\00F1a')
,p_placeholder=>unistr('Contrase\00F1a')
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_tag_attributes=>'autocomplete="current-password"'
,p_field_template=>1609121967514267634
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#:margin-top-sm'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'submit_when_enter_pressed', 'Y')).to_clob
,p_updated_on=>wwv_flow_imp.dz('20261001150727Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56137493373640129)
,p_name=>'P9999_REMEMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(295789477551610822)
,p_prompt=>'Recordar nombre de usuario'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_display_when=>'apex_authentication.persistent_cookies_enabled'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#:margin-top-sm'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
,p_updated_on=>wwv_flow_imp.dz('20261001145627Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56148729443906282)
,p_name=>'P9999_NIT_COMPANIA'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(295789477551610822)
,p_prompt=>unistr('Compa\00F1ia')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'  nombre d, ',
'  nit_compania r',
'FROM compania',
'WHERE activar_apex = ''S''',
'ORDER BY nombre'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_display_when=>'P9999_DEV_MODE'
,p_display_when2=>'TRUE'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#:margin-top-sm'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
,p_updated_on=>wwv_flow_imp.dz('20261026190915Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(262372050366857316)
,p_name=>'P9999_LOGO_IMAGE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(295789477551610822)
,p_source=>'https://synchrox-cdn.s3.amazonaws.com/logo-solinfo.png'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'URL')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260814162332Z')
,p_updated_on=>wwv_flow_imp.dz('20261001150727Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(333304993481268947)
,p_name=>'P9999_LOGO_IMAGE_LEFT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(262371846001857314)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_display_when=>'P9999_NIT_COMPANIA'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'SQL',
  'sql_statement', 'SELECT LOGO FROM COMPANIA WHERE NIT_COMPANIA = :P9999_NIT_COMPANIA')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261001150607Z')
,p_updated_on=>wwv_flow_imp.dz('20261001152933Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(333305059257268948)
,p_name=>'P9999_LOGO_IMAGE_LEFT_DEFAULT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(262371846001857314)
,p_source=>'https://synchrox-cdn.s3.amazonaws.com/logo-solinfo.png'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_display_when=>'P9999_NIT_COMPANIA'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'URL')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261001152840Z')
,p_updated_on=>wwv_flow_imp.dz('20261001160119Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(358973220350693705)
,p_name=>'P9999_DEV_MODE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(295789477551610822)
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20261026185832Z')
,p_updated_on=>wwv_flow_imp.dz('20261026185832Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56140069476640131)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_INVOKE_API'
,p_process_name=>'Definir Cookie de Nombre de Usuario'
,p_attribute_01=>'PLSQL_PACKAGE'
,p_attribute_03=>'APEX_AUTHENTICATION'
,p_attribute_04=>'SEND_LOGIN_USERNAME_COOKIE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>26139371607180350
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(56140554654640131)
,p_page_process_id=>wwv_flow_imp.id(56140069476640131)
,p_page_id=>9999
,p_name=>'p_username'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>1
,p_value_type=>'EXPRESSION'
,p_value_language=>'PLSQL'
,p_value=>'lower( :P9999_USERNAME )'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(56141046962640131)
,p_page_process_id=>wwv_flow_imp.id(56140069476640131)
,p_page_id=>9999
,p_name=>'p_consent'
,p_direction=>'IN'
,p_data_type=>'BOOLEAN'
,p_has_default=>false
,p_display_sequence=>2
,p_value_type=>'ITEM'
,p_value=>'P9999_REMEMBER'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56148803440906283)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Set Compa\00F1ia')
,p_process_sql_clob=>'APEX_SESSION.SET_TENANT_ID ( :P9999_NIT_COMPANIA );'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>26148105571446502
,p_updated_on=>wwv_flow_imp.dz('20261026180219Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56138142742640130)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_INVOKE_API'
,p_process_name=>'Login'
,p_attribute_01=>'PLSQL_PACKAGE'
,p_attribute_03=>'APEX_AUTHENTICATION'
,p_attribute_04=>'LOGIN'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>26137444873180349
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(56138602417640130)
,p_page_process_id=>wwv_flow_imp.id(56138142742640130)
,p_page_id=>9999
,p_name=>'p_username'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>1
,p_value_type=>'ITEM'
,p_value=>'P9999_USERNAME'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(56139196223640131)
,p_page_process_id=>wwv_flow_imp.id(56138142742640130)
,p_page_id=>9999
,p_name=>'p_password'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_has_default=>false
,p_display_sequence=>2
,p_value_type=>'ITEM'
,p_value=>'P9999_PASSWORD'
);
wwv_flow_imp_shared.create_invokeapi_comp_param(
 p_id=>wwv_flow_imp.id(56139627121640131)
,p_page_process_id=>wwv_flow_imp.id(56138142742640130)
,p_page_id=>9999
,p_name=>'p_set_persistent_auth'
,p_direction=>'IN'
,p_data_type=>'BOOLEAN'
,p_has_default=>true
,p_display_sequence=>3
,p_value_type=>'API_DEFAULT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56141976880640132)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>unistr('Borrar Cach\00E9 de P\00E1ginas')
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_required_patch=>wwv_flow_imp.id(56129426527640081)
,p_internal_uid=>26141279011180351
,p_updated_on=>wwv_flow_imp.dz('20261023132151Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(346462082134742649)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>unistr('Borrar Cach\00E9 de P\00E1ginas TEST')
,p_attribute_01=>'CLEAR_CACHE_FOR_ITEMS'
,p_attribute_03=>'P9999_USERNAME,P9999_PASSWORD'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>346462082134742649
,p_created_on=>wwv_flow_imp.dz('20261023132126Z')
,p_updated_on=>wwv_flow_imp.dz('20261023132151Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56141586844640132)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Obtener Cookie de Nombre de Usuario'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'   l_cookie owa_cookie.cookie;',
'begin',
'   :P9999_USERNAME := apex_authentication.get_login_username_cookie;',
'   :P9999_REMEMBER := case when :P9999_USERNAME is not null then ''Y'' end;',
'',
'   if :P9999_NIT_COMPANIA is null then',
'      l_cookie := owa_cookie.get(''NIT_COMPANIA'');',
'      if l_cookie.num_vals > 0 then',
'         :P9999_NIT_COMPANIA := l_cookie.vals(1);',
'      end if;',
'   end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>26140888975180351
,p_updated_on=>wwv_flow_imp.dz('20261026174448Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
