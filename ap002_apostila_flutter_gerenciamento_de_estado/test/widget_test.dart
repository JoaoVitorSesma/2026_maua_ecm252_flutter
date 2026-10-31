import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciamento_de_estado/src/app.dart';

void main() {
  testWidgets('O formulario mostra os campos e o botao da apostila', (tester) async {
    await tester.pumpWidget(App());
    expect(find.text('Endereço de e-mail'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    final campos = tester.widgetList<TextField>(find.byType(TextField)).toList();
    expect(campos[0].keyboardType, TextInputType.emailAddress);
    expect(campos[1].obscureText, isTrue);
    expect(campos[1].decoration!.labelText, 'Senha');
  });
}
