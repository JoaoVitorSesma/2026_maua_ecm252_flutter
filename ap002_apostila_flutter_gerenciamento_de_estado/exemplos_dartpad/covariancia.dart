// Exemplo das páginas 54 a 58.
abstract class Animal {
  final _amigos = [];
  final nome;

  Animal(this.nome);

  void fazerAmizade(Animal a);

  void adicionar(Animal a) {
    _amigos.add(a);
  }

  @override
  String toString() {
    return nome;
  }

  void exibir() {
    print(_amigos);
  }
}

class Cachorro extends Animal {
  Cachorro(super.nome);

  @override
  void fazerAmizade(Animal a) {
    adicionar(a);
  }
}

class Papagaio extends Animal {
  Papagaio(super.nome);

  @override
  void fazerAmizade(Animal a) {
    adicionar(a);
  }
}

class Gato extends Animal {
  Gato(super.nome);

  // Sem covariant, restringir o parametro a Gato nao seria uma sobrescrita valida.
  @override
  void fazerAmizade(covariant Gato a) {
    adicionar(a);
  }
}

void main() {
  var c1 = Cachorro('Odie');
  var c2 = Cachorro('Luna');
  var p1 = Papagaio('Zazu');
  var p2 = Papagaio('Lola');
  c1.fazerAmizade(c2);
  c1.fazerAmizade(p2);
  p1.fazerAmizade(c2);
  p1.fazerAmizade(p2);
  c1.exibir();
  p1.exibir();
  var g1 = Gato('Garfield');
  // g1.fazerAmizade(c1); // Invalido: o parametro de Gato exige outro Gato.
  g1.exibir();
}
