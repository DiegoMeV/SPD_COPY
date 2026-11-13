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
  modulo        varchar2(20)  not null,
  opcion        varchar2(30)  not null,
  opc_padre     varchar2(30),
  descripcion   varchar2(200) not null,   -- "Padre - Hijo - Opción"; la etiqueta es lo que va después del último '-'
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
  modulo          varchar2(20),
  opcion          varchar2(30),
  estado          varchar2(10),
  ejecutable_apex varchar2(255)
);

-- Igual a la vista real (SVN_APEX/DB/vistas/v_gen_opciones_sistema_menu.sql), sobre la tabla local.
create or replace view v_gen_opciones_sistema_menu as
select level                                          as lvl,
       m.opcion, m.opc_padre, m.modulo, m.tipo_llamada, m.aplicacion,
       m.ejecutable, m.parametros, m.valores,
       trim(substr(m.descripcion, instr(m.descripcion, '-', -1) + 1)) as label,
       sys_connect_by_path(m.opcion, '/')             as path_opcion,
       sys_connect_by_path(
         replace(trim(substr(m.descripcion, instr(m.descripcion, '-', -1) + 1)), '/', '-'),
         ' / ')                                       as path_label,
       m.menu_icon
  from gen_opciones_sistema_local m
 start with m.opc_padre is null
connect by nocycle prior m.opcion = m.opc_padre and prior m.modulo = m.modulo;

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
    apex_util.set_session_state('G_MODULO', 'SEGUIMIENTO_PRY');
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

-- Menú SPD: módulo SEGUIMIENTO_PRY, un único padre "SPD" (opción 30) y debajo el árbol del
-- menú original (client/components/AppMenu/hooks.ts). Las opciones son números (en varchar2)
-- jerárquicos: cada hijo lleva el código del padre más 01, 02, ... (Configuración 3001, Usuarios 300101).
-- La descripción concatena las de los padres (sin el módulo): "SPD - Configuración - Usuarios".
-- La vista toma como etiqueta lo que va después del último '-', como la vista real.
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30', null, 'SPD', 1, 'PADRE', 'SIIF-SPD', null, 'fa-line-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '3001', '30', 'SPD - Configuración', 2, 'PADRE', 'SIIF-SPD', null, 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300101', '3001', 'SPD - Configuración - Usuarios', 3, 'FORM', 'SIIF-SPD', 'SPD_USUARIOS', 'fa-users');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300102', '3001', 'SPD - Configuración - Entidades', 4, 'FORM', 'SIIF-SPD', 'SPD_ENTIDADES', 'fa-building-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300103', '3001', 'SPD - Configuración - Planes de Desarrollo', 5, 'FORM', 'SIIF-SPD', 'SPD_PLANES_DESARROLLO', 'fa-tasks');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300104', '3001', 'SPD - Configuración - Metas', 6, 'FORM', 'SIIF-SPD', 'SPD_METAS', 'fa-bullseye');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300105', '3001', 'SPD - Configuración - Proyectos', 7, 'FORM', 'SIIF-SPD', 'SPD_PROYECTOS', 'fa-sitemap');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300106', '3001', 'SPD - Configuración - Seguimiento', 8, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-line-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300107', '3001', 'SPD - Configuración - Políticas', 9, 'PADRE', 'SIIF-SPD', null, null);
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30010701', '300107', 'SPD - Configuración - Políticas - Componentes', 10, 'FORM', 'SIIF-SPD', 'SPD_COMPONENTES_POLITICA', 'fa-cube');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30010702', '300107', 'SPD - Configuración - Políticas - Nacionales', 11, 'FORM', 'SIIF-SPD', 'SPD_POLITICAS_NACIONALES', 'fa-flag');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30010703', '300107', 'SPD - Configuración - Políticas - Territoriales', 12, 'FORM', 'SIIF-SPD', 'SPD_POLITICAS_TERRITORIALES', 'fa-flag');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '3002', '30', 'SPD - Catálogos', 13, 'PADRE', 'SIIF-SPD', null, 'fa-cubes');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300201', '3002', 'SPD - Catálogos - ODS', 14, 'FORM', 'SIIF-SPD', 'SPD_ODS', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300202', '3002', 'SPD - Catálogos - Unidades', 15, 'FORM', 'SIIF-SPD', 'SPD_UNIDADES', 'fa-cube');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300203', '3002', 'SPD - Catálogos - Productos', 16, 'FORM', 'SIIF-SPD', 'SPD_PRODUCTOS', 'fa-list-alt');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '3003', '30', 'SPD - Seguimiento', 17, 'PADRE', 'SIIF-SPD', null, 'fa-line-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300301', '3003', 'SPD - Seguimiento - Metas', 18, 'PADRE', 'SIIF-SPD', null, 'fa-line-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030101', '300301', 'SPD - Seguimiento - Metas - Configuración', 19, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030102', '300301', 'SPD - Seguimiento - Metas - Metas', 20, 'FORM', 'SIIF-SPD', 'SPD_METAS', 'fa-bullseye');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030103', '300301', 'SPD - Seguimiento - Metas - Programación', 21, 'FORM', 'SIIF-SPD', 'SPD_PROGRAMACION_METAS', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030104', '300301', 'SPD - Seguimiento - Metas - Reporte', 22, 'FORM', 'SIIF-SPD', 'SPD_REPORTE_METAS', 'fa-file-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030105', '300301', 'SPD - Seguimiento - Metas - Validación', 23, 'FORM', 'SIIF-SPD', 'SPD_VALIDACION_METAS', 'fa-check');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030106', '300301', 'SPD - Seguimiento - Metas - Revisión', 24, 'FORM', 'SIIF-SPD', 'SPD_REVISION_METAS', 'fa-edit');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030107', '300301', 'SPD - Seguimiento - Metas - Tableros de Control', 25, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_METAS', 'fa-pie-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300302', '3003', 'SPD - Seguimiento - Proyectos', 26, 'PADRE', 'SIIF-SPD', null, 'fa-sitemap');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030201', '300302', 'SPD - Seguimiento - Proyectos - Configuración', 27, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030202', '300302', 'SPD - Seguimiento - Proyectos - Proyectos', 28, 'FORM', 'SIIF-SPD', 'SPD_PROYECTOS', 'fa-list-ul');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030203', '300302', 'SPD - Seguimiento - Proyectos - Programación', 29, 'FORM', 'SIIF-SPD', 'SPD_PROGRAMACION_PROYECTOS', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030204', '300302', 'SPD - Seguimiento - Proyectos - Reporte', 30, 'FORM', 'SIIF-SPD', 'SPD_REPORTE_PROYECTOS', 'fa-file-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030205', '300302', 'SPD - Seguimiento - Proyectos - Validación', 31, 'FORM', 'SIIF-SPD', 'SPD_VALIDACION_PROYECTOS', 'fa-check');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030206', '300302', 'SPD - Seguimiento - Proyectos - Revisión', 32, 'FORM', 'SIIF-SPD', 'SPD_REVISION_PROYECTOS', 'fa-edit');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030207', '300302', 'SPD - Seguimiento - Proyectos - Tableros de Control', 33, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_PROYECTOS', 'fa-pie-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300303', '3003', 'SPD - Seguimiento - Planes de Acción', 34, 'PADRE', 'SIIF-SPD', null, 'fa-tasks');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030301', '300303', 'SPD - Seguimiento - Planes de Acción - Configuración', 35, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030302', '300303', 'SPD - Seguimiento - Planes de Acción - Planes de Acción', 36, 'FORM', 'SIIF-SPD', 'SPD_PLANES_ACCION', 'fa-tasks');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030303', '300303', 'SPD - Seguimiento - Planes de Acción - Programación', 37, 'FORM', 'SIIF-SPD', 'SPD_PROGRAMACION_PLANES_ACCION', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030304', '300303', 'SPD - Seguimiento - Planes de Acción - Reporte', 38, 'FORM', 'SIIF-SPD', 'SPD_REPORTE_PLANES_ACCION', 'fa-file-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030305', '300303', 'SPD - Seguimiento - Planes de Acción - Validación', 39, 'FORM', 'SIIF-SPD', 'SPD_VALIDACION_PLANES_ACCION', 'fa-check');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030306', '300303', 'SPD - Seguimiento - Planes de Acción - Revisión', 40, 'FORM', 'SIIF-SPD', 'SPD_REVISION_PLANES_ACCION', 'fa-edit');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030307', '300303', 'SPD - Seguimiento - Planes de Acción - Tableros de Control', 41, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_PLANES_ACCION', 'fa-pie-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300304', '3003', 'SPD - Seguimiento - Políticas', 42, 'PADRE', 'SIIF-SPD', null, 'fa-flag');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030401', '300304', 'SPD - Seguimiento - Políticas - Configuración', 43, 'FORM', 'SIIF-SPD', 'SPD_SEGUIMIENTOS', 'fa-cog');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030402', '300304', 'SPD - Seguimiento - Políticas - Políticas', 44, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-flag');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030403', '300304', 'SPD - Seguimiento - Políticas - Programación', 45, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-clipboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030404', '300304', 'SPD - Seguimiento - Políticas - Reporte', 46, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-file-o');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030405', '300304', 'SPD - Seguimiento - Políticas - Validación', 47, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-check');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030406', '300304', 'SPD - Seguimiento - Políticas - Revisión', 48, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-edit');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '30030407', '300304', 'SPD - Seguimiento - Políticas - Tableros de Control', 49, 'FORM', 'SIIF-SPD', 'EN-CONSTRUCCION', 'fa-pie-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '3004', '30', 'SPD - Asistente', 50, 'FORM', 'SIIF-SPD', 'SPD_ASISTENTE', 'fa-magic');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '3005', '30', 'SPD - Otros', 51, 'PADRE', 'SIIF-SPD', null, 'fa-ellipsis-h');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300501', '3005', 'SPD - Otros - Inicio', 52, 'FORM', 'SIIF-SPD', 'SPD_INICIO', 'fa-home');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300502', '3005', 'SPD - Otros - Niveles del plan', 53, 'FORM', 'SIIF-SPD', 'SPD_NIVELES_PLAN', 'fa-sitemap');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300503', '3005', 'SPD - Otros - Metas de actividades', 54, 'FORM', 'SIIF-SPD', 'SPD_METAS_ACTIVIDADES', 'fa-tasks');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300504', '3005', 'SPD - Otros - Metas por actividad', 55, 'FORM', 'SIIF-SPD', 'SPD_METAS_POR_ACTIVIDAD', 'fa-link');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300505', '3005', 'SPD - Otros - Macroproyectos', 56, 'FORM', 'SIIF-SPD', 'SPD_MACROPROYECTOS', 'fa-cubes');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300506', '3005', 'SPD - Otros - Ubicaciones', 57, 'FORM', 'SIIF-SPD', 'SPD_UBICACIONES', 'fa-map-marker');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300507', '3005', 'SPD - Otros - Componentes por política', 58, 'FORM', 'SIIF-SPD', 'SPD_COMPONENTES_POR_POLITICA', 'fa-chain');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300508', '3005', 'SPD - Otros - Historial de metas', 59, 'FORM', 'SIIF-SPD', 'SPD_HISTORIAL_METAS', 'fa-history');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300509', '3005', 'SPD - Otros - Avance de metas', 60, 'FORM', 'SIIF-SPD', 'SPD_AVANCE_METAS', 'fa-tachometer');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300510', '3005', 'SPD - Otros - Registros de seguimiento', 61, 'FORM', 'SIIF-SPD', 'SPD_REGISTROS_SEGUIMIENTO', 'fa-line-chart');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300511', '3005', 'SPD - Otros - Tablero de seguimiento', 62, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_SEGUIMIENTO', 'fa-dashboard');
insert into gen_opciones_sistema_local (modulo, opcion, opc_padre, descripcion, orden, tipo_llamada, aplicacion, ejecutable, menu_icon) values ('SEGUIMIENTO_PRY', '300512', '3005', 'SPD - Otros - Tablero financiero', 63, 'FORM', 'SIIF-SPD', 'SPD_TABLERO_FINANCIERO', 'fa-money');
commit;
