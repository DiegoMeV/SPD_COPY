set serveroutput on feedback off
whenever sqlerror exit failure
begin
  execute immediate 'drop table tmp_apex_export purge';
exception when others then null;
end;
/
create table tmp_apex_export (name varchar2(255), contents clob);
declare
  l_files apex_t_export_files;
begin
  apex_util.set_workspace(p_workspace => 'SPD');
  l_files := apex_export.get_application(p_application_id => 160, p_with_comments => true);
  for i in 1 .. l_files.count loop
    insert into tmp_apex_export values (l_files(i).name, l_files(i).contents);
    dbms_output.put_line(l_files(i).name || ': ' || dbms_lob.getlength(l_files(i).contents) || ' chars');
  end loop;
  commit;
end;
/
set long 2000000000 longchunksize 32767 linesize 32767 trimspool on pagesize 0 heading off termout off verify off echo off
spool /tmp/f160.sql
select contents from tmp_apex_export;
spool off
set termout on
drop table tmp_apex_export purge;
exit
