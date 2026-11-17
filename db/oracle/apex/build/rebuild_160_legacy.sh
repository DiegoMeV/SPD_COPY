#!/bin/bash
# HISTÓRICO: así se construyó la app 160 durante la migración (base f154 + páginas SPD de f100 con
# build_f160.js -> f160_src.sql, más los parches schedule_goals_160.sql, track_160.sql, forms_160.sql...).
# YA NO ES LA FUENTE: desde 2026-11-17 la app se trabaja en el Constructor de aplicaciones y se versiona como
# export dividido en db/oracle/apex/f160 (run_import_160.sh / export_split.js).
# NO correr sobre una 160 con cambios hechos en el Constructor: recrea páginas completas y los pierde.
S="$(cd "$(dirname "$0")" && pwd -W)"
dx() { MSYS_NO_PATHCONV=1 docker "$@"; }
dx cp "$S/f160_src.sql" spd-oracle:/tmp/f160_src.sql; dx cp "$S/import_160.sql" spd-oracle:/tmp/import_160.sql
dx exec -e NLS_LANG=AMERICAN_AMERICA.AL32UTF8 spd-oracle bash -c "sqlplus -s siif/siif@localhost/FREEPDB1 @/tmp/import_160.sql > /tmp/imp160.log 2>&1; echo EXIT=\$?; grep -vE '^prompt|^\s*\$' /tmp/imp160.log | grep -B4 -A10 -E 'ORA-|PLS-' | head -50; tail -2 /tmp/imp160.log"
# Configuraciones globales de tipos de campo (quedan en {} al importar; sin ellas el Switch no se pinta)
dx cp "$S/fix_plugin_settings_160.sql" spd-oracle:/tmp/fix_plugin_settings_160.sql
dx exec spd-oracle bash -c "sqlplus -s / as sysdba @/tmp/fix_plugin_settings_160.sql 2>&1 | grep -E 'OK|ORA-|PLS-'"
# Parches sobre la 160 instalada (como SIIF; re-ejecutables)
for f in schedule_goals_160.sql track_160.sql; do
  dx cp "$S/$f" spd-oracle:/tmp/$f
  dx exec -e NLS_LANG=AMERICAN_AMERICA.AL32UTF8 spd-oracle bash -c "sqlplus -s siif/siif@localhost/FREEPDB1 @/tmp/$f 2>&1 | grep -E 'OK|ORA-|PLS-'"
done
# Compañía oculta, G_PLAN / G_SEGUIMIENTO y filas de formularios (después de los anteriores; como SYS)
dx cp "$S/forms_160.sql" spd-oracle:/tmp/forms_160.sql
dx exec -e NLS_LANG=AMERICAN_AMERICA.AL32UTF8 spd-oracle bash -c "sqlplus -s / as sysdba @/tmp/forms_160.sql 2>&1 | grep -E 'OK|ORA-|PLS-|no existe|Compañía|Campos'"
