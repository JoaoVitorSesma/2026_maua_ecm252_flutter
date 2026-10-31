# Reproduções das limitações da apostila 02

`limitacoes_test.dart` preserva os dois diagnósticos utilizados durante a implementação:

- Login volta a habilitar após editar a senha, embora o e-mail continue inválido.
- Remover o Provider da árvore não fecha automaticamente o Bloc.

Na pasta da aplicação:

```powershell
flutter pub get
flutter test diagnosticos/limitacoes_test.dart
```

Os cenários usam apenas dados fictícios e fecham explicitamente os recursos que criam. Estão fora de `test/`, portanto a execução normal de `flutter test` não os inclui.

**Aprovação aqui significa que o defeito foi reproduzido.** As expectativas descrevem a falha atual, não o comportamento desejado. Ao corrigir esses problemas, transforme os cenários em testes de regressão do comportamento correto na suíte normal e remova ou atualize as reproduções antigas.

O [README da aplicação](../README.md) explica as causas e as limitações de plataforma do Toast.
