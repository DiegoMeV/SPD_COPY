-- App 160: al importar f160_src.sql en APEX 24.2 local, las configuraciones globales de los tipos de
-- campo (Component Settings: Switch, Single Checkbox, Date Picker, Color Picker, Select Many,
-- Star Rating, Geocoded Address) quedan en {}. Sin "display_style" el Switch (NATIVE_YES_NO) no se
-- pinta. Se copian de la app 106 (misma base SIIF Web). Corre como SYS en FREEPDB1; re-ejecutable.
-- Después de esto el export (export_160.sql) ya sale con los valores correctos.
set serveroutput on
alter session set container = FREEPDB1;
set serveroutput on size unlimited
declare
  l_schema varchar2(30);
  n number;
begin
  select max(owner) into l_schema from dba_tables
   where table_name = 'WWV_FLOW_PLUGIN_SETTINGS' and owner like 'APEX\_2%' escape '\';
  execute immediate
    'update ' || l_schema || '.wwv_flow_plugin_settings t
        set attributes = (select s.attributes from ' || l_schema || '.wwv_flow_plugin_settings s
                           where s.flow_id = 106 and s.plugin_type = t.plugin_type and s.plugin = t.plugin)
      where t.flow_id = 160
        and dbms_lob.compare(nvl(t.attributes, to_clob(''{}'')), to_clob(''{}'')) = 0
        and exists (select 1 from ' || l_schema || '.wwv_flow_plugin_settings s
                     where s.flow_id = 106 and s.plugin_type = t.plugin_type and s.plugin = t.plugin
                       and dbms_lob.compare(nvl(s.attributes, to_clob(''{}'')), to_clob(''{}'')) <> 0)';
  n := sql%rowcount;
  commit;
  dbms_output.put_line('PLUGIN SETTINGS OK: ' || n || ' actualizadas');
end;
/
exit
