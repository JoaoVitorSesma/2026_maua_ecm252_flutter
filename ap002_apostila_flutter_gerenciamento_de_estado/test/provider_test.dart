import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciamento_de_estado/src/blocs/bloc.dart';
import 'package:gerenciamento_de_estado/src/blocs/provider.dart' as escopo;

void main() {
  testWidgets('Cada descendente recebe o Bloc do Provider mais proximo', (tester) async {
    final blocos = <Bloc>[];
    Widget descendente() => Builder(builder: (context) {
      blocos.add(escopo.Provider.of(context));
      return const SizedBox();
    });
    final externo = escopo.Provider(
      child: Column(children: [
        descendente(),
        escopo.Provider(child: descendente()),
      ]),
    );
    await tester.pumpWidget(MaterialApp(home: externo));

    expect(blocos, hasLength(2));
    expect(identical(blocos[0], externo.bloc), isTrue);
    expect(identical(blocos[0], blocos[1]), isFalse);
    final valores = Future.wait([blocos[0].email.first, blocos[1].email.first]);
    blocos[0].changeEmail('primeiro@example.com');
    blocos[1].changeEmail('segundo@example.com');
    await tester.pump();
    expect(await valores, ['primeiro@example.com', 'segundo@example.com']);
    await tester.pumpWidget(const SizedBox());
    for (final bloc in blocos) {
      bloc.dispose();
    }
  });
}
