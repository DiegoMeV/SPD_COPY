prompt --application/shared_components/navigation/lists/barra_de_navegacion_principal
begin
--   Manifest
--     LIST: Barra de Navegacion Principal
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
 p_id=>wwv_flow_imp.id(56131690966640106)
,p_name=>'Barra de Navegacion Principal'
,p_list_status=>'PUBLIC'
,p_reference_id=>518518175020749216
,p_version_scn=>41677024840
,p_updated_on=>wwv_flow_imp.dz('20261103160907Z')
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(367046172231137014)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>unistr('Nueva Sesi\00F3n')
,p_list_item_link_target=>'f?p=106:1:&APP_SESSION.:APEX_CLONE_SESSION'
,p_list_item_icon=>'fa-plus-square-o'
,p_list_text_06=>'_blank'
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20261103160907Z')
,p_updated_on=>wwv_flow_imp.dz('20261103160907Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(367046528724137014)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'&G_NOMBRE_USUARIO.'
,p_list_item_link_target=>'#'
,p_list_item_icon=>'fa-user'
,p_list_text_02=>'has-username'
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20261103160907Z')
,p_updated_on=>wwv_flow_imp.dz('20261103160907Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(367046901944137015)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'---'
,p_list_item_link_target=>'separator'
,p_list_item_disp_cond_type=>'USER_IS_NOT_PUBLIC_USER'
,p_parent_list_item_id=>wwv_flow_imp.id(367046528724137014)
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20261103160907Z')
,p_updated_on=>wwv_flow_imp.dz('20261103160907Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(367047347127137015)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>unistr('Cerrar sesi\00F3n')
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_icon=>'fa-sign-out'
,p_list_item_disp_cond_type=>'USER_IS_NOT_PUBLIC_USER'
,p_parent_list_item_id=>wwv_flow_imp.id(367046528724137014)
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20261103160907Z')
,p_updated_on=>wwv_flow_imp.dz('20261103160907Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
