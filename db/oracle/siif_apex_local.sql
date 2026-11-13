-- =============================================================================
-- SOLO PARA AMBIENTES LOCALES / DE DESARROLLO. NO ejecutar en el SIIF real.
--
-- Simula los objetos del SIIF que usan la app 106 (SIIF Web, portal de entrada)
-- y la app base 154 (SIIF Web BASE) para poder probar la app 160 (SIIF_SPD) en
-- un contenedor sin el SIIF completo:
--   - paquetes SIIF_WEB_USUARIOS, WEB_UND_MFA_TOTP (sin MFA: siempre deja pasar)
--     y UND_COMMOM
--   - vistas V_GEN_OPCIONES_SISTEMA_MENU y V_GEN_OPCIONES_USUARIO_ACT
--   - tabla OPCIONES_X_COMPANIA (vacía)
--   - tabla GEN_APEX_AUTH_TOKENS (login por token, página 9991 de la 106; DDL
--     igual al de SVN_APEX/DB/scripts/init.sql)
-- El menú local (GEN_OPCIONES_SISTEMA_LOCAL) replica el menú original de SPD,
-- apuntando a los alias SPD_* de la app 160.
-- Login local: cualquier usuario de USUARIOS con la clave 'Spd#2026'.
-- Ejecutar como SIIF, después de siif_base_tables.sql y spd_seed.sql.
-- =============================================================================

begin
  for t in (select table_name from user_tables
             where table_name in ('GEN_OPCIONES_SISTEMA_LOCAL', 'OPCIONES_X_COMPANIA',
                                  'GEN_APEX_AUTH_TOKENS')) loop
    execute immediate 'drop table ' || t.table_name || ' purge';
  end loop;
end;
/

create table gen_opciones_sistema_local (
  modulo        varchar2(30)  not null,
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
  modulo          varchar2(30),
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

create table gen_apex_auth_tokens (
  token          varchar2(100)  primary key,
  usuario        varchar2(100)  not null,
  nit_compania   varchar2(50)   not null,
  tipo_token     varchar2(10),
  variables      varchar2(1000),
  valores        varchar2(2000),
  fecha_expira   timestamp      not null,
  usado          varchar2(1)    default 'N',
  fecha_creacion timestamp      default systimestamp
);

-- MFA (TOTP): en local no se exige. acceso_permitido = TRUE hace que el proceso
-- de aplicación "Validar MFA" de la 106 no redirija a las páginas 9996/9997.
create or replace package web_und_mfa_totp as
  procedure limpiar_sesion;
  function acceso_permitido (p_nit_compania in varchar2, p_usuario in varchar2) return boolean;
  function tiene_mfa (p_nit_compania in varchar2, p_usuario in varchar2) return boolean;
  function requiere_mfa (p_nit_compania in varchar2, p_usuario in varchar2) return boolean;
  function esta_bloqueado (p_nit_compania in varchar2, p_usuario in varchar2) return boolean;
  function validar (p_nit_compania in varchar2, p_usuario in varchar2, p_codigo in varchar2,
                    p_enrolar in varchar2 default 'N') return boolean;
  function secreto_enrolamiento (p_nit_compania in varchar2, p_usuario in varchar2) return varchar2;
  function uri_otpauth (p_secreto in varchar2, p_nit_compania in varchar2, p_usuario in varchar2) return varchar2;
  function secreto_legible (p_secreto in varchar2) return varchar2;
end web_und_mfa_totp;
/
create or replace package body web_und_mfa_totp as
  c_secreto_local constant varchar2(32) := 'JBSWY3DPEHPK3PXP';

  procedure limpiar_sesion is
  begin
    null;
  end limpiar_sesion;

  function acceso_permitido (p_nit_compania in varchar2, p_usuario in varchar2) return boolean is
  begin
    return true;
  end acceso_permitido;

  function tiene_mfa (p_nit_compania in varchar2, p_usuario in varchar2) return boolean is
  begin
    return false;
  end tiene_mfa;

  function requiere_mfa (p_nit_compania in varchar2, p_usuario in varchar2) return boolean is
  begin
    return false;
  end requiere_mfa;

  function esta_bloqueado (p_nit_compania in varchar2, p_usuario in varchar2) return boolean is
  begin
    return false;
  end esta_bloqueado;

  function validar (p_nit_compania in varchar2, p_usuario in varchar2, p_codigo in varchar2,
                    p_enrolar in varchar2 default 'N') return boolean is
  begin
    return true;
  end validar;

  function secreto_enrolamiento (p_nit_compania in varchar2, p_usuario in varchar2) return varchar2 is
  begin
    return c_secreto_local;
  end secreto_enrolamiento;

  function uri_otpauth (p_secreto in varchar2, p_nit_compania in varchar2, p_usuario in varchar2) return varchar2 is
  begin
    return 'otpauth://totp/SIIFWEB:' || p_usuario || '?secret=' || p_secreto || '&issuer=SIIFWEB';
  end uri_otpauth;

  function secreto_legible (p_secreto in varchar2) return varchar2 is
  begin
    return regexp_replace(p_secreto, '(.{4})', '\1 ');
  end secreto_legible;
end web_und_mfa_totp;
/

create or replace package siif_web_usuarios as
  function validar_credenciales (p_username in varchar2, p_password in varchar2) return boolean;
  procedure set_items_aplicacion (p_usuario in varchar2);
  procedure cambiar_password (p_username in varchar2, p_nit_compania in varchar2, p_password in varchar2);
  function validar_password_actual (p_username in varchar2, p_nit_compania in varchar2, p_password in varchar2) return boolean;
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
    apex_util.set_session_state('G_MODULO', 'SEGUIMIENTO_PROYECTOS');
  end set_items_aplicacion;

  procedure cambiar_password (p_username in varchar2, p_nit_compania in varchar2, p_password in varchar2) is
  begin
    null;
  end cambiar_password;

  function validar_password_actual (p_username in varchar2, p_nit_compania in varchar2, p_password in varchar2) return boolean is
  begin
    return p_password = 'Spd#2026';
  end validar_password_actual;
end siif_web_usuarios;
/

update compania set activar_apex = 'S'
 where nit_compania in (select distinct nit_compania from usuarios);

-- Menú SPD: módulo SEGUIMIENTO_PROYECTOS, un único padre "SPD" (opción 100) y debajo el árbol del
-- menú original (client/components/AppMenu/hooks.ts). Las opciones son números (varchar2) de 3 dígitos,
-- en preorden, para que el orden por path_opcion (texto) coincida con el numérico.
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '100', null, 'SPD', 100, 'PADRE', 'SIIF-SPD', null, 'fa-line-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '101', '100', 'Configuración', 101, 'PADRE', 'SIIF-SPD', null, 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '102', '101', 'Usuarios', 102, 'FORM', 'SIIF-SPD', 'SPD_USUARIOS', 'fa-users');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '103', '101', 'Entidades', 103, 'FORM', 'SIIF-SPD', 'SPD_ENTIDADES', 'fa-building-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '104', '101', 'Planes de Desarrollo', 104, 'FORM', 'SIIF-SPD', 'SPD_PLANES_DESARROLLO', 'fa-tasks');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '105', '101', 'Metas', 105, 'FORM', 'SIIF-SPD', 'SPD_METAS', 'fa-bullseye');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '106', '101', 'Proyectos', 106, 'FORM', 'SIIF-SPD', 'SPD_PROYECTOS', 'fa-sitemap');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '107', '101', 'Seguimiento', 107, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-line-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '108', '101', 'Políticas', 108, 'PADRE', 'SIIF-SPD', null, null);
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '109', '108', 'Componentes', 109, 'FORM', 'SIIF-SPD', 'SPD_COMPONENTES_POLITICA', 'fa-cube');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '110', '108', 'Nacionales', 110, 'FORM', 'SIIF-SPD', 'SPD_POLITICAS_NACIONALES', 'fa-flag');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '111', '108', 'Territoriales', 111, 'FORM', 'SIIF-SPD', 'SPD_POLITICAS_TERRITORIALES', 'fa-flag');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '112', '100', 'Catálogos', 112, 'PADRE', 'SIIF-SPD', null, 'fa-cubes');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '113', '112', 'ODS', 113, 'FORM', 'SIIF-SPD', 'SPD_ODS', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '114', '112', 'Unidades', 114, 'FORM', 'SIIF-SPD', 'SPD_UNIDADES', 'fa-cube');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '115', '112', 'Productos', 115, 'FORM', 'SIIF-SPD', 'SPD_PRODUCTOS', 'fa-list-alt');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '116', '100', 'Seguimiento', 116, 'PADRE', 'SIIF-SPD', null, 'fa-line-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '117', '116', 'Metas', 117, 'PADRE', 'SIIF-SPD', null, 'fa-line-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '118', '117', 'Configuración', 118, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '119', '117', 'Metas', 119, 'FORM', 'SIIF-SPD', 'SPD_METAS', 'fa-bullseye');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '120', '117', 'Programación', 120, 'FORM', 'SIIF-SPD', 'SPD_PROGRAMACION_METAS', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '121', '117', 'Reporte', 121, 'FORM', 'SIIF-SPD', 'SPD_REPORTE_METAS', 'fa-file-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '122', '117', 'Validación', 122, 'FORM', 'SIIF-SPD', 'SPD_VALIDACION_METAS', 'fa-check');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '123', '117', 'Revisión', 123, 'FORM', 'SIIF-SPD', 'SPD_REVISION_METAS', 'fa-edit');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '124', '117', 'Tableros de Control', 124, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_METAS', 'fa-pie-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '125', '116', 'Proyectos', 125, 'PADRE', 'SIIF-SPD', null, 'fa-sitemap');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '126', '125', 'Configuración', 126, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '127', '125', 'Proyectos', 127, 'FORM', 'SIIF-SPD', 'SPD_PROYECTOS', 'fa-list-ul');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '128', '125', 'Programación', 128, 'FORM', 'SIIF-SPD', 'SPD_PROGRAMACION_PROYECTOS', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '129', '125', 'Reporte', 129, 'FORM', 'SIIF-SPD', 'SPD_REPORTE_PROYECTOS', 'fa-file-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '130', '125', 'Validación', 130, 'FORM', 'SIIF-SPD', 'SPD_VALIDACION_PROYECTOS', 'fa-check');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '131', '125', 'Revisión', 131, 'FORM', 'SIIF-SPD', 'SPD_REVISION_PROYECTOS', 'fa-edit');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '132', '125', 'Tableros de Control', 132, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_PROYECTOS', 'fa-pie-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '133', '116', 'Planes de Acción', 133, 'PADRE', 'SIIF-SPD', null, 'fa-tasks');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '134', '133', 'Configuración', 134, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '135', '133', 'Planes de Acción', 135, 'FORM', 'SIIF-SPD', 'SPD_PLANES_ACCION', 'fa-tasks');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '136', '133', 'Programación', 136, 'FORM', 'SIIF-SPD', 'SPD_PROGRAMACION_PLANES_ACCION', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '137', '133', 'Reporte', 137, 'FORM', 'SIIF-SPD', 'SPD_REPORTE_PLANES_ACCION', 'fa-file-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '138', '133', 'Validación', 138, 'FORM', 'SIIF-SPD', 'SPD_VALIDACION_PLANES_ACCION', 'fa-check');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '139', '133', 'Revisión', 139, 'FORM', 'SIIF-SPD', 'SPD_REVISION_PLANES_ACCION', 'fa-edit');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '140', '133', 'Tableros de Control', 140, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_PLANES_ACCION', 'fa-pie-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '141', '116', 'Políticas', 141, 'PADRE', 'SIIF-SPD', null, 'fa-flag');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '142', '141', 'Configuración', 142, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '143', '141', 'Políticas', 143, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-flag');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '144', '141', 'Programación', 144, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '145', '141', 'Reporte', 145, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-file-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '146', '141', 'Validación', 146, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-check');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '147', '141', 'Revisión', 147, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-edit');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '148', '141', 'Tableros de Control', 148, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-pie-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '149', '100', 'Asistente', 149, 'FORM', 'SIIF-SPD', 'SPD_ASISTENTE', 'fa-magic');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '150', '100', 'Otros', 150, 'PADRE', 'SIIF-SPD', null, 'fa-ellipsis-h');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '151', '150', 'Inicio', 151, 'FORM', 'SIIF-SPD', 'SPD_INICIO', 'fa-home');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '152', '150', 'Niveles del plan', 152, 'FORM', 'SIIF-SPD', 'SPD_NIVELES_PLAN', 'fa-sitemap');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '153', '150', 'Metas de actividades', 153, 'FORM', 'SIIF-SPD', 'SPD_METAS_ACTIVIDADES', 'fa-tasks');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '154', '150', 'Metas por actividad', 154, 'FORM', 'SIIF-SPD', 'SPD_METAS_POR_ACTIVIDAD', 'fa-link');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '155', '150', 'Macroproyectos', 155, 'FORM', 'SIIF-SPD', 'SPD_MACROPROYECTOS', 'fa-cubes');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '156', '150', 'Ubicaciones', 156, 'FORM', 'SIIF-SPD', 'SPD_UBICACIONES', 'fa-map-marker');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '157', '150', 'Componentes por política', 157, 'FORM', 'SIIF-SPD', 'SPD_COMPONENTES_POR_POLITICA', 'fa-chain');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '158', '150', 'Historial de metas', 158, 'FORM', 'SIIF-SPD', 'SPD_HISTORIAL_METAS', 'fa-history');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '159', '150', 'Avance de metas', 159, 'FORM', 'SIIF-SPD', 'SPD_AVANCE_METAS', 'fa-tachometer');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '160', '150', 'Registros de seguimiento', 160, 'FORM', 'SIIF-SPD', 'SPD_REGISTROS_SEGUIMIENTO', 'fa-line-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '161', '150', 'Tablero de seguimiento', 161, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_SEGUIMIENTO', 'fa-dashboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, label, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PROYECTOS', '162', '150', 'Tablero financiero', 162, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_FINANCIERO', 'fa-money');
commit;
