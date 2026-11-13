prompt --application/pages/page_00085
begin
--   Manifest
--     PAGE: 00085
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
 p_id=>85
,p_name=>'Vista Previa Reporte'
,p_alias=>'VISTA-PREVIA-REPORTE1'
,p_page_mode=>'MODAL'
,p_step_title=>'Vista Previa Reporte'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'17'
,p_created_on=>wwv_flow_imp.dz('20260422141324Z')
,p_last_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_last_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(241669777142351882)
,p_plug_name=>'Vista Previa'
,p_region_name=>'vistaPrevia'
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>260
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260422141324Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241670877971351915)
,p_name=>'P85_NIT_COMPANIA'
,p_item_sequence=>10
,p_source=>'G_NIT_COMPANIA'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241670941338351916)
,p_name=>'P85_PARAMETRO_1'
,p_item_sequence=>70
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241671709817351924)
,p_name=>'P85_PARAMETRO_2'
,p_item_sequence=>80
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241671839266351925)
,p_name=>'P85_PARAMETRO_3'
,p_item_sequence=>90
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241671906027351926)
,p_name=>'P85_PARAMETRO_4'
,p_item_sequence=>100
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241672007197351927)
,p_name=>'P85_PARAMETRO_5'
,p_item_sequence=>110
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241672165227351928)
,p_name=>'P85_PARAMETRO_6'
,p_item_sequence=>120
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241672236251351929)
,p_name=>'P85_PARAMETRO_7'
,p_item_sequence=>130
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241672384112351930)
,p_name=>'P85_PARAMETRO_8'
,p_item_sequence=>140
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241672467484351931)
,p_name=>'P85_PARAMETRO_9'
,p_item_sequence=>150
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241672554289351932)
,p_name=>'P85_VALOR_PARAMETRO_1'
,p_item_sequence=>160
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241672641441351933)
,p_name=>'P85_VALOR_PARAMETRO_2'
,p_item_sequence=>170
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241672786419351934)
,p_name=>'P85_VALOR_PARAMETRO_3'
,p_item_sequence=>180
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241672815789351935)
,p_name=>'P85_VALOR_PARAMETRO_4'
,p_item_sequence=>190
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241673759603351944)
,p_name=>'P85_VALOR_PARAMETRO_5'
,p_item_sequence=>200
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241673879664351945)
,p_name=>'P85_VALOR_PARAMETRO_6'
,p_item_sequence=>210
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241673907302351946)
,p_name=>'P85_VALOR_PARAMETRO_7'
,p_item_sequence=>220
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241674087010351947)
,p_name=>'P85_VALOR_PARAMETRO_8'
,p_item_sequence=>230
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241674157714351948)
,p_name=>'P85_VALOR_PARAMETRO_9'
,p_item_sequence=>240
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241674233413351949)
,p_name=>'P85_REPORT'
,p_item_sequence=>40
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241674352087351950)
,p_name=>'P85_DESFORMAT'
,p_item_sequence=>50
,p_item_default=>'PDF'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241674490822351951)
,p_name=>'P85_PARAMFORM'
,p_item_sequence=>60
,p_item_default=>'yes'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(241674522413351952)
,p_name=>'P85_MIMETYPE'
,p_item_sequence=>250
,p_item_default=>'application/pdf'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(244438676167034526)
,p_name=>'P85_REPORTS_SERVER'
,p_item_sequence=>20
,p_source=>'G_REPORTS_SERVER'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(244438732991034527)
,p_name=>'P85_REPORTS_SERVER_NAME'
,p_item_sequence=>30
,p_source=>'G_REPORTS_SERVER_NAME'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260930174317Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(145941052062424511)
,p_name=>'Nuevo'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260422141325Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(145941591231424513)
,p_event_id=>wwv_flow_imp.id(145941052062424511)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//alert(apex.item("P85_REPORT").getValue());',
'let l_url = ',
'',
'apex.item("P85_REPORTS_SERVER").getValue() +',
'          "report=" + encodeURIComponent(apex.item("P85_REPORT").getValue()) +',
'          "&userid=siif_web/siif_web@prserv01" +',
'          "&server="+ apex.item("P85_REPORTS_SERVER_NAME").getValue() +',
'          "&destype=CACHE" +',
'          "&desformat=" + encodeURIComponent(apex.item("P85_DESFORMAT").getValue()) +',
'          "&paramform=" + encodeURIComponent(apex.item("P85_PARAMFORM").getValue()) +',
'          "&UnaCompania=" + encodeURIComponent(apex.item("P85_NIT_COMPANIA").getValue());',
'          ',
'          for (i=1; i < 10; i++) {',
'          ',
'            l_parametro = apex.item("P85_PARAMETRO_" + i).getValue();',
'',
'            if (l_parametro) {',
'              let l_valor_parametro = encodeURIComponent(apex.item("P85_VALOR_PARAMETRO_" + i).getValue());',
'              l_url += `&${l_parametro}=${l_valor_parametro}`   ;',
'            }',
'',
'          }',
'',
'          l_url += `&mimetype=${apex.item("P85_MIMETYPE").getValue()}`;',
'',
'document.getElementById("vistaPrevia").innerHTML =',
'`',
'<embed src="${l_url}" type="${apex.item("P85_MIMETYPE").getValue()}" style="height: 99vh; width: 99vw">',
'</embed>',
'`;'))
,p_created_on=>wwv_flow_imp.dz('20260422141325Z')
,p_updated_on=>wwv_flow_imp.dz('20260422141325Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
