prompt --application/pages/page_01062
begin
--   Manifest
--     PAGE: 01062
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>4267703994621115
,p_default_application_id=>160
,p_default_id_offset=>1641014699613402
,p_default_owner=>'SIIF'
);
wwv_flow_imp_page.create_page(
 p_id=>1062
,p_name=>'SPD_Datos de la meta'
,p_alias=>'SPD_DATOS_META'
,p_page_mode=>'MODAL'
,p_step_title=>'Datos de la Meta'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'900'
,p_protection_level=>'C'
,p_page_component_map=>'17'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41228164573911763)
,p_plug_name=>'Datos de la Meta'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>10
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41229943989911764)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39487096731162903)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41230048457911764)
,p_button_sequence=>300
,p_button_plug_id=>wwv_flow_imp.id(41229943989911764)
,p_button_name=>'CERRAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(39601281081162925)
,p_button_image_alt=>'Cerrar'
,p_button_position=>'CLOSE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41230351263911764)
,p_button_sequence=>310
,p_button_plug_id=>wwv_flow_imp.id(41229943989911764)
,p_button_name=>'EDITAR'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(39601281081162925)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Editar'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:1011:&APP_SESSION.::&DEBUG.:1011:P1011_ID:&P1062_ID.'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41228283148911763)
,p_name=>'P1062_ID'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>'ID'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41228360766911763)
,p_name=>'P1062_CODE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>unistr('C\00F3digo')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41228503873911763)
,p_name=>'P1062_NAME'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>'Meta'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41228526016911764)
,p_name=>'P1062_ENTITY'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>'Entidad'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41228628882911764)
,p_name=>'P1062_GOAL_TYPE'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>'Tipo de meta'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41228800502911764)
,p_name=>'P1062_LEVEL'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>'&P1062_LEVEL_LABEL.'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41228835579911764)
,p_name=>'P1062_INDICATOR'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>'Indicador'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_display_when=>'P1062_INDICATOR'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41229005843911764)
,p_name=>'P1062_UNITS'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>'Unidades'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_display_when=>'P1062_UNITS'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41229084500911764)
,p_name=>'P1062_ACCUMULATION'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>unistr('Tipo de acumulaci\00F3n')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_display_when=>'P1062_ACCUMULATION'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41229134520911764)
,p_name=>'P1062_BASE_VALUE'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>'Valor base'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_display_when=>'P1062_BASE_VALUE'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41229282075911764)
,p_name=>'P1062_GOAL_VALUE'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>'Valor meta'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_display_when=>'P1062_GOAL_VALUE'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41229330777911764)
,p_name=>'P1062_POLITIC'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>unistr('Pol\00EDtica P\00FAblica')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_display_when=>'P1062_POLITIC'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41229454520911764)
,p_name=>'P1062_ODS'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>'Objetivos de desarrollo sostenible'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_display_when=>'P1062_ODS'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'HTML',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41229562524911764)
,p_name=>'P1062_PRODUCT'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>'Producto'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_display_when=>'P1062_PRODUCT'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41229709877911764)
,p_name=>'P1062_PI_BASE_VALUE'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>'Valor base - producto'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_display_when=>'P1062_PI_BASE_VALUE'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41229734920911764)
,p_name=>'P1062_PI_GOAL_VALUE'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>'Valor meta - producto'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_display_when=>'P1062_PI_GOAL_VALUE'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_imp.id(39598464321162923)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41229893743911764)
,p_name=>'P1062_LEVEL_LABEL'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_imp.id(41228164573911763)
,p_prompt=>'Etiqueta del nivel'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(41230156471911764)
,p_name=>unistr('Cerrar di\00E1logo')
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(41230048457911764)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(41230296260911764)
,p_event_id=>wwv_flow_imp.id(41230156471911764)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41230433249911764)
,p_process_sequence=>320
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cargar meta'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  function lov(p_lov varchar2, p_value varchar2) return varchar2 is',
'    l_d varchar2(400);',
'  begin',
'    select max(DISPLAY_VALUE) into l_d from APEX_APPLICATION_LOV_ENTRIES',
'     where APPLICATION_ID = :APP_ID and LIST_OF_VALUES_NAME = p_lov and RETURN_VALUE = p_value;',
'    return coalesce(l_d, p_value);',
'  end;',
'begin',
'  for g in (select g.*, e.CODIGO_ENT_PRY, e.NOMBRE_ENT_PRY, l.CODE as L_CODE, l.NAME as L_NAME, l."LEVEL" as L_LEVEL,',
'                   (select pp.CODE || '' - '' || pp.NAME from SPD_PUBLIC_POLITIC pp where pp.ID = g.PUBLIC_POLITIC_ID) as POLITIC,',
'                   (select p.CODIGO || '' - '' || p.NOMBRE from PRODUCTOS_PRY p where p.ID = g.PRODUCT_ID) as PRODUCT,',
'                   (select u.NOMBRE_UNIDAD from UNIDADES_PRY u where u.NIT_COMPANIA = g.NIT_COMPANIA and u.CODIGO_UND = g.UNIT_CODE) as UNITS_NAME,',
'                   (select c.SINGULAR_NAME from V_SPD_PLAN_LEVEL_CONFIG c',
'                     where c.NIT_COMPANIA = g.NIT_COMPANIA and c.PLAN = g.PLAN and c.NUM = l."LEVEL") as LEVEL_LABEL',
'              from SPD_GOAL g',
'              left join ENTIDADES_PRY e on e.ID = g.ENTITY_ID',
'              left join SPD_DEV_PLAN_LEVEL l on l.ID = g.DEV_PLAN_LEVEL_ID',
'             where g.ID = :P1062_ID and g.NIT_COMPANIA = :G_NIT_COMPANIA) loop',
'    :P1062_CODE := g.CODE;',
'    :P1062_NAME := g.NAME;',
'    :P1062_ENTITY := g.CODIGO_ENT_PRY || '' - '' || g.NOMBRE_ENT_PRY;',
'    :P1062_GOAL_TYPE := lov(''SPD - TIPO DE META'', g.GOAL_TYPE);',
'    :P1062_LEVEL := g.L_CODE || '' - '' || g.L_NAME;',
'    :P1062_LEVEL_LABEL := coalesce(g.LEVEL_LABEL, ''Nivel del plan'');',
'    :P1062_INDICATOR := g.INDICATOR;',
'    :P1062_UNITS := g.UNITS_NAME;',
'    :P1062_ACCUMULATION := case when g.ACCUMULATION_TYPE is not null then lov(''SPD - TIPO DE ACUMULACION'', g.ACCUMULATION_TYPE) end;',
'    :P1062_BASE_VALUE := g.BASE_VALUE;',
'    :P1062_GOAL_VALUE := g.GOAL_VALUE;',
'    :P1062_POLITIC := g.POLITIC;',
'    :P1062_PRODUCT := g.PRODUCT;',
'    :P1062_PI_BASE_VALUE := case when g.PRODUCT is not null then g.PI_BASE_VALUE end;',
'    :P1062_PI_GOAL_VALUE := case when g.PRODUCT is not null then g.PI_GOAL_VALUE end;',
'    select listagg(apex_escape.html(o.ID || '' - '' || o.NAME), ''<br>'') within group (order by o.ID) into :P1062_ODS',
'      from SPD_ODS o',
'     where o.ID in (select jt.V from json_table(g.ODS_IDS, ''$[*]'' columns (V number path ''$'')) jt);',
'  end loop;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>39589418550298362
);
wwv_flow_imp.component_end;
end;
/
