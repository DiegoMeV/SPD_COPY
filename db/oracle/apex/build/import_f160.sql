-- Importa la app 160 desde el export dividido (db/oracle/apex/f160, copiado a /tmp/f160).
-- Sin generate_offset: se conservan los IDs del export, así una reexportación no cambia los archivos.
whenever sqlerror exit failure
begin
  apex_application_install.set_workspace('SPD');
  apex_application_install.set_application_id(160);
  apex_application_install.set_schema('SIIF');
  apex_application_install.set_application_alias('SIIF-SPD');
end;
/
@install.sql
exit
