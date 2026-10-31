const assert = require('node:assert/strict');
const fs = require('node:fs/promises');
const path = require('node:path');
const { chromium } = require('playwright-core');

const baseURL = process.env.QA_BASE_URL || 'http://127.0.0.1:8766';
const outputDir = process.env.QA_OUTPUT_DIR
  ? path.resolve(process.env.QA_OUTPUT_DIR)
  : path.join(__dirname, 'artifacts', 'apostila02');

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
      page.on('pageerror', error => errors.push(error.message));
      page.on('console', message => {
        if (message.type() === 'error') errors.push(message.text());
      });
      await page.goto(baseURL, { waitUntil: 'networkidle' });
      await page.locator('flt-glass-pane').waitFor({ state: 'attached' });
      const semantics = page.locator('flt-semantics-placeholder');
      if (await semantics.count()) await semantics.evaluate(element => element.click());
      const login = page.getByRole('button', { name: 'Login' });
      await login.waitFor();
      const email = page.getByRole('textbox', { name: 'Endereço de e-mail' });
      const password = page.getByRole('textbox', { name: 'Senha' });
      async function typeValue(field, value) {
        await field.click();
        await page.keyboard.press('ControlOrMeta+A');
        await page.keyboard.insertText(value);
      }
      assert.equal(await login.isEnabled(), false, 'Login deve nascer desabilitado');
      await typeValue(email, 'aluno');
      await page.getByText('E-mail inválido', { exact: true }).waitFor();
      await typeValue(password, '123');
      await page.getByText('Senha deve ter, pelo menos, 4 caracteres', { exact: true }).waitFor();
      assert.equal(await login.isEnabled(), false, 'Login habilitado com dados invalidos');
      await page.screenshot({ path: path.join(outputDir, `web-${width}-erros.png`), fullPage: true });
      await typeValue(email, 'aluno@example.com');
      await typeValue(password, '1234');
      await page.evaluate(() => document.fonts.ready.then(() => true));
      await login.click();
      const toast = page.locator('.toastify');
      await toast.waitFor({ state: 'visible' });
      const toastText = await toast.innerText();
      assert.equal(toastText, 'E-mail: aluno@example.com, Password: 1234');
      const toastStyle = await toast.evaluate(element => ({ css: element.getAttribute('style'), className: element.className }));
      await page.screenshot({ path: path.join(outputDir, `web-${width}-toast.png`), fullPage: true, animations: 'disabled' });
      await toast.waitFor({ state: 'detached' });

      await typeValue(email, 'aluno');
      await page.getByText('E-mail inválido', { exact: true }).waitFor();
      await typeValue(password, '5678');
      await page.waitForTimeout(150);
      // Observacao do defeito conhecido; nao e uma condicao de aprovacao.
      const loginHabilitadoComEmailInvalido = await login.isEnabled();
      reports.push({ width, url: page.url(), toastText, toastStyle, loginHabilitadoComEmailInvalido, errors });
      await page.close();
    }
    await fs.writeFile(path.join(outputDir, 'browser-qa.json'), JSON.stringify(reports, null, 2));
    console.log(JSON.stringify(reports, null, 2));
    for (const report of reports) {
      assert.deepEqual(report.errors, [], `Erros no navegador em ${report.width}px`);
    }
  } finally {
    await browser.close();
  }
})().catch(error => { console.error(error); process.exitCode = 1; });
