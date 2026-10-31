# Conferência das aplicações no navegador

Os scripts conferem as duas aplicações Web em larguras de 320 e 1280 pixels. Usam dados fictícios; a apostila 01 intercepta a API e as imagens da Pexels, portanto não precisa de chave nem acessa o serviço real.

## Preparação

Instale Node.js 20 ou superior, com npm. Nesta pasta:

```powershell
npm ci
```

O projeto utiliza `playwright-core` com versão fixada no lockfile. É possível instalar o Chromium correspondente com:

```powershell
npx playwright-core install chromium
```

Se já houver um navegador Chromium compatível, informe seu executável antes de executar os scripts:

```powershell
$env:CHROMIUM_EXECUTABLE_PATH = 'C:\caminho\para\chrome.exe'
```

Nenhum caminho específico desta máquina está codificado nos scripts. Sem essa variável, o Playwright procura sua própria instalação do Chromium.

## Executar

Compile a aplicação e mantenha um servidor local aberto. A partir da raiz do repositório, para a apostila 01:

```powershell
cd ap001_apostila_flutter_app_fotos
flutter pub get
flutter build web --no-web-resources-cdn
python -m http.server 8765 --bind 127.0.0.1 --directory build/web
```

Em outro terminal, dentro de `tools/browser`:

```powershell
npm run qa:01
```

Para a apostila 02, use sua pasta e a porta 8766:

```powershell
cd ap002_apostila_flutter_gerenciamento_de_estado
flutter pub get
flutter build web --no-web-resources-cdn
python -m http.server 8766 --bind 127.0.0.1 --directory build/web
```

Em outro terminal, dentro de `tools/browser`:

```powershell
npm run qa:02
```

Os scripts retornam código diferente de zero quando falham as conferências ou há erros no console. Para utilizar outro endereço ou diretório de saída:

```powershell
$env:QA_BASE_URL = 'http://127.0.0.1:9000'
$env:QA_OUTPUT_DIR = 'C:\caminho\para\resultados'
npm run qa:02
```

O endereço padrão é `http://127.0.0.1:8765` para a apostila 01 e `http://127.0.0.1:8766` para a 02. A saída padrão fica em `artifacts/apostila01` ou `artifacts/apostila02`, nesta pasta. Capturas, relatórios JSON e `node_modules/` são ignorados pelo Git; podem ser apagados após a conferência. Se definir outro diretório, mantenha os resultados fora dos arquivos versionados.

## O que é conferido

- Apostila 01: três cliques, contador de imagens, sequência de páginas 1/2/3, captura de tela e erros do navegador.
- Apostila 02: botão inicialmente desabilitado, mensagens dos campos inválidos, envio válido, texto e desaparecimento do Toast, captura de tela e erros do navegador.

A apostila 02 também registra `loginHabilitadoComEmailInvalido` no JSON, observando o defeito conhecido após invalidar o e-mail e editar a senha. Esse dado não é um critério de aprovação; a reprodução determinística está no diagnóstico Flutter.

As verificações Web não comprovam o comportamento nativo Android/iOS nem uma integração real com a Pexels.
