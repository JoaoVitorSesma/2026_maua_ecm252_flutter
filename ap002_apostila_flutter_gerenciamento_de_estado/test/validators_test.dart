import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciamento_de_estado/src/blocs/validators.dart';

class _Validadores with Validators {}

void main() {
  final validadores = _Validadores();

  test('Email valido atravessa o stream e email invalido produz mensagem', () async {
    await expectLater(
      Stream.fromIterable(['aluno', 'aluno@example.com']).transform(validadores.validateEmail),
      emitsInOrder([emitsError('E-mail inválido'), 'aluno@example.com', emitsDone]),
    );
  });

  test('Senha exige pelo menos quatro caracteres', () async {
    await expectLater(
      Stream.fromIterable(['', '123', '1234']).transform(validadores.validatePassword),
      emitsInOrder([
        emitsError('Senha deve ter, pelo menos, 4 caracteres'),
        emitsError('Senha deve ter, pelo menos, 4 caracteres'),
        '1234',
        emitsDone,
      ]),
    );
  });
}
