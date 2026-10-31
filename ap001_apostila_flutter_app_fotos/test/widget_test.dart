import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exibe_imagens/src/app.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  testWidgets('O botao solicita uma foto da Pexels', (tester) async {
    final requisicoes = <http.Request>[];
    await http.runWithClient(
      () async {
        await tester.pumpWidget(App());
        expect(find.text('Minhas Imagens'), findsOneWidget);
      expect(find.text('0'), findsNothing);
      expect(find.byType(ListView), findsOneWidget);

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

      expect(find.text('url: https://images.pexels.com/foto.jpg, alt: Uma pessoa caminhando'),
          findsOneWidget);
        expect(requisicoes, hasLength(1));
        final requisicao = requisicoes.single;
        expect(requisicao.method, 'get');
        expect(requisicao.url.scheme, 'https');
        expect(requisicao.url.host, 'api.pexels.com');
        expect(requisicao.url.path, '/v1/search');
        expect(requisicao.url.queryParameters, {
          'query': 'people',
          'page': '1',
          'per_page': '1',
        });
        expect(
          requisicao.headers['Authorization'],
          const String.fromEnvironment('PEXELS_API_KEY'),
        );
        expect(tester.takeException(), isNull);
      },
      () => MockClient((requisicao) async {
        requisicoes.add(requisicao);
        return http.Response(
          json.encode({
            'photos': [
              {
                'src': {'medium': 'https://images.pexels.com/foto.jpg'},
                'alt': 'Uma pessoa caminhando',
              },
            ],
          }),
          200,
        );
      }),
    );
  });
}
