import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciamento_de_estado/src/app.dart';
import 'package:gerenciamento_de_estado/src/blocs/bloc.dart';

void main() {
  testWidgets('O formulario mostra os campos e o botao da apostila', (tester) async {
    addTearDown(bloc.dispose);
    await tester.pumpWidget(App());
    expect(find.text('Endereço de e-mail'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    final campos = tester.widgetList<TextField>(find.byType(TextField)).toList();
    expect(campos[0].keyboardType, TextInputType.emailAddress);
    expect(campos[1].obscureText, isTrue);
    expect(campos[1].decoration!.labelText, 'Senha');
    expect(find.text('E-mail inválido'), findsNothing);
    expect(find.text('null'), findsNothing);

    await tester.enterText(find.byType(TextField).first, 'aluno');
    await tester.pumpAndSettle();
    expect(find.text('E-mail inválido'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, 'aluno@example.com');
    await tester.pumpAndSettle();
    expect(find.text('E-mail inválido'), findsNothing);

    await tester.enterText(find.byType(TextField).last, '123');
    await tester.pumpAndSettle();
    expect(find.text('Senha deve ter, pelo menos, 4 caracteres'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, '1234');
    await tester.pumpAndSettle();
    expect(find.text('Senha deve ter, pelo menos, 4 caracteres'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
