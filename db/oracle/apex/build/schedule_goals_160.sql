-- Programación de Metas / Proyectos / Planes de Acción (páginas 1030, 1035 y 1040 de la app 160) y diálogo
-- de programación (1063), como en el original
-- (client/components/Goals/GoalsCatalog + GoalsSchedule):
--  * 1030: selector del seguimiento (en React está en el encabezado; por defecto el activo) y pestañas
--    "Listado" (reporte con estado y acciones) y "Por Estructura del Plan" (árbol + metas del nodo).
--    El código abre "Datos de la Meta" (diálogo 1062); la acción Programar / Ver abre el diálogo 1063.
--  * 1063 (diálogo "Programación"): pestañas "Datos Programación" (resumen de la meta, actividades, programación
--    de la meta, ponderación, meses y recursos por fuente: Programación (MANUAL) / Apropiado (DEFINITIVE))
--    e "Historial" (SPD_GOAL_HISTORY del seguimiento). Botones Volver / Guardar.
--  * Guardar = savePlannedMonitoringRecord: registro en PLANNED, recursos (solo si el origen admite recursos
--    del usuario; el apropiado solo si la entidad del usuario tiene presupuesto manual) y evento SCHEDULED;
--    cierra el diálogo y la 1030 refresca el listado. Solo se puede programar dentro de la ventana de
--    programación del seguimiento y si la meta no está Validada / Revisada.
-- Se ejecuta como SIIF sobre la app 160 instalada (run_import_160.sh lo aplica después de importar).
-- Proyectos y Planes usan las mismas pantallas con sus tipos de meta (React: GoalsCatalog con otro goalTypes):
-- sin Indicador / Línea Base / Programación Meta, y los planes de acción no se programan (sí sus metas).
-- Es re-ejecutable: reemplaza las páginas 1030, 1035, 1040 y 1063 completas.
set serveroutput on size unlimited
set define off
whenever sqlerror exit failure

declare
  c_app    constant number := 160;
  g_page   number := 1030;
  g_group  varchar2(20) := 'METAS';
  g_types  varchar2(200) := '''PRODUCT'', ''RESULT'', ''IMPACT'', ''WELL_BEING''';
  g_label  varchar2(100) := 'Metas';
  c_dlg    constant number := 1063;     -- Programación (diálogo)
  l_tpl_btn   number;
  l_tpl_btns  number;
  l_tpl_dlg   number;
  l_btn    number;
  l_evt    number;
  l_load   varchar2(32767);
  l_save   varchar2(32767);
  l_datos  varchar2(32767);
  l_hist   varchar2(32767);
  l_css    varchar2(32767);
  l_jsform varchar2(32767);
  c_det    constant number := 1062;     -- Datos de la Meta (diálogo)
  l_ws     number;
  l_tpl_std   number;
  l_tpl_tabs  number;
  l_tpl_blank number;
  l_tpl_icon  number;
  l_ft_opt    number;
  l_seg    number;
  l_tabs   number;
  l_tab1   number;
  l_tab2   number;
  l_panel  number;
  l_ptabs  number;
  l_wsid   number;
  l_dummy  number;
  l_seq    pls_integer := 0;
  l_colseq pls_integer := 0;

  function r(p varchar2) return varchar2 is
  begin
    return replace(replace(replace(p, '#P#', 'P' || g_page || '_'), '#GT#', g_types), '#G#', g_group);
  end;

  function tpl(p_type varchar2, p_name varchar2) return number is
    l number;
  begin
    select template_id into l from apex_application_templates
     where application_id = c_app and template_type = p_type and template_name = p_name;
    return l;
  end;

  function region(p_name varchar2, p_seq number, p_template number, p_type varchar2 default 'NATIVE_STATIC',
                  p_source clob default null, p_parent number default null, p_new_row boolean default true,
                  p_span number default null, p_options varchar2 default '#DEFAULT#', p_query boolean default false,
                  p_cond_type varchar2 default null, p_cond varchar2 default null, p_attrs clob default null,
                  p_css varchar2 default null, p_static_id varchar2 default null) return number is
    l_id number := wwv_flow_id.next_val;
  begin
    wwv_flow_imp_page.create_page_plug(p_id => l_id, p_flow_id => c_app, p_page_id => g_page,
      p_plug_name => p_name, p_region_name => p_static_id, p_region_template_options => p_options,
      p_plug_template => p_template, p_plug_display_sequence => p_seq,
      p_plug_display_point => case when p_parent is not null then 'SUB_REGIONS' else 'BODY' end,
      p_parent_plug_id => p_parent, p_plug_new_grid_row => p_new_row, p_plug_grid_column_span => p_span,
      p_query_type => case when p_query then 'SQL' end,
      p_function_body_language => case when p_type = 'NATIVE_DYNAMIC_CONTENT' then 'PLSQL' end,
      p_plug_source => p_source, p_plug_source_type => p_type, p_attributes => p_attrs,
      p_region_css_classes => p_css,
      p_plug_display_condition_type => p_cond_type, p_plug_display_when_condition => p_cond);
    return l_id;
  end;

  procedure item(p_plug number, p_name varchar2, p_label varchar2, p_type varchar2 default 'NATIVE_HIDDEN',
                 p_lov varchar2 default null) is
  begin
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_page_item(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
      p_name => r(p_name), p_item_sequence => l_seq, p_item_plug_id => p_plug, p_prompt => p_label,
      p_display_as => p_type, p_use_cache_before_default => 'YES', p_cSize => 30,
      p_lov => p_lov, p_lov_display_null => case when p_lov is not null then 'NO' end,
      p_field_template => case when p_type <> 'NATIVE_HIDDEN' then l_ft_opt end,
      p_item_template_options => '#DEFAULT#', p_is_persistent => 'Y',
      p_attributes => case p_type
        when 'NATIVE_HIDDEN' then wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2('value_protected', 'N')).to_clob
        when 'NATIVE_SELECT_LIST' then wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2('page_action_on_selection', 'SUBMIT')).to_clob
      end);
  end;

  procedure button(p_plug number, p_name varchar2, p_label varchar2, p_icon varchar2,
                   p_cond_type varchar2 default null, p_cond varchar2 default null, p_cond2 varchar2 default null) is
  begin
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_page_button(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
      p_button_sequence => l_seq, p_button_plug_id => p_plug, p_button_name => p_name, p_button_action => 'SUBMIT',
      p_button_template_options => '#DEFAULT#:t-Button--noUI', p_button_template_id => l_tpl_icon,
      p_button_image_alt => p_label, p_button_position => 'EDIT', p_icon_css_classes => p_icon,
      p_button_condition_type => p_cond_type, p_button_condition => p_cond, p_button_condition2 => p_cond2,
      p_warn_on_unsaved_changes => null);
  end;

  procedure process(p_name varchar2, p_point varchar2, p_code varchar2, p_when_type varchar2 default null,
                    p_when varchar2 default null, p_success varchar2 default null) is
  begin
    l_seq := l_seq + 10;
    wwv_flow_imp_page.create_page_process(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
      p_process_sequence => l_seq, p_process_point => p_point, p_process_type => 'NATIVE_PLSQL',
      p_process_name => p_name, p_process_sql_clob => r(p_code), p_process_clob_language => 'PLSQL',
      p_error_display_location => 'INLINE_IN_NOTIFICATION', p_process_success_message => p_success,
      p_process_when_type => p_when_type, p_process_when => p_when);
  end;

  -- columna del reporte interactivo
  procedure wcol(p_name varchar2, p_label varchar2, p_type varchar2 default 'STRING', p_hidden boolean default false,
                 p_align varchar2 default 'LEFT', p_html varchar2 default null, p_link varchar2 default null,
                 p_link_text varchar2 default null, p_link_attr varchar2 default null) is
  begin
    l_colseq := l_colseq + 1;
    wwv_flow_imp_page.create_worksheet_column(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_page_id => g_page,
      p_worksheet_id => l_wsid, p_db_column_name => p_name, p_display_order => l_colseq,
      p_column_identifier => chr(64 + l_colseq), p_column_label => p_label, p_column_type => p_type,
      p_display_text_as => case when p_hidden then 'HIDDEN_ESCAPE_SC' when p_html is not null then 'WITHOUT_MODIFICATION' else 'ESCAPE_SC' end,
      p_column_html_expression => p_html, p_column_link => p_link, p_column_linktext => p_link_text,
      p_column_link_attr => p_link_attr, p_column_link_checksum_type => case when p_link is not null then '3' end,
      p_heading_alignment => p_align, p_column_alignment => p_align, p_tz_dependent => 'N', p_use_as_row_header => 'N');
  end;
begin
  apex_application_install.set_workspace('SIIFWEB');
  l_ws := apex_application_install.get_workspace_id;
  wwv_flow_imp.import_begin(p_version_yyyy_mm_dd => '2024.11.30', p_release => '24.2.0',
    p_default_workspace_id => l_ws, p_default_application_id => c_app, p_default_id_offset => 0,
    p_default_owner => 'SIIF');

  l_tpl_std   := tpl('Region', 'Standard');
  l_tpl_tabs  := tpl('Region', 'Tabs Container');
  l_tpl_blank := tpl('Region', 'Blank with Attributes');
  l_tpl_icon  := tpl('Button', 'Icon');
  l_ft_opt    := tpl('Item Label', 'Optional');
  l_tpl_btn   := tpl('Button', 'Text');
  l_tpl_btns  := tpl('Region', 'Buttons Container');
  l_tpl_dlg   := tpl('Page', 'Modal Dialog');

  l_css := q'~
.spd-badge{display:inline-block;min-width:20px;padding:0 6px;margin-left:6px;border-radius:10px;font-size:11px;line-height:18px;color:#fff;text-align:center;background:#1677ff;vertical-align:middle}
.spd-badge--PRODUCT{background:#9FD912}.spd-badge--RESULT,.spd-badge--WELL_BEING,.spd-badge--IMPACT{background:#52c41a}
.spd-badge--ACTIVITY{background:#1677ff}.spd-badge--PROJECT{background:green}.spd-badge--ACTION_PLAN{background:blueviolet}.spd-badge--ACTION_PLAN_ACTIVITY{background:orange}
.spd-st{display:inline-flex;align-items:center;justify-content:center;width:30px;height:30px;border-radius:50%;font-size:15px;border:1px solid transparent}
.spd-st--NEW{color:#0f1129;border-color:#0f1129}
.spd-st--SCH{color:#008000;border-color:#008000;background:rgba(0,128,0,.15)}
.spd-st--PAR{color:#f99c07;border-color:#f99c07;background:rgba(249,156,7,.15)}
.spd-st--REP{color:#008000;background:rgba(0,128,0,.15)}
.spd-st--VAL{color:#008000;border-color:#008000}
.spd-st--REV{color:#008000;border-color:#008000;background:rgba(0,128,0,.4)}
.spd-st--REJ{color:#ef440b;background:rgba(239,68,11,.15)}
.spd-act{font-size:16px;color:#1677ff}
.spd-collapse{border:1px solid #d9d9d9;border-radius:8px;margin-bottom:10px;background:#fff}
.spd-collapse>summary{padding:12px 16px;cursor:pointer;background:#fafafa;border-radius:8px;list-style:none}
.spd-collapse>summary::before{content:"\203A";display:inline-block;width:16px;font-weight:bold;transition:transform .2s}
.spd-collapse[open]>summary::before{transform:rotate(90deg)}
.spd-collapse[open]>summary{border-bottom:1px solid #d9d9d9;border-radius:8px 8px 0 0}
.spd-collapse>div{padding:16px}
.spd-desc{width:100%;border-collapse:collapse;border:1px solid #f0f0f0}
.spd-desc th,.spd-desc td{border:1px solid #f0f0f0;padding:8px 16px;text-align:left;vertical-align:top;font-weight:normal}
.spd-desc th{background:#fafafa;color:rgba(0,0,0,.65);width:22%}
.spd-tbl{width:100%;border-collapse:collapse}
.spd-scroll{max-height:75vh;overflow:auto}
.spd-scroll .spd-tbl th{position:sticky;top:0;z-index:1}
.spd-tbl th{background:#fafafa;padding:8px;text-align:left;border-bottom:1px solid #f0f0f0}
.spd-tbl td{padding:8px;border-bottom:1px solid #f0f0f0;vertical-align:top}
.spd-empty{padding:24px;text-align:center;color:rgba(0,0,0,.35)}
.spd-empty .fa{font-size:32px;display:block;margin-bottom:6px}
.spd-form{border-collapse:separate;border-spacing:0 8px;width:100%}
.spd-form th{text-align:left;font-weight:normal;padding-right:16px;white-space:nowrap;width:1%}
.spd-form th:after{content:":"}
.spd-form th.spd-noc:after{content:""}
.spd-form td{padding-right:10px}
.spd-form input,.spd-form select{height:32px;border:1px solid #d9d9d9;border-radius:6px;padding:0 8px}
.spd-form input[disabled],.spd-form select[disabled],.spd-form input[readonly]{background:#f5f5f5;color:rgba(0,0,0,.45)}
.spd-num{width:170px;text-align:right}.spd-num--sm{width:70px}.spd-sel{width:200px}
.spd-money{width:100%;min-width:110px;max-width:240px;text-align:right}
.spd-colhead{text-align:center;font-weight:bold;font-size:15px}
.spd-total th{font-weight:bold;font-size:15px}
.spd-sgp-sub th{padding-left:28px}
.spd-sgp-toggle{cursor:pointer;margin-right:6px}
.spd-btns{text-align:center;margin-top:16px}
.spd-hist{list-style:none;margin:0;padding:0}
.spd-hist li{display:flex;gap:16px;padding:12px 0;border-bottom:1px solid #f0f0f0}
.spd-avatar{flex:none;width:32px;height:32px;border-radius:50%;background:#87d068;color:#fff;display:flex;align-items:center;justify-content:center}
.spd-hist-title{font-weight:500}.spd-hist-desc{color:rgba(0,0,0,.45)}~';
  l_jsform := q'~
function spdNum(v) { v = (v || "").replace(/\./g, "").replace(",", "."); var n = parseFloat(v); return isNaN(n) ? 0 : n; }
function spdFmt(n) { return n.toLocaleString("es-CO", {maximumFractionDigits: 2}); }
// totales por columna (y SGP = suma de las fuentes SGP cuando el seguimiento las discrimina)
function spdTotals() {
  ["u", "f"].forEach(function (c) {
    if ($(".spd-sgp-sub ." + c + "-res").length && $("#spd_sgp_disc").val() === "S") {
      var s = 0; $(".spd-sgp-sub ." + c + "-res").each(function () { s += spdNum(this.value); });
      $("#" + c + "_SGP").val(spdFmt(s));
    }
    var t = 0; $("tr:not(.spd-sgp-sub) ." + c + "-res").each(function () { t += spdNum(this.value); });
    $("#" + c + "_TOTAL").val(spdFmt(t));
  });
}
$(document).on("change keyup", ".u-res,.f-res", spdTotals);
// meses: el inicial no puede ser mayor que el final
$(document).on("change", "#spd_from", function () { if (+this.value > +$("#spd_to").val()) $("#spd_to").val(this.value); });
$(document).on("change", "#spd_to", function () { if (+$("#spd_from").val() > +this.value) $("#spd_from").val(this.value); });
$(document).on("click", ".spd-sgp-toggle", function () { $(".spd-sgp-sub").toggle(); $(this).toggleClass("fa-chevron-down fa-chevron-up"); });~';

  for gx in (select regexp_substr(column_value, '[^|]+', 1, 1) as PG, regexp_substr(column_value, '[^|]+', 1, 2) as GRP,
                    regexp_substr(column_value, '[^|]+', 1, 3) as ALIAS, regexp_substr(column_value, '[^|]+', 1, 4) as NAME,
                    regexp_substr(column_value, '[^|]+', 1, 5) as TITLE, regexp_substr(column_value, '[^|]+', 1, 6) as LABEL,
                    regexp_substr(column_value, '[^|]+', 1, 7) as TYPES
               from table(sys.odcivarchar2list(
                 '1030|METAS|SPD_PROGRAMACION_METAS|SPD_Programación de metas|Programación de Metas|Metas|''PRODUCT'', ''RESULT'', ''IMPACT'', ''WELL_BEING''',
                 '1035|PROYECTOS|SPD_PROGRAMACION_PROYECTOS|SPD_Programación de proyectos|Programación de Proyectos|Proyectos|''PROJECT'', ''ACTIVITY''',
                 '1040|PLANES|SPD_PROGRAMACION_PLANES_ACCION|SPD_Programación de planes de acción|Programación de Planes de Acción|Planes de Acción|''ACTION_PLAN'', ''ACTION_PLAN_ACTIVITY''')))
  loop
  g_page := to_number(gx.PG); g_group := gx.GRP; g_types := gx.TYPES; g_label := gx.LABEL; l_seq := 0; l_colseq := 0;
  wwv_flow_imp_page.remove_page(p_flow_id => c_app, p_page_id => g_page);

  wwv_flow_imp_page.create_page(p_id => g_page, p_flow_id => c_app, p_name => gx.NAME,
    p_alias => gx.ALIAS, p_step_title => gx.TITLE, p_autocomplete_on_off => 'OFF',
    p_page_template_options => '#DEFAULT#', p_protection_level => 'C',
    p_inline_css => l_css,
    p_javascript_code_onload => q'~
// al cerrar el diálogo de programación se refresca el listado y las metas del nodo
$(window).on("apexafterclosedialog", function (e, data) {
  apex.region("spd_list").refresh();
  if ($("#spd_node_goals").length) apex.region("spd_node_goals").refresh();
  if (data && data.successMessage && data.successMessage.text) apex.message.showPageSuccess(data.successMessage.text);
});
var t = $("#spd_sched_tree"), L = {PRODUCT: "Producto", RESULT: "Resultado", WELL_BEING: "Bienestar", IMPACT: "Impacto", ACTIVITY: "Actividad", PROJECT: "Proyecto", ACTION_PLAN: "Plan de Acción", ACTION_PLAN_ACTIVITY: "Meta de Plan de Acción", PUBLIC_POLITIC: "Política Pública"};
function spdBadges() { t.find(".a-TreeView-label").each(function () { var e = $(this), m = e.text().match(/^(.*) \{\{(.*)\}\}$/); if (m) { e.text(m[1]); m[2].split(",").forEach(function (x) { var p = x.split(":"); e.append($("<span>").addClass("spd-badge spd-badge--" + p[0]).attr("title", p[1] + " metas de " + (L[p[0]] || p[0])).text(p[1])); }); } }); }
if (t.length) { t.on("treeviewexpansionstatechange", function () { setTimeout(spdBadges, 0); }); var s = t.treeView("getSelection"); if (s.length) { t.treeView("expand", s); } spdBadges(); }~');

  -- ==========================================================================
  -- Seguimiento + ítems de estado
  -- ==========================================================================
  l_seg := region('Seguimiento', 5, l_tpl_blank);
  item(l_seg, '#P#MC', 'Seguimiento', 'NATIVE_SELECT_LIST', q'~select '(' || mc.PERIOD || '-' || mc.SUBPERIOD || ') ' || pd.NOMBRE as d, mc.ID as r
  from SPD_MONITORING_CONFIG mc
  left join PLAN_DESARROLLO pd on pd.NIT_COMPANIA = mc.NIT_COMPANIA and pd.PLAN = mc.PLAN
 where mc.NIT_COMPANIA = :G_NIT_COMPANIA and nvl(mc.USED_FOR, 'DEVELOPMENT_PLANS') = 'DEVELOPMENT_PLANS'
 order by case when mc.IS_ACTIVE = 'S' then 0 else 1 end, mc.PERIOD desc, mc.SUBPERIOD desc~');
  for h in (select column_value n from table(sys.odcivarchar2list(
              'GOAL_ID', 'NODE', 'NODE_NAME', 'TOTAL', 'PLAN', 'ORIGIN', 'WEIGHT_TYPE', 'SGP_DISC', 'SUPPORT_PI',
              'DATE_OK', 'MANUAL_BUDGET', 'EDITABLE', 'REC_ID', 'STATUS', 'GOAL_TYPE', 'USER_ID'))) loop
    item(l_seg, '#P#' || h.n, h.n);
  end loop;

  -- ==========================================================================
  -- Pestañas: Listado / Por Estructura del Plan
  -- ==========================================================================
  l_tabs := region(g_label, 10, l_tpl_tabs, p_options => '#DEFAULT#:js-useLocalStorage:t-TabsRegion-mod--simple');

  l_tab1 := region(r('Listado <span class="spd-badge">&#P#TOTAL.</span>'), 10, l_tpl_blank, 'NATIVE_IR',
    p_parent => l_tabs, p_query => true, p_static_id => 'spd_list', p_source => r(q'~
select m.GOAL_ID, m.CODE, m.NAME, m.INDICATOR, m.BASE_VALUE, m.ENTITY_CODE, m.ENTITY_NAME, m.GOAL_VALUE,
       m.SCHEDULE_STATUS,
       case m.SCHEDULE_STATUS when 'Sin Programar' then 'NEW' when 'Programada' then 'SCH' when 'Programada Parcial' then 'PAR'
            when 'Reportada' then 'REP' when 'Validada' then 'VAL' when 'Revisada' then 'REV' when 'Rechazada' then 'REJ' end as ST_KEY,
       case when m.SCHEDULE_STATUS in ('Sin Programar', 'Programada', 'Programada Parcial') then 'fa-usd'
            when m.SCHEDULE_STATUS = 'Reportada' then 'fa-pencil-square-o' when m.SCHEDULE_STATUS = 'Validada' then 'fa-check-circle'
            when m.SCHEDULE_STATUS = 'Revisada' then 'fa-check-square-o' else 'fa-calendar-times-o' end as ST_ICON,
       m.GOAL_ID as ACCIONES,
       case when :#P#DATE_OK = 'S' and m.SCHEDULE_STATUS not in ('Validada', 'Revisada') then 'fa-clipboard' else 'fa-eye' end as ACCION_ICON,
       case when :#P#DATE_OK = 'S' and m.SCHEDULE_STATUS not in ('Validada', 'Revisada') then 'Programar' else 'Ver' end as ACCION_TITLE
  from V_SPD_GOAL_MONITORING m
 where m.NIT_COMPANIA = :G_NIT_COMPANIA and m.MONITORING_CONFIG_ID = :#P#MC and m.GOAL_GROUP = '#G#'~'));
  l_wsid := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_worksheet(p_id => l_wsid, p_flow_id => c_app, p_page_id => g_page, p_region_id => l_tab1,
    p_name => 'Metas', p_max_row_count_message => 'El reporte tiene más de #MAX_ROW_COUNT# filas: aplique un filtro.',
    p_no_data_found_message => 'No hay datos', p_pagination_type => 'ROWS_X_TO_Y', p_pagination_display_pos => 'BOTTOM_RIGHT',
    p_report_list_mode => 'NONE', p_lazy_loading => false, p_show_detail_link => 'N', p_show_notify => 'N',
    p_show_chart => 'N', p_show_group_by => 'N', p_show_pivot => 'N', p_show_calendar => 'N', p_show_flashback => 'N',
    p_allow_save_rpt_public => 'N', p_download_formats => 'CSV:XLSX', p_enable_mail_download => 'N',
    p_owner => 'SIIF', p_internal_uid => l_wsid);
  wcol('GOAL_ID', 'ID', 'NUMBER', p_hidden => true);
  wcol('CODE', 'Código', p_link => 'f?p=&APP_ID.:' || c_det || ':&APP_SESSION.::&DEBUG.:' || c_det || ':P' || c_det || '_ID:#GOAL_ID#',
       p_link_text => '#CODE#');
  wcol('NAME', 'Nombre');
  if g_group = 'METAS' then
    wcol('INDICATOR', 'Indicador');
    wcol('BASE_VALUE', 'Línea Base', 'NUMBER', p_align => 'RIGHT');
  else
    wcol('INDICATOR', 'Indicador', p_hidden => true);
    wcol('BASE_VALUE', 'Línea Base', 'NUMBER', p_hidden => true);
  end if;
  wcol('ENTITY_CODE', 'Entidad', p_html => '<span title="#ENTITY_NAME#">#ENTITY_CODE#</span>');
  wcol('ENTITY_NAME', 'Nombre de la entidad', p_hidden => true);
  wcol('GOAL_VALUE', 'Meta', 'NUMBER', p_align => 'RIGHT');
  wcol('SCHEDULE_STATUS', 'Estado', p_align => 'CENTER',
       p_html => '<span class="spd-st spd-st--#ST_KEY#" title="#SCHEDULE_STATUS#"><span class="fa #ST_ICON#" aria-hidden="true"></span></span>');
  wcol('ST_KEY', 'ST_KEY', p_hidden => true);
  wcol('ST_ICON', 'ST_ICON', p_hidden => true);
  wcol('ACCIONES', 'Acciones', 'NUMBER', p_align => 'CENTER',
       p_link => 'f?p=&APP_ID.:' || c_dlg || ':&APP_SESSION.::&DEBUG.:' || c_dlg || ':P' || c_dlg || '_GOAL_ID,P' || c_dlg || '_MC:#GOAL_ID#,&P' || g_page || '_MC.',
       p_link_text => '<span class="fa #ACCION_ICON# spd-act" title="#ACCION_TITLE#" aria-label="#ACCION_TITLE#"></span>',
       p_link_attr => 'data-goal="#GOAL_ID#"');
  wcol('ACCION_ICON', 'ACCION_ICON', p_hidden => true);
  wcol('ACCION_TITLE', 'ACCION_TITLE', p_hidden => true);
  wwv_flow_imp_page.create_worksheet_rpt(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_page_id => g_page,
    p_worksheet_id => l_wsid, p_application_user => 'APXWS_DEFAULT', p_report_seq => 10, p_report_alias => 'SPD_PROG_METAS',
    p_status => 'PUBLIC', p_is_default => 'Y', p_display_rows => 10,
    p_report_columns => case when g_group = 'METAS' then 'CODE:NAME:INDICATOR:BASE_VALUE:ENTITY_CODE:GOAL_VALUE:SCHEDULE_STATUS:ACCIONES'
                             else 'CODE:NAME:ENTITY_CODE:SCHEDULE_STATUS:ACCIONES' end,
    p_sort_column_1 => 'CODE', p_sort_direction_1 => 'ASC');

  -- pestaña 2: Por Estructura del Plan
  l_tab2 := region('Por Estructura del Plan', 20, l_tpl_blank, p_parent => l_tabs);
  l_dummy := region('Estructura del Plan de Desarrollo', 10, l_tpl_std, 'NATIVE_JSTREE', p_parent => l_tab2, p_span => 5,
    p_query => true, p_source => r(q'~with r as (
  select connect_by_root ID as ROOT_ID, ID from SPD_DEV_PLAN_LEVEL
   start with NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :#P#PLAN connect by prior ID = PARENT_ID),
cnt as (
  select r.ROOT_ID, g.GOAL_TYPE, count(*) as N from r join SPD_GOAL g on g.DEV_PLAN_LEVEL_ID = r.ID
   where g.GOAL_TYPE in (#GT#) group by r.ROOT_ID, g.GOAL_TYPE
  union all
  select 0, GOAL_TYPE, count(*) from SPD_GOAL where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = :#P#PLAN
     and GOAL_TYPE in (#GT#) group by GOAL_TYPE),
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
 order siblings by nlssort(n.CODE, 'NLS_SORT=BINARY')~'),
    p_attrs => wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
      'activate_node_link_with', 'S', 'default_icon_css_class', 'icon-tree-folder',
      'hierarchy_level_column', 'LVL', 'icon_css_class_column', 'ICON', 'link_column', 'LINK',
      'node_label_column', 'TITLE', 'node_status_column', 'STATUS', 'node_value_column', 'VALUE',
      'selected_node_page_item', r('#P#NODE'), 'static_tree_id', 'spd_sched_tree',
      'tree_hierarchy', 'LEVEL', 'tree_tooltip', 'N')).to_clob);

  -- metas del nodo seleccionado (y de sus hijos), con estado y acciones
  l_dummy := region(r(g_label || ' de &#P#NODE_NAME.'), 20, l_tpl_std, 'NATIVE_DYNAMIC_CONTENT', p_parent => l_tab2,
    p_new_row => false, p_static_id => 'spd_node_goals', p_source => r(q'~
declare
  l clob;
  rw varchar2(32767);
  n pls_integer := 0;
begin
  l := '<div class="spd-scroll"><table class="spd-tbl"><tr><th>Código</th><th>Nombre</th>' || case when '#G#' = 'METAS' then '<th>Indicador</th><th style="text-align:right">Meta</th>' end
    || '<th style="text-align:center">Estado</th><th style="text-align:center">Acciones</th></tr>';
  for m in (select m.GOAL_ID, m.CODE, m.NAME, m.INDICATOR, m.GOAL_VALUE, m.SCHEDULE_STATUS
              from V_SPD_GOAL_MONITORING m join SPD_GOAL g on g.ID = m.GOAL_ID
             where m.NIT_COMPANIA = :G_NIT_COMPANIA and m.MONITORING_CONFIG_ID = :#P#MC and m.GOAL_GROUP = '#G#'
               and (nvl(:#P#NODE, '0') = '0'
                    or g.DEV_PLAN_LEVEL_ID in (select ID from SPD_DEV_PLAN_LEVEL start with ID = to_number(:#P#NODE)
                                               connect by prior ID = PARENT_ID))
             order by nlssort(m.CODE, 'NLS_SORT=BINARY')) loop
    n := n + 1;
    rw := '<tr><td><a href="' || apex_page.get_url(p_page => 1062, p_items => 'P1062_ID', p_values => m.GOAL_ID, p_clear_cache => '1062')
      || '">' || apex_escape.html(m.CODE) || '</a></td><td>' || apex_escape.html(m.NAME) || '</td>'
      || case when '#G#' = 'METAS' then '<td>' || apex_escape.html(m.INDICATOR) || '</td><td style="text-align:right">' || m.GOAL_VALUE || '</td>' end
      || '<td style="text-align:center"><span class="spd-st spd-st--'
      || case m.SCHEDULE_STATUS when 'Sin Programar' then 'NEW' when 'Programada' then 'SCH' when 'Programada Parcial' then 'PAR'
              when 'Reportada' then 'REP' when 'Validada' then 'VAL' when 'Revisada' then 'REV' else 'REJ' end
      || '" title="' || m.SCHEDULE_STATUS || '"><span class="fa '
      || case when m.SCHEDULE_STATUS in ('Sin Programar', 'Programada', 'Programada Parcial') then 'fa-usd'
              when m.SCHEDULE_STATUS = 'Reportada' then 'fa-pencil-square-o' when m.SCHEDULE_STATUS = 'Validada' then 'fa-check-circle'
              when m.SCHEDULE_STATUS = 'Revisada' then 'fa-check-square-o' else 'fa-calendar-times-o' end
      || '"></span></span></td><td style="text-align:center"><a data-goal="' || m.GOAL_ID || '" href="'
      || apex_page.get_url(p_page => 1063, p_items => 'P1063_GOAL_ID,P1063_MC', p_values => m.GOAL_ID || ',' || :#P#MC,
                           p_clear_cache => '1063') || '">'
      || case when :#P#DATE_OK = 'S' and m.SCHEDULE_STATUS not in ('Validada', 'Revisada')
              then '<span class="fa fa-clipboard spd-act" title="Programar"></span>'
              else '<span class="fa fa-eye spd-act" title="Ver"></span>' end
      || '</a></td></tr>';
    l := l || rw;
  end loop;
  if n = 0 then
    return '<div class="spd-empty"><span class="fa fa-inbox"></span>No hay datos</div>';
  end if;
  return l || '</table></div>';
end;~'));

  -- ==========================================================================
  -- Procesos de la 1030
  -- ==========================================================================
  l_load := q'~
declare
  mc SPD_MONITORING_CONFIG%rowtype;
  function ts(v varchar2) return timestamp with time zone is
  begin
    return from_tz(to_timestamp(substr(v, 1, 23), 'YYYY-MM-DD"T"HH24:MI:SS.FF3'), 'UTC');
  end;
begin
  if :#P#MC is null then
    select max(ID) keep (dense_rank first order by case when IS_ACTIVE = 'S' then 0 else 1 end, PERIOD desc, SUBPERIOD desc)
      into :#P#MC from SPD_MONITORING_CONFIG
     where NIT_COMPANIA = :G_NIT_COMPANIA and nvl(USED_FOR, 'DEVELOPMENT_PLANS') = 'DEVELOPMENT_PLANS';
  end if;
  begin
    select * into mc from SPD_MONITORING_CONFIG where ID = :#P#MC and NIT_COMPANIA = :G_NIT_COMPANIA;
  exception when no_data_found then
    :#P#MC := null; :#P#GOAL_ID := null; :#P#TOTAL := 0; return;
  end;
  :#P#PLAN := mc.PLAN;
  :#P#ORIGIN := mc.MONITORING_RESOURCES_ORIGIN;
  :#P#WEIGHT_TYPE := mc.WEIGHTING_TYPE;
  :#P#SGP_DISC := mc.SGP_DISCRIMINATED;
  :#P#SUPPORT_PI := mc.SUPPORT_PRODUCT_MONITORING;
  -- ventana de programación (DATES_CONFIG.scheduling = [inicio, fin], en UTC)
  :#P#DATE_OK := 'N';
  begin
    if systimestamp between ts(json_value(mc.DATES_CONFIG, '$.scheduling[0]'))
                        and ts(json_value(mc.DATES_CONFIG, '$.scheduling[1]')) then
      :#P#DATE_OK := 'S';
    end if;
  exception when others then null;
  end;
  select count(*) into :#P#TOTAL from V_SPD_GOAL_MONITORING
   where NIT_COMPANIA = :G_NIT_COMPANIA and MONITORING_CONFIG_ID = mc.ID and GOAL_GROUP = nvl('#G#', GOAL_GROUP);

  -- usuario actual (USUARIOS.ID = autor del historial) y presupuesto manual de su entidad
  select max(u.ID), max(e.SPD_PRESUPUESTO_MANUAL) into :#P#USER_ID, :#P#MANUAL_BUDGET
    from USUARIOS u
    left join ENTIDADES_PRY e on e.NIT_COMPANIA = u.NIT_COMPANIA and e.CODIGO_ENT_PRY = u.CODIGO_ENT_PRY
   where u.NIT_COMPANIA = :G_NIT_COMPANIA and (upper(u.USUARIO) = upper(:APP_USER) or upper(u.EMAIL) = upper(:APP_USER));

  -- nodo del árbol
  :#P#NODE := nvl(:#P#NODE, '0');
  if :#P#NODE <> '0' then
    begin
      select CODE || ' ' || NAME into :#P#NODE_NAME from SPD_DEV_PLAN_LEVEL
       where ID = :#P#NODE and NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = mc.PLAN;
    exception when no_data_found then :#P#NODE := '0';
    end;
  end if;
  if :#P#NODE = '0' then
    select max(NOMBRE) into :#P#NODE_NAME from PLAN_DESARROLLO where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = mc.PLAN;
  end if;

  -- meta seleccionada: estado en este seguimiento y si se puede programar
  :#P#REC_ID := null; :#P#STATUS := null; :#P#GOAL_TYPE := null; :#P#EDITABLE := 'N';
  if :#P#GOAL_ID is not null then
    begin
      select MONITORING_RECORD_ID, SCHEDULE_STATUS, GOAL_TYPE into :#P#REC_ID, :#P#STATUS, :#P#GOAL_TYPE
        from V_SPD_GOAL_MONITORING
       where NIT_COMPANIA = :G_NIT_COMPANIA and MONITORING_CONFIG_ID = mc.ID and GOAL_ID = :#P#GOAL_ID and GOAL_GROUP = nvl('#G#', GOAL_GROUP);
      :#P#EDITABLE := case when :#P#DATE_OK = 'S' and :#P#STATUS not in ('Validada', 'Revisada')
                                and :#P#GOAL_TYPE <> 'ACTION_PLAN' then 'S' else 'N' end;
    exception when no_data_found then :#P#GOAL_ID := null;
    end;
  end if;
end;~';
  l_save := q'~
declare
  mc     SPD_MONITORING_CONFIG%rowtype;
  l_rec  number := :#P#REC_ID;
  l_status varchar2(30);
  l_type varchar2(30);
  v1 number; v2 number; v3 number; v4 number; v5 number;
  h1 varchar2(1); h2 varchar2(1); h3 varchar2(1); h4 varchar2(1); h5 varchar2(1);
  type t_res is table of varchar2(30);
  f  t_res := t_res('RP', 'SGP', 'SGP_EDUCATION', 'SGP_HEALTH', 'SGP_WATER', 'SGP_CULTURE', 'SGP_SPORT', 'SGP_FREE_INVESTMENT',
                    'SGP_FREE_DESTINATION', 'SGP_SCHOOL_FEEDING', 'SGP_MAGDALENA_RIVER', 'SGP_EARLY_CHILDHOOD',
                    'CN', 'CD', 'SGR', 'CREDIT', 'OTHERS', 'MANAGEMENT', 'OPERATION');
  function num(v varchar2) return number is
  begin
    if trim(v) is null then return null; end if;
    return to_number(replace(replace(trim(v), '.', ''), ',', '.'), '999999999999999999999D999999', 'NLS_NUMERIC_CHARACTERS=''.,''');
  exception when others then
    raise_application_error(-20001, 'Valor numérico no válido: ' || v);
  end;
  function arr(p apex_application_global.vc_arr2, i pls_integer) return number is
  begin
    return case when p.exists(i) then nvl(num(p(i)), 0) else 0 end;
  end;
  procedure save_res(p_type varchar2, p apex_application_global.vc_arr2) is
    v  apex_t_number := apex_t_number();
    l_sgp number;
  begin
    if p.count = 0 then return; end if;   -- columna no visible o deshabilitada
    v.extend(f.count);
    for i in 1 .. f.count loop v(i) := arr(p, i); end loop;
    l_sgp := case when mc.SGP_DISCRIMINATED = 'S' then v(3) + v(4) + v(5) + v(6) + v(7) + v(8) + v(9) + v(10) + v(11) + v(12) else v(2) end;
    merge into SPD_MONITORING_RECORD_RESOURCE t
    using (select l_rec as MONITORING_RECORD_ID, p_type as RESOURCE_TYPE from dual) s
       on (t.MONITORING_RECORD_ID = s.MONITORING_RECORD_ID and t.RESOURCE_TYPE = s.RESOURCE_TYPE)
     when matched then update set RP = v(1), SGP = l_sgp, SGP_EDUCATION = v(3), SGP_HEALTH = v(4), SGP_WATER = v(5),
          SGP_CULTURE = v(6), SGP_SPORT = v(7), SGP_FREE_INVESTMENT = v(8), SGP_FREE_DESTINATION = v(9),
          SGP_SCHOOL_FEEDING = v(10), SGP_MAGDALENA_RIVER = v(11), SGP_EARLY_CHILDHOOD = v(12), CN = v(13), CD = v(14),
          SGR = v(15), CREDIT = v(16), OTHERS = v(17), MANAGEMENT = v(18), OPERATION = v(19),
          UPDATED_AT = systimestamp, UPDATED_BY = :#P#USER_ID
     when not matched then insert (MONITORING_RECORD_ID, RESOURCE_TYPE, RP, SGP, SGP_EDUCATION, SGP_HEALTH, SGP_WATER,
          SGP_CULTURE, SGP_SPORT, SGP_FREE_INVESTMENT, SGP_FREE_DESTINATION, SGP_SCHOOL_FEEDING, SGP_MAGDALENA_RIVER,
          SGP_EARLY_CHILDHOOD, CN, CD, SGR, CREDIT, OTHERS, MANAGEMENT, OPERATION, CREATED_BY)
          values (l_rec, p_type, v(1), l_sgp, v(3), v(4), v(5), v(6), v(7), v(8), v(9), v(10), v(11), v(12), v(13), v(14),
                  v(15), v(16), v(17), v(18), v(19), :#P#USER_ID);
  end;
begin
  select * into mc from SPD_MONITORING_CONFIG where ID = :#P#MC and NIT_COMPANIA = :G_NIT_COMPANIA;
  -- se vuelve a validar en el servidor (fechas y estado)
  select max(SCHEDULE_STATUS), max(GOAL_TYPE), max(MONITORING_RECORD_ID) into l_status, l_type, l_rec
    from V_SPD_GOAL_MONITORING where MONITORING_CONFIG_ID = mc.ID and GOAL_ID = :#P#GOAL_ID and GOAL_GROUP = nvl('#G#', GOAL_GROUP);
  if :#P#DATE_OK <> 'S' then
    raise_application_error(-20001, 'El seguimiento no está en fechas de programación.');
  elsif l_status in ('Validada', 'Revisada') or l_type = 'ACTION_PLAN' then
    raise_application_error(-20001, 'La meta está ' || lower(l_status) || ': no se puede modificar su programación.');
  end if;

  -- valores del formulario (un campo deshabilitado no llega: se conserva el valor guardado)
  if apex_application.g_f01.exists(1) then h1 := 'S'; v1 := num(apex_application.g_f01(1)); end if;
  if apex_application.g_f02.exists(1) then h2 := 'S'; v2 := num(apex_application.g_f02(1)); end if;
  if apex_application.g_f03.exists(1) then h3 := 'S'; v3 := num(apex_application.g_f03(1)); end if;
  if apex_application.g_f04.exists(1) then h4 := 'S'; v4 := num(apex_application.g_f04(1)); end if;
  if apex_application.g_f05.exists(1) then h5 := 'S'; v5 := num(apex_application.g_f05(1)); end if;

  if l_rec is null then
    insert into SPD_MONITORING_RECORD (MONITORING_CONFIG_ID, GOAL_ID, PERIOD, GOAL_VALUE, PI_GOAL_VALUE, WEIGHTING,
           FROM_MONTH, TO_MONTH, RECORD_STATUS, CREATED_BY, UPDATED_BY)
    values (mc.ID, :#P#GOAL_ID, mc.PERIOD,
            v1,
            v2,
            v3,
            v4,
            v5,
            'PLANNED', :#P#USER_ID, :#P#USER_ID)
    returning ID into l_rec;
  else
    update SPD_MONITORING_RECORD
       set GOAL_VALUE    = case when h1 = 'S' then v1 else GOAL_VALUE end,
           PI_GOAL_VALUE = case when h2 = 'S' then v2 else PI_GOAL_VALUE end,
           WEIGHTING     = case when h3 = 'S' then v3 else WEIGHTING end,
           FROM_MONTH    = case when h4 = 'S' then v4 else FROM_MONTH end,
           TO_MONTH      = case when h5 = 'S' then v5 else TO_MONTH end,
           RECORD_STATUS = 'PLANNED', UPDATED_AT = systimestamp, UPDATED_BY = :#P#USER_ID
     where ID = l_rec;
  end if;

  -- recursos: solo si el seguimiento admite recursos del usuario (supportUserResources)
  if mc.MONITORING_RESOURCES_ORIGIN in ('USER', 'USER_AND_FINANCIAL') then
    save_res('MANUAL', apex_application.g_f06);
    save_res('DEFINITIVE', apex_application.g_f07);   -- solo llega si la entidad tiene presupuesto manual
  end if;

  insert into SPD_GOAL_HISTORY (GOAL_ID, MONITORING_RECORD_ID, EVENT, DESCRIPTION, CREATED_BY)
  values (:#P#GOAL_ID, l_rec, 'SCHEDULED', 'Programación actualizada por el usuario', :#P#USER_ID);
end;~';
  l_datos := q'~
declare
  l      clob;
  dis    varchar2(20) := case when :#P#EDITABLE = 'S' then null else ' disabled' end;
  lvl_lbl varchar2(200);
  type t_res is table of varchar2(30);
  f  t_res := t_res('RP', 'SGP', 'SGP_EDUCATION', 'SGP_HEALTH', 'SGP_WATER', 'SGP_CULTURE', 'SGP_SPORT', 'SGP_FREE_INVESTMENT',
                    'SGP_FREE_DESTINATION', 'SGP_SCHOOL_FEEDING', 'SGP_MAGDALENA_RIVER', 'SGP_EARLY_CHILDHOOD',
                    'CN', 'CD', 'SGR', 'CREDIT', 'OTHERS', 'MANAGEMENT', 'OPERATION');
  lb t_res := t_res('Recursos Propios', 'Recursos SGP', 'Educación', 'Salud', 'Agua Potable', 'Cultura', 'Deporte', 'Libre Inversión',
                    'Libre Destinación', 'Alimentación Escolar', 'Río Magdalena', 'Primera Infancia',
                    'Recursos CN', 'Recursos CD', 'Recursos SGR', 'Recursos Crédito', 'Otros Recursos', 'Recursos Gestión',
                    'Recursos Funcionamiento');
  ru  SPD_MONITORING_RECORD_RESOURCE%rowtype;
  rf  SPD_MONITORING_RECORD_RESOURCE%rowtype;
  rec SPD_MONITORING_RECORD%rowtype;
  show_u boolean := :#P#ORIGIN in ('USER', 'USER_AND_FINANCIAL');
  show_f boolean := :#P#ORIGIN in ('FINANCIAL', 'USER_AND_FINANCIAL');
  sgp_disc boolean := :#P#SGP_DISC = 'S';
  procedure add(p varchar2) is begin l := l || p; end;

  function h(v varchar2) return varchar2 is begin return apex_escape.html(v); end;
  function fmt(n number) return varchar2 is
  begin
    return case when n is not null then rtrim(to_char(n, 'FM999G999G999G999G990D99999', 'NLS_NUMERIC_CHARACTERS='',.'''), ',') end;
  end;
  function lov(p_lov varchar2, p_value varchar2) return varchar2 is
    d varchar2(400);
  begin
    select max(DISPLAY_VALUE) into d from APEX_APPLICATION_LOV_ENTRIES
     where APPLICATION_ID = :APP_ID and LIST_OF_VALUES_NAME = p_lov and RETURN_VALUE = p_value;
    return coalesce(d, p_value);
  end;
  function val(r SPD_MONITORING_RECORD_RESOURCE%rowtype, c varchar2) return number is
  begin
    return case c when 'RP' then r.RP when 'SGP' then r.SGP when 'SGP_EDUCATION' then r.SGP_EDUCATION
      when 'SGP_HEALTH' then r.SGP_HEALTH when 'SGP_WATER' then r.SGP_WATER when 'SGP_CULTURE' then r.SGP_CULTURE
      when 'SGP_SPORT' then r.SGP_SPORT when 'SGP_FREE_INVESTMENT' then r.SGP_FREE_INVESTMENT
      when 'SGP_FREE_DESTINATION' then r.SGP_FREE_DESTINATION when 'SGP_SCHOOL_FEEDING' then r.SGP_SCHOOL_FEEDING
      when 'SGP_MAGDALENA_RIVER' then r.SGP_MAGDALENA_RIVER when 'SGP_EARLY_CHILDHOOD' then r.SGP_EARLY_CHILDHOOD
      when 'CN' then r.CN when 'CD' then r.CD when 'SGR' then r.SGR when 'CREDIT' then r.CREDIT when 'OTHERS' then r.OTHERS
      when 'MANAGEMENT' then r.MANAGEMENT when 'OPERATION' then r.OPERATION end;
  end;
  function money(p_idx number, p_col varchar2, p_field varchar2, p_value number, p_disabled varchar2) return varchar2 is
  begin
    return '<td><input type="text" name="f' || lpad(p_idx, 2, '0') || '" id="' || p_col || '_' || p_field || '" class="spd-money '
      || p_col || '-res" value="' || fmt(p_value) || '" placeholder="$"' || p_disabled || '></td>';
  end;
  function months(p_idx number, p_id varchar2, p_value number) return varchar2 is
    s varchar2(4000) := '<select name="f' || lpad(p_idx, 2, '0') || '" id="' || p_id || '" class="spd-sel"' || dis || '><option value=""></option>';
  begin
    for m in 1 .. 12 loop
      s := s || '<option value="' || m || '"' || case when m = p_value then ' selected' end || '>'
        || initcap(to_char(to_date(m, 'MM'), 'FMMonth', 'NLS_DATE_LANGUAGE=SPANISH')) || '</option>';
    end loop;
    return s || '</select>';
  end;
begin
  if :#P#REC_ID is not null then
    select * into rec from SPD_MONITORING_RECORD where ID = :#P#REC_ID;
    for x in (select * from SPD_MONITORING_RECORD_RESOURCE where MONITORING_RECORD_ID = rec.ID) loop
      if x.RESOURCE_TYPE = 'MANUAL' then ru := x; elsif x.RESOURCE_TYPE = 'DEFINITIVE' then rf := x; end if;
    end loop;
  end if;

  -- resumen de la meta (GoalSummary) y actividades (GoalActivities)
  for g in (select g.*, e.CODIGO_ENT_PRY, e.NOMBRE_ENT_PRY, dl.CODE as L_CODE, dl.NAME as L_NAME,
                   (select c.SINGULAR_NAME from V_SPD_PLAN_LEVEL_CONFIG c
                     where c.NIT_COMPANIA = g.NIT_COMPANIA and c.PLAN = g.PLAN and c.NUM = dl."LEVEL") as LEVEL_LABEL
              from SPD_GOAL g
              left join ENTIDADES_PRY e on e.ID = g.ENTITY_ID
              left join SPD_DEV_PLAN_LEVEL dl on dl.ID = g.DEV_PLAN_LEVEL_ID
             where g.ID = :#P#GOAL_ID) loop
    add('<details class="spd-collapse"><summary><b>' || h(g.CODE) || case when g.GOAL_TYPE not in ('PROJECT', 'ACTION_PLAN') then ':</b> ' || h(g.NAME) else '</b>' end
      || '</summary><div><table class="spd-desc">'
      || '<tr><th>ID</th><td>' || g.ID || '</td><th>Código</th><td>' || h(g.CODE) || '</td></tr>'
      || '<tr><th>Meta</th><td colspan="3">' || h(g.NAME) || '</td></tr>'
      || '<tr><th>Entidad</th><td colspan="3">' || h(g.CODIGO_ENT_PRY || ' - ' || g.NOMBRE_ENT_PRY) || '</td></tr>'
      || '<tr><th>Tipo de meta</th><td>' || h(lov('SPD - TIPO DE META', g.GOAL_TYPE)) || '</td><th>'
      || h(coalesce(g.LEVEL_LABEL, 'Nivel del plan')) || '</th><td>' || h(g.L_CODE || ' - ' || g.L_NAME) || '</td></tr>'
      || case when g.GOAL_TYPE in ('PRODUCT', 'RESULT', 'IMPACT', 'WELL_BEING') then
           case when g.INDICATOR is not null then '<tr><th>Indicador</th><td colspan="3">' || h(g.INDICATOR) || '</td></tr>' end
           || '<tr><th>Unidades</th><td>' || h(g.UNITS_NAME) || '</td><th>Tipo de acumulación</th><td>'
           || h(lov('SPD - TIPO DE ACUMULACION', g.ACCUMULATION_TYPE)) || '</td></tr>'
           || '<tr><th>Valor base</th><td>' || fmt(g.BASE_VALUE) || '</td><th>Valor meta</th><td>' || fmt(g.GOAL_VALUE) || '</td></tr>' end
      || case when g.PROJECT_CODE is not null then '<tr><th>Proyecto</th><td colspan="3">' || h(g.PROJECT_CODE) || '</td></tr>' end
      || '</table></div></details>');
  end loop;
  if :#P#GOAL_TYPE in ('PRODUCT', 'RESULT', 'IMPACT', 'WELL_BEING') then
  add('<details class="spd-collapse"><summary><b>Actividades</b></summary><div>');
  declare
    n pls_integer := 0;
    a clob := '<table class="spd-tbl"><tr><th>Proyecto</th><th>Actividad</th><th style="text-align:right">Ponderación</th></tr>';
  begin
    for x in (select PROYECTO, CODIGO_ACT, WEIGHTING from SPD_ACTIVITY_GOAL where GOAL_ID = :#P#GOAL_ID order by PROYECTO, CODIGO_ACT) loop
      n := n + 1;
      a := a || to_char('<tr><td>' || x.PROYECTO || '</td><td>' || x.CODIGO_ACT || '</td><td style="text-align:right">' || fmt(x.WEIGHTING) || '</td></tr>');
    end loop;
    if n = 0 then
      add('<div class="spd-empty"><span class="fa fa-inbox"></span>No hay datos</div>');
    else
      l := l || a;
      add('</table>');
    end if;
    add('</div></details>');
  end;
  end if;

  -- programación (GoalScheduleCol + GoalScheduleResourcesCol)
  add('<input type="hidden" id="spd_sgp_disc" value="' || :#P#SGP_DISC || '"><table class="spd-form">');
  if :#P#GOAL_TYPE not in ('PROJECT', 'ACTION_PLAN') then
    add('<tr><th>Programación Meta</th><td colspan="2"><input type="text" name="f01" class="spd-num" value="'
      || fmt(rec.GOAL_VALUE) || '"' || dis || '></td></tr>');
  end if;
  if :#P#SUPPORT_PI = 'S' then
    add('<tr><th>Programación Indicador Producto</th><td colspan="2"><input type="text" name="f02" class="spd-num" value="'
      || fmt(rec.PI_GOAL_VALUE) || '"' || dis || '></td></tr>');
  end if;
  add('<tr><th>Ponderación</th><td colspan="2"><input type="text" name="f03" class="spd-num spd-num--sm" value="'
    || fmt(rec.WEIGHTING) || '"' || case when :#P#WEIGHT_TYPE = 'FINANCIAL' then ' disabled' else dis end || '></td></tr>'
    || '<tr><th>Mes inicial</th><td colspan="2">' || months(4, 'spd_from', rec.FROM_MONTH) || '</td></tr>'
    || '<tr><th>Mes final</th><td colspan="2">' || months(5, 'spd_to', rec.TO_MONTH) || '</td></tr>'
    || '<tr><th>Origen Datos Financieros</th>'
    || case when show_u then '<td class="spd-colhead">Programación</td>' end
    || case when show_f then '<td class="spd-colhead">Apropiado</td>' end || '</tr>');
  for i in 1 .. f.count loop
    add('<tr' || case when f(i) like 'SGP\_%' escape '\' then ' class="spd-sgp-sub" style="display:none"' end || '><th'
      || case when f(i) = 'SGP' and sgp_disc then ' class="spd-noc"' end || '>'
      || case when f(i) = 'SGP' and sgp_disc then '<span class="fa fa-chevron-down spd-sgp-toggle"></span><b>' || lb(i) || '</b>'
              else lb(i) end || '</th>'
      || case when show_u then money(6, 'u', f(i), val(ru, f(i)),
                                     case when f(i) = 'SGP' and sgp_disc then ' readonly' else dis end) end
      || case when show_f then money(7, 'f', f(i), val(rf, f(i)),
                                     case when :#P#MANUAL_BUDGET = 'S' and dis is null
                                          then case when f(i) = 'SGP' and sgp_disc then ' readonly' end else ' disabled' end) end
      || '</tr>');
  end loop;
  add('<tr class="spd-total"><th class="spd-noc">Total Recursos:</th>'
    || case when show_u then '<td><input type="text" id="u_TOTAL" class="spd-money" placeholder="$" disabled></td>' end
    || case when show_f then '<td><input type="text" id="f_TOTAL" class="spd-money" placeholder="$" disabled></td>' end
    || '</tr></table>');
  return l;
end;~';
  l_hist := q'~
declare
  l clob := '<ul class="spd-hist">';
  rw varchar2(32767);
  n pls_integer := 0;
begin
  for x in (select h.EVENT, h.DESCRIPTION, h.CREATED_AT, u.DESCRIPCION as USER_NAME
              from SPD_GOAL_HISTORY h
              left join SPD_MONITORING_RECORD r on r.ID = h.MONITORING_RECORD_ID
              left join USUARIOS u on u.ID = h.CREATED_BY and u.NIT_COMPANIA = :G_NIT_COMPANIA
             where h.GOAL_ID = :#P#GOAL_ID and (r.ID is null or r.MONITORING_CONFIG_ID = :#P#MC)
             order by h.CREATED_AT, h.ID) loop
    n := n + 1;
    rw := '<li><span class="spd-avatar" title="' || apex_escape.html_attribute(coalesce(x.USER_NAME, 'SPD')) || '">'
      || apex_escape.html(case when x.USER_NAME is null then 'S'
                               else upper(substr(x.USER_NAME, 1, 1) || substr(regexp_substr(x.USER_NAME, '\S+', 1, 2), 1, 1)) end)
      || '</span><div><div class="spd-hist-title">'
      || case x.EVENT when 'CREATED' then 'Creada' when 'MONITORED' then 'Reportada' when 'REJECTED' then 'Rechazada'
              when 'REVIEWED' then 'Aprobada' when 'SCHEDULED' then 'Programada' when 'UPDATED' then 'Actualizada'
              when 'VALIDATED' then 'Validada' end
      || ' - ' || to_char(x.CREATED_AT at time zone 'America/Bogota', 'YYYY-MM-DD HH24:MI:SS')
      || '</div><div class="spd-hist-desc">' || apex_escape.html(x.DESCRIPTION) || '</div></div></li>';
    l := l || rw;
  end loop;
  if n = 0 then
    return '<div class="spd-empty"><span class="fa fa-inbox"></span>No hay datos</div>';
  end if;
  return l || '</ul>';
end;~';
  process('Cargar seguimiento', 'BEFORE_HEADER', l_load);
  process('Cambiar seguimiento', 'AFTER_SUBMIT', ':#P#NODE := ''0'';', 'REQUEST_EQUALS_CONDITION', r('#P#MC'));
  wwv_flow_imp_page.create_page_branch(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
    p_branch_name => 'Volver a la página', p_branch_point => 'AFTER_PROCESSING', p_branch_type => 'REDIRECT_URL',
    p_branch_action => 'f?p=&APP_ID.:' || g_page || ':&APP_SESSION.::&DEBUG.:::', p_branch_sequence => 10);
  end loop;

  -- ==========================================================================
  -- 1063 · Programación (diálogo)
  -- ==========================================================================
  g_page := c_dlg;
  g_group := null;
  l_seq := 0;
  wwv_flow_imp_page.remove_page(p_flow_id => c_app, p_page_id => g_page);
  wwv_flow_imp_page.create_page(p_id => g_page, p_flow_id => c_app, p_name => 'SPD_Programación de la meta',
    p_alias => 'SPD_PROGRAMAR_META', p_page_mode => 'MODAL', p_step_title => 'Programación',
    p_step_template => l_tpl_dlg, p_page_template_options => '#DEFAULT#', p_dialog_width => '960',
    p_dialog_chained => 'Y', p_autocomplete_on_off => 'OFF', p_protection_level => 'C',
    p_inline_css => l_css, p_javascript_code => l_jsform, p_javascript_code_onload => 'spdTotals();');
  l_seg := region('Estado', 1, l_tpl_blank);
  for h in (select column_value n from table(sys.odcivarchar2list(
              'MC', 'GOAL_ID', 'NODE', 'NODE_NAME', 'TOTAL', 'PLAN', 'ORIGIN', 'WEIGHT_TYPE', 'SGP_DISC', 'SUPPORT_PI',
              'DATE_OK', 'MANUAL_BUDGET', 'EDITABLE', 'REC_ID', 'STATUS', 'GOAL_TYPE', 'USER_ID'))) loop
    item(l_seg, '#P#' || h.n, h.n);
  end loop;
  l_ptabs := region('Programación', 10, l_tpl_tabs, p_options => '#DEFAULT#:t-TabsRegion-mod--simple');
  l_dummy := region('Datos Programación', 10, l_tpl_blank, 'NATIVE_DYNAMIC_CONTENT', p_parent => l_ptabs, p_source => r(l_datos));
  l_dummy := region('Historial', 20, l_tpl_blank, 'NATIVE_DYNAMIC_CONTENT', p_parent => l_ptabs, p_source => r(l_hist));

  -- pie del diálogo: Volver (cierra sin guardar) / Guardar (solo si se puede programar)
  l_panel := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_page_plug(p_id => l_panel, p_flow_id => c_app, p_page_id => g_page, p_plug_name => 'Botones',
    p_region_template_options => '#DEFAULT#', p_plug_template => l_tpl_btns, p_plug_display_sequence => 20,
    p_plug_display_point => 'REGION_POSITION_03', p_plug_source_type => 'NATIVE_STATIC');
  l_btn := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_page_button(p_id => l_btn, p_flow_id => c_app, p_flow_step_id => g_page,
    p_button_sequence => 10, p_button_plug_id => l_panel, p_button_name => 'VOLVER', p_button_action => 'DEFINED_BY_DA',
    p_button_template_options => '#DEFAULT#', p_button_template_id => l_tpl_btn, p_button_image_alt => 'Volver',
    p_button_position => 'CLOSE', p_warn_on_unsaved_changes => null);
  wwv_flow_imp_page.create_page_button(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
    p_button_sequence => 20, p_button_plug_id => l_panel, p_button_name => 'SAVE', p_button_action => 'SUBMIT',
    p_button_template_options => '#DEFAULT#', p_button_template_id => l_tpl_btn, p_button_is_hot => 'Y',
    p_button_image_alt => 'Guardar', p_button_position => 'NEXT',
    p_button_condition_type => 'VAL_OF_ITEM_IN_COND_EQ_COND2', p_button_condition => r('#P#EDITABLE'), p_button_condition2 => 'S');
  l_evt := wwv_flow_id.next_val;
  wwv_flow_imp_page.create_page_da_event(p_id => l_evt, p_flow_id => c_app, p_page_id => g_page,
    p_name => 'Volver', p_event_sequence => 10, p_triggering_element_type => 'BUTTON',
    p_triggering_button_id => l_btn, p_bind_type => 'bind', p_execution_type => 'IMMEDIATE', p_bind_event_type => 'click');
  wwv_flow_imp_page.create_page_da_action(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_page_id => g_page,
    p_event_id => l_evt, p_event_result => 'TRUE', p_action_sequence => 10, p_execute_on_page_init => 'N',
    p_action => 'NATIVE_DIALOG_CANCEL');

  process('Cargar programación', 'BEFORE_HEADER', l_load);
  process('Guardar programación', 'AFTER_SUBMIT', l_save, 'REQUEST_EQUALS_CONDITION', 'SAVE', 'Programación guardada');
  l_seq := l_seq + 10;
  wwv_flow_imp_page.create_page_process(p_id => wwv_flow_id.next_val, p_flow_id => c_app, p_flow_step_id => g_page,
    p_process_sequence => l_seq, p_process_point => 'AFTER_SUBMIT', p_process_type => 'NATIVE_CLOSE_WINDOW',
    p_process_name => 'Cerrar diálogo', p_process_when_type => 'REQUEST_EQUALS_CONDITION', p_process_when => 'SAVE',
    p_process_success_message => 'Programación guardada');

  wwv_flow_imp.import_end(p_auto_install_sup_obj => false);
  commit;
  dbms_output.put_line('PROGRAMACION OK (páginas 1030, 1035, 1040 y ' || c_dlg || ')');
end;
/
exit
