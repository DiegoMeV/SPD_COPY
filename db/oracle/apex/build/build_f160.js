// Construye la app 160 (SIIF_SPD) = base SIIF Web (f154, APEX 24.2) + páginas SPD (f100, APEX 24.1).
// Uso: node build_f160.js <salida.sql> [--24.1]
//   Por defecto el resultado es para APEX 24.2 (la versión de producción y del contenedor local).
//   Con --24.1 se convierte la base a 24.1 (p_attributes -> p_attribute_NN, sin p_dialog_resizable,
//   modo de compatibilidad 21.2), para importarla en un APEX 24.1.
// Se importa en el contenedor local (run_import_160.sh) y luego se reexporta con apex_export (export_160.sql).
const fs = require('fs');
const path = require('path');
const F154 = path.join(__dirname, '..', 'f154');      // export split de la app 154 (install.sql + application/)
const F100 = path.join(__dirname, '..', 'f100.sql');
const OUT = process.argv[2];
const TARGET_241 = process.argv.includes('--24.1');

// Un export split se lee concatenando sus archivos en el orden de install.sql:
// cada archivo empieza con su propio "prompt --application/...".
function readExport(p) {
  if (!fs.statSync(p).isDirectory()) return fs.readFileSync(p, 'utf8');
  // El export split viene en Latin-1 (tildes en install.sql, prompts y comentarios).
  return fs.readFileSync(path.join(p, 'install.sql'), 'latin1').split(/\r?\n/)
    .filter(l => l.startsWith('@@')).map(l => fs.readFileSync(path.join(p, l.slice(2).trim()), 'latin1')).join('\n');
}

function sections(p) {
  const txt = readExport(p).replace(/\r\n/g, '\n');
  const parts = txt.split(/(?=^prompt --application\/)/m);
  const m = new Map();
  for (const p of parts.filter(x => x.startsWith("prompt --application/"))) m.set(p.split('\n', 1)[0].slice('prompt --application/'.length).trim(), p);
  return m;
}
const B = sections(F154), S = sections(F100);
const need = (M, k) => { if (!M.has(k)) throw new Error('falta sección ' + k); return M.get(k); };

const PAGES = [
  [1, 'SPD_Inicio', 'SPD_INICIO'], [2, 'SPD_Usuarios', 'SPD_USUARIOS'], [3, 'SPD_Usuario', 'SPD_USUARIO'],
  [4, 'SPD_Entidades', 'SPD_ENTIDADES'], [5, 'SPD_Entidad', 'SPD_ENTIDAD'],
  [6, 'SPD_Planes de desarrollo', 'SPD_PLANES_DESARROLLO'], [7, 'SPD_Plan de desarrollo', 'SPD_PLAN_DESARROLLO'],
  [8, 'SPD_Niveles del plan', 'SPD_NIVELES_PLAN'], [9, 'SPD_Nivel del plan', 'SPD_NIVEL_PLAN'],
  [10, 'SPD_Metas', 'SPD_METAS'], [11, 'SPD_Meta', 'SPD_META'],
  [12, 'SPD_Metas de actividades', 'SPD_METAS_ACTIVIDADES'], [13, 'SPD_Metas por actividad', 'SPD_METAS_POR_ACTIVIDAD'],
  [14, 'SPD_Macroproyectos', 'SPD_MACROPROYECTOS'], [15, 'SPD_Macroproyecto', 'SPD_MACROPROYECTO'],
  [16, 'SPD_Políticas nacionales', 'SPD_POLITICAS_NACIONALES'], [17, 'SPD_Política nacional', 'SPD_POLITICA_NACIONAL'],
  [18, 'SPD_Políticas territoriales', 'SPD_POLITICAS_TERRITORIALES'], [19, 'SPD_Política territorial', 'SPD_POLITICA_TERRITORIAL'],
  [20, 'SPD_Componentes de política', 'SPD_COMPONENTES_POLITICA'], [21, 'SPD_Componente de política', 'SPD_COMPONENTE_POLITICA'],
  [22, 'SPD_Componentes por política', 'SPD_COMPONENTES_POR_POLITICA'],
  [23, 'SPD_Ubicaciones', 'SPD_UBICACIONES'], [24, 'SPD_Ubicación', 'SPD_UBICACION'],
  [25, 'SPD_ODS', 'SPD_ODS'], [26, 'SPD_Unidades', 'SPD_UNIDADES'], [27, 'SPD_Productos', 'SPD_PRODUCTOS'],
  [28, 'SPD_Proyectos', 'SPD_PROYECTOS'], [29, 'SPD_Planes de acción', 'SPD_PLANES_ACCION'],
  [30, 'SPD_Programación de metas', 'SPD_PROGRAMACION_METAS'], [31, 'SPD_Reporte de avance de metas', 'SPD_REPORTE_METAS'],
  [32, 'SPD_Validación de avance de metas', 'SPD_VALIDACION_METAS'], [33, 'SPD_Revisión de avance de metas', 'SPD_REVISION_METAS'],
  [34, 'SPD_Tableros de control - Metas', 'SPD_TABLERO_METAS'],
  [35, 'SPD_Programación de proyectos', 'SPD_PROGRAMACION_PROYECTOS'], [36, 'SPD_Reporte de seguimiento de proyectos', 'SPD_REPORTE_PROYECTOS'],
  [37, 'SPD_Validación de seguimiento de proyectos', 'SPD_VALIDACION_PROYECTOS'], [38, 'SPD_Revisión de seguimiento de proyectos', 'SPD_REVISION_PROYECTOS'],
  [39, 'SPD_Tableros de control - Proyectos', 'SPD_TABLERO_PROYECTOS'],
  [40, 'SPD_Programación de planes de acción', 'SPD_PROGRAMACION_PLANES_ACCION'], [41, 'SPD_Reporte de seguimiento de planes de acción', 'SPD_REPORTE_PLANES_ACCION'],
  [42, 'SPD_Validación de seguimiento de planes de acción', 'SPD_VALIDACION_PLANES_ACCION'], [43, 'SPD_Revisión de seguimiento de planes de acción', 'SPD_REVISION_PLANES_ACCION'],
  [44, 'SPD_Tableros de control - Planes de acción', 'SPD_TABLERO_PLANES_ACCION'],
  [45, 'SPD_Configuración de seguimiento', 'SPD_SEGUIMIENTOS'], [46, 'SPD_Seguimiento', 'SPD_SEGUIMIENTO'],
  [47, 'SPD_Registros de seguimiento', 'SPD_REGISTROS_SEGUIMIENTO'], [48, 'SPD_Avance de metas', 'SPD_AVANCE_METAS'],
  [49, 'SPD_Historial de metas', 'SPD_HISTORIAL_METAS'], [50, 'SPD_Tablero de seguimiento', 'SPD_TABLERO_SEGUIMIENTO'],
  [51, 'SPD_Tablero financiero', 'SPD_TABLERO_FINANCIERO'], [52, 'SPD_Asistente', 'SPD_ASISTENTE'],
  [60, 'SPD_Detalles del plan', 'SPD_DETALLE_PLAN'], [61, 'SPD_Estructura del plan', 'SPD_ESTRUCTURA_PLAN'],
  [62, 'SPD_Datos de la meta', 'SPD_DATOS_META'],
];
const NEW = new Map(PAGES.map(([n]) => [n, 1000 + n]));
const OLD_GLOBAL_REGION = '39550128749283276';   // "Breadcrumb Global" página 0 de f100
const BASE_GLOBAL_REGION = '644171683471333937'; // "Breadcrumb Global" página 0 de f154

const renItems = t => t.replace(/(?<![A-Za-z0-9_$#])P(\d+)_(?=[A-Za-z0-9])/g,
  (m, n) => NEW.has(+n) ? `P${NEW.get(+n)}_` : m);

const unknown = new Set();
function fixFp(s) {
  const f = s.slice(4).split(':');
  if (f.length > 1 && /^\d+$/.test(f[1])) {
    const n = +f[1];
    if (NEW.has(n)) f[1] = String(NEW.get(n)); else if (n === 53) f[1] = 'EN-CONSTRUCCION'; else unknown.add(s);
  }
  if (f.length > 5) f[5] = f[5].split(',').map(x => /^\d+$/.test(x) && NEW.has(+x) ? String(NEW.get(+x)) : x).join(',');
  return 'f?p=' + f.join(':');
}
const fixPages = t => t.replace(/f\?p=&APP_ID\.[^'"\s\\|]*/g, fixFp);

function transformPage([n, name, alias], txt) {
  txt = txt.replace(/^prompt --application\/pages\/page_\d+/m, 'prompt --application/pages/page_' + String(NEW.get(n)).padStart(5, '0'));
  txt = txt.replace(new RegExp('^ p_id=>' + n + '$', 'm'), ' p_id=>' + NEW.get(n));
  txt = txt.replace(/^,p_name=>.*$/m, `,p_name=>'${name.replace(/'/g, "''")}'`);
  if (/^,p_alias=>/m.test(txt)) txt = txt.replace(/^,p_alias=>.*$/m, `,p_alias=>'${alias}'`);
  else txt = txt.replace(/^(,p_name=>.*)$/m, `$1\n,p_alias=>'${alias}'`);
  txt = txt.split(OLD_GLOBAL_REGION).join(BASE_GLOBAL_REGION);
  return fixPages(renItems(txt));
}

// plantillas: id crudo UT 24.2 (f154) -> id de la plantilla equivalente de f100 (24.1)
const TPL = {
  '4072355960268175073': '37809922637549494', // page STANDARD
  '2100407606326202693': '37789562526549489', // page MODAL_DIALOG
  '2101157952850466385': '37791050830549489', // page LOGIN
  '4072358936313175081': '37893983495549507', // region STANDARD
  '2531463326621247859': '37854907321549502', // region TITLE_BAR
  '2674017834225413037': '37874803773549504', // region HERO
  '2126429139436695430': '37846082031549501', // region BUTTONS_CONTAINER
  '4501440665235496320': '37903786052549509', // region BLANK_WITH_ATTRIBUTES
  '2072724515482255512': '37839364162549500', // region CARDS_CONTAINER
  '2674157997338192145': '37878397971549505', // region LOGIN
  '2467739217141810545': '37946591569549518', // list SIDE_NAVIGATION_MENU
  '2847543055748234966': '37946151175549517', // list NAVIGATION_BAR
  '2886769488667748277': '37934583981549515', // list CARDS
  '1609121967514267634': '37956811864549521', // label OPTIONAL
  '1609122147107268652': '37956953606549521', // label REQUIRED
  '2040785906935475274': '37956700460549521', // label HIDDEN
  '4072362960822175091': '37960266381549523', // button TEXT
};
const remapTpl = t => t.replace(/(p_[a-z_]*template[a-z_]*)=>(\d{12,})/g, (m, p, v) => {
  if (!TPL[v]) throw new Error('plantilla sin mapear: ' + m);
  return `${p}=>wwv_flow_imp.id(${TPL[v]})`;
});
// En 24.1 create_page_item no acepta p_attributes (24.2): se pasan a p_attribute_NN.
const ITEM_ATTR = {
  NATIVE_TEXT_FIELD: { disabled: 1, submit_when_enter_pressed: 2, subtype: 4, trim_spaces: 5 },
  NATIVE_HIDDEN: { value_protected: 1 },
  NATIVE_DISPLAY_ONLY: { send_on_page_submit: 1, based_on: 2, show_line_breaks: 4, format: 5 },
  NATIVE_PASSWORD: { submit_when_enter_pressed: 1 },
  NATIVE_SINGLE_CHECKBOX: { use_defaults: 1 },
  NATIVE_SELECT_LIST: { page_action_on_selection: 1 },
  NATIVE_SELECT_ONE: {}, NATIVE_RICH_TEXT_EDITOR: {},   // atributos por defecto
};
const fixItems = t => t.replace(/wwv_flow_imp_page\.create_page_item\([\s\S]*?\n\);/g, blk => {
  const m = /\n,p_attributes=>wwv_flow_t_plugin_attributes\(wwv_flow_t_varchar2\(([\s\S]*?)\)\)\.to_clob/.exec(blk);
  if (!m) return blk;
  const ty = (/p_display_as=>'([A-Z_]+)'/.exec(blk) || [])[1];
  const map = ITEM_ATTR[ty];
  if (!map) throw new Error('tipo de ítem sin mapa de atributos: ' + ty);
  const kv = [...m[1].matchAll(/'([a-z_]+)', '((?:[^']|'')*)'/g)];
  const lines = kv.filter(([, k]) => map[k]).sort((a, b) => map[a[1]] - map[b[1]])
    .map(([, k, v]) => `\n,p_attribute_${String(map[k]).padStart(2, '0')}=>'${v}'`).join('');
  return blk.replace(m[0], lines);
});
const base = k => TARGET_241
  ? fixItems(remapTpl(need(B, k))).replace(/^,p_dialog_resizable=>.*\n/gm, '')
  : remapTpl(need(B, k));
const keys = (M, pre) => [...M.keys()].filter(k => k.startsWith(pre));

const out = [];
let head = need(S, 'set_environment')
  .replace('p_default_application_id=>100', 'p_default_application_id=>160')
  .replace(/^prompt APPLICATION 100 .*$/m, 'prompt APPLICATION 160 - SIIF_SPD')
  .replace(/^-- Application Export:[\s\S]*?^--\n(?=prompt )/m, '');
out.push(head, need(S, 'delete_application'));

let flow = base('create_application')
  .replace(/get_application_name,'[^']*'\)/, "get_application_name,'SIIF_SPD')")
  .replace(/get_application_alias,'[^']*'\)/, "get_application_alias,'SIIF-SPD')")
  .replace("p_compatibility_mode=>'24.2'", TARGET_241 ? "p_compatibility_mode=>'21.2'" : "p_compatibility_mode=>'24.2'")
  .replace(/^,p_(version_scn|files_version|last_updated_on|last_updated_by|checksum_salt)=>.*\n/gm, '');
out.push(flow, base('user_interfaces'));
keys(B, 'shared_components/navigation/lists/').forEach(k => out.push(base(k)));
out.push(need(S, 'shared_components/navigation/listentry'));
keys(B, 'shared_components/files/').forEach(k => out.push(base(k)));
out.push(base('plugin_settings'));
keys(B, 'shared_components/security/authorizations/').forEach(k => out.push(base(k)));
out.push(need(S, 'shared_components/navigation/navigation_bar'));
keys(B, 'shared_components/logic/application_processes/').forEach(k => out.push(base(k)));
keys(B, 'shared_components/logic/application_items/').forEach(k => out.push(base(k)));
['shared_components/logic/application_settings', 'shared_components/navigation/tabs/standard',
 'shared_components/navigation/tabs/parent'].forEach(k => out.push(need(S, k)));
out.push(base('pages/page_groups'), need(S, 'comments'));
keys(B, 'shared_components/navigation/breadcrumbs/').forEach(k => out.push(base(k)));
out.push(need(S, 'shared_components/navigation/breadcrumbentry'));
keys(S, 'shared_components/user_interface/templates/').forEach(k => out.push(need(S, k)));
out.push(need(S, 'shared_components/user_interface/themes'));
let st = need(S, 'shared_components/user_interface/theme_style').replace('p_is_current=>true', 'p_is_current=>false');
let bst = /begin\n([\s\S]*)end;\n\//.exec(base('shared_components/user_interface/theme_style'))[1]
  .replace(",p_name=>'Vita (SIIF_WEB)'", ",p_name=>'Vita (SIIF_WEB)'\n,p_is_current=>true");
const pos = st.lastIndexOf('end;\n/');
st = st.slice(0, pos) + bst + st.slice(pos);
out.push(st, base('shared_components/user_interface/theme_files'));
['shared_components/user_interface/template_opt_groups', 'shared_components/user_interface/template_options',
 'shared_components/globalization/language'].forEach(k => out.push(need(S, k)));
keys(S, 'shared_components/user_interface/lovs/').forEach(k => out.push(fixPages(renItems(need(S, k)))));
out.push(base('shared_components/logic/build_options'));
out.push(need(S, 'shared_components/globalization/messages'), need(S, 'shared_components/globalization/dyntranslations'));
keys(B, 'shared_components/security/authentications/').forEach(k => out.push(base(k)));
keys(S, 'shared_components/plugins/template_component/').forEach(k => out.push(need(S, k)));
out.push(need(S, 'user_interfaces/combined_files'));

const pages = [];
[...B.keys()].filter(k => /^pages\/page_\d+$/.test(k)).forEach(k => pages.push([+k.slice(11), base(k)]));
for (const p of PAGES) pages.push([NEW.get(p[0]), transformPage(p, need(S, 'pages/page_' + String(p[0]).padStart(5, '0')))]);
pages.sort((a, b) => a[0] - b[0]).forEach(([, t]) => out.push(t));
// deployment/* es opcional: el export split de la 154 no lo trae.
['deployment/definition', 'deployment/checks', 'deployment/buildoptions'].forEach(k => { if (B.has(k)) out.push(B.get(k)); });
out.push(need(B, 'end_environment'));

const res = out.join('');
fs.writeFileSync(OUT, res);
const ids = [...res.matchAll(/^ p_id=>wwv_flow_imp\.id\((\d+)\)/gm)].map(m => m[1]);
const c = new Map(); ids.forEach(i => c.set(i, (c.get(i) || 0) + 1));
console.log('componentes:', ids.length, 'duplicados:', [...c].filter(([, v]) => v > 1).map(([k]) => k));
console.log('refs a páginas no migradas:', [...unknown]);
