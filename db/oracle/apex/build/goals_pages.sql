-- Metas, como en el original (client/components/Goals/GoalsCatalog):
--  * Pestañas "Listado" (reporte, con el total en un badge) y "Por Estructura del Plan" (árbol del plan con
--    badges por tipo de meta y, a la derecha, las metas del nodo seleccionado).
--  * Al hacer clic en una meta se abre "Datos de la Meta" (solo lectura, página 62) con el botón Editar.
-- JavaScript mínimo: el Tree escapa las etiquetas, así que un script corto convierte el sufijo {{TIPO:n,...}}
-- de cada etiqueta en badges, y expande el nodo seleccionado.
-- Se ejecuta como APEX_240100 después de company_filter.sql. Es re-ejecutable.
set serveroutput on size unlimited
set define off
whenever sqlerror exit failure

declare
  c_app     constant number := 100;
  c_det     constant number := 62;    -- Datos de la Meta (diálogo)
  l_sgid    number;
  l_list    number;                   -- página del reporte de metas
  l_form    number;                   -- formulario de la meta
  l_ir_plg  number;
  l_tabs    number;
  l_tab2    number;
  l_tree    number;
  l_goals   number;
  l_ig      number;
  l_rpt     number;
  l_view    number;
  l_plug    number;
  l_btn     number;
  l_evt     number;
  l_tpl_std number;
  l_tpl_tabs number;
  l_tpl_blank number;
  l_tpl_btns number;
  l_tpl_btn number;
  l_ft_opt  number;
  l_ft_above number;
  l_dlg_tpl number;
  l_seq     pls_integer := 0;
  type t_ids is table of number index by varchar2(30);
  l_col t_ids;

  function region(p_page number, p_name varchar2, p_seq number, p_template number, p_type varchar2 default 'NATIVE_STATIC',
                  p_sql varchar2 default null, p_attrs clob default null, p_span number default null,
                  p_new_row boolean default true, p_parent number default null, p_options varchar2 default '#DEFAULT#',
                  p_point varchar2 default null, p_items_submit varchar2 default null) return number is
    l_id number := wwv_flow_id.next_val;
  begin
    wwv_flow_imp_page.create_page_plug(p_id => l_id, p_flow_id => c_app, p_page_id => p_page,
      p_plug_name => p_name, p_region_template_options => p_options, p_plug_template => p_template,
      p_plug_display_sequence => p_seq,
      p_plug_display_point => coalesce(p_point, case when p_parent is not null then 'SUB_REGIONS' else 'BODY' end),
      p_parent_plug_id => p_parent,
      p_plug_new_grid_row => p_new_row, p_plug_grid_column_span => p_span,
      p_query_type => case when p_sql is not null then 'SQL' end, p_plug_source => p_sql,
      p_plug_source_type => p_type, p_attributes => p_attrs, p_ajax_items_to_submit => p_items_submit);
    return l_id;
  end;

  procedure item(p_page number, p_plug number, p_name varchar2, p_label varchar2, p_type varchar2,
                 p_new_line boolean default true, p_format varchar2 default 'PLAIN', p_named_lov varchar2 default null,
                 p_submit boolean default false, p_show_if_value boolean default false) is
  begin
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_page_item(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => p_page,
      p_name => p_name, p_item_sequence => l_seq, p_item_plug_id => p_plug, p_prompt => p_label,
      p_display_as => p_type, p_use_cache_before_default => 'YES',
      p_begin_on_new_line => case when p_new_line then 'Y' else 'N' end,
      p_field_template => case when p_type = 'NATIVE_DISPLAY_ONLY' then l_ft_above else l_ft_opt end,
      p_item_template_options => '#DEFAULT#', p_csize => 30, p_is_persistent => 'Y',
      p_named_lov => p_named_lov, p_lov_display_null => case when p_named_lov is not null then 'NO' end,
      p_display_when_type => case when p_show_if_value then 'ITEM_IS_NOT_NULL' end,
      p_display_when => case when p_show_if_value then p_name end,
      p_attribute_01 => case p_type when 'NATIVE_HIDDEN' then 'Y' when 'NATIVE_DISPLAY_ONLY' then 'N'
                                    when 'NATIVE_SELECT_LIST' then case when p_submit then 'SUBMIT' else 'NONE' end end,
      p_attribute_02 => case p_type when 'NATIVE_DISPLAY_ONLY' then 'VALUE' when 'NATIVE_SELECT_LIST' then 'N' end,
      p_attribute_04 => case p_type when 'NATIVE_DISPLAY_ONLY' then 'Y' end,
      p_attribute_05 => case p_type when 'NATIVE_DISPLAY_ONLY' then p_format end);
  end;

  function button(p_page number, p_plug number, p_name varchar2, p_label varchar2, p_position varchar2,
                  p_url varchar2 default null, p_hot boolean default false, p_action varchar2 default null) return number is
    l_id number := wwv_flow_id.next_val;
  begin
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_page_button(p_id => l_id, p_flow_id => c_app, p_flow_step_id => p_page,
      p_button_sequence => l_seq, p_button_plug_id => p_plug, p_button_name => p_name,
      p_button_action => coalesce(p_action, case when p_url is not null then 'REDIRECT_URL' else 'SUBMIT' end),
      p_button_redirect_url => p_url, p_button_template_id => l_tpl_btn, p_button_template_options => '#DEFAULT#',
      p_button_is_hot => case when p_hot then 'Y' else 'N' end, p_button_image_alt => p_label,
      p_button_position => p_position);
    return l_id;
  end;

  procedure process(p_page number, p_name varchar2, p_point varchar2, p_code varchar2,
                    p_when_type varchar2 default null, p_when varchar2 default null) is
  begin
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_page_process(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => p_page,
      p_process_sequence => l_seq, p_process_point => p_point, p_process_type => 'NATIVE_PLSQL',
      p_process_name => p_name, p_process_sql_clob => p_code, p_process_clob_language => 'PLSQL',
      p_error_display_location => 'INLINE_IN_NOTIFICATION',
      p_process_when_type => p_when_type, p_process_when => p_when);
  end;

  -- columna de la grilla de solo lectura
  procedure col(p_name varchar2, p_type varchar2, p_label varchar2, p_data_type varchar2 default 'VARCHAR2',
                p_pk boolean default false, p_align varchar2 default 'LEFT', p_link varchar2 default null,
                p_link_text varchar2 default null) is
    l_id number := wwv_flow_id.next_val;
  begin
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_region_column(
      p_id => l_id, p_flow_id => c_app, p_page_id => l_list, p_region_id => l_goals,
      p_name => p_name, p_source_type => 'DB_COLUMN', p_source_expression => p_name,
      p_data_type => p_data_type, p_session_state_data_type => 'VARCHAR2', p_is_query_only => false,
      p_item_type => p_type, p_heading => p_label, p_label => p_label,
      p_heading_alignment => p_align, p_value_alignment => p_align, p_display_sequence => l_seq,
      p_attribute_01 => case p_type when 'NATIVE_HIDDEN' then 'Y' when 'NATIVE_DISPLAY_ONLY' then 'Y' end,
      p_attribute_02 => case p_type when 'NATIVE_DISPLAY_ONLY' then 'VALUE' end,
      p_attribute_05 => case p_type when 'NATIVE_DISPLAY_ONLY' then 'PLAIN' end,
      p_link_target => p_link, p_link_text => p_link_text,
      p_enable_filter => not p_pk, p_filter_is_required => false, p_filter_lov_type => 'NONE',
      p_use_as_row_header => false, p_enable_sort_group => true, p_enable_control_break => false,
      p_enable_hide => true, p_enable_pivot => false, p_is_primary_key => p_pk,
      p_duplicate_value => true, p_include_in_export => true);
    l_col(p_name) := l_id;
  end;

  procedure rpt_col(p_name varchar2, p_seq number, p_visible boolean default true, p_sort boolean default false) is
  begin
    wwv_flow_imp_page.create_ig_report_column(
      p_id => wwv_flow_id.next_val, p_view_id => l_view, p_display_seq => p_seq,
      p_column_id => l_col(p_name), p_is_visible => p_visible, p_is_frozen => false,
      p_sort_order => case when p_sort then 1 end, p_sort_direction => case when p_sort then 'ASC' end);
  end;
begin
  l_sgid := apex_util.find_security_group_id(p_workspace => 'SPD');
  wwv_flow_security.g_security_group_id := l_sgid;
  wwv_flow_imp.import_begin(p_version_yyyy_mm_dd => '2024.05.31', p_release => '24.1.0',
    p_default_workspace_id => l_sgid, p_default_application_id => c_app, p_default_id_offset => 0,
    p_default_owner => 'SIIF');

  select page_id into l_form from wwv_flow_page_plugs
   where flow_id = c_app and plug_source_type = 'NATIVE_FORM' and query_table = 'SPD_GOAL';
  select p.page_id, p.id into l_list, l_ir_plg from wwv_flow_page_plugs p
   where p.flow_id = c_app and p.plug_source_type = 'NATIVE_IR' and p.query_table = 'SPD_GOAL';
  select id into l_tpl_std   from wwv_flow_page_plug_templates where flow_id = c_app and page_plug_template_name = 'Standard';
  select id into l_tpl_tabs  from wwv_flow_page_plug_templates where flow_id = c_app and page_plug_template_name = 'Tabs Container';
  select id into l_tpl_blank from wwv_flow_page_plug_templates where flow_id = c_app and page_plug_template_name = 'Blank with Attributes';
  select id into l_tpl_btns  from wwv_flow_page_plug_templates where flow_id = c_app and page_plug_template_name = 'Buttons Container';
  select id into l_tpl_btn   from wwv_flow_button_templates    where flow_id = c_app and template_name = 'Text';
  select id into l_ft_opt    from wwv_flow_field_templates     where flow_id = c_app and template_name = 'Optional - Floating';
  select id into l_ft_above  from wwv_flow_field_templates     where flow_id = c_app and template_name = 'Optional - Above';
  select step_template into l_dlg_tpl from wwv_flow_steps where flow_id = c_app and id = l_form;

  -----------------------------------------------------------------------------
  -- re-ejecutable: quita lo creado antes en la página del listado y el diálogo
  -----------------------------------------------------------------------------
  update wwv_flow_page_plugs set parent_plug_id = null, plug_display_point = 'BODY', plug_name = 'Metas'
   where id = l_ir_plg and flow_id = c_app;
  delete from wwv_flow_step_items      where flow_id = c_app and flow_step_id = l_list;
  delete from wwv_flow_step_processing where flow_id = c_app and flow_step_id = l_list;
  delete from wwv_flow_step_branches   where flow_id = c_app and flow_step_id = l_list;
  delete from wwv_flow_page_plugs where flow_id = c_app and page_id = l_list and id <> l_ir_plg and parent_plug_id is not null;
  delete from wwv_flow_page_plugs where flow_id = c_app and page_id = l_list and id <> l_ir_plg
     and plug_name in ('Metas', 'Por Estructura del Plan');
  for p in (select id from wwv_flow_steps where flow_id = c_app and id = c_det) loop
    wwv_flow_imp_page.remove_page(p_flow_id => c_app, p_page_id => p.id);
  end loop;

  -- ============================================================================
  -- Listado de metas: pestañas
  -- ============================================================================
  update wwv_flow_steps
     set html_page_header = '<style>'
           || '.spd-badge{display:inline-block;min-width:20px;padding:0 6px;margin-left:6px;border-radius:10px;'
           || 'font-size:11px;line-height:18px;color:#fff;text-align:center;background:#13c2c2;vertical-align:middle}'
           || '.spd-badge--PRODUCT{background:#9FD912}.spd-badge--RESULT,.spd-badge--WELL_BEING,.spd-badge--IMPACT{background:#52c41a}'
           || '.spd-badge--ACTIVITY{background:#1677ff}.spd-badge--PROJECT{background:green}'
           || '.spd-badge--ACTION_PLAN{background:blueviolet}.spd-badge--ACTION_PLAN_ACTIVITY{background:orange}'
           || '.spd-badge--TOTAL{background:#1677ff}</style>',
         javascript_code_onload =
           'var t = $("#spd_goal_tree"), L = {PRODUCT: "Producto", RESULT: "Resultado", WELL_BEING: "Bienestar", IMPACT: "Impacto", '
           || 'ACTIVITY: "Actividad", PROJECT: "Proyecto", ACTION_PLAN: "Plan de Acción", ACTION_PLAN_ACTIVITY: "Meta de Plan de Acción", '
           || 'PUBLIC_POLITIC: "Política Pública"};' || chr(10)
           || '// badges por tipo de meta: la etiqueta trae el sufijo {{TIPO:n,...}}' || chr(10)
           || 'function spdBadges() { t.find(".a-TreeView-label").each(function () { var e = $(this), m = e.text().match(/^(.*) \{\{(.*)\}\}$/); '
           || 'if (m) { e.text(m[1]); m[2].split(",").forEach(function (x) { var p = x.split(":"); '
           || 'e.append($("<span>").addClass("spd-badge spd-badge--" + p[0]).attr("title", p[1] + " metas de " + (L[p[0]] || p[0])).text(p[1])); }); } }); }' || chr(10)
           || 't.on("treeviewexpansionstatechange", function () { setTimeout(spdBadges, 0); });' || chr(10)
           || 'var s = t.treeView("getSelection"); if (s.length) { t.treeView("expand", s); }' || chr(10)
           || 'spdBadges();'
   where flow_id = c_app and id = l_list;

  l_tabs := region(l_list, 'Metas', 5, l_tpl_tabs, p_options => '#DEFAULT#:js-useLocalStorage:t-TabsRegion-mod--simple');
  -- pestaña 1: el reporte existente, con el total de metas en un badge
  update wwv_flow_page_plugs
     set parent_plug_id = l_tabs, plug_display_point = 'SUB_REGIONS', plug_display_sequence = 10,
         plug_name = 'Listado <span class="spd-badge spd-badge--TOTAL">&P' || l_list || '_TOTAL.</span>'
   where id = l_ir_plg and flow_id = c_app;
  -- clic en una meta: sus datos (diálogo de solo lectura)
  update wwv_flow_worksheets
     set detail_link = 'f?p=&APP_ID.:' || c_det || ':&APP_SESSION.::&DEBUG.:' || c_det || ':P62_ID:\#ID#\',
         detail_link_text = '<span role="img" aria-label="Ver datos de la meta" class="fa fa-eye" title="Ver datos de la meta"></span>'
   where flow_id = c_app and region_id = l_ir_plg;

  -- pestaña 2: Por Estructura del Plan
  l_tab2 := region(l_list, 'Por Estructura del Plan', 20, l_tpl_blank, p_parent => l_tabs);
  item(l_list, l_tab2, 'P' || l_list || '_PLAN', 'Plan de desarrollo', 'NATIVE_SELECT_LIST',
       p_named_lov => 'SPD - PLANES DE DESARROLLO', p_submit => true);
  item(l_list, l_tab2, 'P' || l_list || '_NODE', 'Nodo', 'NATIVE_HIDDEN');
  item(l_list, l_tab2, 'P' || l_list || '_NODE_NAME', 'Nodo', 'NATIVE_HIDDEN');
  item(l_list, l_tab2, 'P' || l_list || '_TOTAL', 'Total', 'NATIVE_HIDDEN');

  l_tree := region(l_list, 'Estructura del Plan de Desarrollo', 30, l_tpl_std, 'NATIVE_JSTREE', p_parent => l_tab2, p_span => 5,
    p_sql => replace(q'~with r as (
  select connect_by_root ID as ROOT_ID, ID from SPD_DEV_PLAN_LEVEL
   start with NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :#P#PLAN connect by prior ID = PARENT_ID),
cnt as (
  select r.ROOT_ID, g.GOAL_TYPE, count(*) as N from r join SPD_GOAL g on g.DEV_PLAN_LEVEL_ID = r.ID group by r.ROOT_ID, g.GOAL_TYPE
  union all
  select 0, GOAL_TYPE, count(*) from SPD_GOAL where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :#P#PLAN group by GOAL_TYPE),
sfx as (
  select ROOT_ID, ' {{' || listagg(GOAL_TYPE || ':' || N, ',') within group (order by GOAL_TYPE) || '}}' as SUFFIX from cnt group by ROOT_ID),
n as (
  select 0 as VALUE, null as PARENT, NOMBRE as TITLE, null as CODE from PLAN_DESARROLLO
   where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :#P#PLAN
  union all
  select ID, nvl(PARENT_ID, 0), CODE || ' ' || NAME, CODE from SPD_DEV_PLAN_LEVEL
   where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :#P#PLAN)
select case when connect_by_isleaf = 1 then 0 when n.VALUE = 0 then 1 else -1 end as STATUS, level as LVL,
       n.TITLE || (select s.SUFFIX from sfx s where s.ROOT_ID = n.VALUE) as TITLE, null as ICON, n.VALUE, null as TOOLTIP,
       apex_page.get_url(p_items => '#P#NODE', p_values => n.VALUE) as LINK
  from n
 start with n.PARENT is null connect by prior n.VALUE = n.PARENT
 order siblings by nlssort(n.CODE, 'NLS_SORT=BINARY')~', '#P#', 'P' || l_list || '_'),
    p_attrs => wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
      'activate_node_link_with', 'S', 'default_icon_css_class', 'icon-tree-folder',
      'hierarchy_level_column', 'LVL', 'icon_css_class_column', 'ICON', 'link_column', 'LINK',
      'node_label_column', 'TITLE', 'node_status_column', 'STATUS', 'node_value_column', 'VALUE',
      'selected_node_page_item', 'P' || l_list || '_NODE', 'static_tree_id', 'spd_goal_tree',
      'tree_hierarchy', 'LEVEL', 'tree_tooltip', 'N')).to_clob);

  -- metas del nodo seleccionado (y de sus hijos); raíz = todas las del plan
  l_goals := region(l_list, 'Metas de &P' || l_list || '_NODE_NAME.', 40, l_tpl_std, 'NATIVE_IG', p_parent => l_tab2,
    p_span => 7, p_new_row => false, p_items_submit => 'P' || l_list || '_PLAN,P' || l_list || '_NODE',
    p_sql => replace(q'~select g.ID, g.CODE, g.NAME, g.INDICATOR, g.BASE_VALUE, g.GOAL_VALUE
  from SPD_GOAL g
 where g.NIT_COMPANIA = :G_NIT_COMPANIA and g.PLAN = :#P#PLAN
   and (nvl(:#P#NODE, '0') = '0'
        or g.DEV_PLAN_LEVEL_ID in (select ID from SPD_DEV_PLAN_LEVEL start with ID = to_number(:#P#NODE) connect by prior ID = PARENT_ID))~',
       '#P#', 'P' || l_list || '_'));
  col('ID', 'NATIVE_HIDDEN', 'ID', 'NUMBER', p_pk => true);
  col('CODE', 'NATIVE_LINK', 'Código',
      p_link => 'f?p=&APP_ID.:' || c_det || ':&APP_SESSION.::&DEBUG.:' || c_det || ':P62_ID:&ID.', p_link_text => '&CODE.');
  col('NAME', 'NATIVE_DISPLAY_ONLY', 'Nombre');
  col('INDICATOR', 'NATIVE_DISPLAY_ONLY', 'Indicador');
  col('BASE_VALUE', 'NATIVE_DISPLAY_ONLY', 'Línea Base', 'NUMBER', p_align => 'RIGHT');
  col('GOAL_VALUE', 'NATIVE_DISPLAY_ONLY', 'Meta', 'NUMBER', p_align => 'RIGHT');
  l_ig := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_interactive_grid(p_id => l_ig, p_flow_id => c_app, p_page_id => l_list,
    p_region_id => l_goals, p_internal_uid => l_ig, p_is_editable => false,
    p_lazy_loading => false, p_requires_filter => false, p_select_first_row => false, p_fixed_row_height => true,
    p_pagination_type => 'SET', p_show_total_row_count => true, p_show_toolbar => true,
    p_toolbar_buttons => 'SEARCH_FIELD:ACTIONS_MENU', p_enable_save_public_report => false,
    p_enable_subscriptions => false, p_enable_flashback => false, p_define_chart_view => false,
    p_enable_download => true, p_enable_mail_download => false, p_fixed_header => 'NONE',
    p_show_icon_view => false, p_show_detail_view => false);
  l_rpt := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_ig_report(p_id => l_rpt, p_flow_id => c_app, p_page_id => l_list,
    p_interactive_grid_id => l_ig, p_static_id => to_char(l_rpt), p_type => 'PRIMARY',
    p_default_view => 'GRID', p_rows_per_page => 15, p_show_row_number => false, p_settings_area_expanded => false);
  l_view := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_ig_report_view(p_id => l_view, p_flow_id => c_app, p_page_id => l_list,
    p_report_id => l_rpt, p_view_type => 'GRID', p_srv_exclude_null_values => false,
    p_srv_only_display_columns => true, p_edit_mode => false);
  rpt_col('CODE', 1, p_sort => true);
  rpt_col('NAME', 2);
  rpt_col('INDICATOR', 3);
  rpt_col('BASE_VALUE', 4);
  rpt_col('GOAL_VALUE', 5);

  process(l_list, 'Cargar estructura', 'BEFORE_HEADER', replace(q'~
begin
  select count(*) into :#P#TOTAL from SPD_GOAL where NIT_COMPANIA = :G_NIT_COMPANIA;
  -- plan por defecto: el activo de la compañía (o el más reciente)
  if :#P#PLAN is null then
    select max(PLAN) keep (dense_rank first order by case when SPD_ACTIVO = 'S' then 0 else 1 end, PLAN desc)
      into :#P#PLAN from PLAN_DESARROLLO where NIT_COMPANIA = :G_NIT_COMPANIA;
  end if;
  :#P#NODE := nvl(:#P#NODE, '0');
  if :#P#NODE <> '0' then
    begin
      select CODE || ' ' || NAME into :#P#NODE_NAME from SPD_DEV_PLAN_LEVEL
       where ID = :#P#NODE and NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :#P#PLAN;
    exception when no_data_found then :#P#NODE := '0';
    end;
  end if;
  if :#P#NODE = '0' then
    select max(NOMBRE) into :#P#NODE_NAME from PLAN_DESARROLLO where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :#P#PLAN;
  end if;
end;~', '#P#', 'P' || l_list || '_'));
  -- al cambiar de plan se vuelve a la raíz del árbol
  process(l_list, 'Cambiar plan', 'AFTER_SUBMIT', ':P' || l_list || '_NODE := ''0'';',
          'REQUEST_EQUALS_CONDITION', 'P' || l_list || '_PLAN');
  wwv_flow_imp_page.create_page_branch(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => l_list,
    p_branch_name => 'Volver al listado', p_branch_point => 'AFTER_PROCESSING', p_branch_type => 'REDIRECT_URL',
    p_branch_action => 'f?p=&APP_ID.:' || l_list || ':&APP_SESSION.::&DEBUG.:::', p_branch_sequence => 10);

  -- ============================================================================
  -- 62 · Datos de la Meta (diálogo de solo lectura)
  -- ============================================================================
  wwv_flow_imp_page.create_page(p_id => c_det, p_flow_id => c_app, p_name => 'Datos de la Meta',
    p_alias => 'DATOS-DE-LA-META', p_page_mode => 'MODAL', p_step_title => 'Datos de la Meta',
    p_step_template => l_dlg_tpl, p_page_template_options => '#DEFAULT#', p_dialog_width => '900',
    p_dialog_chained => 'Y', p_autocomplete_on_off => 'OFF', p_protection_level => 'C');
  l_plug := region(c_det, 'Datos de la Meta', 10, l_tpl_blank);
  item(c_det, l_plug, 'P62_ID', 'ID', 'NATIVE_DISPLAY_ONLY');
  item(c_det, l_plug, 'P62_CODE', 'Código', 'NATIVE_DISPLAY_ONLY', p_new_line => false);
  item(c_det, l_plug, 'P62_NAME', 'Meta', 'NATIVE_DISPLAY_ONLY');
  item(c_det, l_plug, 'P62_ENTITY', 'Entidad', 'NATIVE_DISPLAY_ONLY');
  item(c_det, l_plug, 'P62_GOAL_TYPE', 'Tipo de meta', 'NATIVE_DISPLAY_ONLY');
  item(c_det, l_plug, 'P62_LEVEL', '&P62_LEVEL_LABEL.', 'NATIVE_DISPLAY_ONLY', p_new_line => false);
  item(c_det, l_plug, 'P62_INDICATOR', 'Indicador', 'NATIVE_DISPLAY_ONLY', p_show_if_value => true);
  item(c_det, l_plug, 'P62_UNITS', 'Unidades', 'NATIVE_DISPLAY_ONLY', p_show_if_value => true);
  item(c_det, l_plug, 'P62_ACCUMULATION', 'Tipo de acumulación', 'NATIVE_DISPLAY_ONLY', p_new_line => false, p_show_if_value => true);
  item(c_det, l_plug, 'P62_BASE_VALUE', 'Valor base', 'NATIVE_DISPLAY_ONLY', p_show_if_value => true);
  item(c_det, l_plug, 'P62_GOAL_VALUE', 'Valor meta', 'NATIVE_DISPLAY_ONLY', p_new_line => false, p_show_if_value => true);
  item(c_det, l_plug, 'P62_POLITIC', 'Política Pública', 'NATIVE_DISPLAY_ONLY', p_show_if_value => true);
  item(c_det, l_plug, 'P62_ODS', 'Objetivos de desarrollo sostenible', 'NATIVE_DISPLAY_ONLY', p_format => 'HTML', p_show_if_value => true);
  item(c_det, l_plug, 'P62_PRODUCT', 'Indicador de Producto', 'NATIVE_DISPLAY_ONLY', p_show_if_value => true);
  item(c_det, l_plug, 'P62_PI_BASE_VALUE', 'Valor base - producto', 'NATIVE_DISPLAY_ONLY', p_show_if_value => true);
  item(c_det, l_plug, 'P62_PI_GOAL_VALUE', 'Valor meta - producto', 'NATIVE_DISPLAY_ONLY', p_new_line => false, p_show_if_value => true);
  item(c_det, l_plug, 'P62_LEVEL_LABEL', 'Etiqueta del nivel', 'NATIVE_HIDDEN');

  l_plug := region(c_det, 'Buttons', 20, l_tpl_btns, p_point => 'REGION_POSITION_03');
  l_btn := button(c_det, l_plug, 'CERRAR', 'Cerrar', 'CLOSE', p_action => 'DEFINED_BY_DA');
  l_evt := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_page_da_event(p_id => l_evt, p_flow_id => c_app, p_page_id => c_det,
    p_name => 'Cerrar diálogo', p_event_sequence => 10, p_triggering_element_type => 'BUTTON',
    p_triggering_button_id => l_btn, p_bind_type => 'bind', p_execution_type => 'IMMEDIATE', p_bind_event_type => 'click');
  wwv_flow_imp_page.create_page_da_action(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_page_id => c_det,
    p_event_id => l_evt, p_event_result => 'TRUE', p_action_sequence => 10, p_execute_on_page_init => 'N',
    p_action => 'NATIVE_DIALOG_CANCEL');
  l_btn := button(c_det, l_plug, 'EDITAR', 'Editar', 'NEXT',
                  'f?p=&APP_ID.:' || l_form || ':&APP_SESSION.::&DEBUG.:' || l_form || ':P' || l_form || '_ID:&P62_ID.', p_hot => true);

  process(c_det, 'Cargar meta', 'BEFORE_HEADER', q'~
declare
  function lov(p_lov varchar2, p_value varchar2) return varchar2 is
    l_d varchar2(400);
  begin
    select max(DISPLAY_VALUE) into l_d from APEX_APPLICATION_LOV_ENTRIES
     where APPLICATION_ID = :APP_ID and LIST_OF_VALUES_NAME = p_lov and RETURN_VALUE = p_value;
    return coalesce(l_d, p_value);
  end;
begin
  for g in (select g.*, e.CODIGO_ENT_PRY, e.NOMBRE_ENT_PRY, l.CODE as L_CODE, l.NAME as L_NAME, l."LEVEL" as L_LEVEL,
                   (select pp.CODE || ' - ' || pp.NAME from SPD_PUBLIC_POLITIC pp where pp.ID = g.PUBLIC_POLITIC_ID) as POLITIC,
                   (select pc.CODE || ' - ' || pc.NAME from SPD_PRODUCT_CATALOG pc where pc.ID = g.PRODUCT_CATALOG_ID) as PRODUCT,
                   (select c.SINGULAR_NAME from V_SPD_PLAN_LEVEL_CONFIG c
                     where c.NIT_COMPANIA = g.NIT_COMPANIA and c.PLAN = g.PLAN and c.NUM = l."LEVEL") as LEVEL_LABEL
              from SPD_GOAL g
              left join ENTIDADES_PRY e on e.ID = g.ENTITY_ID
              left join SPD_DEV_PLAN_LEVEL l on l.ID = g.DEV_PLAN_LEVEL_ID
             where g.ID = :P62_ID and g.NIT_COMPANIA = :G_NIT_COMPANIA) loop
    :P62_CODE := g.CODE;
    :P62_NAME := g.NAME;
    :P62_ENTITY := g.CODIGO_ENT_PRY || ' - ' || g.NOMBRE_ENT_PRY;
    :P62_GOAL_TYPE := lov('SPD - TIPO DE META', g.GOAL_TYPE);
    :P62_LEVEL := g.L_CODE || ' - ' || g.L_NAME;
    :P62_LEVEL_LABEL := coalesce(g.LEVEL_LABEL, 'Nivel del plan');
    :P62_INDICATOR := g.INDICATOR;
    :P62_UNITS := g.UNITS_NAME;
    :P62_ACCUMULATION := case when g.ACCUMULATION_TYPE is not null then lov('SPD - TIPO DE ACUMULACION', g.ACCUMULATION_TYPE) end;
    :P62_BASE_VALUE := g.BASE_VALUE;
    :P62_GOAL_VALUE := g.GOAL_VALUE;
    :P62_POLITIC := g.POLITIC;
    :P62_PRODUCT := g.PRODUCT;
    :P62_PI_BASE_VALUE := case when g.PRODUCT is not null then g.PI_BASE_VALUE end;
    :P62_PI_GOAL_VALUE := case when g.PRODUCT is not null then g.PI_GOAL_VALUE end;
    select listagg(apex_escape.html(o.ID || ' - ' || o.NAME), '<br>') within group (order by o.ID) into :P62_ODS
      from SPD_ODS o
     where o.ID in (select jt.V from json_table(g.ODS_IDS, '$[*]' columns (V number path '$')) jt);
  end loop;
end;~');

  wwv_flow_imp.import_end(p_auto_install_sup_obj => false);
  commit;
  dbms_output.put_line('METAS OK (listado ' || l_list || ', formulario ' || l_form || ', datos ' || c_det || ')');
end;
/
exit
