import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciamento_de_estado/src/app.dart';
import 'package:gerenciamento_de_estado/src/blocs/provider.dart' as escopo;

void main() {
  testWidgets('Login envia ao Toast os ultimos valores digitados', (
    tester,
  ) async {
    const canal = MethodChannel('PonnamKarthik/fluttertoast');
    final chamadas = <MethodCall>[];
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(canal, (chamada) async {
      chamadas.add(chamada);
      return true;
    });
    addTearDown(() => messenger.setMockMethodCallHandler(canal, null));

    await tester.pumpWidget(App());
    final bloc = escopo.Provider.of(
      tester.element(find.byType(TextField).first),
    );
    addTearDown(bloc.dispose);
    await tester.enterText(
      find.byType(TextField).first,
      'primeiro@example.com',
    );
    await tester.enterText(find.byType(TextField).last, '1234');
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'ultimo@example.com');
    await tester.enterText(find.byType(TextField).last, '5678');
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    expect(chamadas, hasLength(1));
    expect(chamadas.single.method, 'showToast');
    final argumentos = chamadas.single.arguments as Map;
    expect(argumentos['msg'], 'E-mail: ultimo@example.com, Password: 5678');
    expect(argumentos['length'], 'short');
    expect(argumentos['gravity'], 'center');
    expect(argumentos['time'], 1);
    expect(argumentos['bgcolor'], 0xFF2196F3);
    expect(argumentos['textcolor'], 0xFFFFFFFF);
    expect(argumentos['fontSize'], 16.0);
    expect(tester.takeException(), isNull);
  });
}
