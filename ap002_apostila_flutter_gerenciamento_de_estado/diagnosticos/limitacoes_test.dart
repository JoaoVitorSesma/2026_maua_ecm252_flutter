import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciamento_de_estado/src/app.dart';
import 'package:gerenciamento_de_estado/src/blocs/bloc.dart';
import 'package:gerenciamento_de_estado/src/blocs/provider.dart' as escopo;

// Reproducoes de limitacoes, separadas da suite de comportamento desejado.
void main() {
  testWidgets(
    'Email invalido pode coexistir com botao habilitado apos editar senha',
    (tester) async {
      await tester.pumpWidget(App());
      final bloc = escopo.Provider.of(
        tester.element(find.byType(TextField).first),
      );
      addTearDown(bloc.dispose);
      await tester.enterText(find.byType(TextField).first, 'aluno@example.com');
      await tester.enterText(find.byType(TextField).last, '1234');
      await tester.pumpAndSettle();
      expect(
        tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
        isNotNull,
      );
      await tester.enterText(find.byType(TextField).first, 'aluno');
      await tester.pumpAndSettle();
      expect(
        tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
        isNull,
      );
      await tester.enterText(find.byType(TextField).last, '5678');
      await tester.pumpAndSettle();
      expect(find.text('E-mail inválido'), findsOneWidget);
      expect(
        tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
        isNotNull,
      );
    },
  );

  testWidgets('Remover o Provider nao fecha automaticamente o Bloc', (
    tester,
  ) async {
    late Bloc bloc;
    await tester.pumpWidget(
      escopo.Provider(
        child: Builder(
          builder: (context) {
            bloc = escopo.Provider.of(context);
            return const SizedBox();
          },
        ),
      ),
    );
    await tester.pumpWidget(const SizedBox());
    expect(() => bloc.changeEmail('depois@example.com'), returnsNormally);
    bloc.dispose();
  });
}
