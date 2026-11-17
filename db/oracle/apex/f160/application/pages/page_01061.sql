prompt --application/pages/page_01061
begin
--   Manifest
--     PAGE: 01061
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
 p_id=>1061
,p_name=>'SPD_Estructura del plan'
,p_alias=>'SPD_ESTRUCTURA_PLAN'
,p_step_title=>'Estructura del plan de desarrollo'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>'var t = $("#spd_plan_tree"), s = t.treeView("getSelection"); if (s.length) { t.treeView("expand", s); }'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'16'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41221869152911673)
,p_plug_name=>unistr('\00C1rbol de Niveles \00B7 &P1061_PLAN_NOMBRE.')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>7
,p_query_type=>'SQL'
,p_plug_source=>'select case when connect_by_isleaf = 1 then 0 when VALUE = 0 or VALUE in (select ID from SPD_DEV_PLAN_LEVEL start with ID = to_number(:P1061_NODE) connect by ID = prior PARENT_ID) then 1 else -1 end as STATUS, level as LVL, TITLE, null as ICON, VALUE'
||', null as TOOLTIP, apex_page.get_url(p_items => ''P1061_NIT_COMPANIA,P1061_PLAN,P1061_NODE'', p_values => :P1061_NIT_COMPANIA || '','' || :P1061_PLAN || '','' || VALUE) as LINK from (select 0 as VALUE, null as PARENT, NOMBRE as TITLE, null as CODE from PLA'
||'N_DESARROLLO where NIT_COMPANIA = :P1061_NIT_COMPANIA and PLAN = :P1061_PLAN union all select ID, nvl(PARENT_ID, 0), CODE || '' '' || NAME, CODE from SPD_DEV_PLAN_LEVEL where NIT_COMPANIA = :P1061_NIT_COMPANIA and PLAN = :P1061_PLAN) start with PARENT '
||'is null connect by prior VALUE = PARENT order siblings by nlssort(CODE, ''NLS_SORT=BINARY'')'
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_JSTREE'
,p_plug_header=>'<div class="t-Alert t-Alert--colorBG t-Alert--horizontal t-Alert--info" style="margin-bottom:8px"><div class="t-Alert-body">Seleccione un nodo para editar, eliminar o crear niveles hijos.</div></div>'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'activate_node_link_with', 'S',
  'default_icon_css_class', 'icon-tree-folder',
  'hierarchy_level_column', 'LVL',
  'icon_css_class_column', 'ICON',
  'link_column', 'LINK',
  'node_label_column', 'TITLE',
  'node_status_column', 'STATUS',
  'node_value_column', 'VALUE',
  'selected_node_page_item', 'P1061_NODE',
  'static_tree_id', 'spd_plan_tree',
  'tree_hierarchy', 'LEVEL',
  'tree_tooltip', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41223050457911673)
,p_plug_name=>'Editar &P1061_LEVEL_NAME.'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>5
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>'nvl(:P1061_NODE, ''0'') <> ''0'''
,p_plug_display_when_cond2=>'PLSQL'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(41224161426911674)
,p_plug_name=>'Crear &P1061_CHILD_NAME.'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P1061_CHILD_NAME'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41222939265911673)
,p_button_sequence=>270
,p_button_plug_id=>wwv_flow_imp.id(645812698170947339)
,p_button_name=>'VOLVER'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Regresar'
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:1060:&APP_SESSION.::&DEBUG.:1060:P1060_NIT_COMPANIA,P1060_PLAN:&P1061_NIT_COMPANIA.,&P1061_PLAN.'
,p_icon_css_classes=>'fa-arrow-left'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41223515216911674)
,p_button_sequence=>320
,p_button_plug_id=>wwv_flow_imp.id(41223050457911673)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Guardar'
,p_button_position=>'TOP'
,p_button_alignment=>'RIGHT'
,p_icon_css_classes=>'fa-save'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41223669362911674)
,p_button_sequence=>330
,p_button_plug_id=>wwv_flow_imp.id(41223050457911673)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>wwv_flow_imp.id(39601281081162925)
,p_button_image_alt=>'Eliminar'
,p_button_position=>'TOP'
,p_button_alignment=>'RIGHT'
,p_confirm_message=>unistr('El nivel seleccionado se eliminar\00E1 de forma permanente junto con sus nodos hijos. \00BFDesea continuar?')
,p_confirm_style=>'danger'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41224638104911674)
,p_button_sequence=>420
,p_button_plug_id=>wwv_flow_imp.id(41224161426911674)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_image_alt=>'Crear'
,p_button_position=>'TOP'
,p_button_alignment=>'RIGHT'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(41225184594911674)
,p_branch_name=>'Volver a la estructura'
,p_branch_action=>'f?p=&APP_ID.:1061:&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41221929898911673)
,p_name=>'P1061_NIT_COMPANIA'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(41221869152911673)
,p_item_default=>'G_NIT_COMPANIA'
,p_item_default_type=>'ITEM'
,p_prompt=>'NIT'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41222087601911673)
,p_name=>'P1061_PLAN'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_imp.id(41221869152911673)
,p_prompt=>'Plan'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41222125323911673)
,p_name=>'P1061_NODE'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_imp.id(41221869152911673)
,p_prompt=>'Nodo'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41222250163911673)
,p_name=>'P1061_LEVEL'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_imp.id(41221869152911673)
,p_prompt=>'Nivel'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41222362371911673)
,p_name=>'P1061_PARENT'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_imp.id(41221869152911673)
,p_prompt=>'Padre'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41222505725911673)
,p_name=>'P1061_PLAN_NOMBRE'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_imp.id(41221869152911673)
,p_prompt=>'Plan'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41222520223911673)
,p_name=>'P1061_LEVEL_NAME'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_imp.id(41221869152911673)
,p_prompt=>'Nombre del nivel'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41222691691911673)
,p_name=>'P1061_IS_SECTOR'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_imp.id(41221869152911673)
,p_prompt=>'Es sector'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41222720609911673)
,p_name=>'P1061_CHILD_NAME'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_imp.id(41221869152911673)
,p_prompt=>'Nombre del nivel hijo'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41222835420911673)
,p_name=>'P1061_CHILD_IS_SECTOR'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_imp.id(41221869152911673)
,p_prompt=>'Hijo es sector'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41223154609911673)
,p_name=>'P1061_CODE'
,p_item_sequence=>1940
,p_item_plug_id=>wwv_flow_imp.id(41223050457911673)
,p_prompt=>unistr('C\00F3digo')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>50
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41223228948911674)
,p_name=>'P1061_NAME'
,p_item_sequence=>1950
,p_item_plug_id=>wwv_flow_imp.id(41223050457911673)
,p_prompt=>'Nombre'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>1000
,p_begin_on_new_line=>'N'
,p_colspan=>8
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41223336094911674)
,p_name=>'P1061_SECTOR'
,p_item_sequence=>1960
,p_item_plug_id=>wwv_flow_imp.id(41223050457911673)
,p_prompt=>'Sector DNP'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select CODE || '' - '' || NAME d, ID r from SPD_PRODUCT_CATALOG where PARENT_ID is null order by CODE'
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_colspan=>8
,p_display_when=>':P1061_IS_SECTOR = ''S'''
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41223418047911674)
,p_name=>'P1061_WEIGHTING'
,p_item_sequence=>1970
,p_item_plug_id=>wwv_flow_imp.id(41223050457911673)
,p_prompt=>unistr('Ponderaci\00F3n')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41224307202911674)
,p_name=>'P1061_NEW_CODE'
,p_item_sequence=>1980
,p_item_plug_id=>wwv_flow_imp.id(41224161426911674)
,p_prompt=>unistr('C\00F3digo')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>50
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41224335190911674)
,p_name=>'P1061_NEW_NAME'
,p_item_sequence=>1990
,p_item_plug_id=>wwv_flow_imp.id(41224161426911674)
,p_prompt=>'Nombre'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>1000
,p_begin_on_new_line=>'N'
,p_colspan=>8
,p_field_template=>wwv_flow_imp.id(39597068959162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41224425505911674)
,p_name=>'P1061_NEW_SECTOR'
,p_item_sequence=>2000
,p_item_plug_id=>wwv_flow_imp.id(41224161426911674)
,p_prompt=>'Sector DNP'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select CODE || '' - '' || NAME d, ID r from SPD_PRODUCT_CATALOG where PARENT_ID is null order by CODE'
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_colspan=>8
,p_display_when=>':P1061_CHILD_IS_SECTOR = ''S'''
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41224599464911674)
,p_name=>'P1061_NEW_WEIGHTING'
,p_item_sequence=>2010
,p_item_plug_id=>wwv_flow_imp.id(41224161426911674)
,p_prompt=>unistr('Ponderaci\00F3n')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'right',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(41223802686911674)
,p_validation_name=>'P1061_CODE obligatorio'
,p_validation_sequence=>330
,p_validation=>'P1061_CODE'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('C\00F3digo es obligatorio.')
,p_when_button_pressed=>wwv_flow_imp.id(41223515216911674)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(41223883822911674)
,p_validation_name=>'P1061_NAME obligatorio'
,p_validation_sequence=>340
,p_validation=>'P1061_NAME'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Nombre es obligatorio.'
,p_when_button_pressed=>wwv_flow_imp.id(41223515216911674)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(41224814349911674)
,p_validation_name=>'P1061_NEW_CODE obligatorio'
,p_validation_sequence=>420
,p_validation=>'P1061_NEW_CODE'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('C\00F3digo es obligatorio.')
,p_when_button_pressed=>wwv_flow_imp.id(41224638104911674)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(41224893730911674)
,p_validation_name=>'P1061_NEW_NAME obligatorio'
,p_validation_sequence=>430
,p_validation=>'P1061_NEW_NAME'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Nombre es obligatorio.'
,p_when_button_pressed=>wwv_flow_imp.id(41224638104911674)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41223956978911674)
,p_process_sequence=>360
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Guardar nivel'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
'  update SPD_DEV_PLAN_LEVEL',
'     set CODE = :P1061_CODE, NAME = :P1061_NAME,',
'         PRODUCT_CATALOG_ID = case when :P1061_IS_SECTOR = ''S'' then to_number(:P1061_SECTOR) else PRODUCT_CATALOG_ID end,',
'         WEIGHTING = to_number(:P1061_WEIGHTING), UPDATED_AT = systimestamp',
'   where ID = :P1061_NODE and NIT_COMPANIA = :P1061_NIT_COMPANIA and PLAN = :P1061_PLAN;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(41223515216911674)
,p_process_success_message=>'Nivel actualizado.'
,p_internal_uid=>39582942279298272
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41224078103911674)
,p_process_sequence=>370
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Eliminar nivel e hijos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
unistr('  -- primero los m\00E1s profundos (la FK PARENT_ID apunta a la misma tabla)'),
'  for r in (select ID from SPD_DEV_PLAN_LEVEL',
'             start with ID = :P1061_NODE and NIT_COMPANIA = :P1061_NIT_COMPANIA and PLAN = :P1061_PLAN',
'           connect by prior ID = PARENT_ID order by level desc) loop',
'    delete from SPD_DEV_PLAN_LEVEL where ID = r.ID;',
'  end loop;',
'  :P1061_NODE := nvl(:P1061_PARENT, ''0'');',
'exception',
'  when others then',
'    if sqlcode = -2292 then',
'      rollback;',
'      apex_error.add_error(p_message => ''No se puede eliminar: el nivel o alguno de sus hijos tiene metas asociadas.'',',
'                           p_display_location => apex_error.c_inline_in_notification);',
'    else',
'      raise;',
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(41223669362911674)
,p_process_success_message=>'Nivel eliminado.'
,p_internal_uid=>39583063404298272
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41224937257911674)
,p_process_sequence=>450
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Crear nivel'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
'  insert into SPD_DEV_PLAN_LEVEL (NIT_COMPANIA, PLAN, CODE, NAME, "LEVEL", PARENT_ID, PRODUCT_CATALOG_ID, WEIGHTING)',
'  values (:P1061_NIT_COMPANIA, :P1061_PLAN, :P1061_NEW_CODE, :P1061_NEW_NAME, to_number(:P1061_LEVEL) + 1,',
'          nullif(to_number(:P1061_NODE), 0), to_number(:P1061_NEW_SECTOR), to_number(:P1061_NEW_WEIGHTING));',
'  :P1061_NEW_CODE := null; :P1061_NEW_NAME := null; :P1061_NEW_SECTOR := null; :P1061_NEW_WEIGHTING := null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(41224638104911674)
,p_process_success_message=>'Nivel creado.'
,p_internal_uid=>39583922558298272
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(41225020588911674)
,p_process_sequence=>460
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cargar nodo'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  procedure level_info(p_num number, p_name out varchar2, p_sector out varchar2) is',
'    l_has_cfg number;',
'  begin',
'    select count(*), max(case when jt.NUM = p_num then jt.SINGULAR_NAME end),',
'           max(case when jt.NUM = p_num and jt.IS_SECTOR = ''true'' then ''S'' end)',
'      into l_has_cfg, p_name, p_sector',
'      from PLAN_DESARROLLO p,',
'           json_table(p.SPD_CONFIG, ''$.levels[*]'' columns (NUM number path ''$.number'',',
'                      SINGULAR_NAME varchar2(200) path ''$.singularName'', IS_SECTOR varchar2(10) path ''$.isSectorLevel'')) jt',
'     where p.NIT_COMPANIA = :P1061_NIT_COMPANIA and p.PLAN = :P1061_PLAN;',
unistr('    -- sin configuraci\00F3n: niveles gen\00E9ricos 1..9'),
'    if l_has_cfg = 0 and p_num between 1 and 9 then p_name := ''Nivel '' || p_num; end if;',
'  end;',
'begin',
'  select NOMBRE into :P1061_PLAN_NOMBRE from PLAN_DESARROLLO',
'   where NIT_COMPANIA = :P1061_NIT_COMPANIA and PLAN = :P1061_PLAN;',
'  :P1061_NODE := nvl(:P1061_NODE, ''0'');',
'  if :P1061_NODE <> ''0'' then',
'    begin',
'      select CODE, NAME, PRODUCT_CATALOG_ID, WEIGHTING, nvl("LEVEL", 1), PARENT_ID',
'        into :P1061_CODE, :P1061_NAME, :P1061_SECTOR, :P1061_WEIGHTING, :P1061_LEVEL, :P1061_PARENT',
'        from SPD_DEV_PLAN_LEVEL',
'       where ID = :P1061_NODE and NIT_COMPANIA = :P1061_NIT_COMPANIA and PLAN = :P1061_PLAN;',
'    exception when no_data_found then :P1061_NODE := ''0'';',
'    end;',
'  end if;',
'  if :P1061_NODE = ''0'' then',
'    :P1061_LEVEL := 0; :P1061_PARENT := null;',
'    :P1061_CODE := null; :P1061_NAME := null; :P1061_SECTOR := null; :P1061_WEIGHTING := null;',
'  end if;',
'  level_info(to_number(:P1061_LEVEL), :P1061_LEVEL_NAME, :P1061_IS_SECTOR);',
'  level_info(to_number(:P1061_LEVEL) + 1, :P1061_CHILD_NAME, :P1061_CHILD_IS_SECTOR);',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>39584005889298272
);
wwv_flow_imp.component_end;
end;
/
