/* =============================================================================
   SPD - Opciones del menú de la app 160 SIIF_SPD (alias SIIF-SPD) en GEN_OPCIONES_SISTEMA
   Va en el SIIF real (ambiente de pruebas / clientes), después de importar la app 160.
   En local NO: allí el menú lo crea siif_apex_local.sql (GEN_OPCIONES_SISTEMA_LOCAL),
   con el mismo árbol.

   - Módulo SEGUIMIENTO_PRY, un único padre "SPD" (opción 30) y debajo el árbol del menú
     de SPD. Las opciones son jerárquicas: cada hijo lleva el código del padre más
     01, 02, ... (Configuración 3001, Usuarios 300101).
   - Tipo = REFERENCIA en los padres (tipo_llamada PADRE) y DOCUMENTO en las demás. Ejecutable = alias de la página en la app SIIF-SPD.
   - Descripción = descripción del padre + ' - ' + etiqueta, sin el módulo
     ("SPD - Configuración - Usuarios"). V_GEN_OPCIONES_SISTEMA_MENU muestra como
     etiqueta lo que va después del último '-'.
   - FC_CREACION / CREADO_POR / FC_ACTUALIZACION / ACTUALIZADO_POR los llena el trigger
     GEN_OPCIONES_SISTEMA_BIU; ESTADO queda con su valor por defecto.
   - Se puede re-ejecutar: solo inserta las opciones que no existan (módulo + opción).
   - Solo crea las opciones. La activación por compañía y por usuario
     (GEN_OPCIONES_COMPANIA / GEN_OPCIONES_USUARIO) se hace aparte.

   Antes de correrlo: GEN_OPCIONES_SISTEMA.MODULO debe admitir 15 caracteres
   (SEGUIMIENTO_PRY). Si no, el script se detiene sin insertar nada.
   ============================================================================= */
WHENEVER SQLERROR EXIT FAILURE ROLLBACK
ALTER SESSION SET CURRENT_SCHEMA = SIIF;

-- El nombre del módulo debe caber en la columna.
DECLARE
  c_modulo CONSTANT VARCHAR2(100) := 'SEGUIMIENTO_PRY';
  l_largo  NUMBER;
BEGIN
  SELECT
    char_length
  INTO
    l_largo
  FROM
    all_tab_columns
  WHERE
    owner = SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA')
    AND table_name = 'GEN_OPCIONES_SISTEMA'
    AND column_name = 'MODULO';

  IF LENGTH(c_modulo) > l_largo THEN
    RAISE_APPLICATION_ERROR(-20001, 'El modulo ' || c_modulo || ' tiene ' || LENGTH(c_modulo)
      || ' caracteres y GEN_OPCIONES_SISTEMA.MODULO admite ' || l_largo
      || '. Amplie la columna o use un nombre mas corto. No se inserto ninguna opcion.');
  END IF;
END;
/

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30', NULL, 'SPD', 'SEGUIMIENTO_PRY', 'REFERENCIA', 'PADRE', NULL, 'SIIF-SPD', 'fa-line-chart'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '3001', '30', UNISTR('SPD - Configuraci\00F3n'), 'SEGUIMIENTO_PRY', 'REFERENCIA', 'PADRE', NULL, 'SIIF-SPD', 'fa-cog'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '3001');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300101', '3001', UNISTR('SPD - Configuraci\00F3n - Usuarios'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_USUARIOS', 'SIIF-SPD', 'fa-users'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300101');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300102', '3001', UNISTR('SPD - Configuraci\00F3n - Entidades'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_ENTIDADES', 'SIIF-SPD', 'fa-building-o'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300102');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300103', '3001', UNISTR('SPD - Configuraci\00F3n - Planes de Desarrollo'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_PLANES_DESARROLLO', 'SIIF-SPD', 'fa-tasks'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300103');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300104', '3001', UNISTR('SPD - Configuraci\00F3n - Metas'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_METAS', 'SIIF-SPD', 'fa-bullseye'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300104');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300105', '3001', UNISTR('SPD - Configuraci\00F3n - Proyectos'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_PROYECTOS', 'SIIF-SPD', 'fa-sitemap'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300105');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300106', '3001', UNISTR('SPD - Configuraci\00F3n - Seguimiento'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_SEGUIMIENTOS', 'SIIF-SPD', 'fa-line-chart'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300106');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300107', '3001', UNISTR('SPD - Configuraci\00F3n - Pol\00EDticas'), 'SEGUIMIENTO_PRY', 'REFERENCIA', 'PADRE', NULL, 'SIIF-SPD', NULL
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300107');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30010701', '300107', UNISTR('SPD - Configuraci\00F3n - Pol\00EDticas - Componentes'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_COMPONENTES_POLITICA', 'SIIF-SPD', 'fa-cube'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30010701');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30010702', '300107', UNISTR('SPD - Configuraci\00F3n - Pol\00EDticas - Nacionales'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_POLITICAS_NACIONALES', 'SIIF-SPD', 'fa-flag'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30010702');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30010703', '300107', UNISTR('SPD - Configuraci\00F3n - Pol\00EDticas - Territoriales'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_POLITICAS_TERRITORIALES', 'SIIF-SPD', 'fa-flag'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30010703');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '3002', '30', UNISTR('SPD - Cat\00E1logos'), 'SEGUIMIENTO_PRY', 'REFERENCIA', 'PADRE', NULL, 'SIIF-SPD', 'fa-cubes'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '3002');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300201', '3002', UNISTR('SPD - Cat\00E1logos - ODS'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_ODS', 'SIIF-SPD', 'fa-clipboard'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300201');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300202', '3002', UNISTR('SPD - Cat\00E1logos - Unidades'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_UNIDADES', 'SIIF-SPD', 'fa-cube'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300202');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300203', '3002', UNISTR('SPD - Cat\00E1logos - Productos'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_PRODUCTOS', 'SIIF-SPD', 'fa-list-alt'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300203');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '3003', '30', 'SPD - Seguimiento', 'SEGUIMIENTO_PRY', 'REFERENCIA', 'PADRE', NULL, 'SIIF-SPD', 'fa-line-chart'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '3003');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300301', '3003', 'SPD - Seguimiento - Metas', 'SEGUIMIENTO_PRY', 'REFERENCIA', 'PADRE', NULL, 'SIIF-SPD', 'fa-line-chart'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300301');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030101', '300301', UNISTR('SPD - Seguimiento - Metas - Configuraci\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_SEGUIMIENTOS', 'SIIF-SPD', 'fa-cog'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030101');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030102', '300301', 'SPD - Seguimiento - Metas - Metas', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_METAS', 'SIIF-SPD', 'fa-bullseye'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030102');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030103', '300301', UNISTR('SPD - Seguimiento - Metas - Programaci\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_PROGRAMACION_METAS', 'SIIF-SPD', 'fa-clipboard'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030103');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030104', '300301', 'SPD - Seguimiento - Metas - Reporte', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_REPORTE_METAS', 'SIIF-SPD', 'fa-file-o'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030104');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030105', '300301', UNISTR('SPD - Seguimiento - Metas - Validaci\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_VALIDACION_METAS', 'SIIF-SPD', 'fa-check'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030105');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030106', '300301', UNISTR('SPD - Seguimiento - Metas - Revisi\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_REVISION_METAS', 'SIIF-SPD', 'fa-edit'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030106');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030107', '300301', 'SPD - Seguimiento - Metas - Tableros de Control', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_TABLERO_METAS', 'SIIF-SPD', 'fa-pie-chart'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030107');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300302', '3003', 'SPD - Seguimiento - Proyectos', 'SEGUIMIENTO_PRY', 'REFERENCIA', 'PADRE', NULL, 'SIIF-SPD', 'fa-sitemap'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300302');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030201', '300302', UNISTR('SPD - Seguimiento - Proyectos - Configuraci\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_SEGUIMIENTOS', 'SIIF-SPD', 'fa-cog'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030201');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030202', '300302', 'SPD - Seguimiento - Proyectos - Proyectos', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_PROYECTOS', 'SIIF-SPD', 'fa-list-ul'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030202');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030203', '300302', UNISTR('SPD - Seguimiento - Proyectos - Programaci\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_PROGRAMACION_PROYECTOS', 'SIIF-SPD', 'fa-clipboard'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030203');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030204', '300302', 'SPD - Seguimiento - Proyectos - Reporte', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_REPORTE_PROYECTOS', 'SIIF-SPD', 'fa-file-o'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030204');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030205', '300302', UNISTR('SPD - Seguimiento - Proyectos - Validaci\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_VALIDACION_PROYECTOS', 'SIIF-SPD', 'fa-check'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030205');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030206', '300302', UNISTR('SPD - Seguimiento - Proyectos - Revisi\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_REVISION_PROYECTOS', 'SIIF-SPD', 'fa-edit'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030206');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030207', '300302', 'SPD - Seguimiento - Proyectos - Tableros de Control', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_TABLERO_PROYECTOS', 'SIIF-SPD', 'fa-pie-chart'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030207');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300303', '3003', UNISTR('SPD - Seguimiento - Planes de Acci\00F3n'), 'SEGUIMIENTO_PRY', 'REFERENCIA', 'PADRE', NULL, 'SIIF-SPD', 'fa-tasks'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300303');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030301', '300303', UNISTR('SPD - Seguimiento - Planes de Acci\00F3n - Configuraci\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_SEGUIMIENTOS', 'SIIF-SPD', 'fa-cog'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030301');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030302', '300303', UNISTR('SPD - Seguimiento - Planes de Acci\00F3n - Planes de Acci\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_PLANES_ACCION', 'SIIF-SPD', 'fa-tasks'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030302');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030303', '300303', UNISTR('SPD - Seguimiento - Planes de Acci\00F3n - Programaci\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_PROGRAMACION_PLANES_ACCION', 'SIIF-SPD', 'fa-clipboard'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030303');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030304', '300303', UNISTR('SPD - Seguimiento - Planes de Acci\00F3n - Reporte'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_REPORTE_PLANES_ACCION', 'SIIF-SPD', 'fa-file-o'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030304');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030305', '300303', UNISTR('SPD - Seguimiento - Planes de Acci\00F3n - Validaci\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_VALIDACION_PLANES_ACCION', 'SIIF-SPD', 'fa-check'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030305');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030306', '300303', UNISTR('SPD - Seguimiento - Planes de Acci\00F3n - Revisi\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_REVISION_PLANES_ACCION', 'SIIF-SPD', 'fa-edit'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030306');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030307', '300303', UNISTR('SPD - Seguimiento - Planes de Acci\00F3n - Tableros de Control'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_TABLERO_PLANES_ACCION', 'SIIF-SPD', 'fa-pie-chart'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030307');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300304', '3003', UNISTR('SPD - Seguimiento - Pol\00EDticas'), 'SEGUIMIENTO_PRY', 'REFERENCIA', 'PADRE', NULL, 'SIIF-SPD', 'fa-flag'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300304');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030401', '300304', UNISTR('SPD - Seguimiento - Pol\00EDticas - Configuraci\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_SEGUIMIENTOS', 'SIIF-SPD', 'fa-cog'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030401');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030402', '300304', UNISTR('SPD - Seguimiento - Pol\00EDticas - Pol\00EDticas'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'EN-CONSTRUCCION', 'SIIF-SPD', 'fa-flag'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030402');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030403', '300304', UNISTR('SPD - Seguimiento - Pol\00EDticas - Programaci\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'EN-CONSTRUCCION', 'SIIF-SPD', 'fa-clipboard'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030403');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030404', '300304', UNISTR('SPD - Seguimiento - Pol\00EDticas - Reporte'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'EN-CONSTRUCCION', 'SIIF-SPD', 'fa-file-o'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030404');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030405', '300304', UNISTR('SPD - Seguimiento - Pol\00EDticas - Validaci\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'EN-CONSTRUCCION', 'SIIF-SPD', 'fa-check'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030405');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030406', '300304', UNISTR('SPD - Seguimiento - Pol\00EDticas - Revisi\00F3n'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'EN-CONSTRUCCION', 'SIIF-SPD', 'fa-edit'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030406');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '30030407', '300304', UNISTR('SPD - Seguimiento - Pol\00EDticas - Tableros de Control'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'EN-CONSTRUCCION', 'SIIF-SPD', 'fa-pie-chart'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '30030407');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '3004', '30', 'SPD - Asistente', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_ASISTENTE', 'SIIF-SPD', 'fa-magic'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '3004');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '3005', '30', 'SPD - Otros', 'SEGUIMIENTO_PRY', 'REFERENCIA', 'PADRE', NULL, 'SIIF-SPD', 'fa-ellipsis-h'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '3005');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300501', '3005', 'SPD - Otros - Inicio', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_INICIO', 'SIIF-SPD', 'fa-home'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300501');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300502', '3005', 'SPD - Otros - Niveles del plan', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_NIVELES_PLAN', 'SIIF-SPD', 'fa-sitemap'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300502');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300503', '3005', 'SPD - Otros - Metas de actividades', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_METAS_ACTIVIDADES', 'SIIF-SPD', 'fa-tasks'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300503');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300504', '3005', 'SPD - Otros - Metas por actividad', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_METAS_POR_ACTIVIDAD', 'SIIF-SPD', 'fa-link'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300504');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300505', '3005', 'SPD - Otros - Macroproyectos', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_MACROPROYECTOS', 'SIIF-SPD', 'fa-cubes'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300505');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300506', '3005', 'SPD - Otros - Ubicaciones', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_UBICACIONES', 'SIIF-SPD', 'fa-map-marker'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300506');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300507', '3005', UNISTR('SPD - Otros - Componentes por pol\00EDtica'), 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_COMPONENTES_POR_POLITICA', 'SIIF-SPD', 'fa-chain'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300507');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300508', '3005', 'SPD - Otros - Historial de metas', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_HISTORIAL_METAS', 'SIIF-SPD', 'fa-history'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300508');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300509', '3005', 'SPD - Otros - Avance de metas', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_AVANCE_METAS', 'SIIF-SPD', 'fa-tachometer'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300509');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300510', '3005', 'SPD - Otros - Registros de seguimiento', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_REGISTROS_SEGUIMIENTO', 'SIIF-SPD', 'fa-line-chart'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300510');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300511', '3005', 'SPD - Otros - Tablero de seguimiento', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_TABLERO_SEGUIMIENTO', 'SIIF-SPD', 'fa-dashboard'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300511');

INSERT INTO gen_opciones_sistema (opcion, opc_padre, descripcion, modulo, tipo, tipo_llamada, ejecutable, aplicacion, menu_icon)
SELECT '300512', '3005', 'SPD - Otros - Tablero financiero', 'SEGUIMIENTO_PRY', 'DOCUMENTO', 'FORM', 'SPD_TABLERO_FINANCIERO', 'SIIF-SPD', 'fa-money'
FROM   dual
WHERE  NOT EXISTS (SELECT 1 FROM gen_opciones_sistema WHERE modulo = 'SEGUIMIENTO_PRY' AND opcion = '300512');

COMMIT;

-- Verificación: deben ser 63 opciones.
SELECT
  COUNT(*) opciones
FROM
  gen_opciones_sistema
WHERE
  modulo = 'SEGUIMIENTO_PRY';
