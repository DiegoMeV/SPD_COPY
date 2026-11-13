# Estado: app 160 SIIF_SPD (en progreso)

Fecha: 2026-11-12.

**Objetivo:** crear la app **160 · SIIF_SPD · alias SIIF-SPD** a partir de la app base **154 "SIIF Web BASE"** (APEX 24.2), agregándole las páginas SPD de la app 100. Los nombres y alias de las páginas SPD empiezan con `SPD_`.

## Hecho

- **`db/oracle/apex/build/build_f160.js`** (Node) arma la app combinada. Entradas (rutas relativas al script):
  - base: `db/oracle/apex/f154/` (export split de la app 154, APEX 24.2, en Latin-1);
  - SPD: `db/oracle/apex/f100.sql`.

  De la base toma:
  - la aplicación y la interfaz;
  - la autenticación `siif_web`;
  - el menú `SIIF_MENU` y la barra de navegación;
  - los ítems `G_*` y los procesos de aplicación;
  - los íconos;
  - el estilo "Vita (SIIF_WEB)" con sus CSS;
  - las páginas 0, 1, 3, 13, 101, 9085-9087, 9998 y 9999.

  De SPD toma:
  - el tema 24.1 con sus plantillas (los IDs de plantilla de Universal Theme 24.2 de la base se mapean a ellas: tabla `TPL`);
  - las 34 LOV;
  - los mensajes en español;
  - las páginas.

- **Páginas SPD:** pasan de la N a la **1000+N** (Usuarios 2 → 1002, Plan 7 → 1007, Estructura 61 → 1061, …).
  - Los ítems se renombran `P<N>_` → `P<1000+N>_`.
  - Se corrigen los enlaces `f?p=` y las páginas en "clear cache".
  - La lista completa de nombres y alias está en el script (arreglo `PAGES`).
  - No se migraron la página 53 "En construcción" (se usa la de la base, alias `EN-CONSTRUCCION`), el login y la página 0 de SPD.
  - Los botones de los formularios se movieron a la región "Breadcrumb Global" de la página 0 de la base.
- **Versión de APEX:** el contenedor local está en **APEX 24.2**, como producción. El build genera la app para 24.2 (modo de compatibilidad 24.2). La conversión a 24.1 que se usaba antes sigue disponible con `node build_f160.js f160_src.sql --24.1` (`p_attributes` → `p_attribute_NN`, sin `p_dialog_resizable`, compatibilidad 21.2).
- **`db/oracle/apex/f160.sql`** es la exportación **24.2** de la app 160 desde el contenedor local. Se reimporta sin errores.
- **App 106 "SIIF Web" (portal, alias `SIIF-MAIN`)** instalada en el workspace local `SPD` desde `db/oracle/apex/f106/` (export split) con `build/run_import_106.sh`.
  - La base (154/160) redirige a la 106 para el login, el home y el logout. Al estar en el mismo workspace comparten la cookie de sesión (`&WORKSPACE_COOKIE.`), así que ya no hace falta tomar la sesión de `apex_workspace_sessions`.
  - El portal muestra la tarjeta del módulo (el padre "SPD"), que abre la página 101 de `SIIF-SPD` con `G_MODULO` / `G_OPCION_MENU`.
- **`db/oracle/siif_apex_local.sql`** (solo local) simula los objetos del SIIF que usan la 106 y la base:
  - los paquetes `SIIF_WEB_USUARIOS` (incluye `validar_password_actual`), `WEB_UND_MFA_TOTP` (todos los métodos que llama la 106; en local no se exige MFA: `acceso_permitido` = TRUE) y `UND_COMMOM`;
  - las vistas `V_GEN_OPCIONES_SISTEMA_MENU` y `V_GEN_OPCIONES_USUARIO_ACT`;
  - las tablas `OPCIONES_X_COMPANIA` y `GEN_APEX_AUTH_TOKENS` (login por token, página 9991; DDL de `SVN_APEX/DB/scripts/init.sql`);
  - el menú SPD (`GEN_OPCIONES_SISTEMA_LOCAL`), que apunta a los alias `SPD_*` de la aplicación `SIIF-SPD`:
    - módulo `SEGUIMIENTO_PROYECTOS` (también es el `G_MODULO` que fija el login local);
    - un único padre, "SPD" (opción `100`), y debajo el árbol del menú original de SPD;
    - las opciones son números (aunque la columna es `varchar2`) de 3 dígitos, `100`-`162`, en preorden: el menú se ordena por `path_opcion`, que es texto, y con el mismo ancho el orden de texto coincide con el numérico.
- **Prueba en navegador** (`build/tests/test_160.js`, Edge + playwright-core): login por la 106, portal, tarjeta → 101, menú SIIF, las páginas 1, 3, 101 y 1001-1052, migas y botones desde el menú, guardado de Entidad, Detalles → Estructura del plan (árbol, "Editar Eje" / "Crear Sector"), diálogo Datos de la Meta y formulario de Seguimiento con la grilla de colores. **Resultado: 55 páginas sin errores, 0 problemas.**
  - 1060, 1061 y 1062 necesitan el ID del registro: se prueban entrando desde sus listados, no en el recorrido sin parámetros. Sin ID, 1060 y 1061 dan `ORA-01403`, igual que las páginas 60 y 61 de la app 100.
  - Formato de fecha: la base usa `DS`; con idioma `es` se muestra `DD/MM/YYYY`, igual que en SPD.

## Pendiente

1. **Validar la importación** del `f160.sql` final en el APEX 24.2 real. Después de importar conviene "Refrescar tema" (queda Universal Theme 24.1, que viene de la app 100) y revisar que el estilo actual sea "Vita (SIIF_WEB)".
2. **Registrar las opciones SPD** en el menú del SIIF (opciones de sistema), con el ejecutable = alias `SPD_*` y la aplicación `SIIF-SPD`. Como guía sirve el árbol de `build/menu_inserts.sql` (igual al menú local de `siif_apex_local.sql`: módulo `SEGUIMIENTO_PROYECTOS`, padre único "SPD", opciones `100`-`162`).
   - **Ojo:** en el SIIF, `GEN_OPCIONES_SISTEMA.MODULO` es `varchar2(20 char)` y `SEGUIMIENTO_PROYECTOS` tiene 21 caracteres. Hay que ampliar la columna (y revisar las demás tablas `GEN_OPCIONES_*` que guardan el módulo) o acortar el nombre. En local la columna es `varchar2(30)`.
3. **Actualizar `db/oracle/README.md`** con la app 160 cuando quede probada en el ambiente real.
4. Detalles vistos en la prueba (vienen de la app 100, no del armado):
   - En el listado de Seguimientos (1045), "Periodo" tiene máscara con separador de miles y muestra `2.023`.
   - Las migas y la opción resaltada del menú dependen de `G_OPCION_MENU`: si se entra a una página por URL directa (sin pasar por el menú) se ven las de la última opción elegida. Es el comportamiento de la base.

## Cómo reconstruir y probar

Desde `db/oracle/apex/build/`:

```
node build_f160.js f160_src.sql && bash run_import_160.sh
```

Reexportar a `db/oracle/apex/f160.sql` (el script deja el export en `/tmp/f160.sql` del contenedor):

```
docker cp export_160.sql spd-oracle:/tmp/export_160.sql
docker exec -e NLS_LANG=AMERICAN_AMERICA.AL32UTF8 spd-oracle sqlplus -s siif/siif@localhost/FREEPDB1 @/tmp/export_160.sql
docker cp spd-oracle:/tmp/f160.sql ../f160.sql
```

Prueba: en `build/tests/`, `npm i` y `node test_160.js`.

## Ambiente local

- **`spd-oracle`**: Oracle 23 Free (`gvenzl/oracle-free:23`), PDB `FREEPDB1`, puerto 1521, `sys`/`system` = `oracle`, esquema `SIIF/siif`. APEX **24.2**, workspace `SPD` (esquema `SIIF`) con las apps 100, 106 y 160.
  - Usuarios del workspace: `ADMIN` / `Spd#2026` (desarrollador) y `FGIL666@GMAIL.COM` / `Spd#2026` (login de la app 100, *Cuentas de APEX*).
- **`spd-ords`**: ORDS 26.3 (`container-registry.oracle.com/database/ords:latest`), puerto 8080, sirve las imágenes de APEX 24.2 en `/i/`.
  - ORDS 24.4 no se instala sobre `gvenzl/oracle-free` (falla al leer la información de parches de la base); 26.3 sí.
- Orden de instalación en una base nueva, como `SIIF`: `siif_base_tables.sql` → `siif_spd_columns.sql` → `spd_schema.sql` → `spd_views.sql` → `spd_seed.sql` → (APEX y workspace) → `siif_apex_local.sql` → app 100 → `run_import_106.sh` → `run_import_160.sh` (o importar `f160.sql`).
- URLs:
  - Portal SIIF Web (entrada a la 160): `http://localhost:8080/ords/f?p=106:LOGIN:0::::P9999_NIT_COMPANIA:8913800073` (Municipio de Palmira), usuario `fgil666@gmail.com`, clave `Spd#2026`. La compañía va en la URL porque el selector del login solo se ve en modo desarrollo.
  - App 100: `http://localhost:8080/ords/r/spd/spd/login`.

## Notas

- La app 100 (`f100.sql`) sigue siendo la fuente de las páginas SPD. Los scripts de parche de la app 100 están en `build/` (`apply_patch.sh` aplica `plan_detail` → `plan_pages` → `company_filter` → `goals_pages` → `monitoring_page` → `ui_standard`). Ojo: `apply_patch.sh` todavía usa el esquema `APEX_240100` y una ruta fija al repo; con APEX 24.2 el esquema es `APEX_240200`.
- Los exports split de la 106 y la 154 (`db/oracle/apex/f106/`, `f154/`) son copia de `apexprod/apps/` y vienen en Latin-1: `run_import_106.sh` los pasa a UTF-8 dentro del contenedor y `build_f160.js` los lee como Latin-1.
