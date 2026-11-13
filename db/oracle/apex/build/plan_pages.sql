-- Planes de desarrollo: páginas "Detalles del plan" y "Estructura del plan" (árbol de niveles),
-- como en el original (client/components/DevPlan/DevPlanDetails.tsx y DevPlanLevels.tsx).
-- El enlace del reporte de planes abre Detalles; desde ahí se va a Editar (formulario) y a Estructura.
-- Sin JavaScript: el árbol es la región Tree nativa; al seleccionar un nodo se recarga la página.
-- Se ejecuta como APEX_240100 después de plan_detail.sql. Es re-ejecutable.
set serveroutput on size unlimited
set define off
whenever sqlerror exit failure

declare
  c_app     constant number := 100;
  c_det     constant number := 60;   -- Detalles del plan
  c_est     constant number := 61;   -- Estructura del plan
  l_sgid    number;
  l_form    number;                  -- formulario del plan (editar)
  l_ir      number;                  -- reporte de planes
  l_tpl_std number;
  l_tpl_btn number;
  l_ft_opt  number;
  l_ft_req  number;
  l_ft_above number;
  l_plug    number;
  l_btn     number;
  l_seq     pls_integer := 0;

  -- consulta del árbol: raíz = el plan (valor 0), hijos = SPD_DEV_PLAN_LEVEL del plan
  function tree_sql(p varchar2, p_status varchar2, p_link varchar2) return varchar2 is
  begin
    return 'select ' || p_status || ' as STATUS, level as LVL, TITLE, null as ICON, VALUE, null as TOOLTIP, '
        || p_link || ' as LINK from ('
        || 'select 0 as VALUE, null as PARENT, NOMBRE as TITLE, null as CODE from PLAN_DESARROLLO '
        || 'where NIT_COMPANIA = :' || p || '_NIT_COMPANIA and PLAN = :' || p || '_PLAN '
        || 'union all select ID, nvl(PARENT_ID, 0), CODE || '' '' || NAME, CODE from SPD_DEV_PLAN_LEVEL '
        || 'where NIT_COMPANIA = :' || p || '_NIT_COMPANIA and PLAN = :' || p || '_PLAN) '
        || 'start with PARENT is null connect by prior VALUE = PARENT order siblings by nlssort(CODE, ''NLS_SORT=BINARY'')';
  end;

  function tree_attrs(p_selected_item varchar2, p_tree_id varchar2) return clob is
  begin
    return wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
      'activate_node_link_with', 'S',
      'default_icon_css_class', 'icon-tree-folder',
      'hierarchy_level_column', 'LVL',
      'icon_css_class_column', 'ICON',
      'link_column', 'LINK',
      'node_label_column', 'TITLE',
      'node_status_column', 'STATUS',
      'node_value_column', 'VALUE',
      'selected_node_page_item', p_selected_item,
      'static_tree_id', p_tree_id,
      'tree_hierarchy', 'LEVEL',
      'tree_tooltip', 'N')).to_clob;
  end;

  function region(p_page number, p_name varchar2, p_seq number, p_type varchar2 default 'NATIVE_STATIC',
                  p_sql varchar2 default null, p_attrs clob default null, p_span number default null,
                  p_new_row boolean default true, p_new_col boolean default true,
                  p_cond_type varchar2 default null, p_cond varchar2 default null,
                  p_header varchar2 default null) return number is
    l_id number := wwv_flow_id.next_val;
  begin
    wwv_flow_imp_page.create_page_plug(p_id => l_id, p_flow_id => c_app, p_page_id => p_page,
      p_plug_name => p_name, p_region_template_options => '#DEFAULT#', p_plug_template => l_tpl_std,
      p_plug_display_sequence => p_seq, p_plug_display_point => 'BODY',
      p_plug_new_grid_row => p_new_row, p_plug_new_grid_column => p_new_col, p_plug_grid_column_span => p_span,
      p_query_type => case when p_sql is not null then 'SQL' end, p_plug_source => p_sql,
      p_plug_source_type => p_type, p_attributes => p_attrs, p_plug_header => p_header,
      p_plug_display_condition_type => p_cond_type, p_plug_display_when_condition => p_cond,
      p_plug_display_when_cond2 => case when p_cond_type = 'EXPRESSION' then 'PLSQL' end);
    return l_id;
  end;

  procedure item(p_page number, p_plug number, p_name varchar2, p_label varchar2, p_type varchar2,
                 p_new_line boolean default true, p_format varchar2 default 'PLAIN',
                 p_lov varchar2 default null, p_cond varchar2 default null, p_required boolean default false,
                 p_max number default null) is
  begin
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_page_item(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => p_page,
      p_name => p_name, p_item_sequence => l_seq, p_item_plug_id => p_plug, p_prompt => p_label,
      p_display_as => p_type, p_use_cache_before_default => 'YES',
      p_begin_on_new_line => case when p_new_line then 'Y' else 'N' end,
      p_field_template => case when p_type = 'NATIVE_DISPLAY_ONLY' then l_ft_above
                               when p_required then l_ft_req else l_ft_opt end,
      p_item_template_options => '#DEFAULT#',
      p_csize => 30, p_cmaxlength => p_max, p_is_persistent => 'Y',
      p_lov => p_lov, p_lov_display_null => case when p_lov is not null then 'YES' end,
      p_display_when_type => case when p_cond is not null then 'EXPRESSION' end, p_display_when => p_cond,
      p_display_when2 => case when p_cond is not null then 'PLSQL' end,
      p_attribute_01 => case p_type when 'NATIVE_HIDDEN' then 'Y' when 'NATIVE_DISPLAY_ONLY' then 'N'
                                    when 'NATIVE_TEXT_FIELD' then 'N' when 'NATIVE_SELECT_LIST' then 'NONE' end,
      p_attribute_02 => case p_type when 'NATIVE_DISPLAY_ONLY' then 'VALUE' when 'NATIVE_TEXT_FIELD' then 'N'
                                    when 'NATIVE_SELECT_LIST' then 'N' end,
      p_attribute_03 => case p_type when 'NATIVE_TEXT_FIELD' then 'N' when 'NATIVE_NUMBER_FIELD' then 'right' end,
      p_attribute_04 => case p_type when 'NATIVE_DISPLAY_ONLY' then 'Y' when 'NATIVE_TEXT_FIELD' then 'TEXT'
                                    when 'NATIVE_NUMBER_FIELD' then 'decimal' end,
      p_attribute_05 => case p_type when 'NATIVE_DISPLAY_ONLY' then p_format when 'NATIVE_TEXT_FIELD' then 'BOTH' end);
  end;

  function button(p_page number, p_plug number, p_name varchar2, p_label varchar2, p_position varchar2,
                  p_url varchar2 default null, p_hot boolean default false, p_confirm varchar2 default null,
                  p_danger boolean default false) return number is
    l_id number := wwv_flow_id.next_val;
  begin
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_page_button(p_id => l_id, p_flow_id => c_app, p_flow_step_id => p_page,
      p_button_sequence => l_seq, p_button_plug_id => p_plug, p_button_name => p_name,
      p_button_action => case when p_url is not null then 'REDIRECT_URL' else 'SUBMIT' end,
      p_button_redirect_url => p_url, p_button_template_id => l_tpl_btn,
      p_button_template_options => case when p_danger then '#DEFAULT#:t-Button--danger:t-Button--simple' else '#DEFAULT#' end,
      p_button_is_hot => case when p_hot then 'Y' else 'N' end, p_button_image_alt => p_label,
      p_button_position => p_position, p_confirm_message => p_confirm,
      p_confirm_style => case when p_confirm is not null then 'danger' end);
    return l_id;
  end;

  procedure required(p_page number, p_item varchar2, p_label varchar2, p_button number) is
  begin
    wwv_flow_imp_page.create_page_validation(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => p_page,
      p_validation_name => p_item || ' obligatorio', p_validation_sequence => l_seq, p_validation => p_item,
      p_validation_type => 'ITEM_NOT_NULL', p_error_message => p_label || ' es obligatorio.',
      p_when_button_pressed => p_button, p_error_display_location => 'INLINE_WITH_FIELD_AND_NOTIFICATION');
    l_seq := l_seq + 10;
  end;

  procedure process(p_page number, p_name varchar2, p_point varchar2, p_code varchar2,
                    p_button number default null, p_success varchar2 default null) is
  begin
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_page_process(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => p_page,
      p_process_sequence => l_seq, p_process_point => p_point, p_process_type => 'NATIVE_PLSQL',
      p_process_name => p_name, p_process_sql_clob => p_code, p_process_clob_language => 'PLSQL',
      p_error_display_location => 'INLINE_IN_NOTIFICATION',
      p_process_when_button_id => p_button, p_process_success_message => p_success);
  end;

  function url(p_page number, p_items varchar2 default null, p_values varchar2 default null) return varchar2 is
  begin
    return 'f?p=&APP_ID.:' || p_page || ':&APP_SESSION.::&DEBUG.:' || case when p_items is not null then p_page end
        || ':' || p_items || ':' || p_values;
  end;
begin
  l_sgid := apex_util.find_security_group_id(p_workspace => 'SPD');
  wwv_flow_security.g_security_group_id := l_sgid;
  wwv_flow_imp.import_begin(p_version_yyyy_mm_dd => '2024.05.31', p_release => '24.1.0',
    p_default_workspace_id => l_sgid, p_default_application_id => c_app, p_default_id_offset => 0,
    p_default_owner => 'SIIF');

  select page_id into l_form from wwv_flow_page_plugs
   where flow_id = c_app and plug_source_type = 'NATIVE_FORM' and query_table = 'PLAN_DESARROLLO';
  select min(flow_step_id) into l_ir from wwv_flow_step_buttons
   where flow_id = c_app and flow_step_id not in (l_form, c_det, c_est)
     and button_redirect_url like 'f?p=&APP_ID.:' || l_form || ':%';
  select id into l_tpl_std  from wwv_flow_page_plug_templates where flow_id = c_app and page_plug_template_name = 'Standard';
  select id into l_tpl_btn  from wwv_flow_button_templates   where flow_id = c_app and template_name = 'Text';
  select id into l_ft_opt   from wwv_flow_field_templates    where flow_id = c_app and template_name = 'Optional - Floating';
  select id into l_ft_req   from wwv_flow_field_templates    where flow_id = c_app and template_name = 'Required - Floating';
  select id into l_ft_above from wwv_flow_field_templates    where flow_id = c_app and template_name = 'Optional - Above';

  -- re-ejecutable
  for p in (select id from wwv_flow_steps where flow_id = c_app and id in (c_det, c_est)) loop
    wwv_flow_imp_page.remove_page(p_flow_id => c_app, p_page_id => p.id);
  end loop;

  -- ============================================================================
  -- 60 · Detalles del plan
  -----------------------------------------------------------------------------
  wwv_flow_imp_page.create_page(p_id => c_det, p_flow_id => c_app, p_name => 'Detalles del plan',
    p_alias => 'DETALLES-DEL-PLAN', p_step_title => 'Plan de Desarrollo', p_autocomplete_on_off => 'OFF',
    p_page_template_options => '#DEFAULT#', p_protection_level => 'C');

  l_plug := region(c_det, 'Plan de Desarrollo', 10);
  item(c_det, l_plug, 'P60_NIT_COMPANIA', 'NIT', 'NATIVE_HIDDEN');
  item(c_det, l_plug, 'P60_PLAN', 'Plan', 'NATIVE_HIDDEN');
  item(c_det, l_plug, 'P60_COMPANIA', 'Compañía', 'NATIVE_DISPLAY_ONLY');
  item(c_det, l_plug, 'P60_ID', 'ID', 'NATIVE_DISPLAY_ONLY', p_new_line => false);
  item(c_det, l_plug, 'P60_CODIGO', 'Código', 'NATIVE_DISPLAY_ONLY', p_new_line => false);
  item(c_det, l_plug, 'P60_NOMBRE', 'Nombre', 'NATIVE_DISPLAY_ONLY');
  item(c_det, l_plug, 'P60_GOBERNANTE', 'Nombre Gobernante', 'NATIVE_DISPLAY_ONLY');
  item(c_det, l_plug, 'P60_FECHA_INICIO', 'Fecha Inicio', 'NATIVE_DISPLAY_ONLY');
  item(c_det, l_plug, 'P60_FECHA_FIN', 'Fecha Fin', 'NATIVE_DISPLAY_ONLY', p_new_line => false);
  item(c_det, l_plug, 'P60_INICIO_GOBIERNO', 'Fecha Inicio Gobierno', 'NATIVE_DISPLAY_ONLY');
  item(c_det, l_plug, 'P60_FIN_GOBIERNO', 'Fecha Fin Gobierno', 'NATIVE_DISPLAY_ONLY', p_new_line => false);
  item(c_det, l_plug, 'P60_NIVELES', 'Niveles', 'NATIVE_DISPLAY_ONLY', p_format => 'HTML');
  l_btn := button(c_det, l_plug, 'VOLVER', 'Volver', 'PREVIOUS', url(l_ir));
  l_btn := button(c_det, l_plug, 'EDITAR', 'Editar', 'EDIT',
                  url(l_form, 'P' || l_form || '_NIT_COMPANIA,P' || l_form || '_PLAN', '&P60_NIT_COMPANIA.,&P60_PLAN.'), p_hot => true);

  l_plug := region(c_det, 'Estructura del Plan', 20, 'NATIVE_JSTREE',
    tree_sql('P60', 'case when connect_by_isleaf = 1 then 0 when level <= 2 then 1 else -1 end', 'null'),
    tree_attrs(null, 'spd_plan_tree_det'));
  l_btn := button(c_det, l_plug, 'EDITAR_ESTRUCTURA', 'Editar Estructura', 'EDIT',
                  url(c_est, 'P61_NIT_COMPANIA,P61_PLAN', '&P60_NIT_COMPANIA.,&P60_PLAN.'), p_hot => true);

  process(c_det, 'Cargar plan', 'BEFORE_HEADER', q'~
begin
  select c.NOMBRE, p.ID, p.PLAN, p.NOMBRE, p.GOBERNANTE,
         to_char(p.FECHA_INICIO, 'DD/MM/YYYY'), to_char(p.FECHA_FIN, 'DD/MM/YYYY'),
         to_char(p.SPD_INICIO_GOBIERNO, 'DD/MM/YYYY'), to_char(p.SPD_FIN_GOBIERNO, 'DD/MM/YYYY')
    into :P60_COMPANIA, :P60_ID, :P60_CODIGO, :P60_NOMBRE, :P60_GOBERNANTE,
         :P60_FECHA_INICIO, :P60_FECHA_FIN, :P60_INICIO_GOBIERNO, :P60_FIN_GOBIERNO
    from PLAN_DESARROLLO p left join COMPANIA c on c.NIT_COMPANIA = p.NIT_COMPANIA
   where p.NIT_COMPANIA = :P60_NIT_COMPANIA and p.PLAN = :P60_PLAN;
  -- niveles configurados del plan (SPD_CONFIG.levels), como lista anidada
  select listagg('<li>' || apex_escape.html(jt.NUM || '. ' || jt.PLURAL_NAME
                 || case when jt.GOAL_TYPE is not null then ' (Metas de '
                    || nvl((select e.DISPLAY_VALUE from APEX_APPLICATION_LOV_ENTRIES e
                             where e.APPLICATION_ID = :APP_ID and e.LIST_OF_VALUES_NAME = 'SPD - TIPO DE META'
                               and e.RETURN_VALUE = jt.GOAL_TYPE), jt.GOAL_TYPE) || ')' end) || '<ul>', '')
           within group (order by jt.NUM)
         || rpad('</ul></li>', 10 * count(*), '</ul></li>')
    into :P60_NIVELES
    from PLAN_DESARROLLO p,
         json_table(p.SPD_CONFIG, '$.levels[*]' columns (NUM number path '$.number',
                    PLURAL_NAME varchar2(200) path '$.pluralName', GOAL_TYPE varchar2(30) path '$.goalType')) jt
   where p.NIT_COMPANIA = :P60_NIT_COMPANIA and p.PLAN = :P60_PLAN;
  if :P60_NIVELES is not null then :P60_NIVELES := '<ul class="spd-levels">' || :P60_NIVELES || '</ul>'; end if;
end;~');

  -- ============================================================================
  -- 61 · Estructura del plan (árbol + editar nodo + crear hijo)
  -----------------------------------------------------------------------------
  wwv_flow_imp_page.create_page(p_id => c_est, p_flow_id => c_app, p_name => 'Estructura del plan',
    p_alias => 'ESTRUCTURA-DEL-PLAN', p_step_title => 'Estructura del plan de desarrollo',
    -- el Tree no expande el nodo seleccionado: se expande al cargar para ver sus hijos
    p_javascript_code_onload => 'var t = $("#spd_plan_tree"), s = t.treeView("getSelection"); if (s.length) { t.treeView("expand", s); }',
    p_autocomplete_on_off => 'OFF', p_page_template_options => '#DEFAULT#', p_protection_level => 'C');

  -- izquierda: árbol (el nodo seleccionado y sus ancestros quedan expandidos)
  l_plug := region(c_est, 'Árbol de Niveles · &P61_PLAN_NOMBRE.', 10, 'NATIVE_JSTREE',
    tree_sql('P61', 'case when connect_by_isleaf = 1 then 0 when VALUE = 0 or VALUE in (select ID from SPD_DEV_PLAN_LEVEL '
                 || 'start with ID = to_number(:P61_NODE) connect by ID = prior PARENT_ID) then 1 else -1 end',
             'apex_page.get_url(p_items => ''P61_NIT_COMPANIA,P61_PLAN,P61_NODE'', '
             || 'p_values => :P61_NIT_COMPANIA || '','' || :P61_PLAN || '','' || VALUE)'),
    tree_attrs('P61_NODE', 'spd_plan_tree'), p_span => 7,
    p_header => '<div class="t-Alert t-Alert--colorBG t-Alert--horizontal t-Alert--info" style="margin-bottom:8px">'
             || '<div class="t-Alert-body">Seleccione un nodo para editar, eliminar o crear niveles hijos.</div></div>');
  item(c_est, l_plug, 'P61_NIT_COMPANIA', 'NIT', 'NATIVE_HIDDEN');
  item(c_est, l_plug, 'P61_PLAN', 'Plan', 'NATIVE_HIDDEN');
  item(c_est, l_plug, 'P61_NODE', 'Nodo', 'NATIVE_HIDDEN');
  item(c_est, l_plug, 'P61_LEVEL', 'Nivel', 'NATIVE_HIDDEN');
  item(c_est, l_plug, 'P61_PARENT', 'Padre', 'NATIVE_HIDDEN');
  item(c_est, l_plug, 'P61_PLAN_NOMBRE', 'Plan', 'NATIVE_HIDDEN');
  item(c_est, l_plug, 'P61_LEVEL_NAME', 'Nombre del nivel', 'NATIVE_HIDDEN');
  item(c_est, l_plug, 'P61_IS_SECTOR', 'Es sector', 'NATIVE_HIDDEN');
  item(c_est, l_plug, 'P61_CHILD_NAME', 'Nombre del nivel hijo', 'NATIVE_HIDDEN');
  item(c_est, l_plug, 'P61_CHILD_IS_SECTOR', 'Hijo es sector', 'NATIVE_HIDDEN');
  l_btn := button(c_est, l_plug, 'VOLVER', 'Volver', 'PREVIOUS',
                  url(c_det, 'P60_NIT_COMPANIA,P60_PLAN', '&P61_NIT_COMPANIA.,&P61_PLAN.'));

  -- derecha arriba: editar el nodo seleccionado
  l_plug := region(c_est, 'Editar &P61_LEVEL_NAME.', 20, p_span => 5, p_new_row => false,
                   p_cond_type => 'EXPRESSION', p_cond => 'nvl(:P61_NODE, ''0'') <> ''0''');
  item(c_est, l_plug, 'P61_CODE', 'Código', 'NATIVE_TEXT_FIELD', p_required => true, p_max => 50);
  item(c_est, l_plug, 'P61_NAME', 'Nombre', 'NATIVE_TEXT_FIELD', p_required => true, p_max => 1000);
  item(c_est, l_plug, 'P61_SECTOR', 'Sector DNP', 'NATIVE_SELECT_LIST',
       p_lov => 'select CODE || '' - '' || NAME d, ID r from SPD_PRODUCT_CATALOG where PARENT_ID is null order by CODE',
       p_cond => ':P61_IS_SECTOR = ''S''');
  item(c_est, l_plug, 'P61_WEIGHTING', 'Ponderación', 'NATIVE_NUMBER_FIELD');
  declare
    l_save number := button(c_est, l_plug, 'SAVE', 'Guardar', 'NEXT', p_hot => true);
    l_del  number := button(c_est, l_plug, 'DELETE', 'Eliminar', 'DELETE', p_danger => true,
                            p_confirm => 'El nivel seleccionado se eliminará de forma permanente junto con sus nodos hijos. ¿Desea continuar?');
  begin
    required(c_est, 'P61_CODE', 'Código', l_save);
    required(c_est, 'P61_NAME', 'Nombre', l_save);
    process(c_est, 'Guardar nivel', 'AFTER_SUBMIT', q'~
begin
  update SPD_DEV_PLAN_LEVEL
     set CODE = :P61_CODE, NAME = :P61_NAME,
         PRODUCT_CATALOG_ID = case when :P61_IS_SECTOR = 'S' then to_number(:P61_SECTOR) else PRODUCT_CATALOG_ID end,
         WEIGHTING = to_number(:P61_WEIGHTING), UPDATED_AT = systimestamp
   where ID = :P61_NODE and NIT_COMPANIA = :P61_NIT_COMPANIA and PLAN = :P61_PLAN;
end;~', l_save, 'Nivel actualizado.');
    process(c_est, 'Eliminar nivel e hijos', 'AFTER_SUBMIT', q'~
begin
  -- primero los más profundos (la FK PARENT_ID apunta a la misma tabla)
  for r in (select ID from SPD_DEV_PLAN_LEVEL
             start with ID = :P61_NODE and NIT_COMPANIA = :P61_NIT_COMPANIA and PLAN = :P61_PLAN
           connect by prior ID = PARENT_ID order by level desc) loop
    delete from SPD_DEV_PLAN_LEVEL where ID = r.ID;
  end loop;
  :P61_NODE := nvl(:P61_PARENT, '0');
exception
  when others then
    if sqlcode = -2292 then
      rollback;
      apex_error.add_error(p_message => 'No se puede eliminar: el nivel o alguno de sus hijos tiene metas asociadas.',
                           p_display_location => apex_error.c_inline_in_notification);
    else
      raise;
    end if;
end;~', l_del, 'Nivel eliminado.');
  end;

  -- derecha abajo: crear un hijo del nodo seleccionado (o un nivel 1 si está seleccionada la raíz)
  l_plug := region(c_est, 'Crear &P61_CHILD_NAME.', 30, p_new_row => false, p_new_col => false,
                   p_cond_type => 'ITEM_IS_NOT_NULL', p_cond => 'P61_CHILD_NAME');
  item(c_est, l_plug, 'P61_NEW_CODE', 'Código', 'NATIVE_TEXT_FIELD', p_required => true, p_max => 50);
  item(c_est, l_plug, 'P61_NEW_NAME', 'Nombre', 'NATIVE_TEXT_FIELD', p_required => true, p_max => 1000);
  item(c_est, l_plug, 'P61_NEW_SECTOR', 'Sector DNP', 'NATIVE_SELECT_LIST',
       p_lov => 'select CODE || '' - '' || NAME d, ID r from SPD_PRODUCT_CATALOG where PARENT_ID is null order by CODE',
       p_cond => ':P61_CHILD_IS_SECTOR = ''S''');
  item(c_est, l_plug, 'P61_NEW_WEIGHTING', 'Ponderación', 'NATIVE_NUMBER_FIELD');
  declare
    l_create number := button(c_est, l_plug, 'CREATE', 'Guardar', 'NEXT', p_hot => true);
  begin
    required(c_est, 'P61_NEW_CODE', 'Código', l_create);
    required(c_est, 'P61_NEW_NAME', 'Nombre', l_create);
    process(c_est, 'Crear nivel', 'AFTER_SUBMIT', q'~
begin
  insert into SPD_DEV_PLAN_LEVEL (NIT_COMPANIA, PLAN, CODE, NAME, "LEVEL", PARENT_ID, PRODUCT_CATALOG_ID, WEIGHTING)
  values (:P61_NIT_COMPANIA, :P61_PLAN, :P61_NEW_CODE, :P61_NEW_NAME, to_number(:P61_LEVEL) + 1,
          nullif(to_number(:P61_NODE), 0), to_number(:P61_NEW_SECTOR), to_number(:P61_NEW_WEIGHTING));
  :P61_NEW_CODE := null; :P61_NEW_NAME := null; :P61_NEW_SECTOR := null; :P61_NEW_WEIGHTING := null;
end;~', l_create, 'Nivel creado.');
  end;

  -- carga del nodo seleccionado y de los nombres de nivel definidos en la configuración del plan
  process(c_est, 'Cargar nodo', 'BEFORE_HEADER', q'~
declare
  procedure level_info(p_num number, p_name out varchar2, p_sector out varchar2) is
    l_has_cfg number;
  begin
    select count(*), max(case when jt.NUM = p_num then jt.SINGULAR_NAME end),
           max(case when jt.NUM = p_num and jt.IS_SECTOR = 'true' then 'S' end)
      into l_has_cfg, p_name, p_sector
      from PLAN_DESARROLLO p,
           json_table(p.SPD_CONFIG, '$.levels[*]' columns (NUM number path '$.number',
                      SINGULAR_NAME varchar2(200) path '$.singularName', IS_SECTOR varchar2(10) path '$.isSectorLevel')) jt
     where p.NIT_COMPANIA = :P61_NIT_COMPANIA and p.PLAN = :P61_PLAN;
    -- sin configuración: niveles genéricos 1..9
    if l_has_cfg = 0 and p_num between 1 and 9 then p_name := 'Nivel ' || p_num; end if;
  end;
begin
  select NOMBRE into :P61_PLAN_NOMBRE from PLAN_DESARROLLO
   where NIT_COMPANIA = :P61_NIT_COMPANIA and PLAN = :P61_PLAN;
  :P61_NODE := nvl(:P61_NODE, '0');
  if :P61_NODE <> '0' then
    begin
      select CODE, NAME, PRODUCT_CATALOG_ID, WEIGHTING, nvl("LEVEL", 1), PARENT_ID
        into :P61_CODE, :P61_NAME, :P61_SECTOR, :P61_WEIGHTING, :P61_LEVEL, :P61_PARENT
        from SPD_DEV_PLAN_LEVEL
       where ID = :P61_NODE and NIT_COMPANIA = :P61_NIT_COMPANIA and PLAN = :P61_PLAN;
    exception when no_data_found then :P61_NODE := '0';
    end;
  end if;
  if :P61_NODE = '0' then
    :P61_LEVEL := 0; :P61_PARENT := null;
    :P61_CODE := null; :P61_NAME := null; :P61_SECTOR := null; :P61_WEIGHTING := null;
  end if;
  level_info(to_number(:P61_LEVEL), :P61_LEVEL_NAME, :P61_IS_SECTOR);
  level_info(to_number(:P61_LEVEL) + 1, :P61_CHILD_NAME, :P61_CHILD_IS_SECTOR);
end;~');

  -- después de guardar / eliminar / crear se queda en la estructura (con el nodo que corresponda)
  wwv_flow_imp_page.create_page_branch(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => c_est,
    p_branch_name => 'Volver a la estructura', p_branch_point => 'AFTER_PROCESSING', p_branch_type => 'REDIRECT_URL',
    p_branch_action => 'f?p=&APP_ID.:' || c_est || ':&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#',
    p_branch_sequence => 10);

  -- ============================================================================
  -- El reporte de planes abre los detalles (como la tarjeta del original)
  -----------------------------------------------------------------------------
  update wwv_flow_worksheets
     set detail_link = 'f?p=&APP_ID.:' || c_det || ':&APP_SESSION.::&DEBUG.:' || c_det
                       || ':P60_NIT_COMPANIA,P60_PLAN:\#NIT_COMPANIA#\,\#PLAN#\'
   where flow_id = c_app and page_id = l_ir;
  -- tras editar el plan se vuelve a sus detalles
  update wwv_flow_step_branches
     set branch_action = 'f?p=&APP_ID.:' || c_det || ':&APP_SESSION.::&DEBUG.:' || c_det
                         || ':P60_NIT_COMPANIA,P60_PLAN:&P' || l_form || '_NIT_COMPANIA.,&P' || l_form || '_PLAN.&success_msg=#SUCCESS_MSG#',
         branch_condition_type = 'REQUEST_EQUALS_CONDITION', branch_condition = 'SAVE'
   where flow_id = c_app and flow_step_id = l_form and branch_name = 'Volver al reporte';
  wwv_flow_imp_page.create_page_branch(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => l_form,
    p_branch_name => 'Volver al reporte (eliminar)', p_branch_point => 'AFTER_PROCESSING', p_branch_type => 'REDIRECT_URL',
    p_branch_action => 'f?p=&APP_ID.:' || l_ir || ':&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#',
    p_branch_sequence => 30);

  wwv_flow_imp.import_end(p_auto_install_sup_obj => false);
  commit;
  dbms_output.put_line('PLAN PAGINAS OK (detalles ' || c_det || ', estructura ' || c_est || ', reporte ' || l_ir || ')');
end;
/
exit
