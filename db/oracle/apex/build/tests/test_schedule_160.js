// App 160: Programación de Metas (página 1030 + diálogo 1063, build/schedule_goals_160.sql).
// Login por la 106, elige el seguimiento, abre el diálogo de una meta, la programa y guarda (el diálogo se cierra
// y el listado se refresca); revisa historial, Volver, modal Datos de la Meta y la pestaña de estructura.
// Uso: node test_schedule_160.js   (CFG=2024-4 por defecto: el seguimiento demo en etapa de programación;
//      CFG=2024-3 para el caso de solo lectura)
const { chromium } = require('playwright-core');
const B = 'http://localhost:8080/ords/';
const NIT = '8913800073';
const CFG = process.env.CFG || '2024-4';
(async () => {
  const browser = await chromium.launch({ channel: 'msedge', headless: true });
  const page = await browser.newPage({ viewport: { width: 1600, height: 1000 } });
  const problems = [];
  page.on('pageerror', e => problems.push(`JS: ${e.message.slice(0, 200)}`));
  page.on('response', r => { if (r.status() >= 400) problems.push(`HTTP ${r.status()} ${r.url().slice(0, 140)}`); });
  const errs = async (tag, where = page) => {
    const body = await where.locator('body').innerText().catch(() => '');
    const m = body.match(/.{0,120}(ORA-\d+|PLS-\d+|Error inesperado|debug id|Error during).{0,160}/is);
    if (m) problems.push(`[${tag}] ${m[0].replace(/\s+/g, ' ')}`);
  };

  await page.goto(`${B}f?p=106:LOGIN:0::::P9999_NIT_COMPANIA:${NIT}`);
  await page.fill('#P9999_USERNAME', 'fgil666@gmail.com');
  await page.fill('#P9999_PASSWORD', 'Spd#2026');
  await Promise.all([page.waitForURL(u => !/login/i.test(String(u)), { timeout: 20000 }).catch(() => {}), page.click('.t-Button--hot')]);
  await page.waitForLoadState('networkidle').catch(() => {});
  const session = (/[?&]session=(\d+)/.exec(page.url()) || /f\?p=106:[^:]*:(\d+)/.exec(page.url()) || [])[1];
  if (!session) throw new Error('sin sesión: ' + page.url());

  await page.goto(`${B}f?p=160:SPD_PROGRAMACION_METAS:${session}`);
  await page.waitForLoadState('networkidle').catch(() => {});
  await errs('carga');
  const opt = await page.$$eval('#P1030_MC option', (os, c) => (os.find(o => o.textContent.includes(`(${c})`)) || {}).value, CFG);
  if (!opt) throw new Error('no está el seguimiento ' + CFG);
  if ((await page.inputValue('#P1030_MC')) !== opt) {
    await Promise.all([page.waitForNavigation(), page.selectOption('#P1030_MC', opt)]);
    await page.waitForLoadState('networkidle').catch(() => {});
  }
  console.log('seguimiento:', await page.$eval('#P1030_MC', s => s.selectedOptions[0].textContent));
  console.log('pestañas:', (await page.$$eval('.t-Tabs-link', e => e.map(x => x.innerText.trim().replace(/\s+/g, ' ')))).join(' | '));
  console.log('listado:', await page.$$eval('#spd_list .a-IRR-table tr', t => t.length - 1), 'filas | panel lateral:',
    await page.locator('.spd-collapse').count() > 0 ? 'SÍ (no debería)' : 'no');

  // abrir el diálogo de la primera meta "Sin Programar" (o la primera)
  const link = page.locator('#spd_list tr:has(.spd-st--NEW) a[data-goal]').first();
  const target = (await link.count()) ? link : page.locator('#spd_list a[data-goal]').first();
  const goalId = await target.getAttribute('data-goal');
  await target.click();
  const dlgFrame = page.frameLocator('iframe[title="Programación"]');
  await dlgFrame.locator('.spd-collapse summary').first().waitFor({ timeout: 20000 }).catch(() => problems.push('no abrió el diálogo Programación'));
  const frame = page.frames().find(f => /spd_programar_meta|:1063:/i.test(f.url()));
  if (frame) await errs('diálogo', frame);
  console.log('diálogo meta', goalId, ':', await dlgFrame.locator('.spd-collapse summary').first().innerText().catch(() => '?'));
  console.log('  pestañas:', (await dlgFrame.locator('.t-Tabs-link').allInnerTexts()).join(' | '),
    '| botones:', (await dlgFrame.locator('.t-ButtonRegion button, .t-Dialog-footer button').allInnerTexts()).join(' / '));
  const editable = await dlgFrame.locator('input[name=f01]').isEnabled().catch(() => false);
  console.log('  editable:', editable, '| columnas:', (await dlgFrame.locator('.spd-colhead').allInnerTexts()).join(' / '));
  await page.screenshot({ path: 'schedule_160_dialog.png' });

  if (editable) {
    await dlgFrame.locator('input[name=f01]').fill('3');
    await dlgFrame.locator('#spd_from').selectOption('2');
    await dlgFrame.locator('#spd_to').selectOption('1');   // debe ajustar el mes inicial
    console.log('  meses tras ajustar:', await dlgFrame.locator('#spd_from').inputValue(), '-', await dlgFrame.locator('#spd_to').inputValue());
    const u = dlgFrame.locator('#u_RP');
    if (await u.count()) { await u.fill('1.500.000'); await dlgFrame.locator('#u_CN').fill('500000'); await dlgFrame.locator('#u_CN').press('Tab'); }
    console.log('  total usuario:', await dlgFrame.locator('#u_TOTAL').inputValue().catch(() => '-'));
    await dlgFrame.locator('button', { hasText: 'Guardar' }).click();
    await page.waitForFunction(() => !document.querySelector('iframe[title="Programación"]'), null, { timeout: 20000 })
      .catch(async () => problems.push('el diálogo no se cerró al guardar: ' + (await dlgFrame.locator('.a-Notification, .t-Alert').allInnerTexts().catch(() => [])).join(' ').replace(/\s+/g, ' ').slice(0, 300)));
    await page.waitForLoadState('networkidle').catch(() => {});
    await page.waitForTimeout(1500);
    console.log('tras guardar: mensaje =', (await page.locator('#t_Alert_Success, .t-Alert--success').innerText().catch(() => '(sin mensaje)')).replace(/\s+/g, ' ').slice(0, 60),
      '| estado de la meta en la lista =', await page.locator(`#spd_list a[data-goal="${goalId}"]`).locator('xpath=ancestor::tr').locator('.spd-st').getAttribute('title').catch(() => '?'));
    // volver a abrir: valores guardados e historial
    await page.locator(`#spd_list a[data-goal="${goalId}"]`).click();
    await dlgFrame.locator('input[name=f01]').waitFor({ timeout: 20000 });
    console.log('reabierto: meta =', await dlgFrame.locator('input[name=f01]').inputValue(), '| RP =', await dlgFrame.locator('#u_RP').inputValue().catch(() => '-'),
      '| meses =', await dlgFrame.locator('#spd_from').inputValue(), '-', await dlgFrame.locator('#spd_to').inputValue());
  }
  await dlgFrame.locator('.t-Tabs-link', { hasText: 'Historial' }).click();
  await page.waitForTimeout(300);
  console.log('historial:', (await dlgFrame.locator('.spd-hist-title').allInnerTexts()).join(' | ') || '(vacío)');
  await dlgFrame.locator('button', { hasText: 'Volver' }).click();
  await page.waitForFunction(() => !document.querySelector('iframe[title="Programación"]'), null, { timeout: 10000 }).catch(() => problems.push('Volver no cerró el diálogo'));
  console.log('tras Volver: diálogo abierto =', await page.locator('iframe[title="Programación"]').count() > 0);

  // modal Datos de la Meta desde el código
  await page.locator('#spd_list .a-IRR-table td a:not([data-goal])').first().click();
  const det = page.frameLocator('iframe[title="Datos de la Meta"]');
  await det.locator('#P1062_CODE').waitFor({ timeout: 15000 }).catch(() => problems.push('no abrió Datos de la Meta'));
  console.log('Datos de la Meta:', await det.locator('#P1062_CODE').innerText().catch(() => '?'));
  await page.keyboard.press('Escape');
  await page.waitForTimeout(500);

  // pestaña Por Estructura del Plan: árbol, nodo y diálogo desde la lista del nodo
  await page.locator('.t-Tabs-link', { hasText: 'Por Estructura del Plan' }).click();
  await page.waitForTimeout(500);
  console.log('árbol: nodos =', await page.locator('#spd_sched_tree .a-TreeView-label').count(), '| badges =', await page.locator('#spd_sched_tree .spd-badge').count());
  const node = page.locator('#spd_sched_tree .a-TreeView-node .a-TreeView-node .a-TreeView-label').first();
  if (await node.count()) {
    await Promise.all([page.waitForNavigation().catch(() => {}), node.click()]);
    await page.waitForLoadState('networkidle').catch(() => {});
    console.log('nodo -> metas =', await page.locator('#spd_node_goals .spd-tbl tr').count() - 1);
    await page.locator('#spd_node_goals a[data-goal]').first().click();
    await dlgFrame.locator('.spd-collapse summary').first().waitFor({ timeout: 20000 }).catch(() => problems.push('no abrió el diálogo desde el árbol'));
    console.log('diálogo desde el árbol:', await dlgFrame.locator('.spd-collapse summary').first().innerText().catch(() => '?'));
    await page.screenshot({ path: 'schedule_160_tree.png' });
  }

  console.log(`\n${problems.length} problemas`); [...new Set(problems)].forEach(p => console.log(' -', p));
  await browser.close();
})().catch(e => { console.error(e); process.exit(1); });
