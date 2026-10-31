import 'dart:async';

import 'package:exibe_imagens/src/app.dart';
import 'package:exibe_imagens/src/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

// Diagnosticos locais: confirmam limitacoes do material, sem alterar a aplicacao.
void main() {
  test('Resposta sem fotos causa RangeError no modelo da apostila', () {
    expect(() => ImageModel.fromJSON({'photos': []}), throwsRangeError);
  });

  testWidgets('Cliques antes da resposta repetem a mesma pagina', (
    tester,
  ) async {
    final requisicoes = <http.Request>[];
    final respostas = <Completer<http.Response>>[];
    await http.runWithClient(
      () async {
        await tester.pumpWidget(App());
        await tester.tap(find.byIcon(Icons.add));
        await tester.tap(find.byIcon(Icons.add));
        await tester.pump();
        expect(requisicoes.map((r) => r.url.queryParameters['page']), [
          '1',
          '1',
        ]);
        for (final resposta in respostas) {
          resposta.complete(http.Response('{}', 401));
        }
        await tester.pumpAndSettle();
        expect(find.text('Você tem 0 imagens'), findsOneWidget);
      },
      () => MockClient((req) {
        requisicoes.add(req);
        final resposta = Completer<http.Response>();
        respostas.add(resposta);
        return resposta.future;
      }),
    );
  });
}
