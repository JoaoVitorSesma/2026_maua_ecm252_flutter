import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciamento_de_estado/src/blocs/bloc.dart';

void main() {
  test('A submissao ficticia imprime os ultimos valores digitados', () {
    final bloc = Bloc();
    addTearDown(bloc.dispose);
    final mensagens = <String>[];
    runZoned(() {
      bloc.changeEmail('primeiro@example.com');
      bloc.changePassword('1234');
      bloc.changeEmail('ultimo@example.com');
      bloc.changePassword('5678');
      bloc.submitForm();
    }, zoneSpecification: ZoneSpecification(print: (self, parent, zone, texto) {
      mensagens.add(texto);
    }));
    expect(mensagens, ['ultimo@example.com, 5678']);
  });
}
