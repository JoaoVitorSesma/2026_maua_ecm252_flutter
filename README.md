# ECM252 — Flutter

Aplicações e exemplos em Flutter da disciplina ECM252 do Instituto Mauá de Tecnologia, em 2026.

## Aulas

| Pasta | Conteúdo |
| --- | --- |
| [ap001_apostila_flutter_app_fotos](ap001_apostila_flutter_app_fotos/) | Aplicativo `exibe_imagens`, exemplos de JSON, integração com a Pexels e exercícios da apostila até a página 77. |
| [ap002_apostila_flutter_gerenciamento_de_estado](ap002_apostila_flutter_gerenciamento_de_estado/) | Formulário `gerenciamento_de_estado`, BLoC, Provider próprio, RxDart, exemplos DartPad e Toast até a página 90. |

As plataformas, os recursos e os testes permanecem dentro da pasta da aplicação. Não existe uma aplicação Flutter na raiz deste repositório.

## Executar

Instale o Flutter com um SDK Dart compatível com o `pubspec.yaml` da aplicação. Para executar no Chrome:

```powershell
cd ap001_apostila_flutter_app_fotos
flutter pub get
flutter run -d chrome --dart-define=PEXELS_API_KEY=SUA_CHAVE_PEXELS
```

Para conferir a aplicação, dentro dessa mesma pasta:

```powershell
flutter analyze --no-fatal-infos
flutter test
flutter build web
```

Para o formulário da apostila 02, abra outro terminal na raiz deste repositório:

```powershell
cd ap002_apostila_flutter_gerenciamento_de_estado
flutter pub get
flutter run -d chrome
```

O formulário faz uma submissão local fictícia e não exige chave de API. Consulte os READMEs da [apostila 01](ap001_apostila_flutter_app_fotos/README.md) e da [apostila 02](ap002_apostila_flutter_gerenciamento_de_estado/README.md) para as etapas, verificações e limitações. Dependências e arquivos gerados são preparados localmente em cada clone.

## Diagnósticos e conferência no navegador

As reproduções dos defeitos conhecidos ficam em `diagnosticos/` dentro de cada aplicação, separadas da suíte normal. Consulte as instruções da [apostila 01](ap001_apostila_flutter_app_fotos/diagnosticos/README.md) e da [apostila 02](ap002_apostila_flutter_gerenciamento_de_estado/diagnosticos/README.md). Um diagnóstico aprovado confirma a reprodução do defeito.

Os [scripts de navegador](tools/browser/README.md) conferem as aplicações em duas larguras. Capturas, relatórios e dependências locais gerados por esses scripts são ignorados pelo Git.

## Origem e histórico

Este projeto foi separado da pasta `flutter` da `main` de [2026_maua_ecm252](https://github.com/JoaoVitorSesma/2026_maua_ecm252). O commit da aplicação preserva autoria, datas e mensagem, com um novo identificador após a extração. As branches auxiliares e as tags continuam no repositório original.

O desenvolvimento de Flutter passa a ocorrer neste repositório. As pastas do repositório original permanecem como referência e não são sincronizadas automaticamente.

Projetos relacionados: [Dart](https://github.com/JoaoVitorSesma/2026_maua_ecm252_dart) e [React](https://github.com/JoaoVitorSesma/2026_maua_ecm252_react).
