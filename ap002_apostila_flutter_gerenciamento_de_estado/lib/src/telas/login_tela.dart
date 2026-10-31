import 'package:flutter/material.dart';

import '../blocs/bloc.dart';
import '../blocs/provider.dart';

class LoginTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: [
          emailField(bloc),
          passwordField(bloc),
          Container(
            margin: EdgeInsets.only(top: 12.0),
            child: Row(children: [Expanded(child: submitButton(bloc))]),
          ),
        ],
      ),
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'seu@email.com',
            labelText: 'Endereço de e-mail',
            errorText: snapshot.hasError ? snapshot.error.toString() : null,
          ),
        );
      },
    );
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Senha',
            labelText: 'Senha',
            errorText: snapshot.hasError ? snapshot.error.toString() : null,
          ),
        );
      },
    );
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.emailPasswordAreOk,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        return ElevatedButton(
          onPressed: snapshot.hasData ? () {} : null,
          child: Text('Login'),
        );
      },
    );
  }
}
