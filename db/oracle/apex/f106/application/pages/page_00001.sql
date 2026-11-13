prompt --application/pages/page_00001
begin
--   Manifest
--     PAGE: 00001
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
 p_id=>1
,p_name=>'Inicio'
,p_alias=>'HOME'
,p_step_title=>unistr('SIIF Web - Portal Autenticaci\00F3n')
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.card-container{',
'    display: flex;',
'    justify-content: space-between;',
'    align-items: center;',
'    flex-direction: row;',
'}',
'',
'.card-logo{',
'    max-width: 100px;',
'    height: auto;',
'}',
'',
' /* Encabezado */',
'.encabezado-modulo { padding: 1rem 1.25rem; font-family: Inter, "Segoe UI", Roboto, Arial, sans-serif; }',
'.encabezado-modulo__saludo { margin: 0 0 .25rem; font-size: .9375rem;}',
'.encabezado-modulo__compania { margin: 0 0 .25rem; font-size: 1.2rem;}',
'.encabezado-modulo__info { font-weight: 700; color: #1e3a6e; text-transform: uppercase; }',
'',
'',
'/* Card Fecha */',
'.fecha-actual { display: inline-flex; align-items: center; gap: .875rem; padding: .75rem 1.25rem; background: #eef2f7; border-radius: .5rem; font-family: Inter, "Segoe UI", Roboto, Arial, sans-serif; }',
'.fecha-actual__icono { font-size: 1.25rem; color: #1e3a6e; }',
'.fecha-actual__fecha { font-size: .875rem; font-weight: 700; color: #1e293b; }',
'',
'/* Cards Modulos */',
'.card-option-modulo{',
'    border-radius: .5rem;',
'}',
'',
'',
'/* Tarjetas Informacion del sistema */',
'.panel-lateral { display: flex; flex-direction: column; gap: 1rem; font-family: Inter, "Segoe UI", Roboto, Arial, sans-serif; }',
'',
'.tarjeta { padding: 1.25rem; background: #fff; border: 1px solid #e2e8f0; border-radius: .75rem; }',
'.tarjeta--oscura { background: #0f3b7a; border-color: #0f3b7a; color: #fff; }',
'',
'.tarjeta__titulo { display: flex; align-items: center; gap: .5rem; margin: 0 0 .75rem; font-size: 1rem; font-weight: 700; }',
'.tarjeta__titulo--azul { color: #1e3a6e; }',
'',
'.tarjeta__estado { display: flex; align-items: center; gap: .5rem; margin: 0 0 .5rem; font-size: .875rem; }',
'.tarjeta__punto { width: .5rem; height: .5rem; border-radius: 50%; background: #22c55e; }',
'.tarjeta__acceso { margin: 0 0 1rem; font-size: .8125rem; color: #bfdbfe; }',
'',
'.tarjeta__boton { display: block; padding: .625rem; text-align: center; font-size: .875rem; font-weight: 600; color: #fff; text-decoration: none; background: rgba(255,255,255,.15); border-radius: .5rem; }',
'.tarjeta__boton:hover { background: rgba(255,255,255,.25); }',
'.tarjeta__boton:focus-visible { outline: 2px solid #fff; outline-offset: 2px; }',
'',
'.tarjeta__datos { margin: 0; }',
'.tarjeta__datos div { display: flex; justify-content: space-between; gap: 1rem; padding: .625rem 0; font-size: .875rem; }',
'.tarjeta__datos dt { color: #4b5563; }',
'.tarjeta__datos dd { margin: 0; font-weight: 600; color: #1e293b; text-align: right; }',
'',
'',
'/* Tarjeta de consejo */',
'',
'.consejo { display: flex; align-items: center; gap: .75rem; padding: 1rem 1.25rem; background: #dbeafe; border-radius: .5rem; font-family: Inter, "Segoe UI", Roboto, Arial, sans-serif; }',
'.consejo__icono { flex-shrink: 0; font-size: 1.125rem; line-height: 1.5; color: #1d4ed8; }',
'.consejo__texto { margin: 0; font-size: .875rem; line-height: 1.5; color: #1d4ed8; }',
'.consejo__texto strong { font-weight: 700; }'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'13'
,p_last_updated_on=>wwv_flow_imp.dz('20261103161106Z')
,p_last_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(323898093704107411)
,p_plug_name=>'Pantalla Basada en COMPANIA'
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_region_attributes=>'style="border-radius: 8px; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);"'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>'SELECT ROWID, LOGO, NOMBRE, NIT_COMPANIA FROM COMPANIA WHERE NIT_COMPANIA = :G_NIT_COMPANIA'
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
,p_created_on=>wwv_flow_imp.dz('20260929151531Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(324839747254482648)
,p_plug_name=>'CARD_COMPANIA'
,p_parent_plug_id=>wwv_flow_imp.id(323898093704107411)
,p_region_css_classes=>'card-container'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>10
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929155235Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174802Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(325106698300783801)
,p_plug_name=>'FECHA'
,p_parent_plug_id=>wwv_flow_imp.id(324839747254482648)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>50
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="fecha-actual">',
'  <span class="fecha-actual__icono fa fa-calendar-o" aria-hidden="true"></span>',
'  <time class="fecha-actual__fecha" id="fecha-actual"></time>',
'</div>',
'',
'<script>',
'  (function () {',
'    const hoy = new Date();',
'    const el = document.getElementById("fecha-actual");',
'    const texto = new Intl.DateTimeFormat("es-CO", {',
'      weekday: "long", day: "numeric", month: "long", year: "numeric"',
'    }).format(hoy);',
'',
'    el.textContent = texto.charAt(0).toUpperCase() + texto.slice(1);',
'    el.dateTime = hoy.toLocaleDateString("en-CA"); // formato AAAA-MM-DD en hora local',
'  })();',
'</script>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929160547Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174812Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(325106768510783802)
,p_plug_name=>'CONTAINER_COMPANIA_LOGO'
,p_parent_plug_id=>wwv_flow_imp.id(324839747254482648)
,p_region_css_classes=>'card-container'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>30
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929161729Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174802Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(324839843170482649)
,p_plug_name=>'INFORMACION'
,p_parent_plug_id=>wwv_flow_imp.id(325106768510783802)
,p_plug_display_sequence=>20
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="encabezado-modulo">',
'  <p class="encabezado-modulo__saludo">',
'    Bienvenido(a), <strong class="encabezado-modulo__info">&G_NOMBRE_USUARIO.</strong>',
'  </p>  ',
'  <p class="encabezado-modulo__compania">',
'    <strong class="encabezado-modulo__info">&G_NOMBRE_COMPANIA.</strong>',
'  </p>',
'</div>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929155235Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174802Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(325107718653783812)
,p_plug_name=>'INFO_SISTEMA'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>30
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929192452Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174840Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(325107506298783810)
,p_plug_name=>'CONSEJO'
,p_parent_plug_id=>wwv_flow_imp.id(325107718653783812)
,p_plug_display_sequence=>60
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="consejo" role="note">',
'  <span class="consejo__icono fa fa-info-circle-o" aria-hidden="true"></span>',
'  <p class="consejo__texto">',
unistr('    <strong>Consejo:</strong> Utilice el men\00FA lateral para acceder a los m\00F3dulos del sistema. Si presenta alg\00FAn inconveniente, comun\00EDquese con el administrador de su \00E1rea.'),
'  </p>',
'</div>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929191806Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174840Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(325108009463783815)
,p_plug_name=>'CONTAINER_MODULE_CARDS'
,p_parent_plug_id=>wwv_flow_imp.id(325107718653783812)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'  v.modulo,',
'  v.opcion,',
'  v.label                AS card_title,',
'  (SELECT LISTAGG(CASE WHEN x.rn <= 5 THEN x.label END, '', '')',
'            WITHIN GROUP (ORDER BY x.path_opcion)',
'          || CASE WHEN MAX(x.total) > 5 THEN ''...'' END',
'     FROM (SELECT h.label,',
'                  h.path_opcion,',
'                  ROW_NUMBER() OVER (ORDER BY h.path_opcion) AS rn,',
'                  COUNT(*)     OVER ()                       AS total',
'             FROM v_gen_opciones_sistema_menu h',
'            WHERE h.modulo    = v.modulo',
'              AND h.opc_padre = v.opcion',
'              AND (h.tipo_llamada = ''PADRE'' OR h.ejecutable IS NOT NULL)',
'              AND EXISTS (SELECT 1',
'                            FROM v_gen_opciones_usuario_act u2',
'                           WHERE u2.opcion       = h.opcion',
'                             AND u2.modulo       = h.modulo',
'                             AND u2.usuario      = :G_USUARIO',
'                             AND u2.nit_compania = :G_NIT_COMPANIA)) x',
'  )                      AS card_body,',
'  ''fa '' || NVL(v.menu_icon, ''fa-folder'') AS card_icon,',
'  APEX_PAGE.GET_URL(',
'    p_application => v.aplicacion,',
'    p_page        => CASE',
'                        WHEN v.tipo_llamada = ''PADRE'' THEN ''101''',
'                        WHEN v.tipo_llamada = ''URL''   THEN ''9086''',
'                        ELSE NVL(v.ejecutable, ''en-construccion'')',
'                      END,',
'    p_clear_cache => CASE',
'                        WHEN v.tipo_llamada = ''PADRE'' THEN ''101''',
'                        WHEN v.tipo_llamada = ''URL''   THEN ''9086''',
'                        ELSE NVL(v.ejecutable, ''en-construccion'')',
'                      END,',
'    p_items       => ''G_MODULO,G_OPCION_MENU,G_SOLO_LECTURA''',
'                     || CASE WHEN v.tipo_llamada = ''URL'' THEN '',P9086_URL_BASE'' END',
'                     || NVL2(v.parametros, '','' || v.parametros, ''''),',
'    p_values      => v.modulo || '','' || v.opcion || '','' || NVL(u.solo_consulta, ''N'')',
'                     || CASE WHEN v.tipo_llamada = ''URL'' THEN '','' || v.ejecutable END',
'                     || NVL2(v.valores, '','' || REPLACE(v.valores, ''#G_NIT_COMPANIA#'', :G_NIT_COMPANIA), '''')',
'  )                      AS card_link',
'FROM v_gen_opciones_sistema_menu v',
'JOIN v_gen_opciones_usuario_act u',
'  ON u.opcion       = v.opcion',
' AND u.modulo       = v.modulo',
' AND u.usuario      = :G_USUARIO',
' AND u.nit_compania = :G_NIT_COMPANIA',
'WHERE v.tipo_llamada = ''PADRE''',
'  AND v.opc_padre IS NULL',
'ORDER BY v.path_opcion'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CARDS'
,p_plug_query_num_rows_type=>'SCROLL'
,p_show_total_row_count=>false
,p_created_on=>wwv_flow_imp.dz('20260929193345Z')
,p_updated_on=>wwv_flow_imp.dz('20261008203513Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_card(
 p_id=>wwv_flow_imp.id(325108861334783823)
,p_region_id=>wwv_flow_imp.id(325108009463783815)
,p_layout_type=>'GRID'
,p_card_css_classes=>'card-option-modulo'
,p_title_adv_formatting=>false
,p_title_column_name=>'CARD_TITLE'
,p_sub_title_adv_formatting=>false
,p_sub_title_column_name=>'CARD_BODY'
,p_body_adv_formatting=>false
,p_second_body_adv_formatting=>false
,p_icon_source_type=>'DYNAMIC_CLASS'
,p_icon_class_column_name=>'CARD_ICON'
,p_icon_position=>'START'
,p_icon_description=>'&CARD_TITLE.'
,p_media_adv_formatting=>false
,p_pk1_column_name=>'MODULO'
,p_pk2_column_name=>'OPCION'
,p_updated_on=>wwv_flow_imp.dz('20260929200816Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_card_action(
 p_id=>wwv_flow_imp.id(325108974727783824)
,p_card_id=>wwv_flow_imp.id(325108861334783823)
,p_action_type=>'FULL_CARD'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'&CARD_LINK.'
,p_updated_on=>wwv_flow_imp.dz('20260929195652Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(325108123535783816)
,p_plug_name=>'CARDS_INFO'
,p_parent_plug_id=>wwv_flow_imp.id(325107718653783812)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929193345Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174931Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(325107894680783813)
,p_plug_name=>'ACCESO_SEGURO'
,p_parent_plug_id=>wwv_flow_imp.id(325108123535783816)
,p_region_template_options=>'#DEFAULT#:margin-bottom-md'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <div class="tarjeta tarjeta--oscura">',
'    <h2 class="tarjeta__titulo">',
'      <span class="fa fa-shield" aria-hidden="true"></span>',
'      Acceso seguro',
'    </h2>',
'    <p class="tarjeta__estado">',
'      <span class="tarjeta__punto" aria-hidden="true"></span>',
unistr('      Su conexi\00F3n est\00E1 protegida'),
'    </p>',
'    <p class="tarjeta__acceso">',
unistr('      \00DAltimo acceso: <time datetime="2026-06-06T11:32">&P1_ULTIMA_CONEXION.</time>'),
'    </p>',
'  </div>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929192452Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174931Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(325107967090783814)
,p_plug_name=>'APP_INFO'
,p_parent_plug_id=>wwv_flow_imp.id(325108123535783816)
,p_region_template_options=>'#DEFAULT#:margin-bottom-md'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <div class="tarjeta">',
'    <h2 class="tarjeta__titulo tarjeta__titulo--azul">',
'      <span class="fa fa-server" aria-hidden="true"></span>',
unistr('      Informaci\00F3n del sistema'),
'    </h2>',
'    <dl class="tarjeta__datos">',
unistr('      <div><dt>Aplicaci\00F3n</dt><dd>SIIF Web - Portal</dd></div>'),
unistr('      <div><dt>Versi\00F3n</dt><dd>1.0.0</dd></div>'),
'      <div><dt>Entorno</dt><dd>&P1_ENV.</dd></div>',
'      <div><dt>Base de datos</dt><dd>Oracle</dd></div>',
'    </dl>',
'  </div>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929192452Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174931Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(323898213247107413)
,p_name=>'P1_NIT_COMPANIA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(323898093704107411)
,p_item_source_plug_id=>wwv_flow_imp.id(323898093704107411)
,p_source=>'NIT_COMPANIA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929151531Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(323898332980107414)
,p_name=>'P1_NOMBRE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(323898093704107411)
,p_item_source_plug_id=>wwv_flow_imp.id(323898093704107411)
,p_source=>'NOMBRE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929151531Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(323898642009107417)
,p_name=>'P1_LOGO'
,p_source_data_type=>'BLOB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(325106768510783802)
,p_item_source_plug_id=>wwv_flow_imp.id(323898093704107411)
,p_prompt=>'Logo'
,p_source=>'LOGO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_attributes=>'style="border-radius: 8px; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15); width:100px;"'
,p_field_template=>2040785906935475274
,p_item_css_classes=>'card-logo'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'DB_COLUMN')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929151531Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174802Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(324839171553482642)
,p_name=>'P1_ROWID'
,p_source_data_type=>'ROWID'
,p_is_primary_key=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(323898093704107411)
,p_item_source_plug_id=>wwv_flow_imp.id(323898093704107411)
,p_source=>'ROWID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929151643Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(325106837386783803)
,p_name=>'P1_ULTIMA_CONEXION'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(323898093704107411)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_CHAR(',
'         FROM_TZ(CAST(MAX(access_date) AS TIMESTAMP),',
'                 TO_CHAR(SYSTIMESTAMP, ''TZH:TZM''))',
'         AT TIME ZONE ''America/Bogota'',',
'         ''DD/MM/YYYY HH:MI:SS AM'',',
'         ''NLS_DATE_LANGUAGE = AMERICAN'') AS ultima_conexion',
'FROM   apex_workspace_access_log',
'WHERE  authentication_result = ''AUTH_SUCCESS''',
'AND    user_name = :G_USUARIO;'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929162627Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(325109051087783825)
,p_name=>'P1_ENV'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(323898093704107411)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF UPPER(:G_NOMBRE_COMPANIA) LIKE ''%PRUEBAS%'' THEN',
'    RETURN ''Pruebas'';',
'  ELSE',
unistr('    RETURN ''Producci\00F3n'';'),
'  END IF;',
'END;'))
,p_source_type=>'FUNCTION_BODY'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260929201216Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(324839027320482641)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Inicializar ROWID'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ROWID ',
'INTO :P1_ROWID ',
'FROM COMPANIA ',
'WHERE NIT_COMPANIA = :G_NIT_COMPANIA;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>324839027320482641
,p_created_on=>wwv_flow_imp.dz('20260929151643Z')
,p_updated_on=>wwv_flow_imp.dz('20261103161106Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(323898104399107412)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(323898093704107411)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Inicializar pantalla Inicio'
,p_internal_uid=>323898104399107412
,p_created_on=>wwv_flow_imp.dz('20260929151533Z')
,p_updated_on=>wwv_flow_imp.dz('20260929151643Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
