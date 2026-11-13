whenever sqlerror exit failure
begin
  apex_application_install.set_workspace('SPD');
  apex_application_install.set_application_id(160);
  apex_application_install.generate_offset;
  apex_application_install.set_schema('SIIF');
  apex_application_install.set_application_alias('SIIF-SPD');
end;
/
@/tmp/f160_src.sql
exit
