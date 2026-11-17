prompt --application/pages/page_01052
begin
--   Manifest
--     PAGE: 01052
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
 p_id=>1052
,p_name=>'SPD_Asistente'
,p_alias=>'SPD_ASISTENTE'
,p_step_title=>'Asistente'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40778204066163588)
,p_plug_name=>'Asistente de Seguimiento'
,p_plug_template=>wwv_flow_imp.id(39534998195162909)
,p_plug_display_sequence=>10
,p_plug_source=>unistr('<div class="t-Alert t-Alert--colorBG t-Alert--horizontal t-Alert--info"><div class="t-Alert-wrap"><div class="t-Alert-content"><div class="t-Alert-body">Seleccione la acci\00F3n que desea realizar para abrir un asistente que lo guiar\00E1 paso a paso. Aqu\00ED e')
||unistr('ncontrar\00E1 las opciones m\00E1s comunes para comenzar.</div></div></div></div><ul class="t-MediaList t-MediaList--cols t-MediaList--2cols t-MediaList--showIcons t-MediaList--showDesc"><li class="t-MediaList-item"><a href="f?p=&APP_ID.:1006:&SESSION.:" cla')
||'ss="t-MediaList-itemWrap"><div class="t-MediaList-iconWrap" aria-hidden="true"><span class="t-MediaList-icon u-color"><span class="t-Icon fa fa-plus-circle"></span></span></div><div class="t-MediaList-body"><h3 class="t-MediaList-title">Crear un nuev'
||unistr('o plan de desarrollo</h3><p class="t-MediaList-desc">Un nuevo plan de desarrollo ha sido aprobado? Use este asistente para crear el plan de desarrollo con su informaci\00F3n b\00E1sica y adicione cada uno de los niveles del mismo.</p></div></a></li><li class')
||unistr('="t-MediaList-item"><a href="f?p=&APP_ID.:EN-CONSTRUCCION:&SESSION.:Asistente \203A Copiar niveles de un plan de desarrollo" class="t-MediaList-itemWrap"><div class="t-MediaList-iconWrap" aria-hidden="true"><span class="t-MediaList-icon u-color"><span cl')
||'ass="t-Icon fa fa-copy"></span></span></div><div class="t-MediaList-body"><h3 class="t-MediaList-title">Copiar niveles de un plan de desarrollo</h3><p class="t-MediaList-desc">Si ya ha creado los diferentes niveles del plan de desarrollo en SIIF, pue'
||unistr('de utilizar esta opci\00F3n para copiarlos.</p></div></a></li><li class="t-MediaList-item"><a href="f?p=&APP_ID.:EN-CONSTRUCCION:&SESSION.:Asistente \203A Copiar cat\00E1logo de metas" class="t-MediaList-itemWrap"><div class="t-MediaList-iconWrap" aria-hidden="t')
||unistr('rue"><span class="t-MediaList-icon u-color"><span class="t-Icon fa fa-copy"></span></span></div><div class="t-MediaList-body"><h3 class="t-MediaList-title">Copiar cat\00E1logo de metas</h3><p class="t-MediaList-desc">Si ya ha creado las metas del plan de')
||unistr(' desarrollo en SIIF, puede utilizar esta opci\00F3n para copiarlas.</p></div></a></li><li class="t-MediaList-item"><a href="f?p=&APP_ID.:1045:&SESSION.:" class="t-MediaList-itemWrap"><div class="t-MediaList-iconWrap" aria-hidden="true"><span class="t-Med')
||unistr('iaList-icon u-color"><span class="t-Icon fa fa-play-circle"></span></span></div><div class="t-MediaList-body"><h3 class="t-MediaList-title">Iniciar un seguimiento</h3><p class="t-MediaList-desc">Se acerca un nuevo seguimiento? Cree y active los par\00E1m')
||unistr('etros de seguimiento, verifique que se cuenta con la informaci\00F3n b\00E1sica necesaria antes de habilitar el reporte de cada entidad.</p></div></a></li><li class="t-MediaList-item"><a href="f?p=&APP_ID.:1031:&SESSION.:" class="t-MediaList-itemWrap"><div c')
||'lass="t-MediaList-iconWrap" aria-hidden="true"><span class="t-MediaList-icon u-color"><span class="t-Icon fa fa-check-square-o"></span></span></div><div class="t-MediaList-body"><h3 class="t-MediaList-title">Reportar seguimiento</h3><p class="t-Media'
||unistr('List-desc">Informe sobre el progreso de las metas, proyectos y planes de acci\00F3n que corresponden a su secretar\00EDa.</p></div></a></li></ul>')
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp.component_end;
end;
/
