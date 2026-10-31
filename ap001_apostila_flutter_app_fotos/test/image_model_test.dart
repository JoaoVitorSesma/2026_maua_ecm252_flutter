import 'package:exibe_imagens/src/models/image_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('O modelo usa a imagem media e a descricao da primeira foto', () {
    final imagem = ImageModel.fromJSON({
      'photos': [
        {
          'url': 'https://www.pexels.com/photo/1/',
          'src': {
            'original': 'https://images.pexels.com/original.jpg',
            'medium': 'https://images.pexels.com/medium.jpg',
          },
          'alt': 'Uma pessoa caminhando',
        },
        {
          'src': {'medium': 'https://images.pexels.com/outra.jpg'},
          'alt': 'Outra pessoa',
        },
      ],
    });

    expect(imagem.url, 'https://images.pexels.com/medium.jpg');
    expect(imagem.alt, 'Uma pessoa caminhando');
  });
}
