// Exercício das páginas 46 a 48.
import 'dart:convert';

void main() {
  var concessionariaJSON = '''{
    "cnpj": "123456789/0001",
    "filiais": [
      {
        "nome": "Filial 1",
        "endereco": {"logradouro": "Rua A", "numero": 100, "bairro": "Vila A"},
        "veiculos": [
          {"modelo": "Gol", "marca": "VW", "placa": "ABC-1234", "preco": 20000},
          {"modelo": "Celta", "marca": "Chevrolet", "placa": "DEF-5544", "preco": 17000}
        ]
      },
      {
        "nome": "Filial 2",
        "endereco": {"logradouro": "Rua B", "numero": 100, "bairro": "Vila B"},
        "veiculos": [
          {"modelo": "Corsa", "marca": "Chevrolet", "placa": "ERF-1122", "preco": 12000},
          {"modelo": "Fusca", "marca": "VW", "placa": "DEF-1111", "preco": 15000}
        ]
      }
    ]
  }''';
  var concessionaria = json.decode(concessionariaJSON);
  print(concessionaria.runtimeType);
  var filiais = concessionaria['filiais'];
  print(filiais.runtimeType);
  double mediaTotal = 0;
  int totalVeiculos = 0;
  for (final filial in filiais) {
    var veiculos = filial['veiculos'];
    double media = 0;
    for (final veiculo in veiculos) {
      media += veiculo['preco'];
      mediaTotal += veiculo['preco'];
      totalVeiculos++;
    }
    print('Filial ${filial['nome']}: ${media / veiculos.length}');
  }
  print('Média total: ${mediaTotal / totalVeiculos}');
  print('Total de veículos: $totalVeiculos');
}
