prompt --application/shared_components/navigation/lists/menú_de_navegación
begin
--   Manifest
--     LIST: Menú de Navegación
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>4267703994621115
,p_default_application_id=>160
,p_default_id_offset=>1641014699613402
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(645792499588681124)
,p_name=>unistr('Men\00FA de Navegaci\00F3n')
,p_list_status=>'PUBLIC'
,p_version_scn=>35446683803
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(645804296571681171)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Inicio'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp.component_end;
end;
/
