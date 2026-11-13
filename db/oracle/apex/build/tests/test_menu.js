// Recorre todas las entradas del menú (destinos leídos de la BD) en Edge y reporta errores.
const { chromium } = require('playwright-core');
const fs = require('fs');

const entries = fs.readFileSync(process.argv[2], 'utf8').trim().split('\n')
  .map(l => l.split('|')).filter(x => x[1]).map(([path, target]) => ({ path: path.trim(), target: target.trim() }));

(async () => {
  const browser = await chromium.launch({ channel: 'msedge', headless: true });
  const page = await browser.newPage({ viewport: { width: 1400, height: 900 } });
  const problems = [];
  let current = 'login';
  page.on('pageerror', e => problems.push(`[${current}] JS: ${e.message.slice(0, 160)}`));
  page.on('response', r => { if (r.status() >= 400) problems.push(`[${current}] HTTP ${r.status()} ${r.url().slice(0, 120)}`); });

  await page.goto('http://localhost:8080/ords/r/spd/spd/login');
  await page.fill('#P9999_USERNAME', 'ADMIN');
  await page.fill('#P9999_PASSWORD', process.env.SPD_PASS);
  await Promise.all([page.waitForURL(u => !String(u).includes('/login')), page.click('.t-Button--hot')]);
  const session = new URL(page.url()).searchParams.get('session');

  // menú visible en la página
  const menuTexts = await page.$$eval('#t_TreeNav .a-TreeView-label', els => els.map(e => e.textContent.trim()));
  console.log('Menú (primer nivel visible):', menuTexts.slice(0, 8).join(' | '));

  for (const e of entries) {
    current = e.path;
    const url = 'http://localhost:8080/ords/' + e.target.replace('&APP_ID.', '100').replace('&SESSION.', session).replace('&DEBUG.', '');
    await page.goto(url);
    await page.waitForLoadState('networkidle').catch(() => {});
    await page.waitForTimeout(400);
    const errs = await page.$$eval('.a-Notification-item, .t-Alert--danger .t-Alert-body', els => els.map(x => x.innerText.trim()).filter(Boolean));
    errs.forEach(t => problems.push(`[${current}] APEX: ${t.replace(/\s+/g, ' ').slice(0, 200)}`));
    const h2 = await page.$eval('h2', h => h.textContent.trim()).catch(() => '');
    const title = await page.title();
    console.log(`${errs.length ? 'ERROR' : 'ok   '} ${e.path.padEnd(52)} ${title}${title === 'En construcción' ? '  -> "' + h2 + '"' : ''}`);
  }
  await browser.close();
  console.log(`\nProblemas: ${problems.length}`);
  [...new Set(problems)].forEach(p => console.log(' - ' + p));
})().catch(e => { console.error('FALLO:', e.message); process.exit(1); });
