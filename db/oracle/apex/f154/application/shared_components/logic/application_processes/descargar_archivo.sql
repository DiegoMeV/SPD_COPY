prompt --application/shared_components/logic/application_processes/descargar_archivo
begin
--   Manifest
--     APPLICATION PROCESS: DESCARGAR_ARCHIVO
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.21'
,p_default_workspace_id=>23568272425167888
,p_default_application_id=>154
,p_default_id_offset=>292021538769791282
,p_default_owner=>'SIIF'
);
wwv_flow_imp_shared.create_flow_process(
 p_id=>wwv_flow_imp.id(874653504602687341)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'DESCARGAR_ARCHIVO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_base    CONSTANT VARCHAR2(100) := ''/data/archivos'';',
'    l_ruta    VARCHAR2(4000);',
'    l_rel     VARCHAR2(4000);',
'    l_nombre  VARCHAR2(400);',
'    l_mime    VARCHAR2(200);',
'    l_bfile   BFILE;',
'    l_blob    BLOB;',
'    l_dest    INTEGER := 1;',
'    l_src     INTEGER := 1;',
'BEGIN',
'    l_ruta := :G_RUTA_ARCHIVO_ADJUNTO;',
'',
'    IF l_ruta IS NULL OR l_ruta NOT LIKE l_base || ''%'' OR INSTR(l_ruta, ''..'') > 0 THEN',
unistr('        RAISE_APPLICATION_ERROR(-20002, ''Ruta no v\00E1lida.'');'),
'    END IF;',
'',
'    l_rel    := SUBSTR(l_ruta, LENGTH(l_base) + 1);',
'    l_nombre := SUBSTR(l_ruta, INSTR(l_ruta, ''/'', -1) + 1);',
'',
'    l_bfile := BFILENAME(''ARCHIVOS_DIR'', l_rel);',
'',
'    IF DBMS_LOB.FILEEXISTS(l_bfile) = 0 THEN',
'        RAISE_APPLICATION_ERROR(-20001, ''Archivo no encontrado: '' || l_ruta);',
'    END IF;',
'',
'    DBMS_LOB.CREATETEMPORARY(l_blob, TRUE);',
'    DBMS_LOB.FILEOPEN(l_bfile, DBMS_LOB.FILE_READONLY);',
'    DBMS_LOB.LOADBLOBFROMFILE(l_blob, l_bfile, DBMS_LOB.LOBMAXSIZE, l_dest, l_src);',
'    DBMS_LOB.FILECLOSE(l_bfile);',
'',
'    l_mime := CASE LOWER(SUBSTR(l_nombre, INSTR(l_nombre, ''.'', -1) + 1))',
'                WHEN ''doc''  THEN ''application/msword''',
'                WHEN ''docx'' THEN ''application/vnd.openxmlformats-officedocument.wordprocessingml.document''',
'                WHEN ''pdf''  THEN ''application/pdf''',
'                WHEN ''xls''  THEN ''application/vnd.ms-excel''',
'                WHEN ''xlsx'' THEN ''application/vnd.openxmlformats-officedocument.spreadsheetml.sheet''',
'                ELSE ''application/octet-stream''',
'              END;',
'',
'    sys.htp.init;',
'    sys.owa_util.mime_header(l_mime, FALSE);',
'    sys.htp.p(''Content-Length: '' || DBMS_LOB.GETLENGTH(l_blob));',
'    sys.htp.p(''Content-Disposition: attachment; filename="'' ||',
'              REPLACE(l_nombre, ''"'', '''') || ''"'');',
'    sys.owa_util.http_header_close;',
'    sys.wpg_docload.download_file(l_blob);',
'',
unistr('    -- SIN FREETEMPORARY aqu\00ED'),
'    apex_application.stop_apex_engine;',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_version_scn=>40769624983
,p_created_on=>wwv_flow_imp.dz('20260827143645Z')
,p_updated_on=>wwv_flow_imp.dz('20260827165522Z')
,p_created_by=>'DIEGOM.SOLINFO'
,p_updated_by=>'DIEGOM.SOLINFO'
);
wwv_flow_imp.component_end;
end;
/
