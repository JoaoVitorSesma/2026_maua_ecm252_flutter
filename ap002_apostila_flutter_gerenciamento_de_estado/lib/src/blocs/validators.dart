import 'dart:async';

import 'package:email_validator/email_validator.dart';

mixin Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (EmailValidator.validate(email)) {
        sink.add(email);
      } else {
        sink.addError('E-mail inválido');
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.length > 3) {
        sink.add(email);
      } else {
        sink.addError('Senha deve ter, pelo menos, 4 caracteres');
      }
    },
  );
}
