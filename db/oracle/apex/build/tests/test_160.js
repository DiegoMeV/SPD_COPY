// App 160 (SIIF_SPD): login de la base, menú SIIF (stub local), recorre todas las páginas y prueba formularios clave.
const { chromium } = require('playwright-core');
const B = 'http://localhost:8080/ords/';
(async () => {
  const browser = await chromium.launch({ channel: 'msedge', headless: true });
  const page = await browser.newPage({ viewport: { width: 1500, height: 900 } });
  const problems = [];
  let current = 'login';
  page.on('pageerror', e => problems.push(`[${current}] JS: ${e.message.slice(0, 200)}`));
  page.on('response', r => { if (r.status() >= 400 && !r.url().includes('f?p=106')) problems.push(`[${current}] HTTP ${r.status()} ${r.url().slice(0, 140)}`); });
  const errs = async () => {
    const e = await page.$$eval('.a-Notification-item, .t-Alert--danger .t-Alert-body, .t-Region-body .error', els => els.map(x => x.innerText.trim()).filter(Boolean));
    const body = await page.innerText('body').catch(() => '');
    if (/ORA-\d|PLS-\d|debug id|Error .* region/i.test(body)) e.push(body.match(/.{0,120}(ORA-\d|PLS-\d|debug id|Error).{0,160}/is)?.[0].replace(/\s+/g, ' '));
    return e;
  };

  await page.goto(B + 'r/spd/siif-spd/login');
  await page.selectOption('#P9999_NIT_COMPANIA', '8913800073');
  await page.fill('#P9999_USERNAME', 'fgil666@gmail.com');
  await page.fill('#P9999_PASSWORD', 'Spd#2026');
  await Promise.all([page.waitForURL(u => !String(u).includes('/login'), { timeout: 15000 }).catch(() => {}), page.click('.t-Button--hot')]);
  console.log('tras login:', page.url().slice(0, 120));
  const cookies = await page.context().cookies();
  // la base redirige a la app 106 (portal); tomamos la sesión de la URL
  const session = require('child_process').execSync("docker exec spd-oracle bash -c \"printf 'set head off feed off\\nselect max(apex_session_id) from apex_workspace_sessions where user_name = upper(q\\x27[fgil666@gmail.com]\\x27);\\nexit\\n' | sqlplus -s system/oracle@FREEPDB1\"").toString().trim();
  console.log('sesión:', session, 'cookies:', cookies.length);
  const go = async p => { current = p; await page.goto(`${B}f?p=160:${p}:${session}`); await page.waitForLoadState('networkidle').catch(() => {}); await page.waitForTimeout(300); };

  await go('SPD_USUARIOS');
  const menu = await page.$$eval('#t_TreeNav .a-TreeView-label', els => els.map(e => e.textContent.trim()));
  console.log('menú SIIF:', menu.slice(0, 12).join(' | '));
  console.log('logo/usuario:', (await page.innerText('.t-Header').catch(() => '')).replace(/\s+/g, ' ').slice(0, 160));

  const pages = [1, 3, 101, ...[...Array(52).keys()].map(i => 1001 + i), 1060, 1061];
  for (const p of pages) {
    await go(p);
    const e = await errs();
    e.forEach(t => problems.push(`[${p}] ${t}`));
    const title = await page.title();
    console.log(`${e.length ? 'ERROR' : 'ok   '} ${String(p).padEnd(5)} ${title}`);
  }

  // navegación desde el menú SIIF (fija G_MODULO / G_OPCION_MENU -> breadcrumb global)
  await go('SPD_USUARIOS');
  const href = await page.$eval('#t_TreeNav a[href*="SPD_ENTIDADES"], #t_TreeNav a[href*="spd_entidades"]', a => a.href).catch(() => null);
  console.log('enlace de menú Entidades:', href && href.slice(0, 160));
  if (href) {
    current = 'menu->entidades'; await page.goto(href); await page.waitForLoadState('networkidle');
    console.log('  migas:', (await page.$$eval('.t-Breadcrumb-item', e => e.map(x => x.innerText.trim()))).join(' / '));
    console.log('  botones cabecera:', (await page.$$eval('.t-BreadcrumbRegion .t-Button', b => b.filter(x => x.offsetParent).map(x => x.innerText.trim()))).join(' | '));
    current = 'entidad editar';
    await Promise.all([page.waitForNavigation(), page.click('.a-IRR-table td a >> nth=0')]);
    await page.waitForLoadState('networkidle');
    console.log('  form entidad:', page.url().split('?')[0].split('/').pop(), '| botones:', (await page.$$eval('.t-BreadcrumbRegion .t-Button', b => b.filter(x => x.offsetParent).map(x => x.innerText.trim()))).join(' | '));
    await Promise.all([page.waitForNavigation(), page.click('button:has-text("Aplicar Cambios")')]);
    await page.waitForLoadState('networkidle');
    console.log('  tras guardar:', page.url().split('?')[0].split('/').pop(), (await errs()).join(' ; '), await page.$$eval('.t-Alert-body, .a-Notification-item', e => e.map(x => x.innerText.trim()).join(' ')));
  }

  // plan: detalle -> editar (grilla niveles) -> estructura -> nodo
  await go('SPD_PLANES_DESARROLLO');
  current = 'plan detalle';
  await Promise.all([page.waitForNavigation(), page.click('.a-IRR-table td a >> nth=0')]); await page.waitForLoadState('networkidle');
  console.log('plan detalle:', page.url().split('?')[0].split('/').pop(), (await errs()).join(';'));
  current = 'plan estructura';
  await Promise.all([page.waitForNavigation(), page.click('a:has-text("Editar Estructura"), button:has-text("Editar Estructura")')]); await page.waitForLoadState('networkidle');
  await Promise.all([page.waitForNavigation(), page.locator('#spd_plan_tree .a-TreeView-label').nth(1).click()]); await page.waitForLoadState('networkidle');
  console.log('estructura nodo:', page.url().split('?')[0].split('/').pop(), 'regiones:', (await page.$$eval('.t-Region-title', e => e.map(x => x.innerText.trim()))).join(' | '), (await errs()).join(';'));

  // metas: tab árbol y diálogo de datos de meta
  await go('SPD_METAS');
  current = 'meta dialogo';
  await page.click('.a-IRR-table td a >> nth=0');
  await page.waitForSelector('iframe', { timeout: 10000 }).catch(() => {});
  const fr = page.frames().find(f => f.url().includes('1062') || f.url().toLowerCase().includes('spd_datos_meta'));
  console.log('diálogo meta:', fr ? 'abierto ' + fr.url().split('?')[0].split('/').pop() : 'NO');

  // seguimiento form
  await go('SPD_SEGUIMIENTOS');
  current = 'seguimiento';
  await Promise.all([page.waitForNavigation(), page.click('.a-IRR-table td a >> nth=0')]); await page.waitForLoadState('networkidle');
  console.log('seguimiento form:', page.url().split('?')[0].split('/').pop(), 'grilla colores filas:', await page.$$eval('.a-GV-row', r => r.length), (await errs()).join(';'));

  await page.screenshot({ path: 'app160.png' });
  await browser.close();
  console.log(`\nProblemas: ${problems.length}`);
  [...new Set(problems)].forEach(p => console.log(' - ' + p));
})().catch(e => { console.error('FALLO:', e.message); process.exit(1); });
