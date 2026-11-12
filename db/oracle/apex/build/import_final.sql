whenever sqlerror exit failure
begin execute immediate 'drop table SPD_GOAL_APEXGEN purge'; exception when others then null; end;
/
begin
  apex_application_install.set_workspace('SPD');
  apex_application_install.set_application_id(100);
  apex_application_install.set_schema('SIIF');
end;
/
@/tmp/f100_final.sql
exit
