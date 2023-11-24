import '../lib/periodic_table.dart';

class Molecule implements Comparable<Molecule> {
  final String formula;
  final String name;

  Molecule({required this.formula, required this.name}) {
    validateFormula();
  }

  void validateFormula() {
    RegExp formulaValida = RegExp(r'^[A-Za-z0-9]+$');
    if (!formulaValida.hasMatch(formula)) {
      throw FormatException('Formula Inválida: $formula');
    }
  }

  double get weight {
    double totalWeight = 0.0;

    for (int i = 0; i < formula.length; i++) {
      String currentSymbol = formula[i];
      String nextSymbol = (i + 1 < formula.length) ? formula[i + 1] : '';
      String combinedSymbol = currentSymbol + nextSymbol;

      if (PeriodicTable.elements.containsKey(combinedSymbol)) {
        totalWeight += PeriodicTable.elements[combinedSymbol]!.weight;
        i++;
      } else {
        totalWeight += PeriodicTable.elements[currentSymbol]!.weight;
      }
    }

    return totalWeight;
  }

  @override
  int compareTo(Molecule other) {
    return weight.compareTo(other.weight);
  }
}

void main() {
  var water = Molecule(formula: "h2o", name: "water");
  print(water.weight);
}



/*class Molecule {
  final String formula;
  final String name;

  Molecule(this.formula, this.name) {
    if (!isValidFormula(formula)) {
      throw Exception("Invalid formula for molecule: $formula");
    }
  }

  bool isValidFormula(String formula) {
    RegExp regExp = RegExp(r'^[A-Za-z0-9]+$');
    return regExp.hasMatch(formula);
  }
}

void main(){
  var x = Molecule("h(2o", "agua");
}*/