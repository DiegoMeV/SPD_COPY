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
- **`db/oracle/apex/f160/`** es la exportación **24.2** dividida de la app 160 (reemplaza al antiguo `f160.sql` de un solo archivo). Se reimporta sin errores. Ver "Cómo trabajar la app".
- **App 106 "SIIF Web" (portal, alias `SIIF-MAIN`)** instalada en el workspace local `SPD` desde `db/oracle/apex/f106/` (export split) con `build/run_import_106.sh`.
  - La base (154/160) redirige a la 106 para el login, el home y el logout. Al estar en el mismo workspace comparten la cookie de sesión (`&WORKSPACE_COOKIE.`), así que ya no hace falta tomar la sesión de `apex_workspace_sessions`.
  - El portal muestra la tarjeta del módulo (el padre "SPD"), que abre la página 101 de `SIIF-SPD` con `G_MODULO` / `G_OPCION_MENU`.
- **`db/oracle/siif_apex_local.sql`** (solo local) simula los objetos del SIIF que usan la 106 y la base:
  - los paquetes `SIIF_WEB_USUARIOS` (incluye `validar_password_actual`), `WEB_UND_MFA_TOTP` (todos los métodos que llama la 106; en local no se exige MFA: `acceso_permitido` = TRUE) y `UND_COMMOM`;
  - las vistas `V_GEN_OPCIONES_SISTEMA_MENU` y `V_GEN_OPCIONES_USUARIO_ACT`;
  - las tablas `OPCIONES_X_COMPANIA` y `GEN_APEX_AUTH_TOKENS` (login por token, página 9991; DDL de `SVN_APEX/DB/scripts/init.sql`);
  - el menú SPD (`GEN_OPCIONES_SISTEMA_LOCAL`), que apunta a los alias `SPD_*` de la aplicación `SIIF-SPD`:
    - módulo `SEGUIMIENTO_PRY` (también es el `G_MODULO` que fija el login local);
    - un único padre, "SPD" (opción `30`), y debajo el árbol del menú original de SPD;
    - las opciones son números (aunque la columna es `varchar2`) jerárquicos: cada hijo lleva el código del padre más `01`, `02`, … (Configuración `3001`, Usuarios `300101`, Seguimiento › Metas › Configuración `30030101`). Los hermanos tienen el mismo largo, así que el orden por `path_opcion` (texto) es el correcto.
    - la descripción concatena las de los padres, sin el módulo (`SPD - Configuración - Usuarios`); la vista `V_GEN_OPCIONES_SISTEMA_MENU` (local y real) muestra como etiqueta lo que va después del último `-`.
- **Prueba en navegador** (`build/tests/test_160.js`, Edge + playwright-core): login por la 106, portal, tarjeta → 101, menú SIIF, las páginas 1, 3, 101 y 1001-1052, migas y botones desde el menú, guardado de Entidad, Detalles → Estructura del plan (árbol, "Editar Eje" / "Crear Sector"), diálogo Datos de la Meta y formulario de Seguimiento con la grilla de colores. **Resultado: 55 páginas sin errores, 0 problemas.**
  - 1060, 1061 y 1062 necesitan el ID del registro: se prueban entrando desde sus listados, no en el recorrido sin parámetros. Sin ID, 1060 y 1061 dan `ORA-01403`, igual que las páginas 60 y 61 de la app 100.
  - Formato de fecha: la base usa `DS`; con idioma `es` se muestra `DD/MM/YYYY`, igual que en SPD.

- **Programación de Metas (1030 + diálogo 1063)**, con las mismas partes que en React (`client/components/Goals/GoalsCatalog` + `GoalsSchedule`); a pedido del usuario, la programación se abre en un diálogo modal en vez del panel lateral de React. La genera `build/schedule_goals_160.sql`, que corre como `SIIF` sobre la 160 instalada, reemplaza las dos páginas completas y se puede volver a ejecutar. `rebuild_160_legacy.sh` lo aplicaba después de importar.
  - **1030 · Selector de seguimiento:** por defecto, el activo.
  - **1030 · Pestaña "Listado":** reporte con estado (ícono y color de React) y acción Programar / Ver, que abre el diálogo 1063. El código abre el diálogo 1062.
  - **1030 · Pestaña "Por Estructura del Plan":** árbol con badges y las metas del nodo; su acción también abre el 1063.
  - **1063 · Diálogo "Programación"** (`SPD_PROGRAMAR_META`; recibe `P1063_GOAL_ID` y `P1063_MC`):
    - pestaña "Datos Programación": resumen de la meta, actividades (`SPD_ACTIVITY_GOAL`), programación, ponderación, meses y recursos por fuente (Programación = `MANUAL`, Apropiado = `DEFINITIVE`, según el origen de recursos; SGP discriminado plegable; totales en vivo);
    - pestaña "Historial";
    - pie con Volver (cierra sin guardar) y Guardar (solo si se puede programar). Al guardar, el diálogo se cierra y la 1030 refresca el listado y las metas del nodo y muestra "Programación guardada".
  - **Guardar** replica `savePlannedMonitoringRecord`: registro en `PLANNED`, recursos solo si el origen admite recursos del usuario (el apropiado solo si la entidad del usuario, `USUARIOS.CODIGO_ENT_PRY`, tiene `SPD_PRESUPUESTO_MANUAL`) y evento `SCHEDULED` con `CREATED_BY = USUARIOS.ID`. Solo se puede guardar dentro de la ventana de programación y si la meta no está Validada ni Revisada.
  - **Prueba:** `build/tests/test_schedule_160.js` (`CFG=2024-3` para el caso de solo lectura).
  - **Gotchas:**
    - en regiones de contenido dinámico, armar cada pieza en `varchar2` antes de concatenarla al CLOB (concatenar sobre el CLOB una cadena larga con `CASE` da `ORA-06502`);
    - no usar `.exists()` ni funciones locales dentro de sentencias SQL.
    - en SQL, un `CASE` que mezcla una columna CLOB con un `varchar2` da `ORA-00932`: usar `to_clob()`.
- **Programación de Proyectos (1035) y Planes de Acción (1040):** las genera el mismo `schedule_goals_160.sql` (ciclo por grupo), igual que en React (mismo componente con otro `goalTypes`):
  - sin las columnas Indicador ni Línea Base;
  - el resumen del diálogo muestra solo el código;
  - sin "Programación Meta";
  - el plan de acción (`ACTION_PLAN`) no se programa; sí sus metas (`ACTION_PLAN_ACTIVITY`).
  - La vista `V_SPD_GOAL_MONITORING` ahora incluye las actividades con su proyecto y las metas de plan con su plan (grupo `PLANES`), y expone `PARENT_GOAL_ID`, `SUBPERIOD` y `FIN_PROGRESS_PAYMENT`.
- **Reporte / Validación / Revisión / Tableros de los tres grupos** (`build/track_160.sql`, aplicado por `rebuild_160_legacy.sh` después de la programación):
  - **Listas 1031-1033 / 1036-1038 / 1041-1043:**
    - selector de seguimiento y reporte con el estado de la etapa (Sin Reportar / Reportada / Sin Validar / Validada / Sin Revisar / Revisada / Rechazada);
    - acción Reportar / Validar / Revisar (o Ver fuera de la ventana de fechas), que abre el diálogo 1064;
    - el código abre el 1062.
    - Diferencia con React: la lista de Reporte incluye los registros rechazados para poder reportarlos de nuevo (React los excluye de la búsqueda).
  - **Tableros 1034 / 1039 / 1044:** metas revisadas, con:
    - programado y ejecutado del periodo, apropiado, compromisos y obligaciones;
    - avance físico y financiero como medidores, con los colores del seguimiento escalados por subperiodo/4;
    - selector del documento (compromisos / obligaciones / pagos);
    - el ID abre la ejecución en solo lectura.
  - **1064 "Ejecución meta"** (`SPD_EJECUCION_META`, `P1064_MODE` = `REPORT` | `VALIDATE` | `REVIEW` | `VIEW`):
    - arriba: resumen, indicadores (barras de color) y actividades;
    - Decisión: Validada / Sin Validar en validación; Aprobada / Rechazada + Observación en revisión;
    - pestañas: Avance Cuantitativo (programación de solo lectura + ejecución por documento, editable solo con presupuesto manual o en metas de plan de acción), Avance Cualitativo (4 preguntas), Obs. Generales, Focalización E.D. / Org. / R.E., Evidencias, Indicadores (medidores) e Historial.
    - **Focalización:** cada pestaña tiene un IG de solo lectura sobre la vista `V_SPD_TARGET_MATRIX` (una fila por localización del JSON `TARGET_MATRIX`), con "Agregar localización" y el ícono Editar.
      - Los dos abren el **formulario modal 1065** (`SPD_FOCALIZACION`, diálogo no encadenado), con estos campos:
        - Localización: shuttle sobre `SPD_GEO_LOCATION`;
        - los de la sección: Género / Zona / Ciclos de Edad / Condición / Etnia, Institución, o Canino / Felino / Otra Especie / Flora.
      - Botones: Guardar, Eliminar (con confirmación) y Cancelar.
      - Guarda en el mismo formato JSON que React: claves `localizationTabN`, `localization` como arreglo de ID, `localizationLabel`, y la etnia dentro de `ageCycles`. Al cerrarse, el 1064 refresca las grillas.
      - Los campos del formulario salen de una tabla de definiciones en `track_160.sql` (sección | región | ítem | ruta JSON | etiqueta | tipo).
      - Prueba: `build/tests/test_focalizacion_160.js`.
      - Las ubicaciones de prueba de Palmira (`CODE` `DEMO-…`) las crea `spd_demo_seguimiento.sql`, y `spd_demo_to_postgres.js` las copia con el mismo ID.
    - **Guardar** replica `saveTrackingMonitoringRecord`, con estos cálculos:
      - avance físico = min(logro / programado, 1);
      - avance financiero por documento = min(ejecutado / apropiado, 1), contra `MANUAL` en planes de acción;
      - evento en el historial: `MONITORED`, `VALIDATED`, `REVIEWED` o `REJECTED`, con la observación de la revisión.
    - **Diferencias con React:**
      - en la revisión los datos son de solo lectura (React los deja editar pero los descarta al guardar);
      - la decisión de revisión arranca en "Aprobada" (React arranca en "Rechazada" salvo si ya estaba revisada);
      - el servidor también valida fechas y estado (React solo lo hace en la interfaz).
  - **Prueba:** `build/tests/test_monitoring_160.js` recorre las 15 pantallas y guarda en cada etapa (`SAVE=0` para solo mirar).
  - **Datos demo del seguimiento activo (2024-3):** recorre todo el flujo (programada, reportada, validada, revisada, rechazada); proyectos y planes de acción casi todos revisados; ventanas de reporte, validación y revisión abiertas hoy. Así Revisión y los Tableros tienen datos sin cambiar de seguimiento, también en React (que filtra por la entidad del usuario). El reparto de estados es estable entre recargas. Prueba de React: `build/tests/test_react_tableros.js` (`CFG=2024-1` para otro seguimiento).
- **Configuración de tipos de campo** (`build/fix_plugin_settings_160.sql`, como SYS): al importar en APEX 24.2 local, los *Component Settings* de la 160 quedan en `{}` y el Switch no se pinta. El script los copia de la 106; `rebuild_160_legacy.sh` lo corría después de importar f160_src.sql.
- **Formularios y contexto global** (`build/forms_160.sql`, como SYS, último en `rebuild_160_legacy.sh`):
  - **Compañía:** ningún formulario la muestra; el campo queda oculto y toma `G_NIT_COMPANIA`.
  - **`G_PLAN`** (plan de desarrollo; al abrir sesión, el plan activo de la compañía) y **`G_SEGUIMIENTO`** (ID de la configuración):
    - se actualizan al elegir en cualquier lista de plan (1009, 1010, 1011, 1046) o de seguimiento (1030-1044): proceso de aplicación al enviar la página y acción dinámica en los formularios;
    - las páginas abren con ese valor, si es válido para la compañía;
    - los formularios lo usan como plan por defecto al crear.
  - **Filas:** máximo 4 campos por fila (más solo para interruptores o casillas); en la 1061, 2 por fila (región angosta). También corrige las listas de selección que se veían como caja de lista ("Unidad medida").
  - **Prueba:** `build/tests/test_forms_160.js`.

## Pendiente

1. **Validar la importación** de `f160/install.sql` en el APEX 24.2 real. Después de importar conviene "Refrescar tema" (queda Universal Theme 24.1, que viene de la app 100) y revisar que el estilo actual sea "Vita (SIIF_WEB)".
2. **Registrar las opciones SPD** en el menú del SIIF: correr `build/menu_inserts.sql` como `SIIF`, después de importar la app 160. Inserta en `GEN_OPCIONES_SISTEMA` las 63 opciones del módulo `SEGUIMIENTO_PRY` (padre único "SPD", opción `30`, e hijos jerárquicos; ejecutable = alias `SPD_*`, aplicación `SIIF-SPD`), con el mismo árbol del menú local de `siif_apex_local.sql`. Se puede re-ejecutar (solo inserta lo que falte). La activación por compañía y usuario se hace aparte.
3. **Actualizar `db/oracle/README.md`** con la app 160 cuando quede probada en el ambiente real.
4. Detalles vistos en la prueba (vienen de la app 100, no del armado):
   - En el listado de Seguimientos (1045), "Periodo" tiene máscara con separador de miles y muestra `2.023`.
   - Las migas y la opción resaltada del menú dependen de `G_OPCION_MENU`: si se entra a una página por URL directa (sin pasar por el menú) se ven las de la última opción elegida. Es el comportamiento de la base.
5. Seguimiento: lo que falta frente a React.
   - **Evidencias:** solo se listan y se eliminan. Para la carga hay que definir el almacenamiento (React usa S3 con URL prefirmada; `SPD_MONITORING_RECORD_ATTACH` solo guarda la ruta).
   - **Configuración de seguimiento (1045):** faltan las acciones "Copiar Programación" (`copyMonitoringConfigPreviousSchedule`) y "Eliminar".
   - **Planes de Acción (1029):** falta el CRUD de React, con planes y sus metas (`ACTION_PLAN_ACTIVITY`) y la tabla editable "Metas del plan de acción".
   - **Proyectos (1028):** falta el detalle del proyecto con sus actividades. Necesita las vistas SIIF `V_ACTIVIDADES_PRY` y `V_VALOR_FISICO_ACTIVIDAD`, que no están en el Oracle local.
   - **Cálculos que React hace en el servidor al listar y que aquí no existen:**
     - creación automática de las metas `PROJECT` / `ACTIVITY` desde el SIIF;
     - suma de los recursos de las actividades en el proyecto y de las metas en el plan de acción.
   - **Políticas:** el menú existe, pero en React no hay pantallas (dan 404). En APEX quedan "En construcción".

## Cómo trabajar la app (desde 2026-11-17)

La fuente de la app es el **export dividido `db/oracle/apex/f160/`**: un archivo por página (`application/pages/page_01011.sql`) y por componente compartido, más `install.sql`. Es el mismo formato de la 106. Exportar dos veces seguidas da los mismos archivos, así que el diff de git muestra solo lo que cambió.

1. **Traer la app** al APEX local (después de la 106): `bash db/oracle/apex/build/run_import_160.sh`. Importa sin desplazar IDs, así que los IDs del export se mantienen.
2. **Hacer los cambios en el Constructor de aplicaciones** (`http://localhost:8080/ords/r/apex`, workspace `SIIFWEB`).
3. **Exportar** desde la raíz del repo, con Node 20: `node db/oracle/apex/build/export_split.js 160`. Reescribe `f160/` completo, así que los componentes eliminados también desaparecen.
4. **Revisar el diff y hacer commit.** Para evitar conflictos, cada persona trabaja sus páginas. Los componentes compartidos (listas de valores, plantillas, ítems de aplicación) se coordinan.

Producción: importar `f160/install.sql` (Constructor → Importar, o SQL*Plus con `apex_application_install`, como en `build/import_f160.sql`).

**Histórico:** el armado de la migración (`build_f160.js` → `f160_src.sql`, más los parches `schedule_goals_160.sql`, `track_160.sql`, `forms_160.sql` y `fix_plugin_settings_160.sql`) queda en `build/rebuild_160_legacy.sh`. **Ya no es la fuente:** recrea páginas completas y borraría lo hecho en el Constructor. El export dividido conserva la configuración de tipos de campo, así que `fix_plugin_settings_160.sql` ya no hace falta.

Pruebas: en `build/tests/`, `npm i` y luego:
- `node test_160.js`: toda la app;
- `SAVE=0 node test_monitoring_160.js`: seguimiento;
- `node test_forms_160.js`: formularios, `G_PLAN` y `G_SEGUIMIENTO`;
- `node test_focalizacion_160.js`: focalización.

## Ambiente local

- **`spd-oracle`**: Oracle 23 Free (`gvenzl/oracle-free:23`), PDB `FREEPDB1`, puerto 1521, `sys`/`system` = `oracle`, esquema `SIIF/siif`. APEX **24.2**, workspace `SIIFWEB` (esquema `SIIF`) con las apps 100, 106 y 160.
  - Usuarios del workspace: `ADMIN` / `Spd#2026` (desarrollador) y `FGIL666@GMAIL.COM` / `Spd#2026` (login de la app 100, *Cuentas de APEX*).
- **`spd-ords`**: ORDS 26.3 (`container-registry.oracle.com/database/ords:latest`), puerto 8080, sirve las imágenes de APEX 24.2 en `/i/`.
  - ORDS 24.4 no se instala sobre `gvenzl/oracle-free` (falla al leer la información de parches de la base); 26.3 sí.
- Orden de instalación en una base nueva, como `SIIF`: `siif_base_tables.sql` → `siif_spd_columns.sql` → `spd_schema.sql` → `spd_views.sql` → `spd_seed.sql` → (APEX y workspace) → `siif_apex_local.sql` → app 100 → `run_import_106.sh` → `run_import_160.sh` (importa `f160/install.sql`).
- URLs:
  - Portal SIIF Web (entrada a la 160): `http://localhost:8080/ords/f?p=106:LOGIN:0::::P9999_NIT_COMPANIA:8913800073` (Municipio de Palmira), usuario `fgil666@gmail.com`, clave `Spd#2026`. La compañía va en la URL porque el selector del login solo se ve en modo desarrollo.
  - App 100: `http://localhost:8080/ords/r/siifweb/spd/login`.

## Notas

- La app 100 (`f100.sql`) sigue siendo la fuente de las páginas SPD. Los scripts de parche de la app 100 están en `build/` (`apply_patch.sh` aplica `plan_detail` → `plan_pages` → `company_filter` → `goals_pages` → `monitoring_page` → `ui_standard`). Ojo: `apply_patch.sh` todavía usa el esquema `APEX_240100` y una ruta fija al repo; con APEX 24.2 el esquema es `APEX_240200`.
- Los exports split de la 106 y la 154 (`db/oracle/apex/f106/`, `f154/`) son copia de `apexprod/apps/` y vienen en Latin-1: `run_import_106.sh` los pasa a UTF-8 dentro del contenedor y `build_f160.js` los lee como Latin-1.
