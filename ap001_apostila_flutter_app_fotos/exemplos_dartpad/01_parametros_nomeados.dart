// Exemplo das páginas 18 e 19, separado da aplicação Flutter.

// Pode ser null e implicitamente é inicializado com null pelo compilador.
void opcional({int? numero}) {
  print(numero);
}

// Assim não funciona: int não pode ser null e o valor implícito é null.
// void obrigatorio({int numero}) {
//   print(numero);
// }

void obrigatorio({int numero = 5}) {
  print(numero);
}

void comParametrosSemNome(int semNome, {int? comNome}) {
  print(semNome);
  print(comNome);
}

// Os nomeados, separados por {}, devem aparecer depois dos sem nome.
// void comParametrosSemNome({int? comNome}, int semNome) {
//   print(semNome);
//   print(comNome);
// }

void main() {
  // Exibe null.
  opcional();
  // Exibe 2.
  opcional(numero: 2);
  // Exibe 5.
  obrigatorio();
  // Exibe 10.
  obrigatorio(numero: 10);
  // Exibe 2 e null.
  comParametrosSemNome(2);
  // Exibe 2 e 2.
  comParametrosSemNome(2, comNome: 2);
}
