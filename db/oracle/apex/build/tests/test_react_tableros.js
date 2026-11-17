// App React: Revisión y Tableros de Control de Metas, Proyectos y Planes con el seguimiento indicado (CFG, por defecto 2024-3, la activa) (requiere yarn dev en el 3000).
const CFG = process.env.CFG || '2024-3';
const { chromium } = require('playwright-core');
(async () => {
  const b = await chromium.launch({ channel: 'msedge', headless: true }); const p = await b.newPage({ viewport: { width: 1600, height: 1000 } });
  const errs = [];
  p.on('response', async r => { if (r.url().includes('/api/graphql')) { try { const j = await r.json(); (j.errors || []).forEach(e => errs.push(e.message.slice(0, 150))); } catch {} } });
  await p.goto('http://localhost:3000/login?key=8913800073'); await p.waitForSelector('#basic_email', { timeout: 60000 }); await p.waitForTimeout(3000);
  await p.fill('#basic_email', 'fgil666@gmail.com'); await p.fill('#basic_password', 'spd'); await p.click('button.ant-btn-primary');
  await p.waitForSelector('.ant-avatar', { timeout: 60000 }); await p.waitForTimeout(2000);
  for (const path of ['goals', 'projects', 'action-plans'].flatMap(m => ['review', 'dashboard'].map(s => `/monitoring/${m}/${s}`))) {
    await p.goto(`http://localhost:3000${path}?key=8913800073`); await p.waitForLoadState('networkidle', { timeout: 90000 }).catch(() => {}); await p.waitForTimeout(1500);
    const sel = p.locator('.ant-select', { has: p.locator('.ant-select-selection-item', { hasText: /^\d{4} - \d+$/ }) }).first();
    if ((await sel.locator('.ant-select-selection-item').textContent()).replace(/\s/g, '') !== CFG) {
      await sel.click(); await p.locator('.ant-select-item-option:visible', { hasText: `(${CFG})` }).first().click();
      await p.waitForLoadState('networkidle', { timeout: 90000 }).catch(() => {}); await p.waitForTimeout(2500);
    }
    const rows = await p.locator('.ant-table-row').count();
    const badge = (await p.locator('.ant-card-head .ant-badge-count, .ant-card-head .ant-scroll-number').allInnerTexts()).join(',');
    const first = (await p.locator('.ant-table-row').first().locator('td').allInnerTexts().catch(() => [])).map(t => t.trim()).filter(Boolean).slice(0, 8).join(' | ');
    console.log(path, '| seguimiento', (await sel.locator('.ant-select-selection-item').textContent()), '| filas', rows, '| badges', badge, '\n   ', first);
    if (path.includes('goals')) await p.screenshot({ path: 'react_dash.png' });
  }
  console.log('errores GraphQL:', errs.length, errs.slice(0, 3));
  await b.close();
})();
