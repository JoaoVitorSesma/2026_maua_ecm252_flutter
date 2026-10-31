import 'package:flutter/material.dart';

class LoginTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: [
          emailField(),
          passwordField(),
          Container(
            margin: EdgeInsets.only(top: 12.0),
            child: Row(children: [Expanded(child: submitButton())]),
          ),
        ],
      ),
    );
  }

  Widget emailField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'seu@email.com',
        labelText: 'Endereço de e-mail',
      ),
    );
  }

  Widget passwordField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(hintText: 'Senha', labelText: 'Senha'),
    );
  }

  Widget submitButton() {
    return ElevatedButton(onPressed: () {}, child: Text('Login'));
  }
}
