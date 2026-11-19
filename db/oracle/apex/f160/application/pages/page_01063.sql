prompt --application/pages/page_01063
begin
--   Manifest
--     PAGE: 01063
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
 p_id=>1063
,p_name=>unistr('SPD_Programaci\00F3n de la meta')
,p_alias=>'SPD_PROGRAMAR_META'
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Programaci\00F3n')
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'function spdNum(v) { v = (v || "").replace(/\./g, "").replace(",", "."); var n = parseFloat(v); return isNaN(n) ? 0 : n; }',
'function spdFmt(n) { return n.toLocaleString("es-CO", {maximumFractionDigits: 2}); }',
'// totales por columna (y SGP = suma de las fuentes SGP cuando el seguimiento las discrimina)',
'function spdTotals() {',
'  ["u", "f"].forEach(function (c) {',
'    if ($(".spd-sgp-sub ." + c + "-res").length && $("#spd_sgp_disc").val() === "S") {',
'      var s = 0; $(".spd-sgp-sub ." + c + "-res").each(function () { s += spdNum(this.value); });',
'      $("#" + c + "_SGP").val(spdFmt(s));',
'    }',
'    var t = 0; $("tr:not(.spd-sgp-sub) ." + c + "-res").each(function () { t += spdNum(this.value); });',
'    $("#" + c + "_TOTAL").val(spdFmt(t));',
'  });',
'}',
'$(document).on("change keyup", ".u-res,.f-res", spdTotals);',
'// meses: el inicial no puede ser mayor que el final',
'$(document).on("change", "#spd_from", function () { if (+this.value > +$("#spd_to").val()) $("#spd_to").val(this.value); });',
'$(document).on("change", "#spd_to", function () { if (+$("#spd_from").val() > +this.value) $("#spd_from").val(this.value); });',
'$(document).on("click", ".spd-sgp-toggle", function () { $(".spd-sgp-sub").toggle(); $(this).toggleClass("fa-chevron-down fa-chevron-up"); });'))
,p_javascript_code_onload=>'spdTotals();'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'.spd-badge{display:inline-block;min-width:20px;padding:0 6px;margin-left:6px;border-radius:10px;font-size:11px;line-height:18px;color:#fff;text-align:center;background:#1677ff;vertical-align:middle}',
'.spd-badge--PRODUCT{background:#9FD912}.spd-badge--RESULT,.spd-badge--WELL_BEING,.spd-badge--IMPACT{background:#52c41a}',
'.spd-badge--ACTIVITY{background:#1677ff}.spd-badge--PROJECT{background:green}.spd-badge--ACTION_PLAN{background:blueviolet}.spd-badge--ACTION_PLAN_ACTIVITY{background:orange}',
'.spd-st{display:inline-flex;align-items:center;justify-content:center;width:30px;height:30px;border-radius:50%;font-size:15px;border:1px solid transparent}',
'.spd-st--NEW{color:#0f1129;border-color:#0f1129}',
'.spd-st--SCH{color:#008000;border-color:#008000;background:rgba(0,128,0,.15)}',
'.spd-st--PAR{color:#f99c07;border-color:#f99c07;background:rgba(249,156,7,.15)}',
'.spd-st--REP{color:#008000;background:rgba(0,128,0,.15)}',
'.spd-st--VAL{color:#008000;border-color:#008000}',
'.spd-st--REV{color:#008000;border-color:#008000;background:rgba(0,128,0,.4)}',
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
'.spd-scroll{max-height:75vh;overflow:auto}',
'.spd-scroll .spd-tbl th{position:sticky;top:0;z-index:1}',
'.spd-tbl th{background:#fafafa;padding:8px;text-align:left;border-bottom:1px solid #f0f0f0}',
'.spd-tbl td{padding:8px;border-bottom:1px solid #f0f0f0;vertical-align:top}',
'.spd-empty{padding:24px;text-align:center;color:rgba(0,0,0,.35)}',
'.spd-empty .fa{font-size:32px;display:block;margin-bottom:6px}',
'.spd-form{border-collapse:separate;border-spacing:0 8px;width:100%}',
'.spd-form th{text-align:left;font-weight:normal;padding-right:16px;white-space:nowrap;width:1%}',
'.spd-form th:after{content:":"}',
'.spd-form th.spd-noc:after{content:""}',
'.spd-form td{padding-right:10px}',
'.spd-form input,.spd-form select{height:32px;border:1px solid #d9d9d9;border-radius:6px;padding:0 8px}',
'.spd-form input[disabled],.spd-form select[disabled],.spd-form input[readonly]{background:#f5f5f5;color:rgba(0,0,0,.45)}',
'.spd-num{width:170px;text-align:right}.spd-num--sm{width:70px}.spd-sel{width:200px}',
'.spd-money{width:100%;min-width:110px;max-width:240px;text-align:right}',
'.spd-colhead{text-align:center;font-weight:bold;font-size:15px}',
'.spd-total th{font-weight:bold;font-size:15px}',
'.spd-sgp-sub th{padding-left:28px}',
'.spd-sgp-toggle{cursor:pointer;margin-right:6px}',
'.spd-btns{text-align:center;margin-top:16px}',
'.spd-hist{list-style:none;margin:0;padding:0}',
'.spd-hist li{display:flex;gap:16px;padding:12px 0;border-bottom:1px solid #f0f0f0}',
'.spd-avatar{flex:none;width:32px;height:32px;border-radius:50%;background:#87d068;color:#fff;display:flex;align-items:center;justify-content:center}',
'.spd-hist-title{font-weight:500}.spd-hist-desc{color:rgba(0,0,0,.45)}'))
,p_step_template=>wwv_flow_imp.id(39430577226162891)
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'960'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1825925773136878)
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
 p_id=>wwv_flow_imp.id(1827760262136879)
,p_plug_name=>unistr('Programaci\00F3n')
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(39530989314162909)
,p_plug_display_sequence=>10
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1827802742136879)
,p_plug_name=>unistr('Datos Programaci\00F3n')
,p_parent_plug_id=>wwv_flow_imp.id(1827760262136879)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l      clob;',
'  dis    varchar2(20) := case when :P1063_EDITABLE = ''S'' then null else '' disabled'' end;',
'  lvl_lbl varchar2(200);',
'  type t_res is table of varchar2(30);',
'  f  t_res := t_res(''RP'', ''SGP'', ''SGP_EDUCATION'', ''SGP_HEALTH'', ''SGP_WATER'', ''SGP_CULTURE'', ''SGP_SPORT'', ''SGP_FREE_INVESTMENT'',',
'                    ''SGP_FREE_DESTINATION'', ''SGP_SCHOOL_FEEDING'', ''SGP_MAGDALENA_RIVER'', ''SGP_EARLY_CHILDHOOD'',',
'                    ''CN'', ''CD'', ''SGR'', ''CREDIT'', ''OTHERS'', ''MANAGEMENT'', ''OPERATION'');',
unistr('  lb t_res := t_res(''Recursos Propios'', ''Recursos SGP'', ''Educaci\00F3n'', ''Salud'', ''Agua Potable'', ''Cultura'', ''Deporte'', ''Libre Inversi\00F3n'','),
unistr('                    ''Libre Destinaci\00F3n'', ''Alimentaci\00F3n Escolar'', ''R\00EDo Magdalena'', ''Primera Infancia'','),
unistr('                    ''Recursos CN'', ''Recursos CD'', ''Recursos SGR'', ''Recursos Cr\00E9dito'', ''Otros Recursos'', ''Recursos Gesti\00F3n'','),
'                    ''Recursos Funcionamiento'');',
'  ru  SPD_MONITORING_RECORD_RESOURCE%rowtype;',
'  rf  SPD_MONITORING_RECORD_RESOURCE%rowtype;',
'  rec SPD_MONITORING_RECORD%rowtype;',
'  show_u boolean := :P1063_ORIGIN in (''USER'', ''USER_AND_FINANCIAL'');',
'  show_f boolean := :P1063_ORIGIN in (''FINANCIAL'', ''USER_AND_FINANCIAL'');',
'  sgp_disc boolean := :P1063_SGP_DISC = ''S'';',
'  procedure add(p varchar2) is begin l := l || p; end;',
'',
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
'  function val(r SPD_MONITORING_RECORD_RESOURCE%rowtype, c varchar2) return number is',
'  begin',
'    return case c when ''RP'' then r.RP when ''SGP'' then r.SGP when ''SGP_EDUCATION'' then r.SGP_EDUCATION',
'      when ''SGP_HEALTH'' then r.SGP_HEALTH when ''SGP_WATER'' then r.SGP_WATER when ''SGP_CULTURE'' then r.SGP_CULTURE',
'      when ''SGP_SPORT'' then r.SGP_SPORT when ''SGP_FREE_INVESTMENT'' then r.SGP_FREE_INVESTMENT',
'      when ''SGP_FREE_DESTINATION'' then r.SGP_FREE_DESTINATION when ''SGP_SCHOOL_FEEDING'' then r.SGP_SCHOOL_FEEDING',
'      when ''SGP_MAGDALENA_RIVER'' then r.SGP_MAGDALENA_RIVER when ''SGP_EARLY_CHILDHOOD'' then r.SGP_EARLY_CHILDHOOD',
'      when ''CN'' then r.CN when ''CD'' then r.CD when ''SGR'' then r.SGR when ''CREDIT'' then r.CREDIT when ''OTHERS'' then r.OTHERS',
'      when ''MANAGEMENT'' then r.MANAGEMENT when ''OPERATION'' then r.OPERATION end;',
'  end;',
'  function money(p_idx number, p_col varchar2, p_field varchar2, p_value number, p_disabled varchar2) return varchar2 is',
'  begin',
'    return ''<td><input type="text" name="f'' || lpad(p_idx, 2, ''0'') || ''" id="'' || p_col || ''_'' || p_field || ''" class="spd-money ''',
'      || p_col || ''-res" value="'' || fmt(p_value) || ''" placeholder="$"'' || p_disabled || ''></td>'';',
'  end;',
'  function months(p_idx number, p_id varchar2, p_value number) return varchar2 is',
'    s varchar2(4000) := ''<select name="f'' || lpad(p_idx, 2, ''0'') || ''" id="'' || p_id || ''" class="spd-sel"'' || dis || ''><option value=""></option>'';',
'  begin',
'    for m in 1 .. 12 loop',
'      s := s || ''<option value="'' || m || ''"'' || case when m = p_value then '' selected'' end || ''>''',
'        || initcap(to_char(to_date(m, ''MM''), ''FMMonth'', ''NLS_DATE_LANGUAGE=SPANISH'')) || ''</option>'';',
'    end loop;',
'    return s || ''</select>'';',
'  end;',
'begin',
'  if :P1063_REC_ID is not null then',
'    select * into rec from SPD_MONITORING_RECORD where ID = :P1063_REC_ID;',
'    for x in (select * from SPD_MONITORING_RECORD_RESOURCE where MONITORING_RECORD_ID = rec.ID) loop',
'      if x.RESOURCE_TYPE = ''MANUAL'' then ru := x; elsif x.RESOURCE_TYPE = ''DEFINITIVE'' then rf := x; end if;',
'    end loop;',
'  end if;',
'',
'  -- resumen de la meta (GoalSummary) y actividades (GoalActivities)',
'  for g in (select g.*, e.CODIGO_ENT_PRY, e.NOMBRE_ENT_PRY, dl.CODE as L_CODE, dl.NAME as L_NAME,',
'                   (select u.NOMBRE_UNIDAD from UNIDADES_PRY u where u.NIT_COMPANIA = g.NIT_COMPANIA and u.CODIGO_UND = g.UNIT_CODE) as UNITS_NAME,',
'                   (select c.SINGULAR_NAME from V_SPD_PLAN_LEVEL_CONFIG c',
'                     where c.NIT_COMPANIA = g.NIT_COMPANIA and c.PLAN = g.PLAN and c.NUM = dl."LEVEL") as LEVEL_LABEL',
'              from SPD_GOAL g',
'              left join ENTIDADES_PRY e on e.ID = g.ENTITY_ID',
'              left join SPD_DEV_PLAN_LEVEL dl on dl.ID = g.DEV_PLAN_LEVEL_ID',
'             where g.ID = :P1063_GOAL_ID) loop',
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
'  if :P1063_GOAL_TYPE in (''PRODUCT'', ''RESULT'', ''IMPACT'', ''WELL_BEING'') then',
'  add(''<details class="spd-collapse"><summary><b>Actividades</b></summary><div>'');',
'  declare',
'    n pls_integer := 0;',
unistr('    a clob := ''<table class="spd-tbl"><tr><th>Proyecto</th><th>Actividad</th><th style="text-align:right">Ponderaci\00F3n</th></tr>'';'),
'  begin',
'    for x in (select PROYECTO, CODIGO_ACT, WEIGHTING from SPD_ACTIVITY_GOAL where GOAL_ID = :P1063_GOAL_ID order by PROYECTO, CODIGO_ACT) loop',
'      n := n + 1;',
'      a := a || to_char(''<tr><td>'' || x.PROYECTO || ''</td><td>'' || x.CODIGO_ACT || ''</td><td style="text-align:right">'' || fmt(x.WEIGHTING) || ''</td></tr>'');',
'    end loop;',
'    if n = 0 then',
'      add(''<div class="spd-empty"><span class="fa fa-inbox"></span>No hay datos</div>'');',
'    else',
'      l := l || a;',
'      add(''</table>'');',
'    end if;',
'    add(''</div></details>'');',
'  end;',
'  end if;',
'',
unistr('  -- programaci\00F3n (GoalScheduleCol + GoalScheduleResourcesCol)'),
'  add(''<input type="hidden" id="spd_sgp_disc" value="'' || :P1063_SGP_DISC || ''"><table class="spd-form">'');',
'  if :P1063_GOAL_TYPE not in (''PROJECT'', ''ACTION_PLAN'') then',
unistr('    add(''<tr><th>Programaci\00F3n Meta</th><td colspan="2"><input type="text" name="f01" class="spd-num" value="'''),
'      || fmt(rec.GOAL_VALUE) || ''"'' || dis || ''></td></tr>'');',
'  end if;',
'  if :P1063_SUPPORT_PI = ''S'' then',
unistr('    add(''<tr><th>Programaci\00F3n Indicador Producto</th><td colspan="2"><input type="text" name="f02" class="spd-num" value="'''),
'      || fmt(rec.PI_GOAL_VALUE) || ''"'' || dis || ''></td></tr>'');',
'  end if;',
unistr('  add(''<tr><th>Ponderaci\00F3n</th><td colspan="2"><input type="text" name="f03" class="spd-num spd-num--sm" value="'''),
'    || fmt(rec.WEIGHTING) || ''"'' || case when :P1063_WEIGHT_TYPE = ''FINANCIAL'' then '' disabled'' else dis end || ''></td></tr>''',
'    || ''<tr><th>Mes inicial</th><td colspan="2">'' || months(4, ''spd_from'', rec.FROM_MONTH) || ''</td></tr>''',
'    || ''<tr><th>Mes final</th><td colspan="2">'' || months(5, ''spd_to'', rec.TO_MONTH) || ''</td></tr>''',
'    || ''<tr><th>Origen Datos Financieros</th>''',
unistr('    || case when show_u then ''<td class="spd-colhead">Programaci\00F3n</td>'' end'),
'    || case when show_f then ''<td class="spd-colhead">Apropiado</td>'' end || ''</tr>'');',
'  for i in 1 .. f.count loop',
'    add(''<tr'' || case when f(i) like ''SGP\_%'' escape ''\'' then '' class="spd-sgp-sub" style="display:none"'' end || ''><th''',
'      || case when f(i) = ''SGP'' and sgp_disc then '' class="spd-noc"'' end || ''>''',
'      || case when f(i) = ''SGP'' and sgp_disc then ''<span class="fa fa-chevron-down spd-sgp-toggle"></span><b>'' || lb(i) || ''</b>''',
'              else lb(i) end || ''</th>''',
'      || case when show_u then money(6, ''u'', f(i), val(ru, f(i)),',
'                                     case when f(i) = ''SGP'' and sgp_disc then '' readonly'' else dis end) end',
'      || case when show_f then money(7, ''f'', f(i), val(rf, f(i)),',
'                                     case when :P1063_MANUAL_BUDGET = ''S'' and dis is null',
'                                          then case when f(i) = ''SGP'' and sgp_disc then '' readonly'' end else '' disabled'' end) end',
'      || ''</tr>'');',
'  end loop;',
'  add(''<tr class="spd-total"><th class="spd-noc">Total Recursos:</th>''',
'    || case when show_u then ''<td><input type="text" id="u_TOTAL" class="spd-money" placeholder="$" disabled></td>'' end',
'    || case when show_f then ''<td><input type="text" id="f_TOTAL" class="spd-money" placeholder="$" disabled></td>'' end',
'    || ''</tr></table>'');',
'  return l;',
'end;'))
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1827994140136879)
,p_plug_name=>'Historial'
,p_parent_plug_id=>wwv_flow_imp.id(1827760262136879)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(39544800752162911)
,p_plug_display_sequence=>20
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
'             where h.GOAL_ID = :P1063_GOAL_ID and (r.ID is null or r.MONITORING_CONFIG_ID = :P1063_MC)',
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
 p_id=>wwv_flow_imp.id(1828091734136879)
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
 p_id=>wwv_flow_imp.id(1828167994136879)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(1828091734136879)
,p_button_name=>'VOLVER'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(39601281081162925)
,p_button_image_alt=>'Volver'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(1828298925136880)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(1828091734136879)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(39601281081162925)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Guardar'
,p_button_position=>'NEXT'
,p_button_condition=>'P1063_EDITABLE'
,p_button_condition2=>'S'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1826084384136878)
,p_name=>'P1063_MC'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'MC'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1826116598136878)
,p_name=>'P1063_GOAL_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'GOAL_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1826275264136878)
,p_name=>'P1063_NODE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'NODE'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1826387216136878)
,p_name=>'P1063_NODE_NAME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'NODE_NAME'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1826472636136878)
,p_name=>'P1063_TOTAL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'TOTAL'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1826579404136878)
,p_name=>'P1063_PLAN'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'PLAN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1826677343136878)
,p_name=>'P1063_ORIGIN'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'ORIGIN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1826781620136878)
,p_name=>'P1063_WEIGHT_TYPE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'WEIGHT_TYPE'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1826834047136878)
,p_name=>'P1063_SGP_DISC'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'SGP_DISC'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1826911785136878)
,p_name=>'P1063_SUPPORT_PI'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'SUPPORT_PI'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1827031780136878)
,p_name=>'P1063_DATE_OK'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'DATE_OK'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1827196906136878)
,p_name=>'P1063_MANUAL_BUDGET'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'MANUAL_BUDGET'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1827269942136878)
,p_name=>'P1063_EDITABLE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'EDITABLE'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1827378119136878)
,p_name=>'P1063_REC_ID'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'REC_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1827402248136879)
,p_name=>'P1063_STATUS'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'STATUS'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1827509662136879)
,p_name=>'P1063_GOAL_TYPE'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'GOAL_TYPE'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1827674235136879)
,p_name=>'P1063_USER_ID'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(1825925773136878)
,p_prompt=>'USER_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>30
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1828302700136880)
,p_name=>'Volver'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(1828167994136879)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1828434325136880)
,p_event_id=>wwv_flow_imp.id(1828302700136880)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(1828697045136880)
,p_process_sequence=>190
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Guardar programaci\00F3n')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  mc     SPD_MONITORING_CONFIG%rowtype;',
'  l_rec  number := :P1063_REC_ID;',
'  l_status varchar2(30);',
'  l_type varchar2(30);',
'  v1 number; v2 number; v3 number; v4 number; v5 number;',
'  h1 varchar2(1); h2 varchar2(1); h3 varchar2(1); h4 varchar2(1); h5 varchar2(1);',
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
'  function arr(p apex_application_global.vc_arr2, i pls_integer) return number is',
'  begin',
'    return case when p.exists(i) then nvl(num(p(i)), 0) else 0 end;',
'  end;',
'  procedure save_res(p_type varchar2, p apex_application_global.vc_arr2) is',
'    v  apex_t_number := apex_t_number();',
'    l_sgp number;',
'  begin',
'    if p.count = 0 then return; end if;   -- columna no visible o deshabilitada',
'    v.extend(f.count);',
'    for i in 1 .. f.count loop v(i) := arr(p, i); end loop;',
'    l_sgp := case when mc.SGP_DISCRIMINATED = ''S'' then v(3) + v(4) + v(5) + v(6) + v(7) + v(8) + v(9) + v(10) + v(11) + v(12) else v(2) end;',
'    merge into SPD_MONITORING_RECORD_RESOURCE t',
'    using (select l_rec as MONITORING_RECORD_ID, p_type as RESOURCE_TYPE from dual) s',
'       on (t.MONITORING_RECORD_ID = s.MONITORING_RECORD_ID and t.RESOURCE_TYPE = s.RESOURCE_TYPE)',
'     when matched then update set RP = v(1), SGP = l_sgp, SGP_EDUCATION = v(3), SGP_HEALTH = v(4), SGP_WATER = v(5),',
'          SGP_CULTURE = v(6), SGP_SPORT = v(7), SGP_FREE_INVESTMENT = v(8), SGP_FREE_DESTINATION = v(9),',
'          SGP_SCHOOL_FEEDING = v(10), SGP_MAGDALENA_RIVER = v(11), SGP_EARLY_CHILDHOOD = v(12), CN = v(13), CD = v(14),',
'          SGR = v(15), CREDIT = v(16), OTHERS = v(17), MANAGEMENT = v(18), OPERATION = v(19),',
'          UPDATED_AT = systimestamp, UPDATED_BY = :P1063_USER_ID',
'     when not matched then insert (MONITORING_RECORD_ID, RESOURCE_TYPE, RP, SGP, SGP_EDUCATION, SGP_HEALTH, SGP_WATER,',
'          SGP_CULTURE, SGP_SPORT, SGP_FREE_INVESTMENT, SGP_FREE_DESTINATION, SGP_SCHOOL_FEEDING, SGP_MAGDALENA_RIVER,',
'          SGP_EARLY_CHILDHOOD, CN, CD, SGR, CREDIT, OTHERS, MANAGEMENT, OPERATION, CREATED_BY)',
'          values (l_rec, p_type, v(1), l_sgp, v(3), v(4), v(5), v(6), v(7), v(8), v(9), v(10), v(11), v(12), v(13), v(14),',
'                  v(15), v(16), v(17), v(18), v(19), :P1063_USER_ID);',
'  end;',
'begin',
'  select * into mc from SPD_MONITORING_CONFIG where ID = :P1063_MC and NIT_COMPANIA = :G_NIT_COMPANIA;',
'  -- se vuelve a validar en el servidor (fechas y estado)',
'  select max(SCHEDULE_STATUS), max(GOAL_TYPE), max(MONITORING_RECORD_ID) into l_status, l_type, l_rec',
'    from V_SPD_GOAL_MONITORING where MONITORING_CONFIG_ID = mc.ID and GOAL_ID = :P1063_GOAL_ID and GOAL_GROUP = nvl('''', GOAL_GROUP);',
'  -- la ventana de fechas se recalcula al guardar: no se usa el valor calculado al abrir el formulario',
'  begin',
'    select case when systimestamp between from_tz(to_timestamp(substr(case ''scheduling'' when ''scheduling'' then json_value(mc.DATES_CONFIG, ''$.scheduling[0]'') when ''reporting'' then json_value(mc.DATES_CONFIG, ''$.reporting[0]'') when ''validating'' then j'
||'son_value(mc.DATES_CONFIG, ''$.validating[0]'') when ''reviewing'' then json_value(mc.DATES_CONFIG, ''$.reviewing[0]'') end, 1, 23), ''YYYY-MM-DD"T"HH24:MI:SS.FF3''), ''UTC'')',
'                                      and from_tz(to_timestamp(substr(case ''scheduling'' when ''scheduling'' then json_value(mc.DATES_CONFIG, ''$.scheduling[1]'') when ''reporting'' then json_value(mc.DATES_CONFIG, ''$.reporting[1]'') when ''validating'' then j'
||'son_value(mc.DATES_CONFIG, ''$.validating[1]'') when ''reviewing'' then json_value(mc.DATES_CONFIG, ''$.reviewing[1]'') end, 1, 23), ''YYYY-MM-DD"T"HH24:MI:SS.FF3''), ''UTC'')',
'                then ''S'' else ''N'' end into :P1063_DATE_OK from dual;',
'  exception when others then :P1063_DATE_OK := ''N'';',
'  end;',
'  if :P1063_DATE_OK <> ''S'' then',
unistr('    raise_application_error(-20001, ''El seguimiento no est\00E1 en fechas de programaci\00F3n.'');'),
'  elsif l_status in (''Validada'', ''Revisada'') or l_type = ''ACTION_PLAN'' then',
unistr('    raise_application_error(-20001, ''La meta est\00E1 '' || lower(l_status) || '': no se puede modificar su programaci\00F3n.'');'),
'  end if;',
'',
'  -- valores del formulario (un campo deshabilitado no llega: se conserva el valor guardado)',
'  if apex_application.g_f01.exists(1) then h1 := ''S''; v1 := num(apex_application.g_f01(1)); end if;',
'  if apex_application.g_f02.exists(1) then h2 := ''S''; v2 := num(apex_application.g_f02(1)); end if;',
'  if apex_application.g_f03.exists(1) then h3 := ''S''; v3 := num(apex_application.g_f03(1)); end if;',
'  if apex_application.g_f04.exists(1) then h4 := ''S''; v4 := num(apex_application.g_f04(1)); end if;',
'  if apex_application.g_f05.exists(1) then h5 := ''S''; v5 := num(apex_application.g_f05(1)); end if;',
'',
'  if l_rec is null then',
'    insert into SPD_MONITORING_RECORD (MONITORING_CONFIG_ID, GOAL_ID, PERIOD, GOAL_VALUE, PI_GOAL_VALUE, WEIGHTING,',
'           FROM_MONTH, TO_MONTH, RECORD_STATUS, CREATED_BY, UPDATED_BY)',
'    values (mc.ID, :P1063_GOAL_ID, mc.PERIOD,',
'            v1,',
'            v2,',
'            v3,',
'            v4,',
'            v5,',
'            ''PLANNED'', :P1063_USER_ID, :P1063_USER_ID)',
'    returning ID into l_rec;',
'  else',
'    update SPD_MONITORING_RECORD',
'       set GOAL_VALUE    = case when h1 = ''S'' then v1 else GOAL_VALUE end,',
'           PI_GOAL_VALUE = case when h2 = ''S'' then v2 else PI_GOAL_VALUE end,',
'           WEIGHTING     = case when h3 = ''S'' then v3 else WEIGHTING end,',
'           FROM_MONTH    = case when h4 = ''S'' then v4 else FROM_MONTH end,',
'           TO_MONTH      = case when h5 = ''S'' then v5 else TO_MONTH end,',
'           RECORD_STATUS = ''PLANNED'', UPDATED_AT = systimestamp, UPDATED_BY = :P1063_USER_ID',
'     where ID = l_rec;',
'  end if;',
'',
'  -- recursos: solo si el seguimiento admite recursos del usuario (supportUserResources)',
'  if mc.MONITORING_RESOURCES_ORIGIN in (''USER'', ''USER_AND_FINANCIAL'') then',
'    save_res(''MANUAL'', apex_application.g_f06);',
'    save_res(''DEFINITIVE'', apex_application.g_f07);   -- solo llega si la entidad tiene presupuesto manual',
'  end if;',
'',
'  insert into SPD_GOAL_HISTORY (GOAL_ID, MONITORING_RECORD_ID, EVENT, DESCRIPTION, CREATED_BY)',
unistr('  values (:P1063_GOAL_ID, l_rec, ''SCHEDULED'', ''Programaci\00F3n actualizada por el usuario'', :P1063_USER_ID);'),
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>unistr('Programaci\00F3n guardada')
,p_internal_uid=>1828697045136880
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(1828790484136880)
,p_process_sequence=>200
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>unistr('Cerrar di\00E1logo')
,p_process_when=>'SAVE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>unistr('Programaci\00F3n guardada')
,p_internal_uid=>1828790484136880
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(1828563154136880)
,p_process_sequence=>180
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Cargar programaci\00F3n')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  mc SPD_MONITORING_CONFIG%rowtype;',
'  function ts(v varchar2) return timestamp with time zone is',
'  begin',
'    return from_tz(to_timestamp(substr(v, 1, 23), ''YYYY-MM-DD"T"HH24:MI:SS.FF3''), ''UTC'');',
'  end;',
'begin',
'  if :P1063_MC is null then',
'    select max(ID) keep (dense_rank first order by case when IS_ACTIVE = ''S'' then 0 else 1 end, PERIOD desc, SUBPERIOD desc)',
'      into :P1063_MC from SPD_MONITORING_CONFIG',
'     where NIT_COMPANIA = :G_NIT_COMPANIA and nvl(USED_FOR, ''DEVELOPMENT_PLANS'') = ''DEVELOPMENT_PLANS'';',
'  end if;',
'  begin',
'    select * into mc from SPD_MONITORING_CONFIG where ID = :P1063_MC and NIT_COMPANIA = :G_NIT_COMPANIA;',
'  exception when no_data_found then',
'    :P1063_MC := null; :P1063_GOAL_ID := null; :P1063_TOTAL := 0; return;',
'  end;',
'  :P1063_PLAN := mc.PLAN;',
'  :P1063_ORIGIN := mc.MONITORING_RESOURCES_ORIGIN;',
'  :P1063_WEIGHT_TYPE := mc.WEIGHTING_TYPE;',
'  :P1063_SGP_DISC := mc.SGP_DISCRIMINATED;',
'  :P1063_SUPPORT_PI := mc.SUPPORT_PRODUCT_MONITORING;',
unistr('  -- ventana de programaci\00F3n (DATES_CONFIG.scheduling = [inicio, fin], en UTC)'),
'  :P1063_DATE_OK := ''N'';',
'  begin',
'    if systimestamp between ts(json_value(mc.DATES_CONFIG, ''$.scheduling[0]''))',
'                        and ts(json_value(mc.DATES_CONFIG, ''$.scheduling[1]'')) then',
'      :P1063_DATE_OK := ''S'';',
'    end if;',
'  exception when others then null;',
'  end;',
'  select count(*) into :P1063_TOTAL from V_SPD_GOAL_MONITORING',
'   where NIT_COMPANIA = :G_NIT_COMPANIA and MONITORING_CONFIG_ID = mc.ID and GOAL_GROUP = nvl('''', GOAL_GROUP);',
'',
'  -- usuario actual (USUARIOS.ID = autor del historial) y presupuesto manual de su entidad',
'  select max(u.ID), max(e.SPD_PRESUPUESTO_MANUAL) into :P1063_USER_ID, :P1063_MANUAL_BUDGET',
'    from USUARIOS u',
'    left join ENTIDADES_PRY e on e.NIT_COMPANIA = u.NIT_COMPANIA and e.CODIGO_ENT_PRY = u.CODIGO_ENT_PRY',
'   where u.NIT_COMPANIA = :G_NIT_COMPANIA and (upper(u.USUARIO) = upper(:APP_USER) or upper(u.EMAIL) = upper(:APP_USER));',
'',
unistr('  -- nodo del \00E1rbol'),
'  :P1063_NODE := nvl(:P1063_NODE, ''0'');',
'  if :P1063_NODE <> ''0'' then',
'    begin',
'      select CODE || '' '' || NAME into :P1063_NODE_NAME from SPD_DEV_PLAN_LEVEL',
'       where ID = :P1063_NODE and NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = mc.PLAN;',
'    exception when no_data_found then :P1063_NODE := ''0'';',
'    end;',
'  end if;',
'  if :P1063_NODE = ''0'' then',
'    select max(NOMBRE) into :P1063_NODE_NAME from PLAN_DESARROLLO where NIT_COMPANIA = :G_NIT_COMPANIA and PLAN = mc.PLAN;',
'  end if;',
'',
'  -- meta seleccionada: estado en este seguimiento y si se puede programar',
'  :P1063_REC_ID := null; :P1063_STATUS := null; :P1063_GOAL_TYPE := null; :P1063_EDITABLE := ''N'';',
'  if :P1063_GOAL_ID is not null then',
'    begin',
'      select MONITORING_RECORD_ID, SCHEDULE_STATUS, GOAL_TYPE into :P1063_REC_ID, :P1063_STATUS, :P1063_GOAL_TYPE',
'        from V_SPD_GOAL_MONITORING',
'       where NIT_COMPANIA = :G_NIT_COMPANIA and MONITORING_CONFIG_ID = mc.ID and GOAL_ID = :P1063_GOAL_ID and GOAL_GROUP = nvl('''', GOAL_GROUP);',
'      :P1063_EDITABLE := case when :P1063_DATE_OK = ''S'' and :P1063_STATUS not in (''Validada'', ''Revisada'')',
'                                and :P1063_GOAL_TYPE <> ''ACTION_PLAN'' then ''S'' else ''N'' end;',
'    exception when no_data_found then :P1063_GOAL_ID := null;',
'    end;',
'  end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>1828563154136880
);
wwv_flow_imp.component_end;
end;
/
