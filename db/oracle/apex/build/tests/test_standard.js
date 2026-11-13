// Estándar de diseño: breadcrumb global, botones del formulario, barra de cuadrículas, textos en español.
const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch({ channel: 'msedge', headless: true });
  const page = await browser.newPage({ viewport: { width: 1600, height: 900 } });
  const errors = [];
  page.on('pageerror', e => errors.push('JS: ' + e.message));
  page.on('response', r => { if (r.status() >= 400) errors.push(`HTTP ${r.status()} ${r.url()}`); });
  const nav = async (fn) => { await Promise.all([page.waitForNavigation(), fn()]); await page.waitForLoadState('networkidle'); };
  const bodyErr = async () => { const t = await page.innerText('body'); if (/debug id|administrator/i.test(t)) console.log('!! ERROR PÁGINA:', t.replace(/\s+/g, ' ').slice(0, 300)); };
  const info = async (label) => {
    await bodyErr();
    const crumbs = await page.$$eval('.t-Breadcrumb-item', e => e.map(x => x.innerText.trim()));
    const head = await page.$$eval('.t-Breadcrumb-region .t-Button, .t-BreadcrumbRegion .t-Button, .t-Body-title .t-Button', b => b.filter(x => x.offsetParent).map(x => x.innerText.trim() + (x.classList.contains('t-Button--hot') ? '*' : '')));
    const tb = await page.$$eval('.a-Toolbar button, .a-Toolbar .a-Button', b => [...new Set(b.filter(x => x.offsetParent).map(x => x.innerText.trim()).filter(Boolean))]);
    console.log(`== ${label}\n   migas: ${crumbs.join(' / ')}\n   botones cabecera: ${head.join(' | ')}\n   barra grilla/reporte: ${tb.join(' | ')}`);
  };
  await page.goto('http://localhost:8080/ords/r/spd/spd/login');
  await page.fill('#P9999_USERNAME', 'ADMIN'); await page.fill('#P9999_PASSWORD', process.env.SPD_PASS);
  await Promise.all([page.waitForURL(u => !String(u).includes('/login')), page.click('.t-Button--hot')]);
  const s = new URL(page.url()).searchParams.get('session');
  const go = async (p) => { await page.goto(`http://localhost:8080/ords/f?p=100:${p}:${s}`); await page.waitForLoadState('networkidle'); };

  await go(4); await info('Entidades (reporte)'); await page.screenshot({ path: 'std_report.png' });
  await nav(() => page.click('.a-IRR-table td a >> nth=0')); await info('Entidad (formulario, editar)');
  console.log('   diálogo:', await page.$('.ui-dialog') !== null);
  await page.screenshot({ path: 'std_form.png' });
  // Aplicar Cambios sin cambios -> vuelve al reporte con mensaje
  await nav(() => page.click('button:has-text("Aplicar Cambios")'));
  console.log('   tras Aplicar Cambios:', page.url().split('?')[0].split('/').pop(), await page.$$eval('.t-Alert-body, .a-Notification-item', e => [...new Set(e.map(x => x.innerText.trim()))]));
  await go(4); await nav(() => page.click('button:has-text("Nuevo")')); await info('Entidad (formulario, nuevo)');
  await go(25); await info('ODS (cuadrícula sola)'); await page.screenshot({ path: 'std_grid.png' });
  const al = await page.$$eval('.a-GV-header', h => h.filter(x => x.offsetParent).map(x => x.innerText.trim() + ':' + getComputedStyle(x).textAlign));
  console.log('   alineación encabezados:', al.join(' , '));
  await go(47); await info('Registros de seguimiento (maestro-detalle)');
  await go(10); await info('Metas (pestañas)');
  await go(6); await nav(() => page.click('.a-IRR-table td a >> nth=0')); await info('Detalles del plan');
  await nav(() => page.click('a:has-text("Editar Estructura"), button:has-text("Editar Estructura")')); await info('Estructura del plan');
  await nav(() => page.locator('#spd_plan_tree .a-TreeView-label').nth(1).click()); await info('Estructura con nodo');
  console.log('   botones región:', await page.$$eval('.t-Region .t-Button', b => b.filter(x => x.offsetParent).map(x => x.innerText.trim()).filter(Boolean)));
  await page.screenshot({ path: 'std_structure.png' });
  await go(6); await nav(() => page.click('.a-IRR-table td a >> nth=0'));
  await nav(() => page.click('.t-BreadcrumbRegion button:has-text("Editar"), .t-BreadcrumbRegion a:has-text("Editar")'));
  await info('Editar plan (formulario + grilla)'); await page.screenshot({ path: 'std_plan.png' });
  console.log('Errores:', errors.length ? errors : 'ninguno');
  await browser.close();
})();
