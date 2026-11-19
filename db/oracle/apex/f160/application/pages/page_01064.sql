prompt --application/pages/page_01064
begin
--   Manifest
--     PAGE: 01064
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
 p_id=>1064
,p_name=>unistr('SPD_Ejecuci\00F3n de la meta')
,p_alias=>'SPD_EJECUCION_META'
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Ejecuci\00F3n meta')
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'function spdNum(v) { v = (v || "").replace(/\./g, "").replace(",", "."); var n = parseFloat(v); return isNaN(n) ? 0 : n; }',
'function spdFmt(n) { return n.toLocaleString("es-CO", {maximumFractionDigits: 2}); }',
'// totales por columna (y SGP = suma de las fuentes SGP cuando el seguimiento las discrimina)',
'function spdTotals() {',
'  var cols = {};',
'  $("[data-col]").each(function () { cols[$(this).data("col")] = 1; });',
'  Object.keys(cols).forEach(function (c) {',
'    if ($("#spd_sgp_disc").val() === "S") {',
'      var s = 0; $(".spd-sgp-sub [data-col=''" + c + "'']").each(function () { s += spdNum(this.value); });',
'      $("#" + c + "_SGP").val(spdFmt(s));',
'    }',
'    var t = 0; $("tr:not(.spd-sgp-sub) [data-col=''" + c + "'']").each(function () { t += spdNum(this.value); });',
'    $("#" + c + "_TOTAL").val(spdFmt(t));',
'  });',
'}',
'$(document).on("change keyup", "[data-col]", spdTotals);',
'$(document).on("click", ".spd-sgp-toggle", function () { $(".spd-sgp-sub").toggle(); $(this).toggleClass("fa-chevron-down fa-chevron-up"); });',
'',
'// evidencias: eliminar',
unistr('function spdDelAtt(id) { apex.message.confirm("Est\00E1 seguro(a) que desea eliminar este archivo?", function (ok) { if (ok) apex.submit({request: "DELETE_ATT", set: {"P1064_ATT_ID": id}}); }); }')))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'spdTotals();',
unistr('// al cerrar el formulario de focalizaci\00F3n se refrescan las grillas'),
'$(document).on("apexafterclosedialog", function (e, data) { ["spd_tm_ed", "spd_tm_org", "spd_tm_re"].forEach(function (id) { if ($("#" + id).length) apex.region(id).refresh(); });',
'  if (data && data.successMessage && data.successMessage.text) apex.message.showPageSuccess(data.successMessage.text); });'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'.spd-badge{display:inline-block;min-width:20px;padding:0 6px;margin-left:6px;border-radius:10px;font-size:11px;line-height:18px;color:#fff;text-align:center;background:#1677ff;vertical-align:middle}',
'.spd-st{display:inline-flex;align-items:center;justify-content:center;width:30px;height:30px;border-radius:50%;font-size:15px;border:1px solid transparent}',
'.spd-st--NEW{color:#0f1129;border-color:#0f1129}',
'.spd-st--SCH{color:#008000;border-color:#008000;background:rgba(0,128,0,.15)}',
'.spd-st--PAR{color:#f99c07;border-color:#f99c07;background:rgba(249,156,7,.15)}',
'.spd-st--REP{color:#008000;background:rgba(0,128,0,.15)}',
'.spd-st--NOREP{color:#1d2f4e;background:rgba(29,47,78,.12)}',
'.spd-st--VAL{color:#008000;border-color:#008000}',
'.spd-st--NOVAL{color:#1d2f4e;background:rgba(29,47,78,.08)}',
'.spd-st--REV{color:#008000;border-color:#008000;background:rgba(0,128,0,.4)}',
'.spd-st--NOREV{color:#ff0000;border-color:#008000}',
'.spd-st--REJ{color:#ef440b;background:rgba(239,68,11,.15)}',
'.spd-act{font-size:16px;color:#1677ff}',
'.spd-collapse{border:1px solid #d9d9d9;border-radius:8px;margin-bottom:10px;background:#fff}',
'.spd-collapse>summary{padding:12px 16px;cursor:pointer;background:#fafafa;border-radius:8px;list-style:none}',
'.spd-collapse>summary::before{content:"\203A";display:inline-block;width:16px;font-weight:bold;transition:transform .2s}',
'.spd-collapse[open]>summary::before{transform:rotate(90deg)}',
'.spd-collapse[open]>summary{border-bottom:1px solid #d9d9d9;border-radius:8px 8px 0 0}',
'.spd-collapse>div{padding:16px}',
'.spd-desc{width:100%;border-collapse:collapse;border:1px solid #f0f0f0}',
'.spd-desc th,.spd-desc td{border:1px solid #f0f0f0;padding:8px 16px;text-align:left;vertical-align:top;font-weight:normal}',
'.spd-desc th{background:#fafafa;color:rgba(0,0,0,.65);width:22%}',
'.spd-tbl{width:100%;border-collapse:collapse}',
'.spd-tbl th{background:#fafafa;padding:8px;text-align:left;border-bottom:1px solid #f0f0f0}',
'.spd-tbl td{padding:8px;border-bottom:1px solid #f0f0f0;vertical-align:top}',
'.spd-empty{padding:24px;text-align:center;color:rgba(0,0,0,.35)}',
'.spd-empty .fa{font-size:32px;display:block;margin-bottom:6px}',
'.spd-form{border-collapse:separate;border-spacing:0 8px;width:100%}',
'.spd-form th{text-align:left;font-weight:normal;padding-right:16px;white-space:nowrap;width:1%}',
'.spd-form th:after{content:":"}',
'.spd-form th.spd-noc:after{content:""}',
'.spd-form td{padding-right:10px}',
'.spd-form input,.spd-form select,.spd-ta,.spd-tm input,.spd-tm select{height:32px;border:1px solid #d9d9d9;border-radius:6px;padding:0 8px}',
'.spd-form input[disabled],.spd-form input[readonly],.spd-ta[disabled],.spd-tm [disabled]{background:#f5f5f5;color:rgba(0,0,0,.45)}',
'.spd-num{width:170px;text-align:right}',
'.spd-money{width:100%;min-width:100px;max-width:200px;text-align:right}',
'.spd-colhead{text-align:center;font-weight:bold;font-size:14px}',
'.spd-total th{font-weight:bold;font-size:15px}',
'.spd-sgp-sub th{padding-left:28px}',
'.spd-sgp-toggle{cursor:pointer;margin-right:6px}',
'.spd-ta{width:100%;height:auto;padding:6px 8px;font-family:inherit}',
'.spd-q{margin-bottom:14px}.spd-q label{display:block;margin-bottom:4px}',
'.spd-hist{list-style:none;margin:0;padding:0}',
'.spd-hist li{display:flex;gap:16px;padding:12px 0;border-bottom:1px solid #f0f0f0}',
'.spd-avatar{flex:none;width:32px;height:32px;border-radius:50%;background:#87d068;color:#fff;display:flex;align-items:center;justify-content:center}',
'.spd-hist-title{font-weight:500}.spd-hist-desc{color:rgba(0,0,0,.45)}',
'.spd-bars{display:grid;grid-template-columns:max-content 1fr 60px;gap:8px 12px;align-items:center}',
'.spd-bar{height:8px;background:#f0f0f0;border-radius:4px;overflow:hidden}.spd-bar>i{display:block;height:100%}',
'.spd-gauge{--p:0;--c:#1677ff;width:84px;height:84px;border-radius:50%;background:conic-gradient(var(--c) calc(var(--p)*1%),#f0f0f0 0);display:inline-flex;align-items:center;justify-content:center;position:relative}',
'.spd-gauge::before{content:"";position:absolute;inset:9px;background:#fff;border-radius:50%}',
'.spd-gauge span{position:relative;font-size:13px;font-weight:500}',
'.spd-gauge--sm{width:56px;height:56px}.spd-gauge--sm::before{inset:6px}.spd-gauge--sm span{font-size:11px}',
'.spd-gauges{display:flex;gap:40px;flex-wrap:wrap;text-align:center}.spd-gauges>div>div{margin-top:6px}',
'.spd-gauge--lg{width:116px;height:116px}.spd-gauge--lg::before{inset:12px}.spd-gauge--lg span{font-size:20px;font-weight:600}',
'.spd-ind{display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:16px;padding:12px 0}',
'.spd-ind-card{background:#fff;border:1px solid #f0f0f0;border-radius:10px;padding:16px 18px;display:flex;flex-direction:column;align-items:center;gap:10px;box-shadow:0 1px 3px rgba(0,0,0,.05)}',
'.spd-ind-kicker{font-size:11px;letter-spacing:.06em;text-transform:uppercase;color:rgba(0,0,0,.45)}',
'.spd-ind-title{font-size:15px;font-weight:600;text-align:center;margin-top:-6px}',
'.spd-ind-chip{display:inline-flex;align-items:center;gap:6px;font-size:12px;padding:2px 10px;border-radius:12px;background:#fafafa;border:1px solid #f0f0f0;color:rgba(0,0,0,.75)}',
'.spd-ind-chip i{width:8px;height:8px;border-radius:50%;background:var(--c)}',
'.spd-ind-figs{align-self:stretch;border-top:1px solid #f0f0f0;padding-top:10px;display:grid;grid-template-columns:1fr auto;gap:4px 12px;font-size:12px;color:rgba(0,0,0,.55)}',
'.spd-ind-figs b{font-weight:500;color:rgba(0,0,0,.88);text-align:right;font-variant-numeric:tabular-nums}',
'.spd-tm-card{border:1px solid #d9d9d9;border-radius:8px;margin-bottom:12px}',
'.spd-tm-card>header{display:flex;gap:12px;align-items:center;padding:8px 12px;background:#fafafa;border-radius:8px 8px 0 0}',
'.spd-tm-card>header select{flex:1}',
'.spd-tm-body{padding:12px;display:flex;flex-wrap:wrap;gap:16px}',
'.spd-tm-group{border:1px solid #f0f0f0;border-radius:6px;padding:8px 12px}',
'.spd-tm-group>b{display:block;margin-bottom:6px}',
'.spd-tm-group label{display:inline-flex;flex-direction:column;margin:0 10px 6px 0;font-size:12px}',
'.spd-tm-group input{width:90px;text-align:right}.spd-tm-group input.spd-tm-text{width:220px;text-align:left}',
'.spd-alert{padding:10px 14px;border:1px solid #91caff;background:#e6f4ff;border-radius:6px;margin-bottom:12px}',
'.spd-row-sel td{background:#e6f4ff !important}'))
,p_step_template=>wwv_flow_imp.id(39430577226162891)
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'1100'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3680049190607292)
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
 p_id=>wwv_flow_imp.id(3682063623607293)
,p_plug_name=>'Resumen'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>5
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l clob;',
'  procedure add(p varchar2) is begin l := l || p; end;',
'  function h(v varchar2) return varchar2 is begin return apex_escape.html(v); end;',
'  function fmt(n number) return varchar2 is',
'  begin',
'    return case when n is not null then rtrim(to_char(n, ''FM999G999G999G999G990D99999'', ''NLS_NUMERIC_CHARACTERS='''',.''''''), '','') end;',
'  end;',
'  function lov(p_lov varchar2, p_value varchar2) return varchar2 is',
'    d varchar2(400);',
'  begin',
'    select max(DISPLAY_VALUE) into d from APEX_APPLICATION_LOV_ENTRIES',
'     where APPLICATION_ID = :APP_ID and LIST_OF_VALUES_NAME = p_lov and RETURN_VALUE = p_value;',
'    return coalesce(d, p_value);',
'  end;',
'  function color(p number) return varchar2 is',
'    c varchar2(30);',
'  begin',
'    select coalesce(',
'             (select c.COLOR from V_SPD_MONITORING_COLORS c where c.ID = :P1064_MC',
'                 and p >= c.FROM_VALUE * :P1064_SUBPERIOD / 4 and p <= c.TO_VALUE * :P1064_SUBPERIOD / 4 order by c.POS fetch first 1 row only),',
'             (select max(c.COLOR) keep (dense_rank last order by c.POS) from V_SPD_MONITORING_COLORS c where c.ID = :P1064_MC), ''#1677ff'')',
'      into c from dual;',
'    return c;',
'  end;',
'  procedure bar(p_label varchar2, p_value number) is',
'    p number := round(nvl(p_value, 0) * 100, 2);',
'  begin',
'    add(''<span>'' || p_label || ''</span><div class="spd-bar"><i style="width:'' || to_char(least(p, 100), ''FM990D00'', ''NLS_NUMERIC_CHARACTERS=''''.,'''''')',
'      || ''%;background:'' || color(p) || ''"></i></div><span>'' || fmt(p) || ''%</span>'');',
'  end;',
'begin',
'  if :P1064_REC_ID is null then',
unistr('    return ''<div class="spd-alert">La meta no tiene programaci\00F3n en este seguimiento.</div>'';'),
'  end if;',
'  for g in (select g.*, e.CODIGO_ENT_PRY, e.NOMBRE_ENT_PRY, dl.CODE as L_CODE, dl.NAME as L_NAME,',
'                   (select u.NOMBRE_UNIDAD from UNIDADES_PRY u where u.NIT_COMPANIA = g.NIT_COMPANIA and u.CODIGO_UND = g.UNIT_CODE) as UNITS_NAME,',
'                   (select c.SINGULAR_NAME from V_SPD_PLAN_LEVEL_CONFIG c',
'                     where c.NIT_COMPANIA = g.NIT_COMPANIA and c.PLAN = g.PLAN and c.NUM = dl."LEVEL") as LEVEL_LABEL',
'              from SPD_GOAL g',
'              left join ENTIDADES_PRY e on e.ID = g.ENTITY_ID',
'              left join SPD_DEV_PLAN_LEVEL dl on dl.ID = g.DEV_PLAN_LEVEL_ID',
'             where g.ID = :P1064_GOAL_ID) loop',
'    add(''<details class="spd-collapse"><summary><b>'' || h(g.CODE) || case when g.GOAL_TYPE not in (''PROJECT'', ''ACTION_PLAN'') then '':</b> '' || h(g.NAME) else ''</b>'' end',
'      || ''</summary><div><table class="spd-desc">''',
unistr('      || ''<tr><th>ID</th><td>'' || g.ID || ''</td><th>C\00F3digo</th><td>'' || h(g.CODE) || ''</td></tr>'''),
'      || ''<tr><th>Meta</th><td colspan="3">'' || h(g.NAME) || ''</td></tr>''',
'      || ''<tr><th>Entidad</th><td colspan="3">'' || h(g.CODIGO_ENT_PRY || '' - '' || g.NOMBRE_ENT_PRY) || ''</td></tr>''',
'      || ''<tr><th>Tipo de meta</th><td>'' || h(lov(''SPD - TIPO DE META'', g.GOAL_TYPE)) || ''</td><th>''',
'      || h(coalesce(g.LEVEL_LABEL, ''Nivel del plan'')) || ''</th><td>'' || h(g.L_CODE || '' - '' || g.L_NAME) || ''</td></tr>''',
'      || case when g.GOAL_TYPE in (''PRODUCT'', ''RESULT'', ''IMPACT'', ''WELL_BEING'') then',
'           case when g.INDICATOR is not null then ''<tr><th>Indicador</th><td colspan="3">'' || h(g.INDICATOR) || ''</td></tr>'' end',
unistr('           || ''<tr><th>Unidades</th><td>'' || h(g.UNITS_NAME) || ''</td><th>Tipo de acumulaci\00F3n</th><td>'''),
'           || h(lov(''SPD - TIPO DE ACUMULACION'', g.ACCUMULATION_TYPE)) || ''</td></tr>''',
'           || ''<tr><th>Valor base</th><td>'' || fmt(g.BASE_VALUE) || ''</td><th>Valor meta</th><td>'' || fmt(g.GOAL_VALUE) || ''</td></tr>'' end',
'      || case when g.PROJECT_CODE is not null then ''<tr><th>Proyecto</th><td colspan="3">'' || h(g.PROJECT_CODE) || ''</td></tr>'' end',
'      || ''</table></div></details>'');',
'  end loop;',
'',
'  -- indicadores (abierto por defecto)',
'  add(''<details class="spd-collapse" open><summary><b>Indicadores</b></summary><div><div class="spd-bars">'');',
'  for x in (select r.PHYSICAL_INDICATOR from SPD_MONITORING_RECORD r where r.ID = :P1064_REC_ID) loop',
unistr('    if :P1064_GOAL_TYPE <> ''PROJECT'' then bar(''Avance F\00EDsico'', x.PHYSICAL_INDICATOR); end if;'),
'  end loop;',
'  for d in (select jt.DOC, jt.POS from SPD_MONITORING_CONFIG mc,',
'                   json_table(mc.SPENT_DOCS, ''$[*]'' columns (POS for ordinality, DOC varchar2(20) path ''$'')) jt',
'             where mc.ID = :P1064_MC and jt.DOC <> ''PAYMENT'' order by jt.POS) loop',
'    declare',
'      fi number;',
'    begin',
'      select max(FINANCIAL_INDICATOR) into fi from SPD_MONITORING_RECORD_RESOURCE',
'       where MONITORING_RECORD_ID = :P1064_REC_ID and RESOURCE_TYPE = d.DOC;',
'      bar(''Avance Financiero - '' || case d.DOC when ''COMMITMENT'' then ''Compromisos'' when ''OBLIGATION'' then ''Obligaciones'' else ''Pagos'' end, fi);',
'    end;',
'  end loop;',
'  add(''</div></div></details>'');',
'',
'  if :P1064_GOAL_TYPE in (''PRODUCT'', ''RESULT'', ''IMPACT'', ''WELL_BEING'') then',
'    declare',
'      n pls_integer := 0;',
unistr('      a clob := ''<table class="spd-tbl"><tr><th>Proyecto</th><th>Actividad</th><th style="text-align:right">Ponderaci\00F3n</th></tr>'';'),
'    begin',
'      add(''<details class="spd-collapse"><summary><b>Actividades</b></summary><div>'');',
'      for x in (select PROYECTO, CODIGO_ACT, WEIGHTING from SPD_ACTIVITY_GOAL where GOAL_ID = :P1064_GOAL_ID order by PROYECTO, CODIGO_ACT) loop',
'        n := n + 1;',
'        a := a || to_char(''<tr><td>'' || x.PROYECTO || ''</td><td>'' || x.CODIGO_ACT || ''</td><td style="text-align:right">'' || fmt(x.WEIGHTING) || ''</td></tr>'');',
'      end loop;',
'      if n = 0 then add(''<div class="spd-empty"><span class="fa fa-inbox"></span>No hay datos</div>''); else l := l || a; add(''</table>''); end if;',
'      add(''</div></details>'');',
'    end;',
'  end if;',
'  return l;',
'end;'))
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3682181106607294)
,p_plug_name=>unistr('Decisi\00F3n')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>6
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>':P1064_MODE in (''VALIDATE'', ''REVIEW'') and :P1064_REC_ID is not null'
,p_plug_display_when_cond2=>'PLSQL'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3682588330607294)
,p_plug_name=>unistr('Pesta\00F1as')
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(39530989314162909)
,p_plug_display_sequence=>10
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P1064_REC_ID'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3682616989607295)
,p_plug_name=>'Avance Cuantitativo'
,p_parent_plug_id=>wwv_flow_imp.id(3682588330607294)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l      clob;',
'  dis    varchar2(20) := case when :P1064_DATA_EDITABLE = ''S'' then null else '' disabled'' end;',
'  type t_res is table of varchar2(30);',
'  f  t_res := t_res(''RP'', ''SGP'', ''SGP_EDUCATION'', ''SGP_HEALTH'', ''SGP_WATER'', ''SGP_CULTURE'', ''SGP_SPORT'', ''SGP_FREE_INVESTMENT'',',
'                    ''SGP_FREE_DESTINATION'', ''SGP_SCHOOL_FEEDING'', ''SGP_MAGDALENA_RIVER'', ''SGP_EARLY_CHILDHOOD'',',
'                    ''CN'', ''CD'', ''SGR'', ''CREDIT'', ''OTHERS'', ''MANAGEMENT'', ''OPERATION'');',
unistr('  lb t_res := t_res(''Recursos Propios'', ''Recursos SGP'', ''Educaci\00F3n'', ''Salud'', ''Agua Potable'', ''Cultura'', ''Deporte'', ''Libre Inversi\00F3n'','),
unistr('                    ''Libre Destinaci\00F3n'', ''Alimentaci\00F3n Escolar'', ''R\00EDo Magdalena'', ''Primera Infancia'','),
unistr('                    ''Recursos CN'', ''Recursos CD'', ''Recursos SGR'', ''Recursos Cr\00E9dito'', ''Otros Recursos'', ''Recursos Gesti\00F3n'','),
'                    ''Recursos Funcionamiento'');',
'  type t_rows is table of SPD_MONITORING_RECORD_RESOURCE%rowtype index by varchar2(20);',
'  res t_rows;',
'  rec SPD_MONITORING_RECORD%rowtype;',
'  type t_cols is table of varchar2(20);',
'  cols t_cols := t_cols();      -- tipos de recurso por columna',
'  heads t_cols := t_cols();',
'  keys t_cols := t_cols();      -- prefijo de los id (u, f, c1..c3)',
unistr('  idx t_cols := t_cols();       -- nombre del arreglo fNN (solo las columnas de ejecuci\00F3n)'),
'  edit t_cols := t_cols();      -- ''S'' si la columna es editable',
'  sgp_disc boolean := :P1064_SGP_DISC = ''S'';',
'  is_plan boolean := :P1064_GOAL_TYPE in (''ACTION_PLAN'', ''ACTION_PLAN_ACTIVITY'');',
'  n pls_integer := 0;',
'  procedure add(p varchar2) is begin l := l || p; end;',
'  function fmt(n number) return varchar2 is',
'  begin',
'    return case when n is not null then rtrim(to_char(n, ''FM999G999G999G999G990D99999'', ''NLS_NUMERIC_CHARACTERS='''',.''''''), '','') end;',
'  end;',
'  function val(t varchar2, c varchar2) return number is',
'    r SPD_MONITORING_RECORD_RESOURCE%rowtype;',
'  begin',
'    if not res.exists(t) then return null; end if;',
'    r := res(t);',
'    return case c when ''RP'' then r.RP when ''SGP'' then r.SGP when ''SGP_EDUCATION'' then r.SGP_EDUCATION',
'      when ''SGP_HEALTH'' then r.SGP_HEALTH when ''SGP_WATER'' then r.SGP_WATER when ''SGP_CULTURE'' then r.SGP_CULTURE',
'      when ''SGP_SPORT'' then r.SGP_SPORT when ''SGP_FREE_INVESTMENT'' then r.SGP_FREE_INVESTMENT',
'      when ''SGP_FREE_DESTINATION'' then r.SGP_FREE_DESTINATION when ''SGP_SCHOOL_FEEDING'' then r.SGP_SCHOOL_FEEDING',
'      when ''SGP_MAGDALENA_RIVER'' then r.SGP_MAGDALENA_RIVER when ''SGP_EARLY_CHILDHOOD'' then r.SGP_EARLY_CHILDHOOD',
'      when ''CN'' then r.CN when ''CD'' then r.CD when ''SGR'' then r.SGR when ''CREDIT'' then r.CREDIT when ''OTHERS'' then r.OTHERS',
'      when ''MANAGEMENT'' then r.MANAGEMENT when ''OPERATION'' then r.OPERATION end;',
'  end;',
'  procedure col(p_type varchar2, p_head varchar2, p_key varchar2, p_idx varchar2, p_edit varchar2) is',
'  begin',
'    cols.extend; heads.extend; keys.extend; idx.extend; edit.extend;',
'    cols(cols.count) := p_type; heads(cols.count) := p_head; keys(cols.count) := p_key; idx(cols.count) := p_idx; edit(cols.count) := p_edit;',
'  end;',
'begin',
'  select * into rec from SPD_MONITORING_RECORD where ID = :P1064_REC_ID;',
'  for x in (select * from SPD_MONITORING_RECORD_RESOURCE where MONITORING_RECORD_ID = rec.ID) loop',
'    res(x.RESOURCE_TYPE) := x;',
'  end loop;',
unistr('  -- programaci\00F3n (solo lectura): Programaci\00F3n (MANUAL) y/o Apropiado (DEFINITIVE; no en planes de acci\00F3n)'),
unistr('  if :P1064_ORIGIN in (''USER'', ''USER_AND_FINANCIAL'') then col(''MANUAL'', ''Programaci\00F3n'', ''u'', null, ''N''); end if;'),
'  if :P1064_ORIGIN in (''FINANCIAL'', ''USER_AND_FINANCIAL'') and not is_plan then col(''DEFINITIVE'', ''Apropiado'', ''f'', null, ''N''); end if;',
unistr('  -- ejecuci\00F3n: una columna por documento del seguimiento; editable con presupuesto manual (o meta de plan de acci\00F3n)'),
'  for d in (select jt.DOC, jt.POS from SPD_MONITORING_CONFIG mc,',
'                   json_table(mc.SPENT_DOCS, ''$[*]'' columns (POS for ordinality, DOC varchar2(20) path ''$'')) jt',
'             where mc.ID = :P1064_MC order by jt.POS) loop',
'    n := n + 1;',
'    exit when n > 3;',
'    col(d.DOC, case d.DOC when ''COMMITMENT'' then ''Compromisos'' when ''OBLIGATION'' then ''Obligaciones'' else ''Pagos'' end,',
'        ''c'' || n, ''f'' || to_char(5 + n, ''FM00''),',
'        case when dis is null and (:P1064_MANUAL_BUDGET = ''S'' or :P1064_GOAL_TYPE = ''ACTION_PLAN_ACTIVITY'') then ''S'' else ''N'' end);',
'  end loop;',
'',
'  add(''<input type="hidden" id="spd_sgp_disc" value="'' || :P1064_SGP_DISC || ''"><table class="spd-form">''',
unistr('    || ''<tr><th class="spd-noc"></th><td class="spd-colhead">Programaci\00F3n</td><td class="spd-colhead">Ejecuci\00F3n</td></tr>'');'),
'  if :P1064_GOAL_TYPE not in (''PROJECT'', ''ACTION_PLAN'') then',
'    add(''<tr><th>Logro Meta</th><td><input type="text" class="spd-num" value="'' || fmt(rec.GOAL_VALUE) || ''" disabled></td>''',
'      || ''<td><input type="text" name="f01" class="spd-num" value="'' || fmt(rec.GOAL_ACHIEVED_VALUE) || ''"'' || dis || ''></td></tr>'');',
'  end if;',
'  if :P1064_SUPPORT_PI = ''S'' then',
'    add(''<tr><th>Logro Indicador Producto</th><td><input type="text" class="spd-num" value="'' || fmt(rec.PI_GOAL_VALUE) || ''" disabled></td>''',
'      || ''<td><input type="text" name="f02" class="spd-num" value="'' || fmt(rec.PI_GOAL_ACHIEVED_VALUE) || ''"'' || dis || ''></td></tr>'');',
'  end if;',
'  add(''</table><table class="spd-form"><tr><th>Origen Datos Financieros</th>'');',
'  for c in 1 .. cols.count loop add(''<td class="spd-colhead">'' || heads(c) || ''</td>''); end loop;',
'  add(''</tr>'');',
'  for i in 1 .. f.count loop',
'    add(''<tr'' || case when f(i) like ''SGP\_%'' escape ''\'' then '' class="spd-sgp-sub" style="display:none"'' end || ''><th''',
'      || case when f(i) = ''SGP'' and sgp_disc then '' class="spd-noc"'' end || ''>''',
'      || case when f(i) = ''SGP'' and sgp_disc then ''<span class="fa fa-chevron-down spd-sgp-toggle"></span><b>'' || lb(i) || ''</b>'' else lb(i) end',
'      || ''</th>'');',
'    for c in 1 .. cols.count loop',
'      add(''<td><input type="text"'' || case when idx(c) is not null then '' name="'' || idx(c) || ''"'' end',
'        || '' id="'' || keys(c) || ''_'' || f(i) || ''" data-col="'' || keys(c) || ''" class="spd-money" value="'' || fmt(val(cols(c), f(i)))',
'        || ''" placeholder="$"''',
'        || case when edit(c) = ''S'' then case when f(i) = ''SGP'' and sgp_disc then '' readonly'' end',
'                when idx(c) is not null then '' readonly tabindex="-1"'' else '' disabled'' end || ''></td>'');',
'    end loop;',
'    add(''</tr>'');',
'  end loop;',
'  add(''<tr class="spd-total"><th class="spd-noc">Total Recursos:</th>'');',
'  for c in 1 .. cols.count loop',
'    add(''<td><input type="text" id="'' || keys(c) || ''_TOTAL" class="spd-money" placeholder="$" disabled></td>'');',
'  end loop;',
'  add(''</tr></table>'');',
'  return l;',
'end;'))
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3682765563607295)
,p_plug_name=>'Avance Cualitativo'
,p_parent_plug_id=>wwv_flow_imp.id(3682588330607294)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  rec SPD_MONITORING_RECORD%rowtype;',
'  dis varchar2(20) := case when :P1064_DATA_EDITABLE = ''S'' then null else '' disabled'' end;',
'  function q(p_name varchar2, p_label varchar2, p_value clob) return varchar2 is',
'  begin',
'    return ''<div class="spd-q"><label>'' || p_label || ''</label><textarea name="'' || p_name || ''" rows="4" class="spd-ta"'' || dis || ''>''',
'      || apex_escape.html(dbms_lob.substr(p_value, 8000, 1)) || ''</textarea></div>'';',
'  end;',
'begin',
'  select * into rec from SPD_MONITORING_RECORD where ID = :P1064_REC_ID;',
unistr('  return q(''f11'', ''En qu\00E9 consisti\00F3 el logro del indicador/meta?'', rec.QUESTION_HOW)'),
unistr('      || q(''f12'', ''Qu\00E9 impacto, aspecto positivo o poblaci\00F3n beneficiada se logr\00F3?'', rec.QUESTION_RESULT)'),
unistr('      || q(''f13'', ''C\00F3mo se evidencia el logro o gesti\00F3n?'', rec.QUESTION_EVIDENCE)'),
unistr('      || q(''f14'', ''Qu\00E9 dificultad de present\00F3 para el logro del indicador/meta?'', rec.QUESTION_PROBLEM);'),
'end;'))
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3682883482607295)
,p_plug_name=>'Obs. Generales'
,p_parent_plug_id=>wwv_flow_imp.id(3682588330607294)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  rec SPD_MONITORING_RECORD%rowtype;',
'begin',
'  select * into rec from SPD_MONITORING_RECORD where ID = :P1064_REC_ID;',
'  return ''<div class="spd-q"><label>Notas Generales</label><textarea name="f15" rows="10" class="spd-ta"''',
'    || case when :P1064_DATA_EDITABLE = ''S'' then null else '' disabled'' end || ''>''',
'    || apex_escape.html(dbms_lob.substr(rec.NOTES, 8000, 1)) || ''</textarea></div>'';',
'end;'))
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3682975846607295)
,p_plug_name=>unistr('Focalizaci\00F3n E.D.')
,p_parent_plug_id=>wwv_flow_imp.id(3682588330607294)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>40
,p_plug_display_point=>'SUB_REGIONS'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3683045835607295)
,p_plug_name=>unistr('Focalizaci\00F3n E.D. - botones')
,p_parent_plug_id=>wwv_flow_imp.id(3682975846607295)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39487096731162903)
,p_plug_display_sequence=>5
,p_plug_display_point=>'SUB_REGIONS'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3683120686607295)
,p_plug_name=>unistr('Focalizaci\00F3n E.D. - grilla')
,p_region_name=>'spd_tm_ed'
,p_parent_plug_id=>wwv_flow_imp.id(3682975846607295)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>'select RECORD_ID, SECTION, POS, null as EDITAR, LOCALIZATION_LABEL, H, M, U, R, TOTAL_PEOPLE from V_SPD_TARGET_MATRIX where RECORD_ID = :P1064_REC_ID and SECTION = ''ed'''
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P1064_REC_ID'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3683545246607296)
,p_name=>'RECORD_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECORD_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>'Registro'
,p_label=>'Registro'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>10
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3683676140607297)
,p_name=>'SECTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SECTION'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>unistr('Secci\00F3n')
,p_label=>unistr('Secci\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3683781848607297)
,p_name=>'POS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'POS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>unistr('Posici\00F3n')
,p_label=>unistr('Posici\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3683854367607297)
,p_name=>'EDITAR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EDITAR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_LINK'
,p_heading=>'Acciones'
,p_label=>'Acciones'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_link_target=>'f?p=&APP_ID.:1065:&APP_SESSION.::&DEBUG.:1065:P1065_REC_ID,P1065_SECTION,P1065_POS,P1065_EDITABLE:&RECORD_ID.,&SECTION.,&POS.,&P1064_DATA_EDITABLE.'
,p_link_text=>'<span class="fa fa-edit spd-act" aria-hidden="true" title="Editar"></span><span class="u-VisuallyHidden">Editar</span>'
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3684070792607297)
,p_name=>'LOCALIZATION_LABEL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LOCALIZATION_LABEL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('Localizaci\00F3n')
,p_label=>unistr('Localizaci\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3684286967607298)
,p_name=>'H'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'H'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Hombres'
,p_label=>'Hombres'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>60
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3684438451607298)
,p_name=>'M'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'M'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Mujeres'
,p_label=>'Mujeres'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>70
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3684617646607298)
,p_name=>'U'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'U'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Urbano'
,p_label=>'Urbano'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>80
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3684876420607298)
,p_name=>'R'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'R'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Rural'
,p_label=>'Rural'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>90
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3685024919607298)
,p_name=>'TOTAL_PEOPLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TOTAL_PEOPLE'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Total personas'
,p_label=>'Total personas'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>100
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(3683224935607295)
,p_internal_uid=>3683224935607295
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>false
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_FIELD:ACTIONS_MENU'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>false
,p_enable_flashback=>false
,p_define_chart_view=>false
,p_enable_download=>false
,p_enable_mail_download=>false
,p_fixed_header=>'NONE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(3683323327607295)
,p_interactive_grid_id=>wwv_flow_imp.id(3683224935607295)
,p_static_id=>'3683323327607295'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>10
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(3683452421607295)
,p_report_id=>wwv_flow_imp.id(3683323327607295)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3683900454607297)
,p_view_id=>wwv_flow_imp.id(3683452421607295)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(3683854367607297)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3684155239607298)
,p_view_id=>wwv_flow_imp.id(3683452421607295)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(3684070792607297)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3684397130607298)
,p_view_id=>wwv_flow_imp.id(3683452421607295)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(3684286967607298)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3684560872607298)
,p_view_id=>wwv_flow_imp.id(3683452421607295)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(3684438451607298)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3684774947607298)
,p_view_id=>wwv_flow_imp.id(3683452421607295)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(3684617646607298)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3684991353607298)
,p_view_id=>wwv_flow_imp.id(3683452421607295)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(3684876420607298)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3685188993607298)
,p_view_id=>wwv_flow_imp.id(3683452421607295)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(3685024919607298)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3685319956607313)
,p_plug_name=>unistr('Focalizaci\00F3n Org.')
,p_parent_plug_id=>wwv_flow_imp.id(3682588330607294)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>50
,p_plug_display_point=>'SUB_REGIONS'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3685487666607313)
,p_plug_name=>unistr('Focalizaci\00F3n Org. - botones')
,p_parent_plug_id=>wwv_flow_imp.id(3685319956607313)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39487096731162903)
,p_plug_display_sequence=>5
,p_plug_display_point=>'SUB_REGIONS'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3685580456607313)
,p_plug_name=>unistr('Focalizaci\00F3n Org. - grilla')
,p_region_name=>'spd_tm_org'
,p_parent_plug_id=>wwv_flow_imp.id(3685319956607313)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>'select RECORD_ID, SECTION, POS, null as EDITAR, LOCALIZATION_LABEL, ORG_TYPE, ORG_OBJECT, NUM_BENEFICIARIES, POPULATION_DESC from V_SPD_TARGET_MATRIX where RECORD_ID = :P1064_REC_ID and SECTION = ''org'''
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P1064_REC_ID'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3685953810607313)
,p_name=>'RECORD_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECORD_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>'Registro'
,p_label=>'Registro'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>10
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3686022582607313)
,p_name=>'SECTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SECTION'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>unistr('Secci\00F3n')
,p_label=>unistr('Secci\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3686101875607313)
,p_name=>'POS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'POS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>unistr('Posici\00F3n')
,p_label=>unistr('Posici\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3686278056607313)
,p_name=>'EDITAR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EDITAR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_LINK'
,p_heading=>'Acciones'
,p_label=>'Acciones'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_link_target=>'f?p=&APP_ID.:1065:&APP_SESSION.::&DEBUG.:1065:P1065_REC_ID,P1065_SECTION,P1065_POS,P1065_EDITABLE:&RECORD_ID.,&SECTION.,&POS.,&P1064_DATA_EDITABLE.'
,p_link_text=>'<span class="fa fa-edit spd-act" aria-hidden="true" title="Editar"></span><span class="u-VisuallyHidden">Editar</span>'
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3686443896607313)
,p_name=>'LOCALIZATION_LABEL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LOCALIZATION_LABEL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('Localizaci\00F3n')
,p_label=>unistr('Localizaci\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3686656120607313)
,p_name=>'ORG_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ORG_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('Tipo de instituci\00F3n')
,p_label=>unistr('Tipo de instituci\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3686820213607313)
,p_name=>'ORG_OBJECT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ORG_OBJECT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('Objeto de instituci\00F3n')
,p_label=>unistr('Objeto de instituci\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3687004313607313)
,p_name=>'NUM_BENEFICIARIES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NUM_BENEFICIARIES'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('N\00FAmero de beneficiarios')
,p_label=>unistr('N\00FAmero de beneficiarios')
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>80
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3687296724607314)
,p_name=>'POPULATION_DESC'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'POPULATION_DESC'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('Total poblaci\00F3n /unidad')
,p_label=>unistr('Total poblaci\00F3n /unidad')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(3685622194607313)
,p_internal_uid=>3685622194607313
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>false
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_FIELD:ACTIONS_MENU'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>false
,p_enable_flashback=>false
,p_define_chart_view=>false
,p_enable_download=>false
,p_enable_mail_download=>false
,p_fixed_header=>'NONE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(3685792654607313)
,p_interactive_grid_id=>wwv_flow_imp.id(3685622194607313)
,p_static_id=>'3685792654607313'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>10
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(3685877091607313)
,p_report_id=>wwv_flow_imp.id(3685792654607313)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3686368569607313)
,p_view_id=>wwv_flow_imp.id(3685877091607313)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(3686278056607313)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3686561774607313)
,p_view_id=>wwv_flow_imp.id(3685877091607313)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(3686443896607313)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3686780331607313)
,p_view_id=>wwv_flow_imp.id(3685877091607313)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(3686656120607313)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3686910232607313)
,p_view_id=>wwv_flow_imp.id(3685877091607313)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(3686820213607313)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3687142149607313)
,p_view_id=>wwv_flow_imp.id(3685877091607313)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(3687004313607313)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3687363737607314)
,p_view_id=>wwv_flow_imp.id(3685877091607313)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(3687296724607314)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3687569486607314)
,p_plug_name=>unistr('Focalizaci\00F3n R.E.')
,p_parent_plug_id=>wwv_flow_imp.id(3682588330607294)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>60
,p_plug_display_point=>'SUB_REGIONS'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3687691231607314)
,p_plug_name=>unistr('Focalizaci\00F3n R.E. - botones')
,p_parent_plug_id=>wwv_flow_imp.id(3687569486607314)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39487096731162903)
,p_plug_display_sequence=>5
,p_plug_display_point=>'SUB_REGIONS'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3687721420607314)
,p_plug_name=>unistr('Focalizaci\00F3n R.E. - grilla')
,p_region_name=>'spd_tm_re'
,p_parent_plug_id=>wwv_flow_imp.id(3687569486607314)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>'select RECORD_ID, SECTION, POS, null as EDITAR, LOCALIZATION_LABEL, CANINE, FELINE, OTHERS, FLORA from V_SPD_TARGET_MATRIX where RECORD_ID = :P1064_REC_ID and SECTION = ''re'''
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P1064_REC_ID'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3688127905607314)
,p_name=>'RECORD_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECORD_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>'Registro'
,p_label=>'Registro'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>10
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3688283979607314)
,p_name=>'SECTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SECTION'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>unistr('Secci\00F3n')
,p_label=>unistr('Secci\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3688345687607314)
,p_name=>'POS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'POS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>unistr('Posici\00F3n')
,p_label=>unistr('Posici\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3688434922607314)
,p_name=>'EDITAR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EDITAR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_LINK'
,p_heading=>'Acciones'
,p_label=>'Acciones'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_link_target=>'f?p=&APP_ID.:1065:&APP_SESSION.::&DEBUG.:1065:P1065_REC_ID,P1065_SECTION,P1065_POS,P1065_EDITABLE:&RECORD_ID.,&SECTION.,&POS.,&P1064_DATA_EDITABLE.'
,p_link_text=>'<span class="fa fa-edit spd-act" aria-hidden="true" title="Editar"></span><span class="u-VisuallyHidden">Editar</span>'
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3688658160607314)
,p_name=>'LOCALIZATION_LABEL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LOCALIZATION_LABEL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('Localizaci\00F3n')
,p_label=>unistr('Localizaci\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3688842039607314)
,p_name=>'CANINE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CANINE'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Caninos'
,p_label=>'Caninos'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>60
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3689061111607314)
,p_name=>'FELINE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FELINE'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Felinos'
,p_label=>'Felinos'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>70
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3689262362607314)
,p_name=>'OTHERS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OTHERS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Otra Especie'
,p_label=>'Otra Especie'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>80
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(3689451591607314)
,p_name=>'FLORA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FLORA'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Flora'
,p_label=>'Flora'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N')).to_clob
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(3687853845607314)
,p_internal_uid=>3687853845607314
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>false
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_FIELD:ACTIONS_MENU'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>false
,p_enable_flashback=>false
,p_define_chart_view=>false
,p_enable_download=>false
,p_enable_mail_download=>false
,p_fixed_header=>'NONE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(3687968112607314)
,p_interactive_grid_id=>wwv_flow_imp.id(3687853845607314)
,p_static_id=>'3687968112607314'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>10
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(3688006685607314)
,p_report_id=>wwv_flow_imp.id(3687968112607314)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3688524399607314)
,p_view_id=>wwv_flow_imp.id(3688006685607314)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(3688434922607314)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3688780472607314)
,p_view_id=>wwv_flow_imp.id(3688006685607314)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(3688658160607314)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3688979589607314)
,p_view_id=>wwv_flow_imp.id(3688006685607314)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(3688842039607314)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3689141252607314)
,p_view_id=>wwv_flow_imp.id(3688006685607314)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(3689061111607314)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3689322308607314)
,p_view_id=>wwv_flow_imp.id(3688006685607314)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(3689262362607314)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(3689586693607314)
,p_view_id=>wwv_flow_imp.id(3688006685607314)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(3689451591607314)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3689735144607314)
,p_plug_name=>'Evidencias'
,p_parent_plug_id=>wwv_flow_imp.id(3682588330607294)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>70
,p_plug_display_point=>'SUB_REGIONS'
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
unistr('  l clob := ''<table class="spd-tbl"><tr><th>Archivo</th><th>Descripci\00F3n</th><th>Fecha</th><th></th></tr>'';'),
'  rw varchar2(32767);',
'  n pls_integer := 0;',
'begin',
'  for a in (select ID, NAME, DESCRIPTION, S3_PATH, CREATED_AT from SPD_MONITORING_RECORD_ATTACH',
'             where MONITORING_RECORD_ID = :P1064_REC_ID order by CREATED_AT) loop',
'    n := n + 1;',
'    rw := ''<tr><td><span class="fa fa-file-o"></span> <span title="'' || apex_escape.html_attribute(a.S3_PATH) || ''">''',
'      || apex_escape.html(a.NAME) || ''</span></td><td>'' || apex_escape.html(a.DESCRIPTION) || ''</td><td>''',
'      || to_char(a.CREATED_AT at time zone ''America/Bogota'', ''YYYY-MM-DD HH24:MI'') || ''</td><td style="text-align:right">''',
'      || case when :P1064_DATA_EDITABLE = ''S'' then ''<button type="button" class="t-Button t-Button--small t-Button--danger" onclick="spdDelAtt(''',
'              || a.ID || '')"><span class="fa fa-trash-o"></span></button>'' end || ''</td></tr>'';',
'    l := l || rw;',
'  end loop;',
unistr('  return ''<div class="spd-alert">Los archivos del original se guardan en S3: aqu\00ED se listan y se pueden eliminar; '''),
'      || ''la carga de archivos queda pendiente de definir el almacenamiento en el SIIF.</div>''',
'      || case when n = 0 then ''<div class="spd-empty"><span class="fa fa-inbox"></span>No hay datos</div>'' else l || ''</table>'' end;',
'end;'))
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3689822927607314)
,p_plug_name=>'Indicadores'
,p_parent_plug_id=>wwv_flow_imp.id(3682588330607294)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>80
,p_plug_display_point=>'SUB_REGIONS'
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  -- tarjetas: anillo con el color del rango configurado en el seguimiento, etiqueta del rango y',
'  -- las cifras de las que sale el porcentaje (logro / programado, ejecutado / apropiado)',
'  l      clob := ''<div class="spd-ind">'';',
'  l_base varchar2(20) := case when :P1064_GOAL_TYPE in (''ACTION_PLAN'', ''ACTION_PLAN_ACTIVITY'') then ''MANUAL'' else ''DEFINITIVE'' end;',
'  l_appr number;',
'  n      pls_integer := 0;',
'  function pct(p number) return varchar2 is',
'  begin',
'    return to_char(p, ''FM999G990D00'', ''NLS_NUMERIC_CHARACTERS=''''.,'''''') || ''%'';',
'  end;',
'  function fmt(v number) return varchar2 is',
'  begin',
unistr('    return case when v is null then ''\2014'' else to_char(v, ''FM999G999G999G990D00'', ''NLS_NUMERIC_CHARACTERS=''''.,'''''') end;'),
'  end;',
'  function money(v number) return varchar2 is',
'  begin',
unistr('    return case when v is null then ''\2014'' else to_char(v, ''FM$999G999G999G999G990'', ''NLS_NUMERIC_CHARACTERS=''''.,'''''') end;'),
'  end;',
'  function total(p_type varchar2) return number is',
'    t number;',
'  begin',
'    select sum(nvl(CAPITAL,0) + nvl(CD,0) + nvl(CN,0) + nvl(CREDIT,0) + nvl(DE,0) + nvl(OPERATION,0) + nvl(MANAGEMENT,0)',
'             + nvl(MONOPOLY,0) + nvl(OTHERS,0) + nvl(RP,0) + nvl(SGP,0) + nvl(SGR,0))',
'      into t from SPD_MONITORING_RECORD_RESOURCE where MONITORING_RECORD_ID = :P1064_REC_ID and RESOURCE_TYPE = p_type;',
'    return t;',
'  end;',
'  function card(p_kicker varchar2, p_title varchar2, p_value number, p_figs varchar2) return varchar2 is',
'    p  number := round(nvl(p_value, 0) * 100, 2);',
'    c  varchar2(30);',
'    lb varchar2(200);',
'  begin',
unistr('    -- rango de color (los l\00EDmites se escalan al subperiodo, como en los tableros)'),
'    begin',
'      select c.COLOR, c.LABEL into c, lb from V_SPD_MONITORING_COLORS c',
'       where c.ID = :P1064_MC and p >= c.FROM_VALUE * :P1064_SUBPERIOD / 4 and p <= c.TO_VALUE * :P1064_SUBPERIOD / 4',
'       order by c.POS fetch first 1 row only;',
'    exception when no_data_found then',
'      select max(c.COLOR) keep (dense_rank last order by c.POS), max(c.LABEL) keep (dense_rank last order by c.POS)',
'        into c, lb from V_SPD_MONITORING_COLORS c where c.ID = :P1064_MC;',
'    end;',
'    c := nvl(c, ''#1677ff'');',
'    n := n + 1;',
'    return ''<div class="spd-ind-card"><div class="spd-ind-kicker">'' || p_kicker || ''</div>''',
'        || ''<div class="spd-ind-title">'' || p_title || ''</div>''',
'        || ''<div class="spd-gauge spd-gauge--lg" style="--p:'' || to_char(least(p, 100), ''FM990D00'', ''NLS_NUMERIC_CHARACTERS=''''.,'''''')',
'        || '';--c:'' || c || ''"><span>'' || pct(p) || ''</span></div>''',
'        || case when lb is not null then ''<span class="spd-ind-chip" style="--c:'' || c || ''"><i></i>'' || apex_escape.html(lb) || ''</span>'' end',
'        || ''<div class="spd-ind-figs">'' || p_figs || ''</div></div>'';',
'  end;',
'begin',
'  if :P1064_GOAL_TYPE <> ''PROJECT'' then',
'    for x in (select PHYSICAL_INDICATOR, GOAL_VALUE, GOAL_ACHIEVED_VALUE from SPD_MONITORING_RECORD where ID = :P1064_REC_ID) loop',
unistr('      l := l || card(''Avance f\00EDsico'', ''Logro de la meta'', x.PHYSICAL_INDICATOR,'),
'                     ''<span>Programado</span><b>'' || fmt(x.GOAL_VALUE) || ''</b>''',
'                  || ''<span>Logrado</span><b>'' || fmt(x.GOAL_ACHIEVED_VALUE) || ''</b>'');',
'    end loop;',
'  end if;',
'  l_appr := total(l_base);',
unistr('  if l_appr is null and l_base = ''MANUAL'' then   -- plan sin programaci\00F3n manual: lo apropiado'),
'    l_base := ''DEFINITIVE'';',
'    l_appr := total(l_base);',
'  end if;',
'  for d in (select jt.DOC, jt.POS from SPD_MONITORING_CONFIG mc,',
'                   json_table(mc.SPENT_DOCS, ''$[*]'' columns (POS for ordinality, DOC varchar2(20) path ''$'')) jt',
'             where mc.ID = :P1064_MC and jt.DOC <> ''PAYMENT'' order by jt.POS) loop',
'    declare',
'      fi number;',
'    begin',
'      select max(FINANCIAL_INDICATOR) into fi from SPD_MONITORING_RECORD_RESOURCE where MONITORING_RECORD_ID = :P1064_REC_ID and RESOURCE_TYPE = d.DOC;',
'      l := l || card(''Avance financiero'',',
'                     case d.DOC when ''COMMITMENT'' then ''Compromisos'' when ''OBLIGATION'' then ''Obligaciones'' else ''Pagos'' end, fi,',
'                     ''<span>'' || case l_base when ''MANUAL'' then ''Programado'' else ''Apropiado'' end || ''</span><b>'' || money(l_appr) || ''</b>''',
'                  || ''<span>Ejecutado</span><b>'' || money(total(d.DOC)) || ''</b>'');',
'    end;',
'  end loop;',
'  if n = 0 then',
'    return ''<div class="spd-empty"><span class="fa fa-inbox"></span>No hay indicadores para este seguimiento</div>'';',
'  end if;',
'  return l || ''</div>'';',
'end;'))
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3689983865607315)
,p_plug_name=>'Historial'
,p_parent_plug_id=>wwv_flow_imp.id(3682588330607294)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>90
,p_plug_display_point=>'SUB_REGIONS'
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l clob := ''<ul class="spd-hist">'';',
'  rw varchar2(32767);',
'  n pls_integer := 0;',
'begin',
'  for x in (select h.EVENT, h.DESCRIPTION, h.CREATED_AT, u.DESCRIPCION as USER_NAME',
'              from SPD_GOAL_HISTORY h',
'              left join SPD_MONITORING_RECORD r on r.ID = h.MONITORING_RECORD_ID',
'              left join USUARIOS u on u.ID = h.CREATED_BY and u.NIT_COMPANIA = :G_NIT_COMPANIA',
'             where h.GOAL_ID = :P1064_GOAL_ID and (r.ID is null or r.MONITORING_CONFIG_ID = :P1064_MC)',
'             order by h.CREATED_AT, h.ID) loop',
'    n := n + 1;',
'    rw := ''<li><span class="spd-avatar" title="'' || apex_escape.html_attribute(coalesce(x.USER_NAME, ''SPD'')) || ''">''',
'      || apex_escape.html(case when x.USER_NAME is null then ''S''',
'                               else upper(substr(x.USER_NAME, 1, 1) || substr(regexp_substr(x.USER_NAME, ''\S+'', 1, 2), 1, 1)) end)',
'      || ''</span><div><div class="spd-hist-title">''',
'      || case x.EVENT when ''CREATED'' then ''Creada'' when ''MONITORED'' then ''Reportada'' when ''REJECTED'' then ''Rechazada''',
'              when ''REVIEWED'' then ''Aprobada'' when ''SCHEDULED'' then ''Programada'' when ''UPDATED'' then ''Actualizada''',
'              when ''VALIDATED'' then ''Validada'' end',
'      || '' - '' || to_char(x.CREATED_AT at time zone ''America/Bogota'', ''YYYY-MM-DD HH24:MI:SS'')',
'      || ''</div><div class="spd-hist-desc">'' || apex_escape.html(x.DESCRIPTION) || ''</div></div></li>'';',
'    l := l || rw;',
'  end loop;',
'  if n = 0 then',
'    return ''<div class="spd-empty"><span class="fa fa-inbox"></span>No hay datos</div>'';',
'  end if;',
'  return l || ''</ul>'';',
'end;'))
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3690060116607315)
,p_plug_name=>'Botones'
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
 p_id=>wwv_flow_imp.id(3690186030607315)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(3690060116607315)
,p_button_name=>'VOLVER'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(39601281081162925)
,p_button_image_alt=>'Volver'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3690242960607315)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(3690060116607315)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(39601281081162925)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Guardar'
,p_button_position=>'NEXT'
,p_button_condition=>'P1064_EDITABLE'
,p_button_condition2=>'S'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3685228789607298)
,p_button_sequence=>230
,p_button_plug_id=>wwv_flow_imp.id(3683045835607295)
,p_button_name=>'ADD_TM_ED'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Agregar localizaci\00F3n')
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:1065:&APP_SESSION.::&DEBUG.:1065:P1065_REC_ID,P1065_SECTION,P1065_POS,P1065_EDITABLE:&P1064_REC_ID.,ed,,S'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P1064_DATA_EDITABLE'
,p_button_condition2=>'S'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3687421507607314)
,p_button_sequence=>240
,p_button_plug_id=>wwv_flow_imp.id(3685487666607313)
,p_button_name=>'ADD_TM_ORG'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Agregar localizaci\00F3n')
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:1065:&APP_SESSION.::&DEBUG.:1065:P1065_REC_ID,P1065_SECTION,P1065_POS,P1065_EDITABLE:&P1064_REC_ID.,org,,S'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P1064_DATA_EDITABLE'
,p_button_condition2=>'S'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3689692540607314)
,p_button_sequence=>250
,p_button_plug_id=>wwv_flow_imp.id(3687691231607314)
,p_button_name=>'ADD_TM_RE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(39599033835162924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Agregar localizaci\00F3n')
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:1065:&APP_SESSION.::&DEBUG.:1065:P1065_REC_ID,P1065_SECTION,P1065_POS,P1065_EDITABLE:&P1064_REC_ID.,re,,S'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P1064_DATA_EDITABLE'
,p_button_condition2=>'S'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(3690934739607316)
,p_branch_name=>unistr('Volver al di\00E1logo')
,p_branch_action=>'f?p=&APP_ID.:1064:&APP_SESSION.::&DEBUG.:::'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_branch_condition=>'DELETE_ATT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3680158711607292)
,p_name=>'P1064_MC'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'MC'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3680214459607292)
,p_name=>'P1064_GOAL_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'GOAL_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3680327977607292)
,p_name=>'P1064_MODE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'MODE'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3680408282607292)
,p_name=>'P1064_ORIGIN'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'ORIGIN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3680594799607293)
,p_name=>'P1064_SGP_DISC'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'SGP_DISC'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3680665253607293)
,p_name=>'P1064_SUPPORT_PI'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'SUPPORT_PI'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3680725205607293)
,p_name=>'P1064_SPENT_DOCS'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'SPENT_DOCS'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3680824727607293)
,p_name=>'P1064_DATE_OK'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'DATE_OK'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3680976958607293)
,p_name=>'P1064_MANUAL_BUDGET'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'MANUAL_BUDGET'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3681072996607293)
,p_name=>'P1064_EDITABLE'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'EDITABLE'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3681114802607293)
,p_name=>'P1064_DATA_EDITABLE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'DATA_EDITABLE'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3681206640607293)
,p_name=>'P1064_REC_ID'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'REC_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3681371243607293)
,p_name=>'P1064_RECORD_STATUS'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'RECORD_STATUS'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3681485396607293)
,p_name=>'P1064_STATUS'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'STATUS'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3681564626607293)
,p_name=>'P1064_GOAL_TYPE'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'GOAL_TYPE'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3681694624607293)
,p_name=>'P1064_USER_ID'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'USER_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3681766608607293)
,p_name=>'P1064_SUBPERIOD'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'SUBPERIOD'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3681897603607293)
,p_name=>'P1064_ATT_ID'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'ATT_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3681928243607293)
,p_name=>'P1064_MSG'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_imp.id(3680049190607292)
,p_prompt=>'MSG'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_cHeight=>1
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3682259821607294)
,p_name=>'P1064_VALIDATED'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_imp.id(3682181106607294)
,p_prompt=>unistr('Validaci\00F3n')
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC2:Validada;VALIDATED,Sin Validar;REPORTED'
,p_cSize=>30
,p_cHeight=>1
,p_display_when=>'P1064_MODE'
,p_display_when2=>'VALIDATE'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_read_only_when=>'P1064_EDITABLE'
,p_read_only_when2=>'S'
,p_read_only_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '2',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3682376795607294)
,p_name=>'P1064_REVIEWED'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_imp.id(3682181106607294)
,p_prompt=>unistr('Revisi\00F3n')
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC2:Aprobada;REVIEWED,Rechazada;REJECTED'
,p_cSize=>30
,p_cHeight=>1
,p_display_when=>'P1064_MODE'
,p_display_when2=>'REVIEW'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_read_only_when=>'P1064_EDITABLE'
,p_read_only_when2=>'S'
,p_read_only_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_of_columns', '2',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3682494761607294)
,p_name=>'P1064_REVIEW_NOTES'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_imp.id(3682181106607294)
,p_prompt=>unistr('Observaci\00F3n')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cHeight=>1
,p_colspan=>12
,p_display_when=>'P1064_MODE'
,p_display_when2=>'REVIEW'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_read_only_when=>'P1064_EDITABLE'
,p_read_only_when2=>'S'
,p_read_only_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_field_template=>wwv_flow_imp.id(39596958012162922)
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(3690300275607315)
,p_name=>'Volver'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(3690186030607315)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(3690481775607315)
,p_event_id=>wwv_flow_imp.id(3690300275607315)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3690624450607316)
,p_process_sequence=>270
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Eliminar evidencia'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
'  if :P1064_DATA_EDITABLE = ''S'' then',
'    delete from SPD_MONITORING_RECORD_ATTACH where ID = :P1064_ATT_ID and MONITORING_RECORD_ID = :P1064_REC_ID;',
'  end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'DELETE_ATT'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>3690624450607316
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3690749206607316)
,p_process_sequence=>280
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Guardar ejecuci\00F3n')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  rec    SPD_MONITORING_RECORD%rowtype;',
'  mc     SPD_MONITORING_CONFIG%rowtype;',
'  l_status varchar2(20);',
'  l_event  varchar2(20);',
'  l_sched  varchar2(20) := case when :P1064_GOAL_TYPE in (''ACTION_PLAN'', ''ACTION_PLAN_ACTIVITY'') then ''MANUAL'' else ''DEFINITIVE'' end;',
'  v1 number; v2 number; h1 varchar2(1); h2 varchar2(1);',
'  q1 varchar2(32767); q2 varchar2(32767); q3 varchar2(32767); q4 varchar2(32767); q5 varchar2(32767);',
'  k1 varchar2(1); k2 varchar2(1); k3 varchar2(1); k4 varchar2(1); k5 varchar2(1);',
'  l_tm   clob;',
'  type t_res is table of varchar2(30);',
'  f  t_res := t_res(''RP'', ''SGP'', ''SGP_EDUCATION'', ''SGP_HEALTH'', ''SGP_WATER'', ''SGP_CULTURE'', ''SGP_SPORT'', ''SGP_FREE_INVESTMENT'',',
'                    ''SGP_FREE_DESTINATION'', ''SGP_SCHOOL_FEEDING'', ''SGP_MAGDALENA_RIVER'', ''SGP_EARLY_CHILDHOOD'',',
'                    ''CN'', ''CD'', ''SGR'', ''CREDIT'', ''OTHERS'', ''MANAGEMENT'', ''OPERATION'');',
'  function num(v varchar2) return number is',
'  begin',
'    if trim(v) is null then return null; end if;',
'    return to_number(replace(replace(trim(v), ''.'', ''''), '','', ''.''), ''999999999999999999999D999999'', ''NLS_NUMERIC_CHARACTERS=''''.,'''''');',
'  exception when others then',
unistr('    raise_application_error(-20001, ''Valor num\00E9rico no v\00E1lido: '' || v);'),
'  end;',
'  function txt(p apex_application_global.vc_arr2) return varchar2 is',
'  begin',
'    return case when p.exists(1) then p(1) end;',
'  end;',
'  -- total de un recurso: los mismos campos que calculateFinancialIndicator',
'  function total(p_rec number, p_type varchar2) return number is',
'    t number;',
'  begin',
'    select sum(CAPITAL + CD + CN + CREDIT + DE + OPERATION + MANAGEMENT + MONOPOLY + OTHERS + RP + SGP + SGR) into t',
'      from SPD_MONITORING_RECORD_RESOURCE where MONITORING_RECORD_ID = p_rec and RESOURCE_TYPE = p_type;',
'    return t;',
'  end;',
'  procedure save_res(p_type varchar2, p apex_application_global.vc_arr2) is',
'    v  apex_t_number := apex_t_number();',
'    l_sgp number;',
'    l_s number;',
'    l_t number;',
'  begin',
'    if p.count = 0 then return; end if;',
'    v.extend(f.count);',
'    for i in 1 .. f.count loop v(i) := case when p.exists(i) then nvl(num(p(i)), 0) else 0 end; end loop;',
'    l_sgp := case when :P1064_SGP_DISC = ''S'' then v(3) + v(4) + v(5) + v(6) + v(7) + v(8) + v(9) + v(10) + v(11) + v(12) else v(2) end;',
'    merge into SPD_MONITORING_RECORD_RESOURCE t',
'    using (select rec.ID as MONITORING_RECORD_ID, p_type as RESOURCE_TYPE from dual) s',
'       on (t.MONITORING_RECORD_ID = s.MONITORING_RECORD_ID and t.RESOURCE_TYPE = s.RESOURCE_TYPE)',
'     when matched then update set RP = v(1), SGP = l_sgp, SGP_EDUCATION = v(3), SGP_HEALTH = v(4), SGP_WATER = v(5),',
'          SGP_CULTURE = v(6), SGP_SPORT = v(7), SGP_FREE_INVESTMENT = v(8), SGP_FREE_DESTINATION = v(9),',
'          SGP_SCHOOL_FEEDING = v(10), SGP_MAGDALENA_RIVER = v(11), SGP_EARLY_CHILDHOOD = v(12), CN = v(13), CD = v(14),',
'          SGR = v(15), CREDIT = v(16), OTHERS = v(17), MANAGEMENT = v(18), OPERATION = v(19),',
'          UPDATED_AT = systimestamp, UPDATED_BY = :P1064_USER_ID',
'     when not matched then insert (MONITORING_RECORD_ID, RESOURCE_TYPE, RP, SGP, SGP_EDUCATION, SGP_HEALTH, SGP_WATER,',
'          SGP_CULTURE, SGP_SPORT, SGP_FREE_INVESTMENT, SGP_FREE_DESTINATION, SGP_SCHOOL_FEEDING, SGP_MAGDALENA_RIVER,',
'          SGP_EARLY_CHILDHOOD, CN, CD, SGR, CREDIT, OTHERS, MANAGEMENT, OPERATION, CREATED_BY)',
'          values (rec.ID, p_type, v(1), l_sgp, v(3), v(4), v(5), v(6), v(7), v(8), v(9), v(10), v(11), v(12), v(13), v(14),',
'                  v(15), v(16), v(17), v(18), v(19), :P1064_USER_ID);',
'  end;',
'begin',
'  select * into mc from SPD_MONITORING_CONFIG where ID = :P1064_MC and NIT_COMPANIA = :G_NIT_COMPANIA;',
'  -- la ventana de fechas se recalcula al guardar: no se usa el valor calculado al abrir el formulario',
'  begin',
'    select case when systimestamp between from_tz(to_timestamp(substr(case case :P1064_MODE when ''REPORT'' then ''reporting'' when ''VALIDATE'' then ''validating'' when ''REVIEW'' then ''reviewing'' end when ''scheduling'' then json_value(mc.DATES_CONFIG, ''$.sche'
||'duling[0]'') when ''reporting'' then json_value(mc.DATES_CONFIG, ''$.reporting[0]'') when ''validating'' then json_value(mc.DATES_CONFIG, ''$.validating[0]'') when ''reviewing'' then json_value(mc.DATES_CONFIG, ''$.reviewing[0]'') end, 1, 23), ''YYYY-MM-DD"T"HH24:'
||'MI:SS.FF3''), ''UTC'')',
'                                      and from_tz(to_timestamp(substr(case case :P1064_MODE when ''REPORT'' then ''reporting'' when ''VALIDATE'' then ''validating'' when ''REVIEW'' then ''reviewing'' end when ''scheduling'' then json_value(mc.DATES_CONFIG, ''$.sche'
||'duling[1]'') when ''reporting'' then json_value(mc.DATES_CONFIG, ''$.reporting[1]'') when ''validating'' then json_value(mc.DATES_CONFIG, ''$.validating[1]'') when ''reviewing'' then json_value(mc.DATES_CONFIG, ''$.reviewing[1]'') end, 1, 23), ''YYYY-MM-DD"T"HH24:'
||'MI:SS.FF3''), ''UTC'')',
'                then ''S'' else ''N'' end into :P1064_DATE_OK from dual;',
'  exception when others then :P1064_DATE_OK := ''N'';',
'  end;',
'  if :P1064_DATE_OK <> ''S'' then',
unistr('    raise_application_error(-20001, ''El seguimiento no est\00E1 en fechas para esta etapa.'');'),
'  end if;',
'  if :P1064_REC_ID is null then',
unistr('    raise_application_error(-20001, ''No se encontr\00F3 la programaci\00F3n de la meta'');'),
'  elsif :P1064_EDITABLE <> ''S'' then',
'    raise_application_error(-20001, ''La meta no se puede modificar en esta etapa (fechas o estado).'');',
'  end if;',
'  select * into rec from SPD_MONITORING_RECORD where ID = :P1064_REC_ID;',
'',
'  if :P1064_MODE = ''REVIEW'' then',
unistr('    -- revisi\00F3n: solo la decisi\00F3n; la observaci\00F3n queda en el historial'),
'    l_status := nvl(:P1064_REVIEWED, ''REVIEWED'');',
'    update SPD_MONITORING_RECORD set RECORD_STATUS = l_status, UPDATED_AT = systimestamp, UPDATED_BY = :P1064_USER_ID where ID = rec.ID;',
'    insert into SPD_GOAL_HISTORY (GOAL_ID, MONITORING_RECORD_ID, EVENT, DESCRIPTION, CREATED_BY)',
'    values (:P1064_GOAL_ID, rec.ID, case l_status when ''REVIEWED'' then ''REVIEWED'' else ''REJECTED'' end, :P1064_REVIEW_NOTES, :P1064_USER_ID);',
unistr('    :P1064_MSG := ''Revisi\00F3n guardada'';'),
'    return;',
'  end if;',
'',
'  l_status := case when :P1064_MODE = ''VALIDATE'' then nvl(:P1064_VALIDATED, ''REPORTED'') else ''REPORTED'' end;',
'  if apex_application.g_f01.exists(1) then h1 := ''S''; v1 := num(apex_application.g_f01(1)); end if;',
'  if apex_application.g_f02.exists(1) then h2 := ''S''; v2 := num(apex_application.g_f02(1)); end if;',
'  -- textos (un campo deshabilitado no llega: se conserva lo guardado)',
'  if apex_application.g_f11.exists(1) then k1 := ''S''; q1 := apex_application.g_f11(1); end if;',
'  if apex_application.g_f12.exists(1) then k2 := ''S''; q2 := apex_application.g_f12(1); end if;',
'  if apex_application.g_f13.exists(1) then k3 := ''S''; q3 := apex_application.g_f13(1); end if;',
'  if apex_application.g_f14.exists(1) then k4 := ''S''; q4 := apex_application.g_f14(1); end if;',
'  if apex_application.g_f15.exists(1) then k5 := ''S''; q5 := apex_application.g_f15(1); end if;',
'  if apex_application.g_f16.exists(1) and trim(apex_application.g_f16(1)) is not null then',
'    l_tm := apex_application.g_f16(1);',
'    if l_tm is not json then l_tm := null; end if;',
'  end if;',
'  update SPD_MONITORING_RECORD',
'     set GOAL_ACHIEVED_VALUE    = case when h1 = ''S'' then nvl(v1, 0) else nvl(GOAL_ACHIEVED_VALUE, 0) end,',
'         PI_GOAL_ACHIEVED_VALUE = case when h2 = ''S'' then v2 else PI_GOAL_ACHIEVED_VALUE end,',
'         QUESTION_HOW      = case when k1 = ''S'' then to_clob(q1) else QUESTION_HOW end,',
'         QUESTION_RESULT   = case when k2 = ''S'' then to_clob(q2) else QUESTION_RESULT end,',
'         QUESTION_EVIDENCE = case when k3 = ''S'' then to_clob(q3) else QUESTION_EVIDENCE end,',
'         QUESTION_PROBLEM  = case when k4 = ''S'' then to_clob(q4) else QUESTION_PROBLEM end,',
'         NOTES             = case when k5 = ''S'' then to_clob(q5) else NOTES end,',
'         TARGET_MATRIX     = nvl(l_tm, TARGET_MATRIX),',
'         RECORD_STATUS     = l_status,',
'         UPDATED_AT = systimestamp, UPDATED_BY = :P1064_USER_ID',
'   where ID = rec.ID;',
unistr('  -- avance f\00EDsico = min(logro / programado, 1)'),
'  update SPD_MONITORING_RECORD',
'     set PHYSICAL_INDICATOR = case when nvl(GOAL_VALUE, 0) <> 0 then round(least(nvl(GOAL_ACHIEVED_VALUE, 0) / GOAL_VALUE, 1), 4) else 0 end',
'   where ID = rec.ID;',
'',
unistr('  -- recursos de ejecuci\00F3n: una columna por documento del seguimiento (f06, f07, f08)'),
'  for d in (select jt.DOC, jt.POS from SPD_MONITORING_CONFIG mc,',
'                   json_table(mc.SPENT_DOCS, ''$[*]'' columns (POS for ordinality, DOC varchar2(20) path ''$'')) jt',
'             where mc.ID = :P1064_MC and jt.POS <= 3 order by jt.POS) loop',
'    if d.POS = 1 then save_res(d.DOC, apex_application.g_f06);',
'    elsif d.POS = 2 then save_res(d.DOC, apex_application.g_f07);',
'    else save_res(d.DOC, apex_application.g_f08);',
'    end if;',
'  end loop;',
'  -- avance financiero de cada documento = min(ejecutado / apropiado, 1)',
'  declare',
'    l_base number := total(rec.ID, l_sched);',
'    l_exec number;',
'  begin',
'    for x in (select RESOURCE_TYPE from SPD_MONITORING_RECORD_RESOURCE',
'               where MONITORING_RECORD_ID = rec.ID and RESOURCE_TYPE in (''COMMITMENT'', ''OBLIGATION'', ''PAYMENT'')) loop',
'      l_exec := nvl(total(rec.ID, x.RESOURCE_TYPE), 0);',
'      update SPD_MONITORING_RECORD_RESOURCE',
'         set FINANCIAL_INDICATOR = case when nvl(l_base, 0) <> 0 then round(least(l_exec / l_base, 1), 4) else 0 end',
'       where MONITORING_RECORD_ID = rec.ID and RESOURCE_TYPE = x.RESOURCE_TYPE;',
'    end loop;',
'  end;',
'',
'  l_event := case l_status when ''VALIDATED'' then ''VALIDATED'' else ''MONITORED'' end;',
'  insert into SPD_GOAL_HISTORY (GOAL_ID, MONITORING_RECORD_ID, EVENT, DESCRIPTION, CREATED_BY)',
'  values (:P1064_GOAL_ID, rec.ID, l_event, null, :P1064_USER_ID);',
unistr('  :P1064_MSG := case when :P1064_MODE = ''VALIDATE'' then ''Validaci\00F3n guardada'' else ''Seguimiento guardado'' end;'),
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>3690749206607316
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3690857944607316)
,p_process_sequence=>290
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>unistr('Cerrar di\00E1logo')
,p_process_when=>'SAVE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'&P1064_MSG.'
,p_internal_uid=>3690857944607316
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3690581211607315)
,p_process_sequence=>260
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Cargar ejecuci\00F3n')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  mc SPD_MONITORING_CONFIG%rowtype;',
'  l_window varchar2(20);',
'  function ts(v varchar2) return timestamp with time zone is',
'  begin',
'    return from_tz(to_timestamp(substr(v, 1, 23), ''YYYY-MM-DD"T"HH24:MI:SS.FF3''), ''UTC'');',
'  end;',
'begin',
'  :P1064_MODE := nvl(:P1064_MODE, ''VIEW'');',
'  select * into mc from SPD_MONITORING_CONFIG where ID = :P1064_MC and NIT_COMPANIA = :G_NIT_COMPANIA;',
'  :P1064_ORIGIN := mc.MONITORING_RESOURCES_ORIGIN;',
'  :P1064_SGP_DISC := mc.SGP_DISCRIMINATED;',
'  :P1064_SUPPORT_PI := mc.SUPPORT_PRODUCT_MONITORING;',
'  :P1064_SUBPERIOD := mc.SUBPERIOD;',
'  l_window := case :P1064_MODE when ''REPORT'' then ''reporting'' when ''VALIDATE'' then ''validating'' when ''REVIEW'' then ''reviewing'' end;',
'  :P1064_DATE_OK := ''N'';',
'  if l_window is not null then',
'    begin',
'      if systimestamp between ts(case l_window when ''reporting'' then json_value(mc.DATES_CONFIG, ''$.reporting[0]'') when ''validating'' then json_value(mc.DATES_CONFIG, ''$.validating[0]'') when ''reviewing'' then json_value(mc.DATES_CONFIG, ''$.reviewing[0]'
||''') end)',
'                          and ts(case l_window when ''reporting'' then json_value(mc.DATES_CONFIG, ''$.reporting[1]'') when ''validating'' then json_value(mc.DATES_CONFIG, ''$.validating[1]'') when ''reviewing'' then json_value(mc.DATES_CONFIG, ''$.reviewing[1]'
||''') end) then',
'        :P1064_DATE_OK := ''S'';',
'      end if;',
'    exception when others then null;',
'    end;',
'  end if;',
'  select max(u.ID), max(e.SPD_PRESUPUESTO_MANUAL) into :P1064_USER_ID, :P1064_MANUAL_BUDGET',
'    from USUARIOS u',
'    left join ENTIDADES_PRY e on e.NIT_COMPANIA = u.NIT_COMPANIA and e.CODIGO_ENT_PRY = u.CODIGO_ENT_PRY',
'   where u.NIT_COMPANIA = :G_NIT_COMPANIA and (upper(u.USUARIO) = upper(:APP_USER) or upper(u.EMAIL) = upper(:APP_USER));',
'',
'  select max(MONITORING_RECORD_ID), max(RECORD_STATUS), max(GOAL_TYPE),',
'         max(case :P1064_MODE when ''REPORT'' then REPORT_STATUS when ''VALIDATE'' then VALIDATION_STATUS else REVIEW_STATUS end)',
'    into :P1064_REC_ID, :P1064_RECORD_STATUS, :P1064_GOAL_TYPE, :P1064_STATUS',
'    from V_SPD_GOAL_MONITORING',
'   where NIT_COMPANIA = :G_NIT_COMPANIA and MONITORING_CONFIG_ID = mc.ID and GOAL_ID = :P1064_GOAL_ID;',
'',
'  :P1064_EDITABLE := case',
'    when :P1064_REC_ID is null or :P1064_DATE_OK <> ''S'' then ''N''',
'    when :P1064_MODE = ''REPORT''   and :P1064_RECORD_STATUS not in (''VALIDATED'', ''REVIEWED'', ''APPROVED'') then ''S''',
'    when :P1064_MODE = ''VALIDATE'' and :P1064_RECORD_STATUS not in (''REVIEWED'', ''APPROVED'') then ''S''',
'    when :P1064_MODE = ''REVIEW'' then ''S''',
'    else ''N'' end;',
unistr('  -- en la revisi\00F3n solo se decide; los datos del reporte quedan de solo lectura'),
'  :P1064_DATA_EDITABLE := case when :P1064_EDITABLE = ''S'' and :P1064_MODE in (''REPORT'', ''VALIDATE'') then ''S'' else ''N'' end;',
'  :P1064_VALIDATED := case when :P1064_RECORD_STATUS in (''VALIDATED'', ''REVIEWED'', ''APPROVED'') then ''VALIDATED'' else ''REPORTED'' end;',
'  :P1064_REVIEWED := case when :P1064_RECORD_STATUS = ''REJECTED'' then ''REJECTED'' else ''REVIEWED'' end;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>3690581211607315
);
wwv_flow_imp.component_end;
end;
/
