prompt --application/shared_components/navigation/lists/menu_de_navegacion
begin
--   Manifest
--     LIST: Menu de Navegacion
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>106
,p_default_id_offset=>30000697869459781
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(56130488155640086)
,p_name=>'Menu de Navegacion'
,p_list_status=>'PUBLIC'
,p_version_scn=>39302982034
,p_updated_on=>wwv_flow_imp.dz('20260529205646Z')
,p_updated_by=>'JUANVVE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(56142285138640133)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Inicio'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp.component_end;
end;
/
