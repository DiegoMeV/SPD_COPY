prompt --application/pages/page_01065
begin
--   Manifest
--     PAGE: 01065
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
 p_id=>1065
,p_name=>unistr('SPD_Focalizaci\00F3n')
,p_alias=>'SPD_FOCALIZACION'
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Focalizaci\00F3n')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_imp.id(39430577226162891)
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'900'
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_read_only_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_read_only_when=>'P1065_EDITABLE'
,p_read_only_when2=>'S'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3691198642607318)
,p_plug_name=>'Estado'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>1
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3691718746607318)
,p_plug_name=>unistr('Localizaci\00F3n')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>5
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3691963223607319)
,p_plug_name=>unistr('G\00E9nero')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>20
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P1065_SECTION'
,p_plug_display_when_cond2=>'ed'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3692298928607319)
,p_plug_name=>'Zona'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>30
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P1065_SECTION'
,p_plug_display_when_cond2=>'ed'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3692550365607319)
,p_plug_name=>'Ciclos de Edad'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>40
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P1065_SECTION'
,p_plug_display_when_cond2=>'ed'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3693294333607319)
,p_plug_name=>unistr('Condici\00F3n')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>50
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P1065_SECTION'
,p_plug_display_when_cond2=>'ed'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3694007822607320)
,p_plug_name=>'Etnia'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>60
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P1065_SECTION'
,p_plug_display_when_cond2=>'ed'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3694792441607320)
,p_plug_name=>unistr('Instituci\00F3n')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>70
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P1065_SECTION'
,p_plug_display_when_cond2=>'org'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3695266573607320)
,p_plug_name=>'Canino'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>80
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P1065_SECTION'
,p_plug_display_when_cond2=>'re'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3695599835607320)
,p_plug_name=>'Felino'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>90
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P1065_SECTION'
,p_plug_display_when_cond2=>'re'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3695861426607320)
,p_plug_name=>'Otra Especie'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>100
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P1065_SECTION'
,p_plug_display_when_cond2=>'re'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3696190428607321)
,p_plug_name=>'Flora'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>110
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P1065_SECTION'
,p_plug_display_when_cond2=>'re'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3696391596607321)
,p_plug_name=>'Botones'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39487096731162903)
,p_plug_display_sequence=>500
,p_plug_display_point=>'REGION_POSITION_03'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3696450301607321)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(3696391596607321)
,p_button_name=>'CANCELAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(39601281081162925)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3696540065607321)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(3696391596607321)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>wwv_flow_imp.id(39601281081162925)
,p_button_image_alt=>'Eliminar'
,p_button_position=>'DELETE'
,p_button_redirect_url=>unistr('javascript:apex.confirm(''Eliminar focalizaci\00F3n'', ''DELETE'');')
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>':P1065_POS is not null and :P1065_EDITABLE = ''S'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3696665032607321)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(3696391596607321)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(39601281081162925)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Guardar'
,p_button_position=>'NEXT'
,p_button_condition=>'P1065_EDITABLE'
,p_button_condition2=>'S'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3691272075607318)
,p_name=>'P1065_REC_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(3691198642607318)
,p_prompt=>'REC_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3691344438607318)
,p_name=>'P1065_SECTION'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(3691198642607318)
,p_prompt=>'SECTION'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3691472262607318)
,p_name=>'P1065_POS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(3691198642607318)
,p_prompt=>'POS'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3691547832607318)
,p_name=>'P1065_EDITABLE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(3691198642607318)
,p_prompt=>'EDITABLE'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3691649790607318)
,p_name=>'P1065_KEY'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(3691198642607318)
,p_prompt=>'KEY'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3691899785607318)
,p_name=>'P1065_LOCALIZATION'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(3691718746607318)
,p_prompt=>unistr('Localizaci\00F3n')
,p_display_as=>'NATIVE_SHUTTLE'
,p_lov=>'select NAME || '' ('' || case LOCATION_TYPE when ''DEPARTMENT'' then ''Departamento'' when ''MUNICIPALITY'' then ''Municipio'' when ''TOWNSHIP'' then ''Corregimiento'' when ''RURAL_SETTLEMENT'' then ''Vereda'' when ''DISTRICT'' then ''Comuna'' when ''NEIGHBORHOOD'' then ''Ba'
||'rrio'' else ''Otro'' end || '')'' as d, ID as r from SPD_GEO_LOCATION where NIT_COMPANIA = :G_NIT_COMPANIA order by PARENT_LOCATION_ID nulls first, NAME'
,p_cHeight=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'show_controls', 'ALL')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3692098147607319)
,p_name=>'P1065_ED_GENRE_H'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(3691963223607319)
,p_prompt=>'Hombres'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3692104011607319)
,p_name=>'P1065_ED_GENRE_M'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(3691963223607319)
,p_prompt=>'Mujeres'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3692381110607319)
,p_name=>'P1065_ED_ZONE_U'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(3692298928607319)
,p_prompt=>'Urbano'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3692447284607319)
,p_name=>'P1065_ED_ZONE_R'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(3692298928607319)
,p_prompt=>'Rural'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3692631786607319)
,p_name=>'P1065_ED_AGE_PI'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(3692550365607319)
,p_prompt=>'Primera Infancia'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3692700589607319)
,p_name=>'P1065_ED_AGE_ADOL'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(3692550365607319)
,p_prompt=>'Adolescencia'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3692852519607319)
,p_name=>'P1065_ED_AGE_J'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(3692550365607319)
,p_prompt=>'Juventud'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3692928895607319)
,p_name=>'P1065_ED_AGE_AJ'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(3692550365607319)
,p_prompt=>'Adulto Joven'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3693075989607319)
,p_name=>'P1065_ED_AGE_A'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(3692550365607319)
,p_prompt=>'Adulto'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3693114721607319)
,p_name=>'P1065_ED_AGE_AM'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(3692550365607319)
,p_prompt=>'Adulto Mayor'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3693300394607320)
,p_name=>'P1065_ED_COND_NOC'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(3693294333607319)
,p_prompt=>unistr('Sin Condici\00F3n')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3693498135607320)
,p_name=>'P1065_ED_COND_D'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_imp.id(3693294333607319)
,p_prompt=>'Discapacidad'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3693509699607320)
,p_name=>'P1065_ED_COND_DES'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_imp.id(3693294333607319)
,p_prompt=>'Desplazado'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3693686984607320)
,p_name=>'P1065_ED_COND_VCA'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_imp.id(3693294333607319)
,p_prompt=>'Victima Conf.'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3693781641607320)
,p_name=>'P1065_ED_COND_MCH'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_imp.id(3693294333607319)
,p_prompt=>'Mujer C. H.'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3693824892607320)
,p_name=>'P1065_ED_COND_HC'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_imp.id(3693294333607319)
,p_prompt=>'Hab. Calle'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3693996945607320)
,p_name=>'P1065_ED_COND_MIG'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_imp.id(3693294333607319)
,p_prompt=>'Migrante'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3694197219607320)
,p_name=>'P1065_ED_ETNIA_MZ'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_imp.id(3694007822607320)
,p_prompt=>'Mestizo'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3694278295607320)
,p_name=>'P1065_ED_ETNIA_AFRO'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_imp.id(3694007822607320)
,p_prompt=>'AfroCol'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3694331929607320)
,p_name=>'P1065_ED_ETNIA_I'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_imp.id(3694007822607320)
,p_prompt=>unistr('Ind\00EDgena')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3694449179607320)
,p_name=>'P1065_ED_ETNIA_P'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_imp.id(3694007822607320)
,p_prompt=>'Palenquero'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3694570819607320)
,p_name=>'P1065_ED_ETNIA_R'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_imp.id(3694007822607320)
,p_prompt=>'Raizal'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3694627884607320)
,p_name=>'P1065_ED_ETNIA_ROM'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_imp.id(3694007822607320)
,p_prompt=>'ROM'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3694889569607320)
,p_name=>'P1065_ORG_TYPE'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_imp.id(3694792441607320)
,p_prompt=>unistr('Tipo de instituci\00F3n')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3694974998607320)
,p_name=>'P1065_ORG_OBJECT'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_imp.id(3694792441607320)
,p_prompt=>unistr('Objeto de instituci\00F3n')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3695036228607320)
,p_name=>'P1065_ORG_NUM'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_imp.id(3694792441607320)
,p_prompt=>unistr('N\00FAmero de beneficiarios')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3695104307607320)
,p_name=>'P1065_ORG_POP'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_imp.id(3694792441607320)
,p_prompt=>unistr('Total poblaci\00F3n /unidad')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3695346018607320)
,p_name=>'P1065_RE_CANINE_M'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_imp.id(3695266573607320)
,p_prompt=>'Macho'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3695468132607320)
,p_name=>'P1065_RE_CANINE_F'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_imp.id(3695266573607320)
,p_prompt=>'Hembra'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3695695489607320)
,p_name=>'P1065_RE_FELINE_M'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_imp.id(3695599835607320)
,p_prompt=>'Macho'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3695735120607320)
,p_name=>'P1065_RE_FELINE_F'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_imp.id(3695599835607320)
,p_prompt=>'Hembra'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3695957392607320)
,p_name=>'P1065_RE_OTHERS_M'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_imp.id(3695861426607320)
,p_prompt=>'Macho'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3696040261607321)
,p_name=>'P1065_RE_OTHERS_F'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_imp.id(3695861426607320)
,p_prompt=>'Hembra'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3696272360607321)
,p_name=>'P1065_RE_FLORA'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_imp.id(3696190428607321)
,p_prompt=>'Flora'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>12
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(3696772574607321)
,p_name=>'Cancelar'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(3696450301607321)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(3696835027607321)
,p_event_id=>wwv_flow_imp.id(3696772574607321)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3697097834607321)
,p_process_sequence=>420
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Guardar focalizaci\00F3n')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_tm    clob;',
'  l_root  json_object_t;',
'  l_sec   json_object_t;',
'  l_obj   json_object_t;',
'  l_arr   json_array_t := json_array_t();',
'  l_key   varchar2(100) := :P1065_KEY;',
'  l_label varchar2(4000);',
'  n       pls_integer := 0;',
'  procedure setp(o in out nocopy json_object_t, p varchar2, v varchar2, k varchar2) is',
'    g  json_object_t;',
'    gn varchar2(100);',
'    fn varchar2(100) := p;',
'  begin',
'    if instr(p, ''.'') > 0 then',
'      gn := substr(p, 1, instr(p, ''.'') - 1); fn := substr(p, instr(p, ''.'') + 1);',
'      g := case when o.has(gn) then o.get_object(gn) else json_object_t() end;',
'      if v is null then g.remove(fn); elsif k = ''N'' then g.put(fn, to_number(v)); else g.put(fn, v); end if;',
'      if g.get_size = 0 then o.remove(gn); else o.put(gn, g); end if;',
'    else',
'      if v is null then o.remove(fn); elsif k = ''N'' then o.put(fn, to_number(v)); else o.put(fn, v); end if;',
'    end if;',
'  end;',
'begin',
'  if :P1065_EDITABLE <> ''S'' then',
unistr('    raise_application_error(-20001, ''La focalizaci\00F3n no se puede modificar en esta etapa.'');'),
'  end if;',
'  select TARGET_MATRIX into l_tm from SPD_MONITORING_RECORD where ID = :P1065_REC_ID for update;',
'  l_root := json_object_t.parse(nvl(l_tm, ''{}''));',
'  l_sec := case when l_root.has(:P1065_SECTION) then l_root.get_object(:P1065_SECTION) else json_object_t() end;',
'  if l_key is not null and l_sec.has(l_key) then',
'    l_obj := l_sec.get_object(l_key);',
'  else',
'    while l_sec.has(''localizationTab'' || n) loop n := n + 1; end loop;',
'    l_key := ''localizationTab'' || n;',
'    l_obj := json_object_t();',
'  end if;',
'  for x in (select to_number(column_value) as ID from table(apex_string.split(:P1065_LOCALIZATION, '':''))) loop',
'    if x.ID is not null then l_arr.append(x.ID); end if;',
'  end loop;',
'  select listagg(g.NAME, '' - '') within group (order by g.NAME) into l_label',
'    from SPD_GEO_LOCATION g',
'   where g.ID in (select to_number(column_value) from table(apex_string.split(:P1065_LOCALIZATION, '':'')));',
'  l_obj.put(''localization'', l_arr);',
unistr('  l_obj.put(''localizationLabel'', nvl(l_label, ''Localizaci\00F3n?''));'),
'  for d in (select ''ed'' SEC, ''ED_GENRE_H'' ITEM, ''genre.h'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_GENRE_M'' ITEM, ''genre.m'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_ZONE_U'' ITEM, ''zone.u'' PATH, ''N'' KIND from dual union a'
||'ll select ''ed'' SEC, ''ED_ZONE_R'' ITEM, ''zone.r'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_AGE_PI'' ITEM, ''ageCycles.pi'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_AGE_ADOL'' ITEM, ''ageCycles.adol'' PATH, ''N'' KIND from dual unio'
||'n all select ''ed'' SEC, ''ED_AGE_J'' ITEM, ''ageCycles.j'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_AGE_AJ'' ITEM, ''ageCycles.aj'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_AGE_A'' ITEM, ''ageCycles.a'' PATH, ''N'' KIND from dual uni'
||'on all select ''ed'' SEC, ''ED_AGE_AM'' ITEM, ''ageCycles.am'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_COND_NOC'' ITEM, ''conditions.noC'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_COND_D'' ITEM, ''conditions.d'' PATH, ''N'' KIND from'
||' dual union all select ''ed'' SEC, ''ED_COND_DES'' ITEM, ''conditions.des'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_COND_VCA'' ITEM, ''conditions.vca'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_COND_MCH'' ITEM, ''conditions.mch'' PA'
||'TH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_COND_HC'' ITEM, ''conditions.hc'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_COND_MIG'' ITEM, ''conditions.mig'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_ETNIA_MZ'' ITEM, ''age'
||'Cycles.mz'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_ETNIA_AFRO'' ITEM, ''ageCycles.afro'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_ETNIA_I'' ITEM, ''ageCycles.i'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_ETNIA_P'
||''' ITEM, ''ageCycles.p'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_ETNIA_R'' ITEM, ''ageCycles.r'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_ETNIA_ROM'' ITEM, ''ageCycles.rom'' PATH, ''N'' KIND from dual union all select ''org'' SEC, '''
||'ORG_TYPE'' ITEM, ''orgType'' PATH, ''T'' KIND from dual union all select ''org'' SEC, ''ORG_OBJECT'' ITEM, ''orgObject'' PATH, ''T'' KIND from dual union all select ''org'' SEC, ''ORG_NUM'' ITEM, ''numBeneficiaries'' PATH, ''N'' KIND from dual union all select ''org'' SEC,'
||' ''ORG_POP'' ITEM, ''populationDesc'' PATH, ''T'' KIND from dual union all select ''re'' SEC, ''RE_CANINE_M'' ITEM, ''canine.m'' PATH, ''N'' KIND from dual union all select ''re'' SEC, ''RE_CANINE_F'' ITEM, ''canine.f'' PATH, ''N'' KIND from dual union all select ''re'' SEC'
||', ''RE_FELINE_M'' ITEM, ''feline.m'' PATH, ''N'' KIND from dual union all select ''re'' SEC, ''RE_FELINE_F'' ITEM, ''feline.f'' PATH, ''N'' KIND from dual union all select ''re'' SEC, ''RE_OTHERS_M'' ITEM, ''others.m'' PATH, ''N'' KIND from dual union all select ''re'' SEC,'
||' ''RE_OTHERS_F'' ITEM, ''others.f'' PATH, ''N'' KIND from dual union all select ''re'' SEC, ''RE_FLORA'' ITEM, ''flora'' PATH, ''T'' KIND from dual) loop',
'    if d.SEC = :P1065_SECTION then',
'      setp(l_obj, d.PATH, v(''P1065_'' || d.ITEM), d.KIND);',
'    end if;',
'  end loop;',
'  l_sec.put(l_key, l_obj);',
'  l_root.put(:P1065_SECTION, l_sec);',
'  l_tm := l_root.to_clob;',
'  update SPD_MONITORING_RECORD set TARGET_MATRIX = l_tm, UPDATED_AT = systimestamp where ID = :P1065_REC_ID;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>unistr('Focalizaci\00F3n guardada')
,p_internal_uid=>3697097834607321
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3697126843607321)
,p_process_sequence=>430
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Eliminar focalizaci\00F3n')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_tm   clob;',
'  l_root json_object_t;',
'  l_sec  json_object_t;',
'begin',
'  if :P1065_EDITABLE <> ''S'' then',
unistr('    raise_application_error(-20001, ''La focalizaci\00F3n no se puede modificar en esta etapa.'');'),
'  end if;',
'  select TARGET_MATRIX into l_tm from SPD_MONITORING_RECORD where ID = :P1065_REC_ID for update;',
'  l_root := json_object_t.parse(nvl(l_tm, ''{}''));',
'  if l_root.has(:P1065_SECTION) and :P1065_KEY is not null then',
'    l_sec := l_root.get_object(:P1065_SECTION);',
'    l_sec.remove(:P1065_KEY);',
'    l_root.put(:P1065_SECTION, l_sec);',
'    l_tm := l_root.to_clob;',
'    update SPD_MONITORING_RECORD set TARGET_MATRIX = l_tm, UPDATED_AT = systimestamp where ID = :P1065_REC_ID;',
'  end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'DELETE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>unistr('Focalizaci\00F3n eliminada')
,p_internal_uid=>3697126843607321
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3697243710607321)
,p_process_sequence=>440
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>unistr('Cerrar di\00E1logo')
,p_process_when=>'SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>3697243710607321
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3696907492607321)
,p_process_sequence=>410
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Cargar focalizaci\00F3n')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_tm   clob;',
'  l_root json_object_t;',
'  l_sec  json_object_t;',
'  l_obj  json_object_t;',
'  l_keys json_key_list;',
'  l_arr  json_array_t;',
'  l_loc  varchar2(4000);',
'  function getp(o json_object_t, p varchar2) return varchar2 is',
'    g json_object_t;',
'  begin',
'    if instr(p, ''.'') > 0 then',
'      if not o.has(substr(p, 1, instr(p, ''.'') - 1)) then return null; end if;',
'      g := o.get_object(substr(p, 1, instr(p, ''.'') - 1));',
'      if g is null or not g.has(substr(p, instr(p, ''.'') + 1)) then return null; end if;',
'      return g.get_string(substr(p, instr(p, ''.'') + 1));',
'    end if;',
'    if not o.has(p) then return null; end if;',
'    return o.get_string(p);',
'  end;',
'begin',
'  select TARGET_MATRIX into l_tm from SPD_MONITORING_RECORD where ID = :P1065_REC_ID;',
'  :P1065_KEY := null;',
'  if :P1065_POS is not null and l_tm is not null then',
'    l_root := json_object_t.parse(l_tm);',
'    if l_root.has(:P1065_SECTION) then',
'      l_sec := l_root.get_object(:P1065_SECTION);',
'      l_keys := l_sec.get_keys;',
'      if to_number(:P1065_POS) <= l_keys.count then',
'        :P1065_KEY := l_keys(to_number(:P1065_POS));',
'        l_obj := l_sec.get_object(:P1065_KEY);',
'      end if;',
'    end if;',
'  end if;',
'  if l_obj is null then l_obj := json_object_t(); :P1065_POS := null; end if;',
'  if l_obj.has(''localization'') then',
'    l_arr := l_obj.get_array(''localization'');',
'    for i in 0 .. l_arr.get_size - 1 loop',
'      l_loc := l_loc || case when l_loc is not null then '':'' end || l_arr.get_string(i);',
'    end loop;',
'  end if;',
'  :P1065_LOCALIZATION := l_loc;',
'  for d in (select ''ed'' SEC, ''ED_GENRE_H'' ITEM, ''genre.h'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_GENRE_M'' ITEM, ''genre.m'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_ZONE_U'' ITEM, ''zone.u'' PATH, ''N'' KIND from dual union a'
||'ll select ''ed'' SEC, ''ED_ZONE_R'' ITEM, ''zone.r'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_AGE_PI'' ITEM, ''ageCycles.pi'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_AGE_ADOL'' ITEM, ''ageCycles.adol'' PATH, ''N'' KIND from dual unio'
||'n all select ''ed'' SEC, ''ED_AGE_J'' ITEM, ''ageCycles.j'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_AGE_AJ'' ITEM, ''ageCycles.aj'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_AGE_A'' ITEM, ''ageCycles.a'' PATH, ''N'' KIND from dual uni'
||'on all select ''ed'' SEC, ''ED_AGE_AM'' ITEM, ''ageCycles.am'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_COND_NOC'' ITEM, ''conditions.noC'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_COND_D'' ITEM, ''conditions.d'' PATH, ''N'' KIND from'
||' dual union all select ''ed'' SEC, ''ED_COND_DES'' ITEM, ''conditions.des'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_COND_VCA'' ITEM, ''conditions.vca'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_COND_MCH'' ITEM, ''conditions.mch'' PA'
||'TH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_COND_HC'' ITEM, ''conditions.hc'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_COND_MIG'' ITEM, ''conditions.mig'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_ETNIA_MZ'' ITEM, ''age'
||'Cycles.mz'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_ETNIA_AFRO'' ITEM, ''ageCycles.afro'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_ETNIA_I'' ITEM, ''ageCycles.i'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_ETNIA_P'
||''' ITEM, ''ageCycles.p'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_ETNIA_R'' ITEM, ''ageCycles.r'' PATH, ''N'' KIND from dual union all select ''ed'' SEC, ''ED_ETNIA_ROM'' ITEM, ''ageCycles.rom'' PATH, ''N'' KIND from dual union all select ''org'' SEC, '''
||'ORG_TYPE'' ITEM, ''orgType'' PATH, ''T'' KIND from dual union all select ''org'' SEC, ''ORG_OBJECT'' ITEM, ''orgObject'' PATH, ''T'' KIND from dual union all select ''org'' SEC, ''ORG_NUM'' ITEM, ''numBeneficiaries'' PATH, ''N'' KIND from dual union all select ''org'' SEC,'
||' ''ORG_POP'' ITEM, ''populationDesc'' PATH, ''T'' KIND from dual union all select ''re'' SEC, ''RE_CANINE_M'' ITEM, ''canine.m'' PATH, ''N'' KIND from dual union all select ''re'' SEC, ''RE_CANINE_F'' ITEM, ''canine.f'' PATH, ''N'' KIND from dual union all select ''re'' SEC'
||', ''RE_FELINE_M'' ITEM, ''feline.m'' PATH, ''N'' KIND from dual union all select ''re'' SEC, ''RE_FELINE_F'' ITEM, ''feline.f'' PATH, ''N'' KIND from dual union all select ''re'' SEC, ''RE_OTHERS_M'' ITEM, ''others.m'' PATH, ''N'' KIND from dual union all select ''re'' SEC,'
||' ''RE_OTHERS_F'' ITEM, ''others.f'' PATH, ''N'' KIND from dual union all select ''re'' SEC, ''RE_FLORA'' ITEM, ''flora'' PATH, ''T'' KIND from dual) loop',
'    if d.SEC = :P1065_SECTION then',
'      apex_util.set_session_state(''P1065_'' || d.ITEM, getp(l_obj, d.PATH));',
'    end if;',
'  end loop;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>3696907492607321
);
wwv_flow_imp.component_end;
end;
/
