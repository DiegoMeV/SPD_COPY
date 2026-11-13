whenever sqlerror exit failure
begin
  apex_application_install.set_workspace('SPD');
  apex_application_install.set_application_id(106);
  apex_application_install.set_schema('SIIF');
end;
/
@install_utf8.sql
exit
