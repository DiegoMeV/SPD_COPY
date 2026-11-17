// App 160: Focalización en "Ejecución meta" (1064): IG de localizaciones por sección + formulario modal 1065.
// Abre el reporte de una meta (seguimiento 2024-3), agrega una localización E.D., la edita y la elimina;
// agrega una localización Org. y R.E. Uso: node test_focalizacion_160.js
const { chromium } = require('playwright-core');
const B = 'http://localhost:8080/ords/';
(async () => {
  const browser = await chromium.launch({ channel: 'msedge', headless: true });
  const page = await browser.newPage({ viewport: { width: 1600, height: 1000 } });
  const problems = [];
  page.on('pageerror', e => problems.push(`JS: ${e.message.slice(0, 200)}`));
  page.on('response', r => { if (r.status() >= 400) problems.push(`HTTP ${r.status()} ${r.url().slice(0, 120)}`); });

  await page.goto(`${B}f?p=106:LOGIN:0::::P9999_NIT_COMPANIA:8913800073`);
  await page.fill('#P9999_USERNAME', 'fgil666@gmail.com');
  await page.fill('#P9999_PASSWORD', 'Spd#2026');
  await Promise.all([page.waitForURL(u => !/login/i.test(String(u)), { timeout: 20000 }).catch(() => {}), page.click('.t-Button--hot')]);
  await page.waitForLoadState('networkidle').catch(() => {});
  const session = (/[?&]session=(\d+)/.exec(page.url()) || /f\?p=106:[^:]*:(\d+)/.exec(page.url()) || [])[1];

  await page.goto(`${B}f?p=160:SPD_REPORTE_METAS:${session}`);
  await page.waitForLoadState('networkidle').catch(() => {});
  const opt = await page.$$eval('#P1031_MC option', os => os.find(o => o.textContent.includes('(2024-3)')).value);
  if ((await page.inputValue('#P1031_MC')) !== opt) { await Promise.all([page.waitForNavigation(), page.selectOption('#P1031_MC', opt)]); await page.waitForLoadState('networkidle').catch(() => {}); }
  await page.locator('#spd_list a[data-goal]:has(.fa-pencil-square-o)').first().click();
  const dlg = page.frameLocator('iframe[title="Ejecución meta"]');
  await dlg.locator('.t-Tabs-link').first().waitFor({ timeout: 20000 });
  await page.waitForTimeout(2500);   // las pestañas se inicializan después de cargar

  const form = () => page.frameLocator('iframe[title="Focalización"]').last();
  const rows = async (sec) => dlg.locator(`#spd_tm_${sec} .a-GV-table tbody tr`).count();
  const cells = async (sec) => (await dlg.locator(`#spd_tm_${sec} .a-GV-table tbody tr`).first().locator('td').allInnerTexts().catch(() => [])).map(t => t.trim()).filter(Boolean).join(' | ');
  const waitClosed = () => page.waitForFunction(() => !document.querySelector('iframe[title="Focalización"]'), null, { timeout: 20000 })
    .then(() => true).catch(() => false);

  for (const [sec, tab] of [['ed', 'Focalización E.D.'], ['org', 'Focalización Org.'], ['re', 'Focalización R.E.']]) {
    await dlg.locator('.t-Tabs-link', { hasText: tab }).click();
    await page.waitForTimeout(600);
    const before = await rows(sec);
    const heads = (await dlg.locator(`#spd_tm_${sec} .a-GV-header`).allInnerTexts().catch(() => [])).map(t => t.trim()).filter(Boolean).join(', ');
    console.log(`${tab}: columnas [${heads}] filas antes = ${before}`);
    // agregar
    const fr = page.frames().find(x => /spd_ejecucion_meta/i.test(x.url()));
    await fr.evaluate(() => { const b = [...document.querySelectorAll('button')].find(x => x.textContent.includes('Agregar localización') && x.offsetParent); b.click(); });
    await form().locator('#P1065_LOCALIZATION_LEFT, select[id$=LOCALIZATION_LEFT]').waitFor({ timeout: 20000 })
      .catch(() => problems.push(`[${sec}] no abrió el formulario Focalización`));
    const regions = (await form().locator('.t-Region-title').allInnerTexts().catch(() => [])).join(' / ');
    console.log(`  formulario: regiones = ${regions}`);
    // elegir dos ubicaciones en el shuttle
    const left = form().locator('select[id$=LOCALIZATION_LEFT]');
    const opts = await left.locator('option').allInnerTexts();
    if (opts.length) {
      await left.selectOption({ index: 1 }).catch(() => {});
      await form().locator('button[aria-label*="Mover"], button[title*="Mover"], .a-Button--shuttle').first().click().catch(() => {});
      await left.dblclick({ position: { x: 20, y: 30 } }).catch(() => {});
    }
    if (sec === 'ed') { await form().locator('#P1065_ED_GENRE_H').fill('10'); await form().locator('#P1065_ED_GENRE_M').fill('15'); await form().locator('#P1065_ED_ZONE_U').fill('20'); await form().locator('#P1065_ED_ETNIA_AFRO').fill('3'); }
    if (sec === 'org') { await form().locator('#P1065_ORG_TYPE').fill('Junta de Acción Comunal'); await form().locator('#P1065_ORG_NUM').fill('120'); }
    if (sec === 're') { await form().locator('#P1065_RE_CANINE_M').fill('4'); await form().locator('#P1065_RE_CANINE_F').fill('6'); await form().locator('#P1065_RE_FLORA').fill('Guayacanes'); }
    await form().locator('button', { hasText: 'Guardar' }).click();
    if (!(await waitClosed())) {
      problems.push(`[${sec}] el formulario no se cerró: ${(await form().locator('.a-Notification, .t-Alert').allInnerTexts().catch(() => [])).join(' ').replace(/\s+/g, ' ').slice(0, 300)}`);
      continue;
    }
    await page.waitForTimeout(2500);
    console.log(`  guardado: filas = ${await rows(sec)} | fila: ${await cells(sec)}`);
    if (sec !== 'ed') continue;
    // editar
    await dlg.locator('#spd_tm_ed .a-GV-table tbody tr').last().locator('a').first().click();
    await form().locator('#P1065_ED_GENRE_H').waitFor({ timeout: 20000 });
    console.log(`  editar: Hombres = ${await form().locator('#P1065_ED_GENRE_H').inputValue()} | Afro = ${await form().locator('#P1065_ED_ETNIA_AFRO').inputValue()}`);
    await form().locator('#P1065_ED_GENRE_H').fill('11');
    await form().locator('button', { hasText: 'Guardar' }).click();
    await waitClosed(); await page.waitForTimeout(2500);
    console.log(`  editado: fila: ${await cells('ed')}`);
    // eliminar
    await dlg.locator('#spd_tm_ed .a-GV-table tbody tr').last().locator('a').first().click();
    await form().locator('button', { hasText: 'Eliminar' }).waitFor({ timeout: 20000 });
    await form().locator('button', { hasText: 'Eliminar' }).click();
    // la confirmación de APEX se abre en la ventana principal
    await page.locator('.ui-dialog button', { hasText: /Aceptar|OK/ }).last().click({ timeout: 10000 }).catch(() => problems.push('[ed] sin confirmación de eliminar'));
    await waitClosed(); await page.waitForTimeout(2500);
    console.log(`  eliminado: filas = ${await rows('ed')} (antes ${before})`);
  }
  await page.screenshot({ path: 'focalizacion.png' });
  console.log(`\n${problems.length} problemas`); [...new Set(problems)].forEach(p => console.log(' -', p));
  await browser.close();
})().catch(e => { console.error(e); process.exit(1); });
