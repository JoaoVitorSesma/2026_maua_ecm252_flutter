# Apostila 02 — Gerenciamento de estado

Aplicativo `gerenciamento_de_estado` da disciplina ECM252. Implementa a apostila até a demonstração das páginas 89–90; a página 91 contém referências. O [plano aprovado](../docs/plans/2026-10-31-1159-feat-apostila-02-estado-plan.md) registra o escopo e a sequência.

O formulário valida e-mail e senha, controla o botão por streams e exibe os últimos valores em um Toast. A submissão é fictícia e local. Use dados inventados: o texto da apostila exibe também a senha. Não há serviço de autenticação nem chave de API.

## Executar

Na pasta desta aplicação, com Flutter e Dart instalados:

```powershell
flutter pub get
flutter run -d chrome
```

Versões utilizadas na implementação: Flutter 3.47.1, Dart 3.13.1, `email_validator` 2.1.16, `rxdart` 0.28.0 e `fluttertoast` 10.0.2. O lockfile está versionado. O pacote de validação foi fixado em 2.1.16 para conservar a versão citada no material; os demais foram resolvidos com o SDK disponível.

## Etapas no histórico

A branch `apostila-02-gerenciamento-de-estado` parte da `main` após o merge da apostila 01. Os commits preservam as versões intermediárias relevantes:

| Unidade | Páginas | Etapa concluída | Commit |
| --- | --- | --- | --- |
| U1 | 5–10 | Base do aplicativo, App e Scaffold | `39d0e38` |
| U2 | 11–20 | Campos, senha oculta, margens e botão expandido | `a636bda` |
| U3 | 21–29 | BLoC com controllers, streams e exemplo de getters/setters | `2443c14` |
| U4 | 30–34 | Validators, transformações e dispose | `d4e8664` |
| U5 | 35–48 | BLoC global e StreamBuilders dos campos | `cf37938` |
| U6 | 49–62 | Provider próprio e exemplo de covariância | `49028e6` |
| U7 | 63–66 | BLoC obtido pelo contexto e remoção da instância global | `4e16836` |
| U8 | 67–81 | CombineLatestStream, controllers broadcast e botão reativo | `3cc5ac0` |
| U9 | 81–85 | BehaviorSubject e submissão com os últimos valores | `22a0bae` |
| U10 | 85–90 | Toast em lugar do print intermediário | `038d664` |
| U11 | Revisão | Formatação dos fontes e testes | `49fa18d` |
| U11 | Revisão | Este README, índice das aplicações e plano versionado | Commit de documentação da branch |

Para estudar uma etapa, abra seu commit no GitHub. Para conservar esses commits ao integrar o PR, use **Create a merge commit**.

## Estrutura final

- `lib/src/app.dart`: Provider envolvendo MaterialApp e LoginTela.
- `lib/src/telas/login_tela.dart`: TextFields e botão com StreamBuilders.
- `lib/src/blocs/bloc.dart`: BehaviorSubjects, streams de entrada/saída, combinação e submissão.
- `lib/src/blocs/validators.dart`: formato de e-mail e senha com pelo menos quatro caracteres.
- `lib/src/blocs/provider.dart`: InheritedWidget próprio que fornece o Bloc mais próximo.
- `exemplos_dartpad/`: exemplos independentes de getters/setters e covariância.
- `test/`: validação, streams, escopo do Provider, tela e chamada do Toast.

O Provider é o exemplo do PDF; não há dependência no pacote `provider` nem no `flutter_bloc`.

```powershell
dart exemplos_dartpad/getters_setters.dart
dart exemplos_dartpad/covariancia.dart
```

Ambos foram executados. O primeiro imprime `Joao`, `25` e `Maria`. O segundo imprime `[Luna, Lola]` duas vezes e `[]` para o gato.

## Tentativas didáticas e compatibilidade

As falhas que o próprio material corrige não permanecem ativas nos commits que concluem as etapas:

- `snapshot.error.toString()` sem condição mostra o texto `null` antes de haver erro. U5 termina com a condição `snapshot.hasError` ensinada em seguida.
- Um controller de assinatura única não atende simultaneamente o campo e o botão. U8 termina com broadcast; U9 troca os controllers por BehaviorSubject, que também permite múltiplos consumidores e entrega o último valor a novas inscrições.
- Condicionar o botão apenas à ausência de erro permite habilitá-lo antes de haver dados. U8 termina com `snapshot.hasData`, conforme o PDF.
- Restringir o parâmetro de `Gato.fazerAmizade` sem `covariant` produz uma sobrescrita inválida. A versão válida usa `covariant Gato`; a chamada com Cachorro está comentada no exemplo.

Foi utilizado o nome real `pubspec.yaml`, apesar das ocorrências de `pubspec.yml` no texto. A aparência dos controles segue o tema padrão do Flutter instalado; pode diferir das capturas feitas com versões anteriores. Os nomes e a estrutura didática foram mantidos.

## Verificações realizadas

Em 31/10/2026, na versão final dos fontes:

| Conferência | Resultado |
| --- | --- |
| `flutter test --no-pub` | 10 testes passaram: quatro de Bloc, dois de validação, um de Provider, dois de tela e um de submissão. |
| `flutter analyze --no-fatal-infos --no-pub` | Nenhum erro ou warning; 11 sugestões informativas. |
| `flutter build web --no-pub --no-web-resources-cdn` | Compilação concluída. |
| Exemplos DartPad | Ambos executados com as saídas descritas acima. |
| Chromium, 320×900 e 1280×900 | Campos, senha oculta, erros, correção dos campos, botão e Toast conferidos; nenhum erro no console. |
| Regressão da apostila 01 | Seus três testes existentes passaram; nenhum arquivo dessa aplicação foi alterado. |

As sugestões do analisador dizem respeito aos exemplos com `dynamic`/`print`, getters/setters didáticos e construtores com key/superparameters. Foram mantidos os padrões apresentados pelo PDF.

O teste de submissão simula o canal do plugin e confere o último par digitado, duração curta, centro, azul, branco e fonte 16. Essa simulação comprova os argumentos enviados, sem comprovar a aparência nativa. Na Web, o Toast real e seu desaparecimento foram observados com dados fictícios. O navegador foi automatizado com Playwright/Chromium já disponíveis, pois não havia ferramenta Browser conectada.

Para repetir as verificações após resolver as dependências:

```powershell
flutter analyze --no-fatal-infos
flutter test
flutter build web
```

## Problemas confirmados para correção posterior

Os itens abaixo foram reproduzidos e preservados conforme a decisão de seguir a apostila antes de corrigir seus defeitos residuais. Os dez testes da suíte não significam que esses problemas estejam resolvidos.

### Botão habilitado com um campo inválido

1. Digite `aluno@example.com` e `1234`: Login fica habilitado.
2. Altere o e-mail para `aluno`: aparece o erro e Login fica desabilitado.
3. Altere a senha para `5678`: Login volta a habilitar, embora o e-mail continue inválido.

O caso foi confirmado em teste diagnóstico separado e no navegador nas duas larguras. `CombineLatestStream` conserva o último dado válido quando recebe um erro; um novo dado do outro campo emite `true` usando esse valor anterior. A submissão lê o valor bruto atual do BehaviorSubject e pode, portanto, enviar o e-mail inválido.

Uma correção posterior precisa representar explicitamente a validade atual dos dois campos, incluindo os estados de erro, e conferir esse estado na submissão.

### Provider não descarta automaticamente o Bloc

O método `Bloc.dispose()` fecha os subjects quando chamado. Entretanto, o Provider mostrado no PDF não chama esse método ao sair da árvore. Um diagnóstico removeu o Provider e confirmou que seu Bloc continuava aceitando dados. Os testes fecham explicitamente os recursos que criam.

A correção posterior precisa atribuir o ciclo de vida do Bloc a um widget que possa chamar dispose, preservando o acesso pelo contexto.

### Toast e plataformas

A chamada preserva `ToastGravity.CENTER`, fundo azul, texto branco, fonte 16 e duração curta do material. No Chromium, com fluttertoast 10.0.2, o Toast real apareceu no topo, à direita na tela larga e ajustado à tela estreita, com gradiente verde padrão. Ele pode sobrepor os campos por sua curta duração. O comportamento Web não reproduz a posição central nem o fundo azul solicitados pela API nativa.

Não havia dispositivo ou emulador Android/iOS disponível: **Toast nativo não verificado**. Os diretórios de plataforma são os gerados pelo Flutter; não comprovam suporte do plugin em todas elas. Esta chamada de Toast suporta Android, iOS e Web; a execução de desktop nativo não foi validada.

## Revisão e entrega

Os fontes, exemplos, testes, dependências e o diff final foram conferidos na sessão principal, juntamente com os requisitos do plano. Não foi realizada revisão independente: o fluxo completo de ce-code-review exige outros contextos, e as instruções do projeto determinam execução sequencial na sessão principal.

Code review: skipped (ce-code-review unavailable)

A entrega é um PR da branch para `main`, com merge manual pelo usuário. Os diagnósticos acima ficam registrados para uma rodada posterior de correções.
