# exibe_imagens

Implementação da apostila `01_apostila_flutter_app_fotos.pdf` até a página 36, inclusive.

O projeto está na própria pasta `ap001_apostila_flutter_app_fotos`, com o nome de pacote `exibe_imagens` indicado na apostila.

- `lib/main.dart`: instancia `App` e chama `runApp`.
- `lib/src/app.dart`: `App` herda de `StatefulWidget`; `AppState` herda de `State<App>`. A tela exibe o título “Minhas Imagens”, o contador `numeroImagens`, inicialmente zero, e um botão com `Icons.add`. Cada clique incrementa o contador usando `setState` e uma arrow function.
- `exemplos_dartpad/`: exemplos de parâmetros nomeados (páginas 18–19) e funções (páginas 23–24), separados da aplicação conforme a apostila.

As etapas intermediárias de `main.dart` e do `StatelessWidget` foram substituídas pela refatoração solicitada nas páginas 35–36. Recursos das páginas seguintes não foram implementados.

## Executar

Dentro desta pasta:

```powershell
flutter run -d chrome
```

## Verificação

```powershell
flutter analyze --no-fatal-infos
flutter test
flutter build web
```

O teste verifica o título, o contador inicial e seis cliques consecutivos no botão.

## Correções necessárias nos exemplos

No exemplo de funções, foram acrescentados os pontos e vírgulas ausentes nas declarações de `f5` e `f9`. As chamadas de `f1`, `f8` e `f9` foram retiradas de `print`, pois essas funções devolvem `void`, cujo resultado não pode ser usado como argumento. Os exemplos comentados de código inválido continuam comentados.

As sugestões informativas do analisador sobre `print`, funções em variáveis, nomes de arquivos e o parâmetro `key` foram mantidas para preservar o formato didático da apostila. Elas não são erros de compilação.
