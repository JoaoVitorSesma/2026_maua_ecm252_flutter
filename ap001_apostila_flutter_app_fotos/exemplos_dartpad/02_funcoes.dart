// Exemplo das páginas 23 e 24, separado da aplicação Flutter.

void main() {
  final f1 = () {
    print('f1');
  };
  final f2 = () {
    print('f2');
    return "f2";
  };
  final f3 = () => print("f3");
  // As chaves delimitam um set ou map, não o corpo da função.
  final f4 = () => {
    // print("E agora?");
  };
  // Devolve um Set com 1 e 2.
  final f5 = () => {1, 2};
  // Devolve um mapa com nome: 'Ana'.
  final f6 = () => {'nome': 'Ana'};
  // Sem inferência de tipo: funções são do tipo Function.
  Function f7 = () {
    print('f7');
  };
  // Funções podem receber funções.
  final f8 = (f) {
    print('f8');
    f();
  };
  // Com parâmetro.
  final f9 = (int? a) {
    print(a);
  };

  // Correção: f1 devolve void; não se pode imprimir seu retorno.
  f1();
  // f2 devolve seu nome.
  print(f2());
  // f3 também devolve void.
  // print(f3());
  f3();
  // Devolve um map vazio.
  print(f4());
  // Devolve um set com 1 e 2.
  print(f5());
  // Devolve um mapa com nome: Ana.
  print(f6());
  // Normal, mas sem inferência de tipo.
  print(f7());
  // Correção: f8 e f9 devolvem void; são chamadas sem print externo.
  // f8 recebe f1 e a coloca em execução.
  f8(f1);
  // f8 recebe uma arrow function sem nome.
  f8(() => print('oi'));
  // Recebe 2 como parâmetro.
  f9(2);
}
