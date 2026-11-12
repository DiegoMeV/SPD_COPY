# SPD en Oracle

Scripts para crear las tablas de SPD en Oracle (esquema `SIIF`) y la aplicación Oracle APEX.

## Archivos

| Archivo | Qué hace | ¿Va en el SIIF real? |
|---|---|---|
| `siif_base_tables.sql` | Crea `COMPANIA`, `ENTIDADES_PRY`, `PLAN_DESARROLLO`, `PROYECTO` y `USUARIOS` (DDL original del SIIF) y una versión mínima de la vista `V_PROYECTO` | **No.** Solo para ambientes locales o de desarrollo |
| `siif_spd_columns.sql` | Agrega columnas `SPD_*` a `ENTIDADES_PRY` y `PLAN_DESARROLLO` | Sí, **revisado por el DBA**: es el único script que modifica tablas del SIIF (solo agrega columnas opcionales) |
| `spd_schema.sql` | Crea las 18 tablas `SPD_*` | Sí |
| `spd_views.sql` | Vistas para reportes, tableros y listas de valores (`V_SPD_*`), incluidas `V_SPD_PLAN_LEVEL_CONFIG` (definición de niveles de cada plan, desde `SPD_CONFIG`) y `V_SPD_MONITORING_COLORS` (colores de indicadores, desde `COLORS_CONFIG`) | Sí |
| `spd_seed.sql` | Datos de prueba (Palmira y Risaralda, catálogos, usuarios) | **No.** Solo para pruebas |
| `apex/f100.sql` | Aplicación APEX 24.1 | Sí |

Orden de ejecución, conectado como el dueño del esquema (`SIIF`):

```
@siif_base_tables.sql   -- solo en local / desarrollo
@siif_spd_columns.sql
@spd_schema.sql
@spd_views.sql
@spd_seed.sql           -- opcional, datos de prueba
```

Probado en Oracle 23 Free. Usa columnas `IDENTITY`, `DEFAULT ON NULL` y `CHECK ... IS JSON`, disponibles desde Oracle 12c, así que debería funcionar en 19c.

## Cómo se relaciona SPD con el SIIF

| En SPD (PostgreSQL) | En Oracle |
|---|---|
| `tenant` | `COMPANIA` (`NIT_COMPANIA`) |
| `entity` | `ENTIDADES_PRY` (`ID`) + columnas `SPD_*` |
| `dev_plan` | `PLAN_DESARROLLO` (`NIT_COMPANIA`, `PLAN`) + columnas `SPD_*` |
| `user_account` | `USUARIOS` (`NIT_COMPANIA`, `USUARIO`) |
| `siif_proyecto` | `PROYECTO` (`NIT_COMPANIA`, `PROYECTO`) |
| el resto (`goal`, `monitoring_*`, ...) | tablas nuevas `SPD_*` |

- Las tablas SPD se enlazan al plan por `(NIT_COMPANIA, PLAN)`, porque `PLAN_DESARROLLO.ID` no tiene `UNIQUE`.
- `CREATED_BY` / `UPDATED_BY` guardan `USUARIOS.ID` (sin FK, porque esa columna tampoco es única).
- La tabla `goal` se llama `SPD_GOAL` porque `SPD_META` ya existe en el SIIF.

## Aplicación APEX (`apex/f100.sql`)

Requiere **APEX 24.1 o superior** y que el esquema de análisis del workspace tenga las tablas y vistas anteriores.

Para importarla:

1. *App Builder → Import* → seleccionar `f100.sql`.
2. Esquema de análisis: el que contiene las tablas `SPD_*` (normalmente `SIIF`).
3. ID de la aplicación: elegir uno libre si el 100 ya está en uso.

### Menú

Es igual al de la aplicación original de SPD (`client/components/AppMenu/hooks.ts`). Cada pantalla replica las columnas de las tablas y los campos de los formularios del original (`client/components/**`), con las mismas etiquetas y orden.

| Menú | Pantalla en APEX |
|---|---|
| Configuración › Usuarios / Entidades | Reporte + formulario sobre `USUARIOS` y `ENTIDADES_PRY` (las columnas `SPD_*` incluidas) |
| Configuración › Planes de Desarrollo | Reporte de planes. El enlace de cada plan abre sus **Detalles**: datos del plan, niveles configurados y la estructura en árbol, con los botones *Editar* y *Editar Estructura*. **Editar** es una página (no diálogo) con el formulario de `PLAN_DESARROLLO` y, como en el original, la grilla "Niveles" con la definición de niveles del plan: Nivel, Nombre Singular, Nombre Plural, Tipo de meta, Asocia sector DNP. Se guarda en `SPD_CONFIG.levels` con el botón del formulario y los niveles se renumeran 1..n. **Estructura** muestra el árbol de niveles: al seleccionar un nodo se puede editar (Código, Nombre, Sector DNP, Ponderación), eliminar junto con sus hijos o crear un hijo, con el nombre del nivel que define el plan (p. ej. "Editar CAPITAL", "Crear SECTOR") |
| Configuración › Metas | Pestañas como en el original. **Listado**: reporte con el total de metas en un badge; el ícono de cada meta abre **Datos de la Meta** (diálogo de solo lectura con *Editar*). **Por Estructura del Plan**: selector de plan, árbol del plan con un badge por tipo de meta (metas del nodo y sus hijos, con los colores del original) y, a la derecha, las metas del nodo seleccionado. El formulario "Nueva meta" tiene sus ~25 campos (ODS como casillas) |
| Configuración › Proyectos | Reporte sobre la vista `V_PROYECTO` del SIIF (Proyecto, Nombre, Entidad) |
| Configuración › Seguimiento | Crear y editar en una página (no diálogo). Parámetros de seguimiento: "Seguimiento para" y "Documento de ejecución" como casillas y las 8 fechas de programación / reporte / validación / revisión. Debajo, **Colores de Indicadores** (Desde, Incluye desde?, Hasta, Incluye hasta?, Color, Etiqueta) con la vista previa de la barra de colores; se guarda en `COLORS_CONFIG` con el botón del formulario |
| Configuración › Políticas › Componentes / Nacionales / Territoriales | Reporte + formulario; nacionales = paz y víctimas, territoriales con año inicial y final |
| Catálogos › ODS / Unidades / Productos | Grillas (ODS, unidades); productos como Sector › Programa › Producto › Indicador |
| Seguimiento › Metas, Proyectos, Planes de Acción › Programación / Reporte / Validación / Revisión | Listado de metas por seguimiento con su estado en esa etapa ("Sin Programar", "Sin Reportar", "Sin Validar", "Sin Revisar"…) — vista `V_SPD_GOAL_MONITORING` |
| Seguimiento › … › Tableros de Control | Tabla "Avance de Metas": programado, ejecutado, apropiado, compromisos, obligaciones, avance físico y financiero |
| Seguimiento › Planes de Acción › Planes de Acción | Listado de planes de acción |
| Seguimiento › … › Configuración | Configuración de seguimiento |
| Seguimiento › Políticas › (resto) | **En construcción** (en la app original estas opciones no tienen página) |
| Asistente | Tarjetas con los accesos del asistente original |
| **Otros** (no está en el original) | Inicio, niveles del plan, metas de actividades, metas por actividad, macroproyectos, ubicaciones, componentes por política, historial de metas, avance de metas, registros de seguimiento, tablero de seguimiento, tablero financiero |

Diferencias con el original:

- **Pantallas de seguimiento:** en el original se elige el seguimiento activo en la cabecera; aquí los listados muestran una columna "Seguimiento" para filtrar. Son de solo lectura: las acciones Programar / Reportar / Validar / Revisar no están migradas.
- **Planes de desarrollo:**
  - El original los muestra como tarjetas; aquí son una tabla.
  - El árbol de la estructura no tiene el buscador del original. Al seleccionar un nodo se recarga la página (la única línea de JavaScript expande el nodo seleccionado).
  - No se puede eliminar un nivel si él o alguno de sus hijos tiene metas asociadas.
  - Al eliminar o reordenar niveles en la definición, los nodos ya creados en `SPD_DEV_PLAN_LEVEL` conservan su número de nivel (igual que en el original).
- **Metas:**
  - El árbol no tiene buscador; seleccionar un nodo recarga la página. Los badges los pinta un script corto, porque el Tree de APEX escapa el HTML de las etiquetas.
  - El listado no tiene el filtro por árbol en la columna "Nivel Plan"; se filtra con las herramientas del reporte interactivo.
- **Políticas:** no se muestran el conteo de componentes y metas, ni el selector de componentes en el formulario.
- **Usuarios:**
  - No hay columna Rol, porque `USUARIOS` no tiene el rol de SPD.
  - Tampoco están "Cambiar clave" ni la contraseña al crear; la clave toma el valor por defecto del SIIF.

### Estándar de diseño SIIFWEB

Las páginas siguen el *Manual Estándar de Diseño APEX v2.0*:

- **Breadcrumb Global:** región en la Página Global (0) con las migas del menú y el título de la página. Reemplaza los breadcrumbs de cada página.
- **Formularios:** todos son páginas, no diálogos; solo "Datos de la Meta" sigue como diálogo, porque es de solo lectura. Sus botones van en el Breadcrumb Global en este orden:
  - *Regresar* (Close, `fa-arrow-left`);
  - *Eliminar* (Delete, Danger · Simple);
  - *Aplicar Cambios* (Edit, directa);
  - *Nuevo* (Create, `fa-file-plus`, solo al editar).
- **Reportes:** el botón *Nuevo* va en el Breadcrumb Global.
- **Botones de región:** son Text with Icon · Success, arriba a la derecha de su región, como en Estructura del plan (*Guardar*, *Crear*) y en Detalles (*Editar Estructura*).
- **Cuadrículas:**
  - Barra con Acciones / Editar / Guardar / Nuevo. Guardar no aparece si la página tiene *Aplicar Cambios*.
  - No agregan una fila vacía ni seleccionan la primera fila.
  - Alineación: casillas centradas, valores monetarios a la derecha y el resto a la izquierda.
- **Textos internos de APEX en español** (barras, paginación, mensajes): son mensajes de texto de la aplicación con el mismo nombre que los de APEX.

No se usan todavía el menú *Acciones* (ninguna página tiene varias acciones adicionales) ni el botón *Buscar* (no hay regiones de filtros; el selector de plan de Metas consulta al cambiar).

En los formularios de `USUARIOS`, `ENTIDADES_PRY` y `PLAN_DESARROLLO`, la llave (compañía + usuario / código / número de plan) se escribe al crear y queda de solo lectura al editar. Las columnas del SIIF que el formulario original no tiene quedan ocultas y toman los valores por defecto de la tabla al crear.

### Pendiente antes de producción

- **Autenticación:** la app usa *Cuentas de APEX*. Hay que cambiarla por la del SIIF (por ejemplo, validando contra `USUARIOS.CONTRASENA`).
- **Roles:** por ahora todos los usuarios ven todas las opciones.
- **Compañía activa:** el ítem de aplicación `G_NIT_COMPANIA` filtra reportes, grillas, gráficos y listas de valores por `NIT_COMPANIA`, y es el valor por defecto de la compañía en los formularios. Hoy se inicializa con Municipio de Palmira (`8913800073`) en cada sesión nueva (cómputo de aplicación). Falta asignarlo según el usuario que inicia sesión (`USUARIOS.NIT_COMPANIA`) cuando se cambie la autenticación.
- **Listas en cascada:** en el formulario de metas, "Nivel del plan" se filtra por el plan elegido; las demás listas (meta padre, etc.) solo se filtran por compañía.
- **Flujo de seguimiento:** las pantallas permiten ver y editar registros, pero la lógica de programar → reportar → validar → revisar (hoy en TypeScript) no está migrada. Son las opciones "En construcción" del menú.
- **Formularios del SIIF:** al editar `USUARIOS`, `ENTIDADES_PRY` y `PLAN_DESARROLLO` desde SPD no se disparan validaciones propias del SIIF que vivan fuera de la base (en sus formularios originales).
