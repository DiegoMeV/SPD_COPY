#!/bin/bash
# Aplica plan_detail.sql sobre la app 100 instalada, exporta, copia al repo y reimporta.
S="$(cd "$(dirname "$0")" && pwd -W)"
REPO_FILE="d:/Trabajo/SOLinfo/Proyectos/SPD_COPY/db/oracle/apex/f100.sql"
D=docker; command -v docker >/dev/null || D="/c/Program Files/Docker/Docker/resources/bin/docker.exe"
dx() { MSYS_NO_PATHCONV=1 "$D" "$@"; }
dx exec spd-oracle bash -c 'printf "alter user APEX_240100 account unlock;\ngrant create session to APEX_240100;\n" | sqlplus -s sys/oracle@localhost/FREEPDB1 as sysdba' | grep -v "^$"
rc=0
for f in plan_detail.sql plan_pages.sql company_filter.sql goals_pages.sql monitoring_page.sql ui_standard.sql; do
  dx cp "$S/$f" spd-oracle:/tmp/$f
  dx exec -e NLS_LANG=AMERICAN_AMERICA.AL32UTF8 spd-oracle bash -c "sqlplus -s APEX_240100/apexbuild@localhost/FREEPDB1 @/tmp/$f 2>&1" || { rc=1; break; }
done
if [ $rc -eq 0 ]; then
  dx cp "$S/export_app.sql" spd-oracle:/tmp/export_app.sql
  dx exec -e NLS_LANG=AMERICAN_AMERICA.AL32UTF8 spd-oracle bash -c "sqlplus -s siif/siif@localhost/FREEPDB1 @/tmp/export_app.sql"
  dx cp spd-oracle:/tmp/f100.sql "$REPO_FILE"
  sed -i "s/'SPD_GOAL_APEXGEN'/'SPD_GOAL'/g; s/p_alias=>'GOAL-APEXGEN'/p_alias=>'META'/; s/Process form Goal Apexgen/Process form Meta/; s/Initialize form Goal Apexgen/Initialize form Meta/" "$REPO_FILE"
  echo "referencias apexgen restantes: $(grep -ci apexgen "$REPO_FILE")"
  dx cp "$REPO_FILE" spd-oracle:/tmp/f100_final.sql
  dx cp "$S/import_final.sql" spd-oracle:/tmp/import_final.sql
  dx exec -e NLS_LANG=AMERICAN_AMERICA.AL32UTF8 spd-oracle bash -c "sqlplus -s siif/siif@localhost/FREEPDB1 @/tmp/import_final.sql 2>&1 | grep -E 'APPLICATION|ORA-' | tail -3"
fi
dx exec spd-oracle bash -c 'printf "revoke create session from APEX_240100;\nalter user APEX_240100 account lock;\n" | sqlplus -s sys/oracle@localhost/FREEPDB1 as sysdba' | grep -v "^$"
