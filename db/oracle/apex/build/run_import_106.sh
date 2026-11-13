#!/bin/bash
# Importa la app 106 (SIIF Web, portal de entrada; export split en db/oracle/apex/f106) en el
# workspace SPD del contenedor local. Debe ir antes que la 160: la base (154/160) redirige a la 106
# para el login, el home y el logout, y comparten sesión por estar en el mismo workspace.
# Requiere que ya se haya corrido db/oracle/siif_apex_local.sql (stubs de los objetos del SIIF).
# Login local: http://localhost:8080/ords/f?p=106:LOGIN:0::::P9999_NIT_COMPANIA:8913800073
S="$(cd "$(dirname "$0")" && pwd -W)"
dx() { MSYS_NO_PATHCONV=1 docker "$@"; }
dx exec -u root spd-oracle rm -rf /tmp/f106
dx cp "$S/../f106" spd-oracle:/tmp/f106
dx cp "$S/import_106.sql" spd-oracle:/tmp/f106/import_106.sql
dx exec -u root spd-oracle chown -R oracle:oinstall /tmp/f106
# El export viene en Latin-1 (tildes en prompts, comentarios y en install.sql) y los nombres de archivo
# quedan en UTF-8 en el contenedor: se pasa todo a UTF-8 para importarlo con NLS_LANG AL32UTF8.
dx exec spd-oracle bash -c "cd /tmp/f106 && find . -name '*.sql' -print0 | while IFS= read -r -d '' f; do iconv -f latin1 -t utf8 \"\$f\" > \"\$f.u\" && mv \"\$f.u\" \"\$f\"; done && cp install.sql install_utf8.sql"
dx exec -e NLS_LANG=AMERICAN_AMERICA.AL32UTF8 spd-oracle bash -c "cd /tmp/f106 && sqlplus -s siif/siif@localhost/FREEPDB1 @import_106.sql > /tmp/imp106.log 2>&1; echo EXIT=\$?; grep -B4 -A10 -E 'ORA-|PLS-|SP2-' /tmp/imp106.log | head -50"
