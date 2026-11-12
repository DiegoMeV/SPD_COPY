#!/bin/bash
S="$(cd "$(dirname "$0")" && pwd -W)"
dx() { MSYS_NO_PATHCONV=1 docker "$@"; }
dx cp "$S/f160_src.sql" spd-oracle:/tmp/f160_src.sql; dx cp "$S/import_160.sql" spd-oracle:/tmp/import_160.sql
dx exec -e NLS_LANG=AMERICAN_AMERICA.AL32UTF8 spd-oracle bash -c "sqlplus -s siif/siif@localhost/FREEPDB1 @/tmp/import_160.sql > /tmp/imp160.log 2>&1; echo EXIT=\$?; grep -vE '^prompt|^\s*\$' /tmp/imp160.log | grep -B4 -A10 -E 'ORA-|PLS-' | head -50; tail -2 /tmp/imp160.log"
