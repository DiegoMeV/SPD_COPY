-- =============================================================================
-- SOLO PARA AMBIENTES LOCALES / DE DESARROLLO. NO ejecutar en el SIIF real.
--
-- Simula los objetos del SIIF que usa la app APEX base (SIIF Web) para poder
-- probar la app 160 (SIIF_SPD) en un contenedor sin el SIIF completo:
--   - paquetes SIIF_WEB_USUARIOS, WEB_UND_MFA_TOTP y UND_COMMOM
--   - vistas V_GEN_OPCIONES_SISTEMA_MENU y V_GEN_OPCIONES_USUARIO_ACT
--   - tabla OPCIONES_X_COMPANIA (vacía)
-- El menú local (GEN_OPCIONES_SISTEMA_LOCAL) replica el menú original de SPD,
-- apuntando a los alias SPD_* de la app 160.
-- Login local: cualquier usuario de USUARIOS con la clave 'Spd#2026'.
-- Ejecutar como SIIF, después de siif_base_tables.sql y spd_seed.sql.
-- =============================================================================

begin
  for t in (select table_name from user_tables
             where table_name in ('GEN_OPCIONES_SISTEMA_LOCAL', 'OPCIONES_X_COMPANIA')) loop
    execute immediate 'drop table ' || t.table_name || ' purge';
  end loop;
end;
/

create table gen_opciones_sistema_local (
  modulo        varchar2(10)  not null,
  opcion        varchar2(30)  not null,
  opc_padre     varchar2(30),
  label         varchar2(200) not null,
  orden         number,
  tipo_llamada  varchar2(10)  not null,   -- PADRE / FORM / REPORT / URL
  aplicacion    varchar2(30),
  ejecutable    varchar2(255),            -- alias o número de página
  parametros    varchar2(4000),
  valores       varchar2(4000),
  menu_icon     varchar2(100),
  constraint gen_opciones_sistema_local_pk primary key (modulo, opcion)
);

create table opciones_x_compania (
  nit_compania    varchar2(20),
  modulo          varchar2(10),
  opcion          varchar2(30),
  estado          varchar2(10),
  ejecutable_apex varchar2(255)
);

create or replace view v_gen_opciones_sistema_menu as
select level                                          as lvl,
       m.modulo, m.opcion, m.opc_padre, m.label, m.tipo_llamada, m.aplicacion,
       m.ejecutable, m.parametros, m.valores, m.menu_icon,
       sys_connect_by_path(m.opcion, '/')             as path_opcion,
       '/' || m.modulo || sys_connect_by_path(m.label, '/') as path_label
  from gen_opciones_sistema_local m
 start with m.opc_padre is null
connect by m.opc_padre = prior m.opcion and m.modulo = prior m.modulo;

create or replace view v_gen_opciones_usuario_act as
select m.modulo, m.opcion, u.usuario, u.nit_compania, 'N' as solo_consulta
  from gen_opciones_sistema_local m
 cross join usuarios u;

create or replace package und_commom as
  function valorparametro (p_parametro in varchar2, p_nit_compania in varchar2) return varchar2;
end und_commom;
/
create or replace package body und_commom as
  function valorparametro (p_parametro in varchar2, p_nit_compania in varchar2) return varchar2 is
  begin
    return case p_parametro
             when 'FORMS_SERVER_SCHEME' then 'http'
             when 'FORMS_SERVER_NAME'   then 'localhost'
           end;
  end valorparametro;
end und_commom;
/

create or replace package web_und_mfa_totp as
  procedure limpiar_sesion;
end web_und_mfa_totp;
/
create or replace package body web_und_mfa_totp as
  procedure limpiar_sesion is begin null; end;
end web_und_mfa_totp;
/

create or replace package siif_web_usuarios as
  function validar_credenciales (p_username in varchar2, p_password in varchar2) return boolean;
  procedure set_items_aplicacion (p_usuario in varchar2);
  procedure cambiar_password (p_username in varchar2, p_nit_compania in varchar2, p_password in varchar2);
end siif_web_usuarios;
/
create or replace package body siif_web_usuarios as
  function nit return varchar2 is
  begin
    return nvl(sys_context('APEX$SESSION', 'APP_TENANT_ID'), '8913800073');
  end nit;

  function validar_credenciales (p_username in varchar2, p_password in varchar2) return boolean is
    l_n   number;
    l_nit varchar2(20) := nit();
  begin
    select count(*) into l_n from usuarios
     where upper(usuario) = upper(p_username) and nit_compania = l_nit;
    return l_n > 0 and p_password = 'Spd#2026';
  end validar_credenciales;

  procedure set_items_aplicacion (p_usuario in varchar2) is
    l_usuario usuarios.usuario%type;
    l_nombre  varchar2(400);
    l_nit     varchar2(20) := nit();
  begin
    select max(usuario) into l_usuario from usuarios
     where upper(usuario) = upper(p_usuario) and nit_compania = l_nit;
    select max(nombre) into l_nombre from compania where nit_compania = l_nit;
    apex_util.set_session_state('G_USUARIO', l_usuario);
    apex_util.set_session_state('G_NOMBRE_USUARIO', l_usuario);
    apex_util.set_session_state('G_NIT_COMPANIA', nit());
    apex_util.set_session_state('G_NOMBRE_COMPANIA', l_nombre);
    apex_util.set_session_state('G_CAMBIAR_PWD', 'N');
    apex_util.set_session_state('G_MODULO', 'SPD');
  end set_items_aplicacion;

  procedure cambiar_password (p_username in varchar2, p_nit_compania in varchar2, p_password in varchar2) is
  begin
    null;
  end cambiar_password;
end siif_web_usuarios;
/

update compania set activar_apex = 'S'
 where nit_compania in (select distinct nit_compania from usuarios);

-- Menú SPD (mismo árbol que client/components/AppMenu/hooks.ts)
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD010', null, 'Configuración', 10, 'PADRE', 'SIIF-SPD', null, 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD120', null, 'Catálogos', 120, 'PADRE', 'SIIF-SPD', null, 'fa-cubes');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD160', null, 'Seguimiento', 160, 'PADRE', 'SIIF-SPD', null, 'fa-line-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD490', null, 'Asistente', 490, 'FORM', 'SIIF-SPD', 'SPD_ASISTENTE', 'fa-magic');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD500', null, 'Otros', 500, 'PADRE', 'SIIF-SPD', null, 'fa-ellipsis-h');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD020', 'SPD010', 'Usuarios', 20, 'FORM', 'SIIF-SPD', 'SPD_USUARIOS', 'fa-users');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD030', 'SPD010', 'Entidades', 30, 'FORM', 'SIIF-SPD', 'SPD_ENTIDADES', 'fa-building-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD040', 'SPD010', 'Planes de Desarrollo', 40, 'FORM', 'SIIF-SPD', 'SPD_PLANES_DESARROLLO', 'fa-tasks');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD050', 'SPD010', 'Metas', 50, 'FORM', 'SIIF-SPD', 'SPD_METAS', 'fa-bullseye');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD060', 'SPD010', 'Proyectos', 60, 'FORM', 'SIIF-SPD', 'SPD_PROYECTOS', 'fa-sitemap');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD070', 'SPD010', 'Seguimiento', 70, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-line-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD080', 'SPD010', 'Políticas', 80, 'PADRE', 'SIIF-SPD', null, null);
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD090', 'SPD080', 'Componentes', 90, 'FORM', 'SIIF-SPD', 'SPD_COMPONENTES_POLITICA', 'fa-cube');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD100', 'SPD080', 'Nacionales', 100, 'FORM', 'SIIF-SPD', 'SPD_POLITICAS_NACIONALES', 'fa-flag');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD110', 'SPD080', 'Territoriales', 110, 'FORM', 'SIIF-SPD', 'SPD_POLITICAS_TERRITORIALES', 'fa-flag');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD130', 'SPD120', 'ODS', 130, 'FORM', 'SIIF-SPD', 'SPD_ODS', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD140', 'SPD120', 'Unidades', 140, 'FORM', 'SIIF-SPD', 'SPD_UNIDADES', 'fa-cube');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD150', 'SPD120', 'Productos', 150, 'FORM', 'SIIF-SPD', 'SPD_PRODUCTOS', 'fa-list-alt');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD170', 'SPD160', 'Metas', 170, 'PADRE', 'SIIF-SPD', null, 'fa-line-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD250', 'SPD160', 'Proyectos', 250, 'PADRE', 'SIIF-SPD', null, 'fa-sitemap');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD330', 'SPD160', 'Planes de Acción', 330, 'PADRE', 'SIIF-SPD', null, 'fa-tasks');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD410', 'SPD160', 'Políticas', 410, 'PADRE', 'SIIF-SPD', null, 'fa-flag');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD180', 'SPD170', 'Configuración', 180, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD190', 'SPD170', 'Metas', 190, 'FORM', 'SIIF-SPD', 'SPD_METAS', 'fa-bullseye');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD200', 'SPD170', 'Programación', 200, 'FORM', 'SIIF-SPD', 'SPD_PROGRAMACION_METAS', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD210', 'SPD170', 'Reporte', 210, 'FORM', 'SIIF-SPD', 'SPD_REPORTE_METAS', 'fa-file-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD220', 'SPD170', 'Validación', 220, 'FORM', 'SIIF-SPD', 'SPD_VALIDACION_METAS', 'fa-check');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD230', 'SPD170', 'Revisión', 230, 'FORM', 'SIIF-SPD', 'SPD_REVISION_METAS', 'fa-edit');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD240', 'SPD170', 'Tableros de Control', 240, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_METAS', 'fa-pie-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD260', 'SPD250', 'Configuración', 260, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD270', 'SPD250', 'Proyectos', 270, 'FORM', 'SIIF-SPD', 'SPD_PROYECTOS', 'fa-list-ul');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD280', 'SPD250', 'Programación', 280, 'FORM', 'SIIF-SPD', 'SPD_PROGRAMACION_PROYECTOS', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD290', 'SPD250', 'Reporte', 290, 'FORM', 'SIIF-SPD', 'SPD_REPORTE_PROYECTOS', 'fa-file-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD300', 'SPD250', 'Validación', 300, 'FORM', 'SIIF-SPD', 'SPD_VALIDACION_PROYECTOS', 'fa-check');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD310', 'SPD250', 'Revisión', 310, 'FORM', 'SIIF-SPD', 'SPD_REVISION_PROYECTOS', 'fa-edit');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD320', 'SPD250', 'Tableros de Control', 320, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_PROYECTOS', 'fa-pie-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD340', 'SPD330', 'Configuración', 340, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD350', 'SPD330', 'Planes de Acción', 350, 'FORM', 'SIIF-SPD', 'SPD_PLANES_ACCION', 'fa-tasks');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD360', 'SPD330', 'Programación', 360, 'FORM', 'SIIF-SPD', 'SPD_PROGRAMACION_PLANES_ACCION', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD370', 'SPD330', 'Reporte', 370, 'FORM', 'SIIF-SPD', 'SPD_REPORTE_PLANES_ACCION', 'fa-file-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD380', 'SPD330', 'Validación', 380, 'FORM', 'SIIF-SPD', 'SPD_VALIDACION_PLANES_ACCION', 'fa-check');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD390', 'SPD330', 'Revisión', 390, 'FORM', 'SIIF-SPD', 'SPD_REVISION_PLANES_ACCION', 'fa-edit');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD400', 'SPD330', 'Tableros de Control', 400, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_PLANES_ACCION', 'fa-pie-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD420', 'SPD410', 'Configuración', 420, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD430', 'SPD410', 'Políticas', 430, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-flag');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD440', 'SPD410', 'Programación', 440, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD450', 'SPD410', 'Reporte', 450, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-file-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD460', 'SPD410', 'Validación', 460, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-check');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD470', 'SPD410', 'Revisión', 470, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-edit');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD480', 'SPD410', 'Tableros de Control', 480, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-pie-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD510', 'SPD500', 'Inicio', 510, 'FORM', 'SIIF-SPD', 'SPD_INICIO', 'fa-home');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD520', 'SPD500', 'Niveles del plan', 520, 'FORM', 'SIIF-SPD', 'SPD_NIVELES_PLAN', 'fa-sitemap');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD530', 'SPD500', 'Metas de actividades', 530, 'FORM', 'SIIF-SPD', 'SPD_METAS_ACTIVIDADES', 'fa-tasks');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD540', 'SPD500', 'Metas por actividad', 540, 'FORM', 'SIIF-SPD', 'SPD_METAS_POR_ACTIVIDAD', 'fa-link');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD550', 'SPD500', 'Macroproyectos', 550, 'FORM', 'SIIF-SPD', 'SPD_MACROPROYECTOS', 'fa-cubes');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD560', 'SPD500', 'Ubicaciones', 560, 'FORM', 'SIIF-SPD', 'SPD_UBICACIONES', 'fa-map-marker');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD570', 'SPD500', 'Componentes por política', 570, 'FORM', 'SIIF-SPD', 'SPD_COMPONENTES_POR_POLITICA', 'fa-chain');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD580', 'SPD500', 'Historial de metas', 580, 'FORM', 'SIIF-SPD', 'SPD_HISTORIAL_METAS', 'fa-history');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD590', 'SPD500', 'Avance de metas', 590, 'FORM', 'SIIF-SPD', 'SPD_AVANCE_METAS', 'fa-tachometer');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD600', 'SPD500', 'Registros de seguimiento', 600, 'FORM', 'SIIF-SPD', 'SPD_REGISTROS_SEGUIMIENTO', 'fa-line-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD610', 'SPD500', 'Tablero de seguimiento', 610, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_SEGUIMIENTO', 'fa-dashboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SPD', 'SPD620', 'SPD500', 'Tablero financiero', 620, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_FINANCIERO', 'fa-money');
commit;
