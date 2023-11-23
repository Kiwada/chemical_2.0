class Atom {
  final String symbol;

  Atom({required this.symbol}) {
    if (!isValidSymbol(symbol)) {
      throw ArgumentError('Símbolo de átomo inválido: $symbol');
    }
  }

  bool isValidSymbol(String symbol) {
    return symbol.isNotEmpty;
  }

  @override
  String toString() {
    return 'Atom(symbol: $symbol)';
  }
}

void main() {
  try {
    final hidrogenio = Atom(symbol: 'H');
    final oxigenio = Atom(symbol: 'O');
    final carbono = Atom(symbol: 'C');
    
    print(hidrogenio);
    print(oxigenio);
    print(carbono);

  } catch (e) {
    print('Erro: $e');
  }
}