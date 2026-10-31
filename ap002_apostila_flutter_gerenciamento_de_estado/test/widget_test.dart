import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciamento_de_estado/src/app.dart';
import 'package:gerenciamento_de_estado/src/blocs/provider.dart' as escopo;

void main() {
  for (final largura in [320.0, 1280.0]) {
  testWidgets('O formulario valida os campos em $largura pixels', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = Size(largura, 900);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(App());
    final bloc = escopo.Provider.of(tester.element(find.byType(TextField).first));
    addTearDown(bloc.dispose);
    expect(find.text('Endereço de e-mail'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    final campos = tester.widgetList<TextField>(find.byType(TextField)).toList();
    expect(campos[0].keyboardType, TextInputType.emailAddress);
    expect(campos[1].obscureText, isTrue);
    expect(campos[1].decoration!.labelText, 'Senha');
    expect(tester.getSize(find.byType(ElevatedButton)).width, largura - 40);
    expect(find.text('E-mail inválido'), findsNothing);
    expect(find.text('null'), findsNothing);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNull);

    await tester.enterText(find.byType(TextField).first, 'aluno');
    await tester.pumpAndSettle();
    expect(find.text('E-mail inválido'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, 'aluno@example.com');
    await tester.pumpAndSettle();
    expect(find.text('E-mail inválido'), findsNothing);

    await tester.enterText(find.byType(TextField).last, '123');
    await tester.pumpAndSettle();
    expect(find.text('Senha deve ter, pelo menos, 4 caracteres'), findsOneWidget);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNull);
    await tester.enterText(find.byType(TextField).last, '1234');
    await tester.pumpAndSettle();
    expect(find.text('Senha deve ter, pelo menos, 4 caracteres'), findsNothing);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNotNull);
    await tester.enterText(find.byType(TextField).first, 'aluno');
    await tester.pumpAndSettle();
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNull);
    expect(tester.takeException(), isNull);
  });
  }
}
