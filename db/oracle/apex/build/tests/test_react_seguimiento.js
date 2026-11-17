// App React (Next, puerto 3000): login en Palmira y recorrido de las pantallas de Seguimiento
// con los datos demo (db/oracle/spd_demo_seguimiento.sql + spd_demo_to_postgres.js).
// Reporta errores de GraphQL, errores JS y filas visibles por pantalla.
// Uso: npm i && node test_react_seguimiento.js   (CFG=2024-3 elige otro seguimiento)   (requiere `yarn dev` corriendo)
const { chromium } = require('playwright-core');
const B = process.env.REACT_URL || 'http://localhost:3000';
const KEY = '8913800073';   // Municipio de Palmira

const PAGES = [
  '/config/monitoring', '/config/projects',
  ...['config', 'goals', 'schedule', 'report', 'validation', 'review', 'dashboard'].map(p => `/monitoring/goals/${p}`),
  '/monitoring/projects', ...['config', 'schedule', 'report', 'validation', 'review', 'dashboard'].map(p => `/monitoring/projects/${p}`),
  ...['config', 'plans', 'schedule', 'report', 'validation', 'review', 'dashboard'].map(p => `/monitoring/action-plans/${p}`),
];

(async () => {
  const browser = await chromium.launch({ channel: 'msedge', headless: true });
  const page = await browser.newPage({ viewport: { width: 1500, height: 900 } });
  const problems = [];
  let current = 'login';
  page.on('pageerror', e => problems.push(`[${current}] JS: ${e.message.slice(0, 200)}`));
  page.on('response', async r => {
    if (!r.url().includes('/api/graphql')) return;
    try {
      const body = await r.json();
      for (const e of body.errors || []) problems.push(`[${current}] GraphQL ${(e.path || []).join('.')}: ${e.message.slice(0, 220)}`);
    } catch { /* respuestas no JSON */ }
  });

  await page.goto(`${B}/login?key=${KEY}`);
  await page.waitForSelector('#basic_email', { timeout: 60000 });
  await page.waitForTimeout(3000);   // esperar la hidratación antes de llenar el formulario
  await page.fill('#basic_email', 'fgil666@gmail.com');
  await page.fill('#basic_password', 'spd');
  await page.click('button.ant-btn-primary');
  await page.waitForSelector('.ant-avatar', { timeout: 60000 });   // la app no cambia la URL al entrar
  await page.waitForTimeout(2000);
  console.log('login OK');
  // Seguimiento a usar (periodo-subperiodo, p. ej. CFG=2024-1): selector del encabezado.
  // Sin CFG se deja el activo (la demo 2024-3).
  const CFG = process.env.CFG;
  const cfgSelect = () => page.locator('.ant-select', { has: page.locator('.ant-select-selection-item', { hasText: /^\d{4} - \d+$/ }) }).first();
  const pickConfig = async () => {
    if (!CFG) return;
    const sel = cfgSelect();
    if (!(await sel.count())) return;   // pantallas sin selector
    if ((await sel.locator('.ant-select-selection-item').textContent()).replace(/\s/g, "") === CFG) return;
    await sel.click();
    await page.locator('.ant-select-item-option:visible', { hasText: `(${CFG})` }).first().click();
    await page.waitForTimeout(1500);
  };
  await pickConfig();
  console.log('seguimiento:', CFG);

  for (const p of PAGES) {
    current = p;
    await page.goto(`${B}${p}?key=${KEY}`);
    await page.waitForLoadState('networkidle', { timeout: 90000 }).catch(() => {});
    await pickConfig().catch(e => problems.push(`[${p}] selector: ${e.message.slice(0, 80)}`));
    await page.waitForLoadState('networkidle', { timeout: 90000 }).catch(() => {});
    await page.waitForTimeout(1500);
    const info = await page.evaluate(() => {
      const rows = document.querySelectorAll('.ant-table-row').length;
      const empty = document.querySelectorAll('.ant-empty').length;
      const badges = [...document.querySelectorAll('.ant-badge-count, .ant-scroll-number')].map(b => b.textContent.trim()).filter(Boolean).slice(0, 4);
      const sel = [...document.querySelectorAll('.ant-select-selection-item')].map(s => s.textContent.trim()).slice(0, 3);
      const alerts = [...document.querySelectorAll('.ant-alert-message, .ant-result-title')].map(a => a.textContent.trim()).slice(0, 2);
      return { rows, empty, badges, sel, alerts };
    });
    console.log(`${p.padEnd(36)} filas=${String(info.rows).padEnd(4)} vacío=${info.empty} badges=[${info.badges}] selects=[${info.sel.join(' | ')}] ${info.alerts.join(' ; ')}`);
  }
  console.log(`\n${problems.length} problemas`);
  [...new Set(problems)].forEach(p => console.log(' -', p));
  await browser.close();
})().catch(e => { console.error(e); process.exit(1); });
