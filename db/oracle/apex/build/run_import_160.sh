#!/bin/bash
# Importa la app 160 (SIIF_SPD) desde el export dividido db/oracle/apex/f160 en el workspace SIIFWEB del
# contenedor local, igual que run_import_106.sh. Va después de la 106 (login / portal).
#
# Flujo de trabajo (varios desarrolladores):
#   1. Cambios en el Constructor de aplicaciones (http://localhost:8080/ords/r/apex).
#   2. Exportar:  node db/oracle/apex/build/export_split.js 160   (reescribe db/oracle/apex/f160)
#   3. Revisar el diff en git (un archivo por página / componente) y hacer commit.
#   4. Los demás traen los cambios y corren este script para tener la misma app.
S="$(cd "$(dirname "$0")" && pwd -W)"
dx() { MSYS_NO_PATHCONV=1 docker "$@"; }
dx exec -u root spd-oracle rm -rf /tmp/f160
dx cp "$S/../f160" spd-oracle:/tmp/f160
dx cp "$S/import_f160.sql" spd-oracle:/tmp/f160/import_f160.sql
dx exec -u root spd-oracle chown -R oracle:oinstall /tmp/f160
dx exec -e NLS_LANG=AMERICAN_AMERICA.AL32UTF8 spd-oracle bash -c "cd /tmp/f160 && sqlplus -s siif/siif@localhost/FREEPDB1 @import_f160.sql > /tmp/imp160.log 2>&1; echo EXIT=\$?; grep -B4 -A10 -E 'ORA-|PLS-|SP2-' /tmp/imp160.log | head -50"
