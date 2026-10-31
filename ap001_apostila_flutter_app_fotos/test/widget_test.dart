import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exibe_imagens/src/app.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'network_images.dart';

void main() {
  testWidgets('O botao solicita uma foto da Pexels', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(800, 1800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    final requisicoes = <http.Request>[];
    await comImagensLocais(
      () => http.runWithClient(
        () async {
          await tester.pumpWidget(App());
          expect(find.text('Minhas Imagens'), findsOneWidget);
          expect(find.text('0'), findsNothing);
          expect(find.byType(GridView), findsOneWidget);
          expect(find.text('Você tem 0 imagens'), findsOneWidget);

          await tester.runAsync(() async {
            final context = tester.element(find.byType(Scaffold));
            await precacheImage(
              const NetworkImage('https://images.pexels.com/foto.jpg'),
              context,
            );
            await precacheImage(
              const NetworkImage('https://images.pexels.com/outra.jpg'),
              context,
            );
          });

          await tester.tap(find.byIcon(Icons.add));
          await tester.pumpAndSettle();

          expect(find.byType(Image, skipOffstage: false), findsOneWidget);
          expect(
            (tester.widget<Image>(find.byType(Image, skipOffstage: false)).image
                    as NetworkImage)
                .url,
            'https://images.pexels.com/foto.jpg',
          );
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
          await tester.tap(find.byIcon(Icons.add));
          await tester.pumpAndSettle();
          expect(requisicoes, hasLength(2));
          expect(requisicoes.last.url.queryParameters['page'], '2');
          expect(find.text('Você tem 2 imagens'), findsOneWidget);
          expect(find.text('Uma pessoa caminhando'), findsOneWidget);
          expect(find.text('Uma pessoa lendo'), findsOneWidget);
          final primeira = tester.getTopLeft(find.byType(Image).first);
          final segunda = tester.getTopLeft(find.byType(Image).last);
          expect(primeira.dy, segunda.dy);
          expect(segunda.dx, greaterThan(primeira.dx));
          expect(primeira.dx, greaterThan(0));
          expect(find.byType(Image, skipOffstage: false), findsNWidgets(2));
          expect(
            (tester
                        .widget<Image>(
                          find.byType(Image, skipOffstage: false).last,
                        )
                        .image
                    as NetworkImage)
                .url,
            'https://images.pexels.com/outra.jpg',
          );
          expect(tester.takeException(), isNull);
        },
        () => MockClient((requisicao) async {
          requisicoes.add(requisicao);
          return http.Response(
            json.encode({
              'photos': [
                {
                  'src': {
                    'medium': requisicoes.length == 1
                        ? 'https://images.pexels.com/foto.jpg'
                        : 'https://images.pexels.com/outra.jpg',
                  },
                  'alt': requisicoes.length == 1
                      ? 'Uma pessoa caminhando'
                      : 'Uma pessoa lendo',
                },
              ],
            }),
            200,
          );
        }),
      ),
    );
  });
}
