// App 160: recorre todas las pantallas de Seguimiento (Metas, Proyectos, Planes de Acción) con los datos demo:
// Programación (2024-4), Reporte (2024-3), Validación (2024-2), Revisión y Tableros (2024-3, la activa). En cada lista abre
// el diálogo de la primera fila con acción habilitada, completa / decide, guarda y verifica cierre + mensaje.
// Uso: node test_monitoring_160.js   (SAVE=0 para no guardar)
const { chromium } = require('playwright-core');
const B = 'http://localhost:8080/ords/';
const NIT = '8913800073';
const SAVE = process.env.SAVE !== '0';
const STEPS = [
  // [alias, página, seguimiento, etapa]
  ['SPD_PROGRAMACION_METAS', 1030, '2024-4', 'SCHEDULE'], ['SPD_PROGRAMACION_PROYECTOS', 1035, '2024-4', 'SCHEDULE'],
  ['SPD_PROGRAMACION_PLANES_ACCION', 1040, '2024-4', 'SCHEDULE'],
  ['SPD_REPORTE_METAS', 1031, '2024-3', 'REPORT'], ['SPD_REPORTE_PROYECTOS', 1036, '2024-3', 'REPORT'],
  ['SPD_REPORTE_PLANES_ACCION', 1041, '2024-3', 'REPORT'],
  ['SPD_VALIDACION_METAS', 1032, '2024-2', 'VALIDATE'], ['SPD_VALIDACION_PROYECTOS', 1037, '2024-2', 'VALIDATE'],
  ['SPD_VALIDACION_PLANES_ACCION', 1042, '2024-2', 'VALIDATE'],
  ['SPD_REVISION_METAS', 1033, '2024-3', 'REVIEW'], ['SPD_REVISION_PROYECTOS', 1038, '2024-3', 'REVIEW'],
  ['SPD_REVISION_PLANES_ACCION', 1043, '2024-3', 'REVIEW'],
  ['SPD_TABLERO_METAS', 1034, '2024-3', 'VIEW'], ['SPD_TABLERO_PROYECTOS', 1039, '2024-3', 'VIEW'],
  ['SPD_TABLERO_PLANES_ACCION', 1044, '2024-3', 'VIEW'],
];
(async () => {
  const browser = await chromium.launch({ channel: 'msedge', headless: true });
  const page = await browser.newPage({ viewport: { width: 1600, height: 1000 } });
  const problems = [];
  let current = 'login';
  page.on('pageerror', e => problems.push(`[${current}] JS: ${e.message.slice(0, 200)}`));
  page.on('response', r => { if (r.status() >= 400) problems.push(`[${current}] HTTP ${r.status()} ${r.url().slice(0, 120)}`); });
  const fillIf = async (loc, v) => { if (await loc.count() && await loc.first().isEditable().catch(() => false)) await loc.first().fill(v); };
  const selIf = async (loc, v) => { if (await loc.count() && await loc.first().isEnabled().catch(() => false)) await loc.first().selectOption(v); };
  const errs = async (where) => {
    const body = await where.locator('body').innerText().catch(() => '');
    const m = body.match(/.{0,100}(ORA-\d+|PLS-\d+|Error inesperado|debug id|Error during|rendering of region).{0,200}/is);
    if (m) problems.push(`[${current}] ${m[0].replace(/\s+/g, ' ')}`);
  };

  await page.goto(`${B}f?p=106:LOGIN:0::::P9999_NIT_COMPANIA:${NIT}`);
  await page.fill('#P9999_USERNAME', 'fgil666@gmail.com');
  await page.fill('#P9999_PASSWORD', 'Spd#2026');
  await Promise.all([page.waitForURL(u => !/login/i.test(String(u)), { timeout: 20000 }).catch(() => {}), page.click('.t-Button--hot')]);
  await page.waitForLoadState('networkidle').catch(() => {});
  const session = (/[?&]session=(\d+)/.exec(page.url()) || /f\?p=106:[^:]*:(\d+)/.exec(page.url()) || [])[1];
  if (!session) throw new Error('sin sesión');

  for (const [alias, pg, cfg, stage] of STEPS) {
    current = `${pg} ${stage}`;
    await page.goto(`${B}f?p=160:${alias}:${session}`);
    await page.waitForLoadState('networkidle').catch(() => {});
    const sel = `#P${pg}_MC`;
    const opt = await page.$$eval(`${sel} option`, (os, c) => (os.find(o => o.textContent.includes(`(${c})`)) || {}).value, cfg).catch(() => null);
    if (opt && (await page.inputValue(sel)) !== opt) {
      await Promise.all([page.waitForNavigation(), page.selectOption(sel, opt)]);
      await page.waitForLoadState('networkidle').catch(() => {});
    }
    await errs(page);
    const title = await page.title();
    const rows = await page.$$eval('#spd_list .a-IRR-table tr', t => t.length - 1).catch(() => 0);
    const heads = (await page.$$eval('#spd_list .a-IRR-table th', t => t.map(x => x.innerText.trim()).filter(Boolean)).catch(() => [])).join(', ');
    const states = [...new Set(await page.$$eval('#spd_list .spd-st', e => e.map(x => x.title)).catch(() => []))].join(', ');
    let line = `${pg} ${title} [${cfg}] filas=${rows} | ${heads} | estados: ${states}`;
    // primera fila con acción habilitada (no "Ver"), si no la primera
    const actionable = page.locator('#spd_list a[data-goal]:has(.spd-act:not(.fa-eye))').first();
    const anyRow = page.locator('#spd_list a[data-goal]').first();
    const target = (await actionable.count()) ? actionable : anyRow;
    if (!(await target.count())) { console.log(line + ' | (sin filas)'); continue; }
    const goal = await target.getAttribute('data-goal');
    await target.click();
    const dlgTitle = stage === 'SCHEDULE' ? 'Programación' : 'Ejecución meta';
    const dlg = page.frameLocator(`iframe[title="${dlgTitle}"]`);
    await dlg.locator('body .spd-collapse summary').first().waitFor({ timeout: 20000 }).catch(() => problems.push(`[${current}] no abrió el diálogo ${dlgTitle}`));
    const fr = page.frames().find(f => /spd_programar_meta|spd_ejecucion_meta/i.test(f.url()));
    if (fr) await errs(fr);
    const tabs = (await dlg.locator('.t-Tabs-link').allInnerTexts().catch(() => [])).join('/');
    const buttons = (await dlg.locator('.t-ButtonRegion button, .t-Dialog-footer button').allInnerTexts().catch(() => [])).join('/');
    const canSave = buttons.includes('Guardar');
    line += `\n     diálogo meta ${goal}: ${(await dlg.locator('.spd-collapse summary').first().innerText().catch(() => '?')).slice(0, 60)} | pestañas: ${tabs} | botones: ${buttons}`;
    if (stage === 'REPORT' || stage === 'VALIDATE' || stage === 'VIEW') {
      line += `\n     cuantitativo: cols=${(await dlg.locator('.spd-colhead').allInnerTexts()).join('/')} | indicadores=${(await dlg.locator('.spd-bars > span:nth-child(3n+1)').allInnerTexts()).join('/')}`;
    }
    if (SAVE && canSave) {
      if (stage === 'SCHEDULE') {
        await fillIf(dlg.locator('input[name=f01]'), '2');
        await selIf(dlg.locator('#spd_from'), '1'); await selIf(dlg.locator('#spd_to'), '3');
        await fillIf(dlg.locator('#u_RP'), '1.000.000');
      } else if (stage === 'REPORT' || stage === 'VALIDATE') {
        await fillIf(dlg.locator('input[name=f01]'), '1');
        await fillIf(dlg.locator('#c1_RP'), '250.000');
        await dlg.locator('.t-Tabs-link', { hasText: 'Avance Cualitativo' }).click();
        await fillIf(dlg.locator('textarea[name=f11]'), 'Prueba automática: se ejecutaron las actividades.');
        // la focalización (IG + formulario 1065) la prueba test_focalizacion_160.js
        if (stage === 'VALIDATE') await dlg.locator('input[type=radio][value="VALIDATED"]').first().check({ force: true, timeout: 5000 }).catch(e => problems.push(`[${current}] opción Validada: ${e.message.split(/\n/)[0]}`));
      } else if (stage === 'REVIEW') {
        await dlg.locator('input[type=radio][value="REVIEWED"]').first().check({ force: true, timeout: 5000 }).catch(e => problems.push(`[${current}] opción Aprobada: ${e.message.split(/\n/)[0]}`));
        await dlg.locator('[id$=REVIEW_NOTES]').fill('Revisado en prueba automática').catch(() => {});
      }
      await dlg.locator('.t-ButtonRegion button, .t-Dialog-footer button', { hasText: 'Guardar' }).first().click();
      const closed = await page.waitForFunction(t => !document.querySelector(`iframe[title="${t}"]`), dlgTitle, { timeout: 20000 }).then(() => true).catch(() => false);
      if (!closed) {
        problems.push(`[${current}] el diálogo no se cerró: ${(await dlg.locator('.a-Notification, .t-Alert, #t_Alert_Notification').allInnerTexts().catch(() => [])).join(' ').replace(/\s+/g, ' ').slice(0, 300)}`);
        await page.keyboard.press('Escape');
      } else {
        await page.waitForTimeout(1200);
        const msg = (await page.locator('#t_Alert_Success').innerText().catch(() => '')).replace(/\s+/g, ' ').replace('Success Message', '').trim();
        const st = await page.locator(`#spd_list a[data-goal="${goal}"]`).locator('xpath=ancestor::tr').locator('.spd-st').getAttribute('title').catch(() => '?');
        line += `\n     guardado: "${msg}" | estado ahora: ${st}`;
      }
    } else {
      await dlg.locator('button', { hasText: 'Volver' }).click().catch(() => page.keyboard.press('Escape'));
      await page.waitForTimeout(500);
    }
    console.log(line);
  }
  console.log(`\n${problems.length} problemas`); [...new Set(problems)].forEach(p => console.log(' -', p));
  await browser.close();
})().catch(e => { console.error(e); process.exit(1); });
