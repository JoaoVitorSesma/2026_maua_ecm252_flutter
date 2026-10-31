# exibe_imagens

Implementação da apostila `01_apostila_flutter_app_fotos.pdf` até o exercício final da página 77. A página 78 contém as referências bibliográficas.

O projeto está na própria pasta `ap001_apostila_flutter_app_fotos`, com o nome de pacote `exibe_imagens` indicado na apostila.

- `lib/main.dart`: instancia `App` e chama `runApp`.
- `lib/src/app.dart`: mantém `App`, `AppState`, `numeroImagens` e a lista `imagens`. O botão chama `obterImagem`, que usa `http.Request`, `Authorization`, `async/await`, `Response.fromStream`, `json.decode` e `setState`, como no material. A busca é por `people`, com uma foto por página. `numeroImagens` começa em 1 e representa a próxima página, enquanto o contador da tela usa `imagens.length`.
- `lib/src/models/image_model.dart`: contém `url`, `alt`, o construtor comum, `ImageModel.fromJSON` e `toString`. Usa `photos[0].src.medium`, conforme a apostila.
- `lib/src/widgets/image_list.dart`: recebe a lista como parâmetro, exibe duas imagens por linha com `Image.network`, bordas, espaçamento e descrições. A tela mostra “Você tem n imagens” acima da grade.
- `exemplos_dartpad/`: exemplos de parâmetros nomeados (páginas 18–19), funções (23–24), JSON (44–45), exercício da concessionária com médias e total de veículos (46–48), classe de modelo (48–49) e construtor nomeado (50–51). `concessionaria.json` corresponde ao exercício das páginas 42–43.

As versões intermediárias foram preservadas nos commits da branch `apostila-01-app-fotos`. A implementação da apostila 02 ainda não foi iniciada.

## Etapas e commits

| Commit | Páginas | Etapa |
| --- | --- | --- |
| `5950346` | 41–51 | Exemplos e exercícios de JSON, concessionária e construtores. |
| `1542e4a` | 52–54 | Modelo de imagem da Pexels. |
| `07143b3` | 54–65 | Pacote `http`, requisição autenticada, `Future.then`, conversão para modelo e `toString`. |
| `0f1c492` | 66–68 | Refatoração para `async/await` e lista no estado. |
| `287dc7a` | 68–72 | Extração de `ImageList` e exibição textual com `ListView.builder`. |
| `ab3ddf8` | 73–74 | Paginação para obter uma nova imagem por clique. |
| `276bf16` | 75–76 | Exibição das fotos com `Image.network`. |
| `202d3b8` | 77 | Exercício final: grade com duas imagens por linha, descrições, contador e espaçamento. |

## Executar

As páginas 38–40 pedem criar uma conta na Pexels e obter uma chave de API. Essa preparação é manual e continua pendente: nenhuma chave real foi fornecida nesta implementação. Consulte a [documentação oficial da Pexels](https://www.pexels.com/api/documentation/).

Dentro desta pasta, execute:

```powershell
flutter pub get
flutter run -d chrome --dart-define=PEXELS_API_KEY=SUA_CHAVE_PEXELS
```

## Verificação

```powershell
flutter analyze --no-fatal-infos
flutter test
flutter build web
```

O literal `'chave'` da apostila foi substituído por `const String.fromEnvironment('PEXELS_API_KEY')`, sem colocar uma credencial no Git. Sem o parâmetro, o cabeçalho `Authorization` fica vazio e a busca real não está configurada. Isso mantém o fluxo didático da requisição.

## Verificações realizadas

Validação em 31/10/2026, com Flutter 3.47.1 e Dart 3.13.1:

- `flutter test --no-pub`: três testes passaram. Cobrem a conversão da resposta para o modelo e o fluxo do botão em larguras de 320 e 1280 pixels, incluindo URL, autorização, paginação, imagens, descrições, contador e duas colunas.
- `flutter analyze --no-fatal-infos --no-pub`: passou, sem erros nem avisos; apresentou 56 sugestões informativas sobre o estilo didático dos exemplos.
- `flutter build web --no-pub --no-web-resources-cdn`: compilou com sucesso.
- Exemplos Dart de JSON e modelos: executados. A concessionária tem quatro veículos, médias de 18500 e 13500 nas filiais e média geral de 16000.
- Navegador Chromium, via Playwright porque o plugin Browser não estava disponível: tela inicial e três cliques conferidos em 320 e 1280 pixels. As requisições avançaram pelas páginas 1, 2 e 3, com contador, descrições e duas colunas visíveis, sem erros no console.

Os testes e a conferência visual usam respostas HTTP e imagens simuladas. Não validam uma conta, uma chave real, cotas ou respostas atuais do serviço Pexels. Android, iOS e desktop não foram compilados nesta etapa.

## Problemas para corrigir depois

As limitações abaixo foram mantidas para seguir o fluxo da apostila e permitir uma próxima etapa de correções.

Confirmadas em diagnósticos locais separados dos testes da aplicação:

- Resposta com `photos: []`: `ImageModel.fromJSON` acessa diretamente a posição zero e lança `RangeError`.
- Dois cliques antes de a primeira resposta terminar: ambas as requisições pedem a mesma página, pois o contador só avança após o sucesso.

Identificadas pela leitura do código:

- Falha de conexão ou JSON inválido: não há `try/catch`; respostas com status diferente de 200 apenas imprimem `Falhou!`, sem mensagem na tela.
- Resposta após descarte do widget: não há verificação de `mounted` antes de `setState`.
- Android em release: o manifesto principal ainda não declara `android.permission.INTERNET`; os manifestos de debug/profile não substituem essa configuração para release.
- Descrições excepcionalmente longas podem exceder a altura fixa de 300 pixels dos itens da grade. Esse caso não foi exercitado na conferência visual.

## Ajustes de transcrição e observações do material

O README e o commit anteriores citavam a página 36. O código do contador já correspondia à solução explicada até a página 38, onde começa a seção da Pexels.

O exemplo de JSON da página 43 contém comentários `//`, que não pertencem à sintaxe JSON. Eles foram omitidos de `concessionaria.json` para permitir sua leitura como JSON válido. Os valores dos exemplos foram preservados, inclusive a associação de Chevrolet com Fusca na página 45 e a saída “Filial Filial 1” do exercício de médias.

O exercício da página 77 não fornece código de solução. Foi resolvido com `GridView.builder`, duas colunas e widgets de leiaute do Flutter; a etapa anterior com `ListView.builder` continua disponível no histórico.

## Correções necessárias nos exemplos

No exemplo de funções, foram acrescentados os pontos e vírgulas ausentes nas declarações de `f5` e `f9`. As chamadas de `f1`, `f8` e `f9` foram retiradas de `print`, pois essas funções devolvem `void`, cujo resultado não pode ser usado como argumento. Os exemplos comentados de código inválido continuam comentados.

As sugestões informativas do analisador sobre `print`, funções em variáveis, nomes de arquivos e o parâmetro `key` foram mantidas para preservar o formato didático da apostila. Elas não são erros de compilação.
