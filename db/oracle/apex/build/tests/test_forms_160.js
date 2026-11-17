// App 160: formularios sin compañía visible, filas de campos (máx. 4 salvo switches / casillas) y
// sincronización de G_SEGUIMIENTO / G_PLAN entre páginas. Uso: node test_forms_160.js [carpeta capturas]
const { chromium } = require('playwright-core');
const B = 'http://localhost:8080/ords/';
const OUT = process.argv[2] || '.';
const FORMS = [1003, 1005, 1007, 1009, 1011, 1015, 1017, 1019, 1021, 1024, 1046];
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
  const go = async (p) => { await page.goto(`${B}f?p=160:${p}:${session}`); await page.waitForLoadState('networkidle').catch(() => {}); };

  // 1. formularios (modo crear)
  for (const pg of FORMS) {
    await go(pg);
    const title = await page.title();
    if (/\berror\b|session state protection/i.test(await page.locator('body').innerText().catch(() => ''))) { problems.push(`[${pg}] no abre: ${title}`); continue; }
    const info = await page.evaluate(() => {
      const vis = [...document.querySelectorAll('.t-Form-fieldContainer')].filter(c => c.offsetParent && !c.closest('.a-GV, .a-IG'));
      const rows = {};
      vis.forEach(c => { const t = Math.round(c.getBoundingClientRect().top / 4); (rows[t] = rows[t] || []).push(c); });
      const out = Object.values(rows).map(r => ({
        n: r.length,
        sw: r.every(c => c.matches('.apex-item-wrapper--yes-no, .apex-item-wrapper--checkbox, .apex-item-wrapper--single-checkbox')),
        labels: r.map(c => (c.querySelector('label, .t-Form-label') || {}).textContent || '?').map(s => s.trim().slice(0, 22)),
      }));
      const nit = [...document.querySelectorAll('[id$=NIT_COMPANIA_CONTAINER], [id$=_COMPANIA_CONTAINER]')].filter(c => c.offsetParent).length;
      const nitVal = (document.querySelector('input[id$=_NIT_COMPANIA]') || {}).value || '';
      return { rows: out, nit, nitVal };
    });
    const max = Math.max(0, ...info.rows.map(r => r.n));
    console.log(`${pg} ${title} | filas=${info.rows.length} máx/fila=${max} | compañía visible=${info.nit} valor=${info.nitVal}`);
    info.rows.forEach(r => console.log('    ' + r.labels.join(' | ')));
    if (info.nit) problems.push(`[${pg}] la compañía sigue visible`);
    if (info.rows.some(r => r.n > 4 && !r.sw)) problems.push(`[${pg}] fila con más de 4 campos`);
    await page.screenshot({ path: `${OUT}/form_${pg}.png`, fullPage: true });
  }

  // elige un seguimiento en Reporte de metas (la lista envía la página)
  const pickMc = async (label) => {
    await go('SPD_REPORTE_METAS');
    const v = await page.$$eval('#P1031_MC option', (os, l) => (os.find(o => o.textContent.includes(l)) || {}).value, label);
    if ((await page.inputValue('#P1031_MC')) === v) return;
    const nav = page.waitForNavigation({ timeout: 20000 }).then(() => true).catch(() => false);
    await page.selectOption('#P1031_MC', v);
    if (!(await nav)) problems.push(`[1031] no recargó al elegir ${label}`);
    await page.waitForLoadState('networkidle').catch(() => {});
  };
  // 2. G_SEGUIMIENTO: elegir 2024-1 en Reporte de metas y comprobar que Revisión y Tableros lo usan
  await pickMc('(2024-1)');
  for (const [alias, item] of [['SPD_REVISION_PROYECTOS', 'P1038_MC'], ['SPD_TABLERO_METAS', 'P1034_MC'], ['SPD_PROGRAMACION_PLANES_ACCION', 'P1040_MC']]) {
    await go(alias);
    const txt = await page.$eval(`#${item}`, s => s.options[s.selectedIndex].textContent).catch(() => '?');
    console.log(`G_SEGUIMIENTO -> ${alias}: ${txt}`);
    if (!txt.includes('(2024-1)')) problems.push(`[${alias}] no tomó el seguimiento 2024-1 (${txt})`);
  }
  // volver al activo para no dejar la sesión cambiada
  await pickMc('(2024-3)');
  await go('SPD_TABLERO_METAS');
  const backMc = await page.$eval('#P1034_MC', s => s.options[s.selectedIndex].textContent).catch(() => '?');
  console.log(`G_SEGUIMIENTO de vuelta -> SPD_TABLERO_METAS: ${backMc}`);
  if (!backMc.includes('(2024-3)')) problems.push(`[1034] no volvió a 2024-3 (${backMc})`);

  // 3. G_PLAN: cambiar el plan en Metas por estructura (1010) y verlo como valor por defecto al crear una meta (1011)
  // la lista de plan está en la pestaña "Por Estructura del Plan"
  const go1010 = async () => {
    await go(1010);
    await page.locator('.t-Tabs-link', { hasText: 'Estructura' }).first().click().catch(() => {});
    await page.waitForTimeout(500);
  };
  await go1010();
  const plans = await page.$$eval('#P1010_PLAN option', os => os.map(o => [o.value, o.textContent.trim()]).filter(o => o[0]));
  const cur = await page.inputValue('#P1010_PLAN');
  const other = (plans.find(p => p[0] !== cur) || [])[0];
  if (other) {
    { const nav = page.waitForNavigation({ timeout: 20000 }).then(() => true).catch(() => false);
      await page.selectOption('#P1010_PLAN', other);
      if (!(await nav)) problems.push('[1010] no recargó al cambiar el plan');
      await page.waitForLoadState('networkidle').catch(() => {}); }
    await go(1011);
    const v = await page.inputValue('#P1011_PLAN').catch(() => '?');
    console.log(`G_PLAN: 1010 elegido=${other} -> 1011 nuevo=${v}`);
    if (v !== other) problems.push(`[1011] no tomó G_PLAN (${v} <> ${other})`);
    // cambiar el plan en el formulario (acción dinámica) y verlo en 1010
    await page.selectOption('#P1011_PLAN', cur); await page.waitForTimeout(1500);
    await go1010();
    const back = await page.inputValue('#P1010_PLAN');
    console.log(`G_PLAN: 1011 cambiado a ${cur} -> 1010=${back}`);
    if (back !== cur) problems.push(`[1010] no tomó G_PLAN desde el formulario (${back} <> ${cur})`);
  } else console.log('G_PLAN: solo hay un plan, no se prueba el cambio');

  console.log(`\n${problems.length} problemas`); [...new Set(problems)].forEach(p => console.log(' -', p));
  await browser.close();
})().catch(e => { console.error(e); process.exit(1); });
