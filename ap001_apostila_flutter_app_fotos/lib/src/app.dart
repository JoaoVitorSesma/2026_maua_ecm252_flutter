import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/image_model.dart';
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int numeroImagens = 1;
  List<ImageModel> imagens = [];

  void obterImagem() async {
    var url = Uri.https('api.pexels.com', '/v1/search', {
      'query': 'people',
      'page': '$numeroImagens',
      'per_page': '1',
    });
    var req = http.Request('get', url);
    req.headers.addAll({
      'Authorization': const String.fromEnvironment('PEXELS_API_KEY'),
    });
    final result = await req.send();
    if (result.statusCode == 200) {
      final response = await http.Response.fromStream(result);
      var decodedJSON = json.decode(response.body);
      var imagem = ImageModel.fromJSON(decodedJSON);
      setState(() {
        numeroImagens++;
        imagens.add(imagem);
      });
    } else {
      print('Falhou!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Minhas Imagens")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text('Você tem ${imagens.length} imagens'),
            ),
            Expanded(child: ImageList(imagens)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: obterImagem,
        ),
      ),
    );
  }
}
