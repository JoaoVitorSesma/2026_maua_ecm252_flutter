import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/image_model.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int numeroImagens = 0;

  void obterImagem() {
    var url = Uri.https('api.pexels.com', '/v1/search', {
      'query': 'people',
      'page': '1',
      'per_page': '1',
    });
    var req = http.Request('get', url);
    req.headers.addAll({
      'Authorization': const String.fromEnvironment('PEXELS_API_KEY'),
    });
    req.send().then((result) {
      if (result.statusCode == 200) {
        http.Response.fromStream(result).then((response) {
          var decodedJSON = json.decode(response.body);
          var imagem = ImageModel.fromJSON(decodedJSON);
          print(imagem);
        });
      } else {
        print('Falhou!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Minhas Imagens")),
        body: Text('$numeroImagens'),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: obterImagem,
        ),
      ),
    );
  }
}
