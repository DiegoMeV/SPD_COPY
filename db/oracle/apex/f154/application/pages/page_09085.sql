prompt --application/pages/page_09085
begin
--   Manifest
--     PAGE: 09085
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
 p_id=>9085
,p_name=>'Vista Previa Reporte'
,p_alias=>'VISTA-PREVIA-REPORTE'
,p_page_mode=>'MODAL'
,p_step_title=>'Vista Previa Reporte'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'17'
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_last_updated_on=>wwv_flow_imp.dz('20261020144129Z')
,p_created_by=>'WISAZA'
,p_last_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1159915673864133030)
,p_plug_name=>'Vista Previa'
,p_region_name=>'vistaPrevia'
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none'
,p_plug_template=>4501440665235496320
,p_plug_display_sequence=>260
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159917280466133036)
,p_name=>'P9085_NIT_COMPANIA'
,p_item_sequence=>10
,p_source=>'G_NIT_COMPANIA'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159917343833133037)
,p_name=>'P9085_PARAMETRO_1'
,p_item_sequence=>70
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159918112312133045)
,p_name=>'P9085_PARAMETRO_2'
,p_item_sequence=>80
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159918241761133046)
,p_name=>'P9085_PARAMETRO_3'
,p_item_sequence=>90
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159918308522133047)
,p_name=>'P9085_PARAMETRO_4'
,p_item_sequence=>100
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159918409692133048)
,p_name=>'P9085_PARAMETRO_5'
,p_item_sequence=>110
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159918567722133049)
,p_name=>'P9085_PARAMETRO_6'
,p_item_sequence=>120
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159918638746133050)
,p_name=>'P9085_PARAMETRO_7'
,p_item_sequence=>130
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159918786607133051)
,p_name=>'P9085_PARAMETRO_8'
,p_item_sequence=>140
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159918869979133052)
,p_name=>'P9085_PARAMETRO_9'
,p_item_sequence=>150
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159918956784133053)
,p_name=>'P9085_VALOR_PARAMETRO_1'
,p_item_sequence=>160
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159919043936133054)
,p_name=>'P9085_VALOR_PARAMETRO_2'
,p_item_sequence=>170
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159919188914133055)
,p_name=>'P9085_VALOR_PARAMETRO_3'
,p_item_sequence=>180
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159919218284133056)
,p_name=>'P9085_VALOR_PARAMETRO_4'
,p_item_sequence=>190
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159920162098133065)
,p_name=>'P9085_VALOR_PARAMETRO_5'
,p_item_sequence=>200
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159920282159133066)
,p_name=>'P9085_VALOR_PARAMETRO_6'
,p_item_sequence=>210
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159920309797133067)
,p_name=>'P9085_VALOR_PARAMETRO_7'
,p_item_sequence=>220
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159920489505133068)
,p_name=>'P9085_VALOR_PARAMETRO_8'
,p_item_sequence=>230
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159920560209133069)
,p_name=>'P9085_VALOR_PARAMETRO_9'
,p_item_sequence=>240
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159920635908133070)
,p_name=>'P9085_REPORT'
,p_item_sequence=>40
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159920754582133071)
,p_name=>'P9085_DESFORMAT'
,p_item_sequence=>50
,p_item_default=>'PDF'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159920893317133072)
,p_name=>'P9085_PARAMFORM'
,p_item_sequence=>60
,p_item_default=>'yes'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1159920924908133073)
,p_name=>'P9085_MIMETYPE'
,p_item_sequence=>250
,p_item_default=>'application/pdf'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1162685078661815647)
,p_name=>'P9085_REPORTS_SERVER'
,p_item_sequence=>20
,p_source=>'G_REPORTS_SERVER'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1162685135485815648)
,p_name=>'P9085_REPORTS_SERVER_NAME'
,p_item_sequence=>30
,p_source=>'G_REPORTS_SERVER_NAME'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20260619200927Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'WISAZA'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(824164740518719912)
,p_name=>'Nuevo'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20261020144129Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(824165298161719912)
,p_event_id=>wwv_flow_imp.id(824164740518719912)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//alert(apex.item("P9085_REPORT").getValue());',
'let l_url = ',
'',
'apex.item("P9085_REPORTS_SERVER").getValue() +',
'          "report=" + encodeURIComponent(apex.item("P9085_REPORT").getValue()) +',
'          "&userid=siif_web/siif_web@prserv01" +',
'          "&server="+ apex.item("P9085_REPORTS_SERVER_NAME").getValue() +',
'          "&destype=CACHE" +',
'          "&desformat=" + encodeURIComponent(apex.item("P9085_DESFORMAT").getValue()) +',
'          "&paramform=" + encodeURIComponent(apex.item("P9085_PARAMFORM").getValue()) +',
'          "&UnaCompania=" + encodeURIComponent(apex.item("P9085_NIT_COMPANIA").getValue());',
'          ',
'          for (i=1; i < 10; i++) {',
'          ',
'            l_parametro = apex.item("P9085_PARAMETRO_" + i).getValue();',
'',
'            if (l_parametro) {',
'              let l_valor_parametro = encodeURIComponent(apex.item("P9085_VALOR_PARAMETRO_" + i).getValue());',
'              l_url += `&${l_parametro}=${l_valor_parametro}`   ;',
'            }',
'',
'          }',
'',
'          l_url += `&mimetype=${apex.item("P9085_MIMETYPE").getValue()}&fechaGenerado=${Date.now()}`;',
'          console.log(''report url ===> '',l_url);',
'',
'document.getElementById("vistaPrevia").innerHTML =',
'`',
'<embed src="${l_url}" type="${apex.item("P9085_MIMETYPE").getValue()}" style="height: 99vh; width: 99vw">',
'</embed>',
'`;'))
,p_created_on=>wwv_flow_imp.dz('20260619200927Z')
,p_updated_on=>wwv_flow_imp.dz('20261020144129Z')
,p_created_by=>'WISAZA'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
