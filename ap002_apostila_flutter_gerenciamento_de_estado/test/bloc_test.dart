import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciamento_de_estado/src/blocs/bloc.dart';

void main() {
  test('Os streams entregam os valores recebidos pelos getters de entrada', () async {
    final bloc = Bloc();
    final email = expectLater(bloc.email.take(1), emits('aluno@example.com'));
    final senha = expectLater(bloc.password.take(1), emits('1234'));
    bloc.changeEmail('aluno@example.com');
    bloc.changePassword('1234');
    await Future.wait([email, senha]);
  });
}
