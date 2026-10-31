import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

// Serve uma imagem PNG real em memoria, sem acessar a Internet nos testes.
Future<void> comImagensLocais(Future<void> Function() executar) async {
  debugNetworkImageHttpClientProvider = () => _ImageHttpClient();
  try {
    await executar();
  } finally {
    debugNetworkImageHttpClientProvider = null;
  }
}

class _ImageHttpClient extends Fake implements HttpClient {
  @override
  set autoUncompress(bool value) {}

  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _ImageRequest();
}

class _ImageRequest extends Fake implements HttpClientRequest {
  @override
  HttpHeaders get headers => _ImageHeaders();

  @override
  Future<HttpClientResponse> close() async => _ImageResponse();
}

class _ImageHeaders extends Fake implements HttpHeaders {
  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {}
}

class _ImageResponse extends Fake implements HttpClientResponse {
  final _bytes = base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAIAAAD91JpzAAAAEklEQVR4nGMMqFjAwMDAxAAGABC6AWyM4UYOAAAAAElFTkSuQmCC',
  );

  @override
  int get statusCode => 200;

  @override
  int get contentLength => _bytes.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int>)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.value(_bytes).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}
