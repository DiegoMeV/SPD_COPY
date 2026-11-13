const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch({ channel: 'msedge', headless: true });
  const page = await browser.newPage({ viewport: { width: 1600, height: 900 } });
  const errors = []; page.on('pageerror', e => errors.push('JS: ' + e.message));
  const nav = async (fn) => { await Promise.all([page.waitForNavigation(), fn()]); await page.waitForLoadState('networkidle'); };
  const msgs = () => page.$$eval('.t-Alert-body, .a-Notification-item', e => [...new Set(e.map(x => x.innerText.trim().replace(/\s+/g, ' ')))]);
  const head = () => page.$$eval('.t-BreadcrumbRegion .t-Button', b => b.filter(x => x.offsetParent).map(x => x.innerText.trim()));
  await page.goto('http://localhost:8080/ords/r/spd/spd/login');
  await page.fill('#P9999_USERNAME', 'ADMIN'); await page.fill('#P9999_PASSWORD', process.env.SPD_PASS);
  await Promise.all([page.waitForURL(u => !String(u).includes('/login')), page.click('.t-Button--hot')]);
  const s = new URL(page.url()).searchParams.get('session');
  // crear entidad
  await page.goto(`http://localhost:8080/ords/f?p=100:4:${s}`); await page.waitForLoadState('networkidle');
  await nav(() => page.click('.t-BreadcrumbRegion button:has-text("Nuevo")'));
  console.log('Entidad nueva - botones:', await head());
  await page.fill('#P5_CODIGO_ENT_PRY', 'ZZTEST'); await page.fill('#P5_NOMBRE_ENT_PRY', 'ENTIDAD DE PRUEBA');
  await page.click('.t-BreadcrumbRegion button:has-text("Aplicar Cambios")'); await page.waitForTimeout(4000); await page.waitForLoadState('networkidle');
  console.log('Tras crear:', page.url().split('?')[0].split('/').pop(), await msgs());
  // editar y eliminar
  const href = await page.$$eval('.a-IRR-table td a', a => a.map(x => x.getAttribute('href')).find(h => /zztest/i.test(h)));
  if (href) {
    await page.goto('http://localhost:8080' + href); await page.waitForLoadState('networkidle');
    console.log('Entidad existente - botones:', await head());
    page.once('dialog', d => d.accept());
    await page.click('.t-BreadcrumbRegion button:has-text("Eliminar")');
    await page.waitForSelector('.ui-dialog .js-confirmBtn', { timeout: 5000 }).then(() => page.click('.ui-dialog .js-confirmBtn')).catch(() => {});
    await page.waitForTimeout(4000); await page.waitForLoadState('networkidle');
    console.log('Tras eliminar:', page.url().split('?')[0].split('/').pop(), await msgs());
  } else console.log('no se encontró la entidad creada en el reporte');
  // barra de cuadrícula en español
  await page.goto(`http://localhost:8080/ords/f?p=100:25:${s}`); await page.waitForLoadState('networkidle');
  console.log('Barra ODS:', [...new Set(await page.$$eval('.a-Toolbar button', b => b.filter(x => x.offsetParent).map(x => x.innerText.trim()).filter(Boolean)))].join(' | '),
              '| buscar:', await page.$eval('.a-Toolbar input[type=search], .a-Toolbar-input', e => e.placeholder).catch(() => '?'));
  // Datos de la Meta -> Editar -> formulario de meta (página normal)
  await page.goto(`http://localhost:8080/ords/f?p=100:10:${s}`); await page.waitForLoadState('networkidle');
  await page.click('.a-IRR-table td a >> nth=0'); await page.waitForSelector('.ui-dialog iframe'); await page.waitForTimeout(2500);
  const dlg = page.frames().find(f => /datos-de-la-meta/.test(f.url()));
  await Promise.all([page.waitForNavigation({ timeout: 15000 }).catch(() => {}), dlg.click('button:has-text("Editar")')]);
  await page.waitForTimeout(3000);
  console.log('Editar meta -> URL principal:', page.url().split('?')[0].split('/').pop(), '| diálogo abierto:', await page.$('.ui-dialog:visible') !== null,
              '| frames meta:', page.frames().filter(f => /\/meta\?/.test(f.url())).length, '| botones:', await head().catch(() => []));
  console.log('Errores:', errors.length ? errors : 'ninguno');
  await browser.close();
})();
