# ECM252 — Flutter

Aplicações e exemplos em Flutter da disciplina ECM252 do Instituto Mauá de Tecnologia, em 2026.

## Aulas

| Pasta | Conteúdo |
| --- | --- |
| [ap001_apostila_flutter_app_fotos](ap001_apostila_flutter_app_fotos/) | Aplicativo `exibe_imagens`, exemplos de Dart e implementação da apostila até a página 36. |

As plataformas, os recursos e os testes permanecem dentro da pasta da aplicação. Não existe uma aplicação Flutter na raiz deste repositório.

## Executar

Instale o Flutter com um SDK Dart compatível com o `pubspec.yaml` da aplicação. Para executar no Chrome:

```powershell
cd ap001_apostila_flutter_app_fotos
flutter pub get
flutter run -d chrome
```

Para conferir a aplicação, dentro dessa mesma pasta:

```powershell
flutter analyze --no-fatal-infos
flutter test
flutter build web
```

Consulte o [README da aplicação](ap001_apostila_flutter_app_fotos/README.md) para o estado atual da apostila e os exemplos. Dependências e arquivos gerados são preparados localmente em cada clone.

## Origem e histórico

Este projeto foi separado da pasta `flutter` da `main` de [2026_maua_ecm252](https://github.com/JoaoVitorSesma/2026_maua_ecm252). O commit da aplicação preserva autoria, datas e mensagem, com um novo identificador após a extração. As branches auxiliares e as tags continuam no repositório original.

O desenvolvimento de Flutter passa a ocorrer neste repositório. As pastas do repositório original permanecem como referência e não são sincronizadas automaticamente.

Projetos relacionados: [Dart](https://github.com/JoaoVitorSesma/2026_maua_ecm252_dart) e [React](https://github.com/JoaoVitorSesma/2026_maua_ecm252_react).
