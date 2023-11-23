//molecule
class Molecule implements Comparable<Molecule> {
  final String formula;
  final String name;

  Molecule({required this.formula, required this.name}) {
    if (!isValidFormula(formula)) {
      throw Exception('Fórmula inválida: $formula');
    }
  }

  double get weight {
    double totalWeight = 0.0;

    for (int i = 0; i < formula.length; i++) {
      String currentSymbol = formula[i];
      int atomCount = 1;

      if (i + 1 < formula.length && isNumeric(formula[i + 1])) {
        atomCount = int.parse(formula[i + 1]);
        i++; 
      }

      totalWeight += getAtomicWeight(currentSymbol) * atomCount;
    }

    return totalWeight;
  }

  bool isValidFormula(String formula) {
    final RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');
    return regex.hasMatch(formula);
  }

  bool isNumeric(String char) {
    return '0' <= char && char <= '9';
  }

  double getAtomicWeight(String symbol) {
    return symbol.length.toDouble();
  }

  @override
  int compareTo(Molecule other) {
    return weight.compareTo(other.weight);
  }
}
