# Reproduções das limitações da apostila 01

`limitacoes_test.dart` preserva os dois diagnósticos utilizados durante a implementação:

- `photos: []` provoca `RangeError` no modelo.
- Dois cliques antes da resposta geram duas requisições para a mesma página.

Na pasta da aplicação:

```powershell
flutter pub get
flutter test diagnosticos/limitacoes_test.dart
```

Os diagnósticos usam respostas HTTP simuladas e não precisam de chave da Pexels. Estão fora de `test/`, portanto a execução normal de `flutter test` não os inclui.

**Aprovação aqui significa que o defeito foi reproduzido.** As expectativas descrevem a falha atual, não o comportamento desejado. Ao corrigir esses problemas, transforme os cenários em testes de regressão do comportamento correto na suíte normal e remova ou atualize as reproduções antigas.

As demais limitações e os resultados anteriores estão no [README da aplicação](../README.md).
