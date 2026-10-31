import 'package:rxdart/rxdart.dart';

import 'validators.dart';

class Bloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);

  Stream<bool> get emailPasswordAreOk =>
      CombineLatestStream.combine2(email, password, (e, p) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  void submitForm() {
    final email = _emailController.value;
    final password = _passwordController.value;
    print('$email, $password');
  }

  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

