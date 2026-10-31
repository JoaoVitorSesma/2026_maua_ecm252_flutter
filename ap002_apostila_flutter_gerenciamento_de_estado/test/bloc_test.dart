import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciamento_de_estado/src/blocs/bloc.dart';

void main() {
  test('Os streams entregam os valores recebidos pelos getters de entrada', () async {
    final bloc = Bloc();
    addTearDown(bloc.dispose);
    final email = expectLater(bloc.email.take(1), emits('aluno@example.com'));
    final senha = expectLater(bloc.password.take(1), emits('1234'));
    bloc.changeEmail('aluno@example.com');
    bloc.changePassword('1234');
    await Future.wait([email, senha]);
  });

  test('Dispose encerra os dois streams', () async {
    final bloc = Bloc();
    final email = expectLater(bloc.email, emitsDone);
    final senha = expectLater(bloc.password, emitsDone);
    bloc.dispose();
    await Future.wait([email, senha]);
  });

  test('Campos e botao podem ouvir os mesmos streams simultaneamente', () async {
    final bloc = Bloc();
    addTearDown(bloc.dispose);
    final email = bloc.email.first;
    final combinado = bloc.emailPasswordAreOk.first;
    bloc.changeEmail('aluno@example.com');
    bloc.changePassword('1234');
    expect(await Future.wait<Object>([email, combinado]), ['aluno@example.com', true]);
  });

  test('Um novo consumidor recebe o ultimo email digitado', () async {
    final bloc = Bloc();
    addTearDown(bloc.dispose);
    bloc.changeEmail('aluno@example.com');
    await expectLater(
      bloc.email.first.timeout(const Duration(milliseconds: 100)),
      completion('aluno@example.com'),
    );
  });
}
