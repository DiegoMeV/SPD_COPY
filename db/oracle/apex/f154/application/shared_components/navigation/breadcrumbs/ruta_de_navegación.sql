prompt --application/shared_components/navigation/breadcrumbs/ruta_de_navegación
begin
--   Manifest
--     MENU: Ruta de Navegación
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>154
,p_default_id_offset=>292021538769791282
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_menu(
 p_id=>wwv_flow_imp.id(644150990606067719)
,p_name=>unistr('Ruta de Navegaci\00F3n')
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(644151143177067720)
,p_short_name=>'Inicio'
,p_link=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>1
);
wwv_flow_imp.component_end;
end;
/
