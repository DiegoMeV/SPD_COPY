-- Estándar de diseño de páginas APEX de SIIFWEB (Manual Estándar de Diseño APEX v2.0):
--  1. Formularios en páginas normales (no drawers), salvo el diálogo de solo lectura "Datos de la Meta".
--  2. Región "Breadcrumb Global" en la Página Global (0), con migas armadas desde el menú de navegación.
--  3. Botones de formulario en el Breadcrumb Global: Regresar (Close), Eliminar (Delete), Aplicar Cambios (Edit,
--     directa) y Nuevo (Create). "Nuevo" de los reportes también va ahí. Botones de región: Text with Icon, Success.
--  4. Cuadrículas: alineación por tipo de dato, barra Acciones/Editar/Guardar/Nuevo (sin Guardar si la página tiene
--     Aplicar Cambios), sin fila vacía automática ni primera fila seleccionada.
--  5. Textos internos de APEX en español (mensajes de texto de la aplicación).
-- Se ejecuta como APEX_240100 al final (después de monitoring_page.sql). Es re-ejecutable.
set serveroutput on size unlimited
set define off
whenever sqlerror exit failure

declare
  c_app        constant number := 100;
  c_dialog     constant number := 62;           -- se queda como diálogo
  l_sgid       number;
  l_tpl_title  number;
  l_tpl_std    number;
  l_btn_text   number;
  l_btn_icon   number;
  l_menu       number;
  l_menu_tpl   number;
  l_global     number;
  l_nav        number;
  l_ir         number;
  l_pg         number;
  l_opt        number;
  l_par        number;
  l_pk         varchar2(255);
  l_has_save   number;
  l_n          pls_integer := 0;
  type t_map is table of number index by varchar2(40);
  l_entry t_map;    -- página -> entrada de breadcrumb
  l_grp   t_map;    -- elemento del menú -> entrada de breadcrumb

  c_icon_left  constant varchar2(100) := '#DEFAULT#:t-Button--iconLeft';
  c_danger     constant varchar2(100) := '#DEFAULT#:t-Button--danger:t-Button--simple';
  c_success    constant varchar2(100) := '#DEFAULT#:t-Button--success:t-Button--iconLeft';

  function page_of(p_target varchar2) return number is
  begin
    return to_number(regexp_substr(p_target, '^f\?p=&APP_ID\.:([0-9]+):', 1, 1, null, 1));
  end;

  -- página del reporte que abre un formulario (botón Crear/Nuevo o enlace del reporte)
  function report_of(p_form number) return number is
    l_r number;
  begin
    select min(flow_step_id) into l_r from wwv_flow_step_buttons
     where flow_id = c_app and flow_step_id not in (p_form, 60, 61, c_dialog)
       and button_redirect_url like 'f?p=&APP_ID.:' || p_form || ':%';
    if l_r is null then
      select min(page_id) into l_r from wwv_flow_worksheets
       where flow_id = c_app and detail_link like 'f?p=&APP_ID.:' || p_form || ':%';
    end if;
    return l_r;
  end;

  procedure btn(p_id number, p_label varchar2, p_plug number, p_pos varchar2, p_tpl number, p_opts varchar2,
                p_icon varchar2, p_hot varchar2, p_align varchar2 default null) is
  begin
    update wwv_flow_step_buttons
       set button_image_alt = p_label, button_plug_id = coalesce(p_plug, button_plug_id), button_position = p_pos,
           button_template_id = p_tpl, button_template_options = p_opts, icon_css_classes = p_icon,
           button_is_hot = p_hot, button_alignment = coalesce(p_align, button_alignment)
     where id = p_id and flow_id = c_app;
    l_n := l_n + 1;
  end;

  procedure msg(p_name varchar2, p_text varchar2) is
  begin
    delete from wwv_flow_messages$ where flow_id = c_app and name = p_name and message_language = 'es';
    wwv_flow_imp_shared.create_message(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_name => p_name,
      p_message_language => 'es', p_message_text => p_text, p_is_js_message => true);
  end;
begin
  l_sgid := apex_util.find_security_group_id(p_workspace => 'SPD');
  wwv_flow_security.g_security_group_id := l_sgid;
  wwv_flow_imp.import_begin(p_version_yyyy_mm_dd => '2024.05.31', p_release => '24.1.0',
    p_default_workspace_id => l_sgid, p_default_application_id => c_app, p_default_id_offset => 0,
    p_default_owner => 'SIIF');

  select id into l_tpl_title from wwv_flow_page_plug_templates where flow_id = c_app and page_plug_template_name = 'Title Bar';
  select id into l_tpl_std   from wwv_flow_page_plug_templates where flow_id = c_app and page_plug_template_name = 'Standard';
  select id into l_btn_text  from wwv_flow_button_templates    where flow_id = c_app and template_name = 'Text';
  select id into l_btn_icon  from wwv_flow_button_templates    where flow_id = c_app and template_name = 'Text with Icon';
  select id into l_menu      from wwv_flow_menus               where flow_id = c_app and name = 'Breadcrumb';
  select id into l_nav       from wwv_flow_lists               where flow_id = c_app and name = 'Navigation Menu';
  select max(id) into l_menu_tpl from wwv_flow_menu_templates where flow_id = c_app and name = 'Breadcrumb';

  -- ============================================================================
  -- 1. Formularios en páginas normales
  -- ============================================================================
  for f in (select s.id pg, p.id plg from wwv_flow_steps s
              join wwv_flow_page_plugs p on p.flow_id = s.flow_id and p.page_id = s.id and p.plug_source_type = 'NATIVE_FORM'
             where s.flow_id = c_app and s.page_mode = 'MODAL' and s.id <> c_dialog) loop
    l_ir := report_of(f.pg);
    update wwv_flow_steps
       set page_mode = 'NORMAL', step_template = null, page_template_options = '#DEFAULT#',
           dialog_chained = 'Y', dialog_width = null, dialog_height = null
     where flow_id = c_app and id = f.pg;
    update wwv_flow_page_plugs set plug_template = l_tpl_std where id = f.plg and flow_id = c_app;
    delete from wwv_flow_page_da_actions
     where flow_id = c_app and event_id in (select id from wwv_flow_page_da_events
                                             where flow_id = c_app and page_id = f.pg and name = 'Cancel Dialog');
    delete from wwv_flow_page_da_events where flow_id = c_app and page_id = f.pg and name = 'Cancel Dialog';
    delete from wwv_flow_step_processing where flow_id = c_app and flow_step_id = f.pg and process_type = 'NATIVE_CLOSE_WINDOW';
    update wwv_flow_step_buttons
       set button_action = 'REDIRECT_PAGE', button_redirect_url = 'f?p=&APP_ID.:' || l_ir || ':&APP_SESSION.::&DEBUG.:::'
     where flow_id = c_app and flow_step_id = f.pg and button_name = 'CANCEL';
    wwv_flow_imp_page.create_page_branch(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => f.pg,
      p_branch_name => 'Volver al reporte', p_branch_point => 'AFTER_PROCESSING', p_branch_type => 'REDIRECT_URL',
      p_branch_action => 'f?p=&APP_ID.:' || l_ir || ':&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#',
      p_branch_sequence => 10);
    dbms_output.put_line('  formulario ' || f.pg || ' -> página normal (reporte ' || l_ir || ')');
  end loop;

  -- ============================================================================
  -- 2. Breadcrumb Global en la Página Global
  -- ============================================================================
  begin
    select id into l_global from wwv_flow_page_plugs where flow_id = c_app and page_id = 0 and plug_name = 'Breadcrumb Global';
  exception when no_data_found then
    l_global := wwv_flow_id.next_val;
    wwv_flow_imp_page.create_page_plug(p_id => l_global, p_flow_id => c_app, p_page_id => 0,
      p_plug_name => 'Breadcrumb Global', p_region_template_options => '#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle',
      p_plug_template => l_tpl_title, p_plug_display_sequence => 10, p_plug_display_point => 'REGION_POSITION_01',
      p_menu_id => l_menu, p_plug_source_type => 'NATIVE_BREADCRUMB', p_menu_template_id => l_menu_tpl,
      p_plug_display_condition_type => 'CURRENT_PAGE_NOT_IN_CONDITION', p_plug_display_when_condition => '9999');
  end;
  -- quita los breadcrumbs de cada página (los reemplaza el global)
  delete from wwv_flow_page_plugs where flow_id = c_app and page_id <> 0 and plug_source_type = 'NATIVE_BREADCRUMB';

  -- migas: igual que el menú de navegación
  delete from wwv_flow_menu_options where flow_id = c_app and menu_id = l_menu;
  for i in (select id, parent_list_item_id par, list_item_display_sequence seq, list_item_link_text txt, list_item_link_target tgt
              from wwv_flow_list_items where flow_id = c_app and list_id = l_nav
             start with parent_list_item_id is null connect by prior id = parent_list_item_id
             order siblings by list_item_display_sequence) loop
    l_pg := page_of(i.tgt);
    if l_pg is null or not l_entry.exists(to_char(l_pg)) then
      l_opt := wwv_flow_id.next_val;
      wwv_flow_imp_shared.create_menu_option(p_id => l_opt, p_menu_id => l_menu,
        p_parent_id => case when i.par is not null and l_grp.exists(to_char(i.par)) then l_grp(to_char(i.par)) end,
        p_option_sequence => i.seq, p_short_name => i.txt,
        p_link => case when l_pg is not null then 'f?p=&APP_ID.:' || l_pg || ':&SESSION.::&DEBUG.:::' end,
        p_page_id => l_pg);
      l_grp(to_char(i.id)) := l_opt;
      if l_pg is not null then l_entry(to_char(l_pg)) := l_opt; end if;
    end if;
  end loop;
  -- formularios y páginas de detalle: cuelgan de su reporte
  for s in (select s.id pg, s.name from wwv_flow_steps s where s.flow_id = c_app and s.page_mode = 'NORMAL'
               and s.id not in (0, 9999) order by s.id) loop
    if not l_entry.exists(to_char(s.pg)) then
      l_ir := case when s.pg = 61 then 60 when s.pg = 60 then 6 else report_of(s.pg) end;
      if l_ir is not null and l_entry.exists(to_char(l_ir)) then
        l_opt := wwv_flow_id.next_val;
        wwv_flow_imp_shared.create_menu_option(p_id => l_opt, p_menu_id => l_menu, p_parent_id => l_entry(to_char(l_ir)),
          p_option_sequence => 10, p_short_name => s.name, p_page_id => s.pg);
        l_entry(to_char(s.pg)) := l_opt;
      end if;
    end if;
  end loop;

  -- ============================================================================
  -- 3. Botones
  -- ============================================================================
  -- formularios
  for f in (select distinct p.page_id pg from wwv_flow_page_plugs p
             where p.flow_id = c_app and p.plug_source_type = 'NATIVE_FORM' and p.page_id <> c_dialog) loop
    for b in (select id, button_name from wwv_flow_step_buttons where flow_id = c_app and flow_step_id = f.pg) loop
      case b.button_name
        when 'CANCEL' then btn(b.id, 'Regresar', l_global, 'CLOSE', l_btn_icon, c_icon_left, 'fa-arrow-left', 'N');
        when 'DELETE' then btn(b.id, 'Eliminar', l_global, 'DELETE', l_btn_text, c_danger, null, 'N');
        when 'SAVE'   then btn(b.id, 'Aplicar Cambios', l_global, 'EDIT', l_btn_text, '#DEFAULT#', null, 'Y');
        when 'CREATE' then btn(b.id, 'Aplicar Cambios', l_global, 'EDIT', l_btn_text, '#DEFAULT#', null, 'Y');
        else null;
      end case;
    end loop;
    -- Nuevo: abre el formulario vacío (solo cuando se está editando un registro)
    -- condición de los botones: la parte de la llave que no tiene valor por defecto (la compañía lo tiene)
    select max(name) keep (dense_rank first order by case when item_default is null then 0 else 1 end, item_sequence) into l_pk
      from wwv_flow_step_items where flow_id = c_app and flow_step_id = f.pg and is_primary_key = 'Y';
    update wwv_flow_step_buttons b set button_condition = l_pk
     where b.flow_id = c_app and b.flow_step_id = f.pg and b.button_name in ('SAVE', 'DELETE', 'CREATE')
       and b.button_condition_type in ('ITEM_IS_NULL', 'ITEM_IS_NOT_NULL')
       and b.button_condition in (select i.name from wwv_flow_step_items i where i.flow_id = c_app and i.flow_step_id = f.pg
                                    and i.is_primary_key = 'Y' and i.item_default is not null);
    delete from wwv_flow_step_buttons where flow_id = c_app and flow_step_id = f.pg and button_name = 'NUEVO';
    wwv_flow_imp_page.create_page_button(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => f.pg,
      p_button_sequence => 50, p_button_plug_id => l_global, p_button_name => 'NUEVO', p_button_action => 'REDIRECT_URL',
      p_button_redirect_url => 'f?p=&APP_ID.:' || f.pg || ':&APP_SESSION.::&DEBUG.:' || f.pg || '::',
      p_button_template_id => l_btn_icon, p_button_template_options => c_icon_left, p_icon_css_classes => 'fa-file-plus',
      p_button_is_hot => 'N', p_button_image_alt => 'Nuevo', p_button_position => 'CREATE',
      p_button_condition_type => case when l_pk is not null then 'ITEM_IS_NOT_NULL' end, p_button_condition => l_pk);
  end loop;

  -- reportes: "Create" -> "Nuevo" en el Breadcrumb Global
  for b in (select b.id from wwv_flow_step_buttons b
             where b.flow_id = c_app and b.button_name = 'CREATE' and b.button_action in ('REDIRECT_PAGE', 'REDIRECT_URL')
               and b.flow_step_id not in (select page_id from wwv_flow_page_plugs where flow_id = c_app and plug_source_type = 'NATIVE_FORM')) loop
    btn(b.id, 'Nuevo', l_global, 'CREATE', l_btn_icon, c_icon_left, 'fa-file-plus', 'N');
  end loop;

  -- páginas maestro-detalle (grillas con botón Guardar de página) -> Aplicar Cambios
  for b in (select b.id from wwv_flow_step_buttons b
             where b.flow_id = c_app and b.button_name = 'SAVE' and b.button_action = 'SUBMIT'
               and b.flow_step_id in (select page_id from wwv_flow_page_plugs where flow_id = c_app and plug_source_type = 'NATIVE_IG')
               and b.flow_step_id not in (select page_id from wwv_flow_page_plugs where flow_id = c_app and plug_source_type = 'NATIVE_FORM')) loop
    btn(b.id, 'Aplicar Cambios', l_global, 'EDIT', l_btn_text, '#DEFAULT#', null, 'Y');
  end loop;

  -- Detalles del plan (60) y Estructura (61)
  for b in (select id, flow_step_id pg, button_name from wwv_flow_step_buttons
             where flow_id = c_app and flow_step_id in (60, 61)) loop
    case
      when b.button_name = 'VOLVER' then btn(b.id, 'Regresar', l_global, 'CLOSE', l_btn_icon, c_icon_left, 'fa-arrow-left', 'N');
      when b.button_name = 'EDITAR' then btn(b.id, 'Editar', l_global, 'EDIT', l_btn_icon, c_icon_left, 'fa-edit', 'Y');
      when b.button_name = 'EDITAR_ESTRUCTURA' then
        btn(b.id, 'Editar Estructura', null, 'TOP', l_btn_icon, c_success, 'fa-sitemap', 'N', 'RIGHT');
      when b.pg = 61 and b.button_name = 'SAVE'   then btn(b.id, 'Guardar', null, 'TOP', l_btn_icon, c_success, 'fa-save', 'N', 'RIGHT');
      when b.pg = 61 and b.button_name = 'DELETE' then btn(b.id, 'Eliminar', null, 'TOP', l_btn_text, c_danger, null, 'N', 'RIGHT');
      when b.pg = 61 and b.button_name = 'CREATE' then btn(b.id, 'Crear', null, 'TOP', l_btn_icon, c_success, 'fa-plus', 'N', 'RIGHT');
      else null;
    end case;
  end loop;
  -- regiones "Buttons" que quedaron vacías
  delete from wwv_flow_page_plugs p
   where p.flow_id = c_app and p.plug_source_type = 'NATIVE_STATIC' and p.plug_name = 'Buttons'
     and not exists (select 1 from wwv_flow_step_buttons b where b.flow_id = c_app and b.button_plug_id = p.id)
     and not exists (select 1 from wwv_flow_step_items i where i.flow_id = c_app and i.item_plug_id = p.id);

  -- ============================================================================
  -- 4. Cuadrículas interactivas
  -- ============================================================================
  for g in (select ig.id, ig.region_id, ig.is_editable, p.page_id from wwv_flow_interactive_grids ig
              join wwv_flow_page_plugs p on p.id = ig.region_id where p.flow_id = c_app) loop
    select count(*) into l_has_save from wwv_flow_step_buttons
     where flow_id = c_app and flow_step_id = g.page_id and button_name in ('SAVE', 'CREATE') and button_action = 'SUBMIT';
    update wwv_flow_interactive_grids
       set add_row_if_empty = 'N', select_first_row = 'N', add_button_label = 'Nuevo', show_toolbar = 'Y',
           toolbar_buttons = 'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET'
                             || case when g.is_editable = 'Y' and l_has_save = 0 then ':SAVE' end
     where id = g.id;
    -- alineación: casillas centradas, valores monetarios a la derecha, el resto a la izquierda
    update wwv_flow_region_columns c
       set heading_alignment = case when c.item_type in ('NATIVE_YES_NO', 'NATIVE_SINGLE_CHECKBOX', 'NATIVE_CHECKBOX') then 'CENTER'
                                    when c.name in ('CAPITAL', 'CD', 'CN', 'CREDIT', 'DE', 'OPERATION', 'MANAGEMENT', 'MONOPOLY',
                                                    'OTHERS', 'RP', 'SGR', 'APPROPRIATED', 'COMMITMENTS', 'OBLIGATIONS', 'PAYMENTS', 'AMOUNT')
                                      or c.name like 'SGP%' then 'RIGHT'
                                    else 'LEFT' end
     where c.flow_id = c_app and c.region_id = g.region_id and c.name not like 'APEX$%';
    update wwv_flow_region_columns c set value_alignment = heading_alignment
     where c.flow_id = c_app and c.region_id = g.region_id and c.name not like 'APEX$%';
  end loop;

  -- ============================================================================
  -- 5. Textos internos de APEX en español
  -- ============================================================================
  msg('APEX.IG.ACTIONS', 'Acciones');                 msg('APEXIR_ACTIONS', 'Acciones');
  msg('APEX.IG.EDIT', 'Editar');                      msg('APEX.IG.SAVE', 'Guardar');
  msg('APEX.IG.ADD_ROW', 'Nuevo');                    msg('APEX.IG.RESET', 'Restablecer');
  msg('APEXIR_RESET', 'Restablecer');                 msg('APEX.IG.GO', 'Ir');
  msg('APEXIR_GO', 'Ir');                             msg('APEX.IG.SEARCH', 'Buscar');
  msg('APEXIR_SEARCH', 'Buscar');                     msg('APEX.IG.SEARCH.ALL_COLUMNS', 'Buscar: Todas las columnas de texto');
  msg('APEX.IG.SEARCH.COLUMN', 'Buscar: %0');         msg('APEXIR_SEARCH_COLUMN', 'Buscar: %0');
  msg('APEX.IG.CHANGES_SAVED', 'Cambios guardados');  msg('APEX.IG.NO_DATA_FOUND', 'No se encontraron datos');
  msg('APEX.IG.CANCEL', 'Cancelar');                  msg('APEX.IG.DELETE', 'Eliminar');
  msg('APEX.IG.DELETE_ROW', 'Eliminar fila');         msg('APEX.IG.DELETE_ROWS', 'Eliminar filas');
  msg('APEX.IG.DUPLICATE_ROW', 'Duplicar fila');      msg('APEX.IG.DUPLICATE_ROWS', 'Duplicar filas');
  msg('APEX.IG.REFRESH_ROW', 'Refrescar fila');       msg('APEX.IG.REFRESH_ROWS', 'Refrescar filas');
  msg('APEX.IG.REVERT_CHANGES', 'Revertir cambios');  msg('APEX.IG.REVERT_ROWS', 'Revertir filas');
  msg('APEX.IG.ROW_ACTIONS', 'Acciones de fila');     msg('APEX.IG.SINGLE_ROW_VIEW', 'Vista de un registro');
  msg('APEX.IG.SELECTION', 'Selección');              msg('APEX.IG.COLUMNS', 'Columnas');
  msg('APEXIR_COLUMNS', 'Columnas');                  msg('APEX.IG.FILTER', 'Filtrar');
  msg('APEXIR_FILTER', 'Filtrar');                    msg('APEX.IG.DATA', 'Datos');
  msg('APEXIR_DATA', 'Datos');                        msg('APEX.IG.FORMAT', 'Formato');
  msg('APEXIR_FORMAT', 'Formato');                    msg('APEX.IG.CHART', 'Gráfico');
  msg('APEXIR_CHART', 'Gráfico');                     msg('APEX.IG.GROUP_BY', 'Agrupar por');
  msg('APEXIR_GROUP_BY', 'Agrupar por');              msg('APEX.IG.PIVOT', 'Pivotar');
  msg('APEXIR_PIVOT', 'Pivotar');                     msg('APEX.IG.REPORT', 'Reporte');
  msg('APEXIR_REPORT', 'Reporte');                    msg('APEX.IG.DOWNLOAD', 'Descargar');
  msg('APEXIR_DOWNLOAD', 'Descargar');                msg('APEX.IG.HELP', 'Ayuda');
  msg('APEXIR_HELP', 'Ayuda');                        msg('APEX.IG.SORT', 'Ordenar');
  msg('APEXIR_SORT', 'Ordenar');                      msg('APEX.IG.AGGREGATE', 'Totalizar');
  msg('APEXIR_AGGREGATE', 'Totalizar');               msg('APEX.IG.COMPUTE', 'Calcular');
  msg('APEXIR_COMPUTE', 'Calcular');                  msg('APEX.IG.CONTROL_BREAK', 'Corte de control');
  msg('APEXIR_CONTROL_BREAK', 'Corte de control');    msg('APEX.IG.HIGHLIGHT', 'Resaltar');
  msg('APEXIR_HIGHLIGHT', 'Resaltar');                msg('APEX.IG.ROWS_PER_PAGE', 'Filas por página');
  msg('APEXIR_ROWS_PER_PAGE', 'Filas por página');    msg('APEXIR_SAVE_REPORT', 'Guardar reporte');
  msg('APEX.GV.PAGE_RANGE_XYZ', '%0 - %1 de %2');     msg('APEX.GV.SELECTION_COUNT', '%0 filas seleccionadas');
  msg('APEX.GV.TOTAL_PAGES', 'Total %0');             msg('APEX.GV.SELECT_ALL_ROWS', 'Seleccionar todas las filas');
  msg('APEX.GV.SELECT_ROW', 'Seleccionar fila');      msg('APEX.GV.DELETED_COUNT', '%0 filas eliminadas');
  msg('SUCCESS_MSG.SINGLE_ROW_CREATED', 'Registro creado.');
  msg('SUCCESS_MSG.SINGLE_ROW_UPDATED', 'Registro actualizado.');
  msg('SUCCESS_MSG.SINGLE_ROW_DELETED', 'Registro eliminado.');
  msg('SUCCESS_MSG.ROWS_INSERTED', '%0 registro(s) creado(s).');
  msg('SUCCESS_MSG.ROWS_UPDATED', '%0 registro(s) actualizado(s).');
  msg('SUCCESS_MSG.ROWS_DELETED', '%0 registro(s) eliminado(s).');
  msg('FLOW.SINGLE_VALIDATION_ERROR', 'Se presentó 1 error');
  msg('FLOW.VALIDATION_ERROR', 'Se presentaron %0 errores');
  msg('APEX.PAGE_ITEM_IS_REQUIRED', '#LABEL# es obligatorio.');
  msg('APEXIR_DELETE_CONFIRM_JS_DIALOG', '¿Desea eliminar este registro?');
  msg('DELETE_MSG', '¿Desea eliminar este registro?');
  msg('APEX.DIALOG.OK', 'Aceptar');                   msg('APEX.DIALOG.CANCEL', 'Cancelar');
  msg('APEX.DIALOG.CLOSE', 'Cerrar');                 msg('APEX.CLOSE_NOTIFICATION', 'Cerrar');

  wwv_flow_imp.import_end(p_auto_install_sup_obj => false);
  commit;
  dbms_output.put_line('ESTANDAR OK (' || l_n || ' botones, ' || l_entry.count || ' migas)');
end;
/
exit
