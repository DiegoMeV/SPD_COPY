prompt --application/pages/page_09086
begin
--   Manifest
--     PAGE: 09086
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>154
,p_default_id_offset=>292021538769791282
,p_default_owner=>'SIIF'
);
wwv_flow_imp_page.create_page(
 p_id=>9086
,p_name=>'Visor Externo'
,p_alias=>'VISOR-EXTERNO'
,p_step_title=>'Visor Externo'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'17'
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_last_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_last_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1193022922957182289)
,p_plug_name=>'HTML Display'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>320
,p_location=>null
,p_plug_source=>'<div id="visorExterno" style="width:100%; height:calc(100vh - 120px);"></div>'
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1193023519376182291)
,p_name=>'P9086_URL_BASE'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1193023769161182293)
,p_name=>'P9086_PARAMETRO_1'
,p_item_sequence=>20
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1193023894929182294)
,p_name=>'P9086_PARAMETRO_2'
,p_item_sequence=>40
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1193023934058182295)
,p_name=>'P9086_PARAMETRO_3'
,p_item_sequence=>60
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1193024028067182296)
,p_name=>'P9086_PARAMETRO_4'
,p_item_sequence=>80
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1193024164380182297)
,p_name=>'P9086_PARAMETRO_5'
,p_item_sequence=>100
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1193024281529182298)
,p_name=>'P9086_PARAMETRO_6'
,p_item_sequence=>120
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1193024312472182299)
,p_name=>'P9086_PARAMETRO_7'
,p_item_sequence=>140
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1193024434037182300)
,p_name=>'P9086_PARAMETRO_8'
,p_item_sequence=>160
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1213727311403336751)
,p_name=>'P9086_PARAMETRO_9'
,p_item_sequence=>180
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1213727333273336752)
,p_name=>'P9086_PARAMETRO_10'
,p_item_sequence=>210
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1213727427899336753)
,p_name=>'P9086_VALOR_PARAMETRO_1'
,p_item_sequence=>220
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1213727584441336754)
,p_name=>'P9086_VALOR_PARAMETRO_2'
,p_item_sequence=>230
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1213727623867336755)
,p_name=>'P9086_VALOR_PARAMETRO_3'
,p_item_sequence=>240
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1213727786656336756)
,p_name=>'P9086_VALOR_PARAMETRO_4'
,p_item_sequence=>250
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1213727850355336757)
,p_name=>'P9086_VALOR_PARAMETRO_5'
,p_item_sequence=>260
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1213727920345336758)
,p_name=>'P9086_VALOR_PARAMETRO_6'
,p_item_sequence=>270
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1213728032777336759)
,p_name=>'P9086_VALOR_PARAMETRO_7'
,p_item_sequence=>280
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1213728211819336760)
,p_name=>'P9086_VALOR_PARAMETRO_8'
,p_item_sequence=>290
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1213728290436336761)
,p_name=>'P9086_VALOR_PARAMETRO_9'
,p_item_sequence=>300
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1213728370368336762)
,p_name=>'P9086_VALOR_PARAMETRO_10'
,p_item_sequence=>310
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(874059909501076065)
,p_name=>'Nuevo'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(874060430939076065)
,p_event_id=>wwv_flow_imp.id(874059909501076065)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let l_url = apex.item("P9086_URL_BASE").getValue();',
'',
'for (let i = 1; i < 10; i++) {',
'',
'  let l_parametro = apex.item("P9086_PARAMETRO_" + i).getValue();',
'',
'  if (l_parametro) {',
'    let l_valor_parametro = encodeURIComponent(apex.item("P9086_VALOR_PARAMETRO_" + i).getValue());',
'    l_url += (l_url.includes("?") ? "&" : "?") + `${l_parametro}=${l_valor_parametro}`;',
'  }',
'',
'}',
'',
'console.log(''url externa ===> '', l_url);',
'',
'document.getElementById("visorExterno").innerHTML =',
'`',
'<iframe src="${l_url}" style="width:100%; height:calc(100vh - 120px); border:none;"></iframe>',
'`;'))
,p_created_on=>wwv_flow_imp.dz('20260826201452Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201452Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
