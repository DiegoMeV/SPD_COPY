# Estado: app 160 SIIF_SPD (en progreso)

Fecha: 2026-11-12.

**Objetivo:** crear la app **160 · SIIF_SPD · alias SIIF-SPD** a partir de la app base **154 "SIIF Web BASE"** (APEX 24.2), agregándole las páginas SPD de la app 100. Los nombres y alias de las páginas SPD empiezan con `SPD_`.

## Hecho

- **`db/oracle/apex/build/build_f160.js`** (Node) arma la app combinada. Rutas de entrada fijas en el script:
  - base: `C:/Users/diego/OneDrive/Desktop/APEX_LOCAL/f154.sql`
  - SPD: `db/oracle/apex/f100.sql`

  De la base toma:
  - la aplicación y la interfaz;
  - la autenticación `siif_web`;
  - el menú `SIIF_MENU` y la barra de navegación;
  - los ítems `G_*` y los procesos de aplicación;
  - los íconos;
  - el estilo "Vita (SIIF_WEB)" con sus CSS;
  - las páginas 0, 1, 3, 13, 101, 9085-9087, 9998 y 9999.

  De SPD toma:
  - el tema 24.1 con sus plantillas;
  - las 34 LOV;
  - los mensajes en español;
  - las páginas.

- **Páginas SPD:** pasan de la N a la **1000+N** (Usuarios 2 → 1002, Plan 7 → 1007, Estructura 61 → 1061, …).
  - Los ítems se renombran `P<N>_` → `P<1000+N>_`.
  - Se corrigen los enlaces `f?p=` y las páginas en "clear cache".
  - La lista completa de nombres y alias está en el script (arreglo `PAGES`).
  - No se migraron la página 53 "En construcción" (se usa la de la base, alias `EN-CONSTRUCCION`), el login y la página 0 de SPD.
  - Los botones de los formularios se movieron a la región "Breadcrumb Global" de la página 0 de la base.
- **Conversión de la base de 24.2 a 24.1**, que es lo que tiene el contenedor local:
  - los IDs de plantilla de Universal Theme 24.2 se mapean a las plantillas 24.1 equivalentes (tabla `TPL`);
  - `p_attributes` de los ítems se convierte a `p_attribute_NN`;
  - se quita `p_dialog_resizable`;
  - el modo de compatibilidad queda en 21.2, porque 24.1 no acepta '24.2'.
- **Importación local:** `build/run_import_160.sh` corre sin errores.
  - Genera un offset nuevo para no chocar con la app 100.
  - `db/oracle/apex/f160.sql` es la exportación 24.1 de ese estado. **Todavía no está validada en el navegador.**
- **`db/oracle/siif_apex_local.sql`** (solo local) simula los objetos del SIIF que usa la base:
  - los paquetes `SIIF_WEB_USUARIOS`, `WEB_UND_MFA_TOTP` y `UND_COMMOM`;
  - las vistas `V_GEN_OPCIONES_SISTEMA_MENU` y `V_GEN_OPCIONES_USUARIO_ACT`;
  - la tabla `OPCIONES_X_COMPANIA`;
  - un menú SPD (`GEN_OPCIONES_SISTEMA_LOCAL`) que apunta a los alias `SPD_*`.

  Login local: Municipio de Palmira, usuario `fgil666@gmail.com`, clave `Spd#2026`.

## Pendiente

1. **Prueba en navegador** (`build/tests/test_160.js`, Edge + playwright-core):
   - Después del login, la base redirige a `f?p=106:1` (el portal, que no existe en local). Por eso la prueba toma el id de sesión de `apex_workspace_sessions`. Ese cambio ya está en el script y falta correrlo.
   - En la primera corrida todo dio "ok" porque las páginas no cargaban (no había sesión): **no es una prueba válida**.
   - Revisar:
     - cada página 1001-1062;
     - el menú SIIF y las migas al entrar desde el menú (`G_MODULO`/`G_OPCION_MENU`);
     - los botones Regresar/Eliminar/Aplicar Cambios/Nuevo;
     - el guardado de Entidad, el plan (grilla de niveles), la estructura (árbol), el diálogo Datos de la Meta y el formulario de Seguimiento con su grilla de colores;
     - el formato de fecha: la base usa `DS` y SPD usaba `DD/MM/YYYY`.
2. **Corregir lo que salga** en `build_f160.js` y volver a correr:

   ```
   node build_f160.js f160_src.sql && bash run_import_160.sh
   ```

   Luego reexportar con `export_160.sql`. Para eso hay que copiar el `.sql` generado junto al `.sh`, porque el script lo busca en su carpeta.
3. **Validar la importación** del `f160.sql` final en el APEX 24.2 real. Después de importar conviene "Refrescar tema" (queda Universal Theme 24.1) y revisar que el estilo actual sea "Vita (SIIF_WEB)".
4. **Registrar las opciones SPD** en el menú del SIIF (opciones de sistema), con el ejecutable = alias `SPD_*` y la aplicación `SIIF-SPD`. Como guía sirve el árbol de `build/menu_inserts.sql`.
5. **Actualizar `db/oracle/README.md`** con la app 160 cuando quede probada.

## Notas

- La app 100 (`f100.sql`) sigue siendo la fuente de las páginas SPD. Los scripts de parche de la app 100 están en `build/` (`apply_patch.sh` aplica `plan_detail` → `plan_pages` → `company_filter` → `goals_pages` → `monitoring_page` → `ui_standard`).
- Contenedores locales:
  - `spd-oracle`: Oracle 23 Free + APEX 24.1, workspace SPD.
  - `spd-ords`: puerto 8080.
- La URL local de la app 160 es `http://localhost:8080/ords/r/spd/siif-spd/login`.
