import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciamento_de_estado/src/app.dart';

void main() {
  testWidgets('A tela inicial mostra o texto da apostila', (tester) async {
    await tester.pumpWidget(App());
    expect(find.text('Começando...'), findsOneWidget);
  });
}
