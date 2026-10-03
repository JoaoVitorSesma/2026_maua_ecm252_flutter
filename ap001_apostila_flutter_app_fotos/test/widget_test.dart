import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exibe_imagens/src/app.dart';

void main() {
  testWidgets('O botão incrementa o número de imagens', (tester) async {
    await tester.pumpWidget(App());
    expect(find.text('Minhas Imagens'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    for (var numero = 1; numero <= 6; numero++) {
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('$numero'), findsOneWidget);
      expect(find.text('${numero - 1}'), findsNothing);
      expect(tester.takeException(), isNull);
    }
  });
}
