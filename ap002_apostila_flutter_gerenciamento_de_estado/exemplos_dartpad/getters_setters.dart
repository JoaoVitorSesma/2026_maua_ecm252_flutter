// Exemplo das páginas 26 e 27.
class Pessoa {
  String _nome;
  int _idade;

  Pessoa(this._nome, this._idade);

  String get nome => _nome;
  set nome(String value) => _nome = value;

  int get idade {
    return _idade;
  }

  set idade(int value) {
    _idade = value;
  }
}

void main() {
  var pessoa = Pessoa('Joao', 25);
  print(pessoa.nome);
  print(pessoa.idade);
  pessoa.nome = 'Maria';
  print(pessoa.nome);
}
