prompt --application/shared_components/navigation/lists/menú_de_navegación
begin
--   Manifest
--     LIST: Menú de Navegación
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>154
,p_default_id_offset=>292021538769791282
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(644151484889067722)
,p_name=>unistr('Men\00FA de Navegaci\00F3n')
,p_list_status=>'PUBLIC'
,p_version_scn=>35446683803
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(644163281872067769)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Inicio'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp.component_end;
end;
/
