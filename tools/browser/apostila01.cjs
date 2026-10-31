const assert = require('node:assert/strict');
const fs = require('node:fs/promises');
const path = require('node:path');
const { chromium } = require('playwright-core');

const baseURL = process.env.QA_BASE_URL || 'http://127.0.0.1:8765';
const outputDir = process.env.QA_OUTPUT_DIR
  ? path.resolve(process.env.QA_OUTPUT_DIR)
  : path.join(__dirname, 'artifacts', 'apostila01');

(async () => {
  await fs.mkdir(outputDir, { recursive: true });
  const browser = await chromium.launch({
    headless: true,
    executablePath: process.env.CHROMIUM_EXECUTABLE_PATH || undefined,
  });
  const reports = [];
  try {
    for (const width of [320, 1280]) {
      const page = await browser.newPage({ viewport: { width, height: 900 } });
      const errors = [];
      const requests = [];
      page.on('pageerror', error => errors.push(error.message));
      page.on('console', message => {
        if (message.type() === 'error') errors.push(message.text());
      });
      await page.route('https://api.pexels.com/**', async route => {
        const request = route.request();
        requests.push({ url: request.url(), method: request.method() });
        const number = Number(new URL(request.url()).searchParams.get('page'));
        await route.fulfill({
          status: 200,
          contentType: 'application/json',
          headers: { 'access-control-allow-origin': '*' },
          body: JSON.stringify({ photos: [{
            src: { medium: `https://images.pexels.com/qa-${number}.png` },
            alt: `Pessoa ${number} caminhando no parque`,
          }] }),
        });
      });
      await page.route('https://images.pexels.com/**', async route => {
        const png = Buffer.from('iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAIAAAD91JpzAAAAEklEQVR4nGMMqFjAwMDAxAAGABC6AWyM4UYOAAAAAElFTkSuQmCC', 'base64');
        await route.fulfill({
          status: 200,
          contentType: 'image/png',
          headers: { 'access-control-allow-origin': '*' },
          body: png,
        });
      });
      await page.goto(baseURL, { waitUntil: 'networkidle' });
      await page.locator('flt-glass-pane').waitFor({ state: 'attached' });
      const semantics = page.locator('flt-semantics-placeholder');
      if (await semantics.count()) await semantics.evaluate(element => element.click());
      await page.getByText('Você tem 0 imagens', { exact: true }).waitFor();
      const button = page.getByRole('button');
      for (let count = 1; count <= 3; count++) {
        await button.click();
        await page.getByText(`Você tem ${count} imagens`, { exact: true }).waitFor();
      }
      await page.screenshot({ path: path.join(outputDir, `web-${width}.png`), fullPage: true });
      reports.push({ width, url: page.url(), requests, errors });
      await page.close();
    }
    await fs.writeFile(path.join(outputDir, 'browser-qa.json'), JSON.stringify(reports, null, 2));
    console.log(JSON.stringify(reports, null, 2));
    for (const report of reports) {
      assert.deepEqual(report.errors, [], `Erros no navegador em ${report.width}px`);
      assert.deepEqual(report.requests.map(request => new URL(request.url).searchParams.get('page')), ['1', '2', '3']);
    }
  } finally {
    await browser.close();
  }
})().catch(error => { console.error(error); process.exitCode = 1; });
