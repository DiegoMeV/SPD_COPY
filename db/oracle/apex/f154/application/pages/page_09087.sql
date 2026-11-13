prompt --application/pages/page_09087
begin
--   Manifest
--     PAGE: 09087
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
 p_id=>9087
,p_name=>'Visor Externo'
,p_alias=>'VISOR-EXTERNO-MODAL'
,p_page_mode=>'MODAL'
,p_step_title=>'Visor Externo'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'17'
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_last_updated_on=>wwv_flow_imp.dz('20260826201729Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_last_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1483088130311715847)
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
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1483089476747715851)
,p_name=>'P9087_URL_BASE'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1483089726532715853)
,p_name=>'P9087_PARAMETRO_1'
,p_item_sequence=>20
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1483089852300715854)
,p_name=>'P9087_PARAMETRO_2'
,p_item_sequence=>40
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1483089891429715855)
,p_name=>'P9087_PARAMETRO_3'
,p_item_sequence=>60
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1483089985438715856)
,p_name=>'P9087_PARAMETRO_4'
,p_item_sequence=>80
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1483090121751715857)
,p_name=>'P9087_PARAMETRO_5'
,p_item_sequence=>100
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1483090238900715858)
,p_name=>'P9087_PARAMETRO_6'
,p_item_sequence=>120
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1483090269843715859)
,p_name=>'P9087_PARAMETRO_7'
,p_item_sequence=>140
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1483090391408715860)
,p_name=>'P9087_PARAMETRO_8'
,p_item_sequence=>160
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1503793268774870311)
,p_name=>'P9087_PARAMETRO_9'
,p_item_sequence=>180
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1503793290644870312)
,p_name=>'P9087_PARAMETRO_10'
,p_item_sequence=>210
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1503793385270870313)
,p_name=>'P9087_VALOR_PARAMETRO_1'
,p_item_sequence=>220
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1503793541812870314)
,p_name=>'P9087_VALOR_PARAMETRO_2'
,p_item_sequence=>230
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1503793581238870315)
,p_name=>'P9087_VALOR_PARAMETRO_3'
,p_item_sequence=>240
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1503793744027870316)
,p_name=>'P9087_VALOR_PARAMETRO_4'
,p_item_sequence=>250
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1503793807726870317)
,p_name=>'P9087_VALOR_PARAMETRO_5'
,p_item_sequence=>260
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1503793877716870318)
,p_name=>'P9087_VALOR_PARAMETRO_6'
,p_item_sequence=>270
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1503793990148870319)
,p_name=>'P9087_VALOR_PARAMETRO_7'
,p_item_sequence=>280
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1503794169190870320)
,p_name=>'P9087_VALOR_PARAMETRO_8'
,p_item_sequence=>290
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1503794247807870321)
,p_name=>'P9087_VALOR_PARAMETRO_9'
,p_item_sequence=>300
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1503794327739870322)
,p_name=>'P9087_VALOR_PARAMETRO_10'
,p_item_sequence=>310
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(874069794470089670)
,p_name=>'Nuevo'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(874070240464089671)
,p_event_id=>wwv_flow_imp.id(874069794470089670)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let l_url = apex.item("P9087_URL_BASE").getValue();',
'',
'for (let i = 1; i < 10; i++) {',
'',
'  let l_parametro = apex.item("P9087_PARAMETRO_" + i).getValue();',
'',
'  if (l_parametro) {',
'    let l_valor_parametro = encodeURIComponent(apex.item("P9087_VALOR_PARAMETRO_" + i).getValue());',
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
,p_created_on=>wwv_flow_imp.dz('20260826201708Z')
,p_updated_on=>wwv_flow_imp.dz('20260826201708Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
