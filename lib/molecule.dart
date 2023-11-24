import 'dart:convert';
import 'dart:io';

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

  int get weight {
    return calculateFormulaWeight(formula, loadElementsJson());
  }

  Map<String, dynamic> loadElementsJson() {
    final jsonData = File('elements.json').readAsStringSync();
    final dynamic decodedData = jsonDecode(jsonData);

    if (decodedData is List) {
      final Map<String, dynamic> elementsMap = {};
      for (final element in decodedData) {
        final symbol = element['symbol'] as String;
        elementsMap[symbol] = element;
      }
      return elementsMap;
    } else if (decodedData is Map) {
      return decodedData.cast<String, dynamic>();
    } else {
      throw Exception('Formato de JSON não suportado');
    }
  }

  int calculateFormulaWeight(
      String formula, Map<String, dynamic> elementsJson) {
    int totalWeight = 0;

    int currentIndex = 0;
    while (currentIndex < formula.length) {
      String currentSymbol = formula[currentIndex];

      int nextIndex = currentIndex + 1;
      while (
          nextIndex < formula.length && isLowerCaseLetter(formula[nextIndex])) {
        currentSymbol += formula[nextIndex];
        nextIndex++;
      }

      String numericPart = '';
      while (nextIndex < formula.length && isNumeric(formula[nextIndex])) {
        numericPart += formula[nextIndex];
        nextIndex++;
      }

      int atomCount = numericPart.isNotEmpty ? int.parse(numericPart) : 1;

      int elementWeight = findWeightBySymbol(currentSymbol, elementsJson);
      totalWeight += elementWeight * atomCount;

      currentIndex = nextIndex;
    }

    return totalWeight;
  }

  int findWeightBySymbol(String symbol, Map<String, dynamic> elementsJson) {
    final element = elementsJson[symbol];

    if (element != null) {
      final weight = element['weight'];
      if (weight is int) {
        return weight;
      } else if (weight is String) {
        return int.parse(weight);
      } else {
        throw Exception('Formato de peso inválido para o símbolo: $symbol');
      }
    } else {
      throw Exception('Elemento não encontrado para o símbolo: $symbol');
    }
  }

  bool isNumeric(String s) {
    return int.tryParse(s) != null;
  }

  bool isLowerCaseLetter(String s) {
    return RegExp(r'[a-z]').hasMatch(s);
  }

  @override
  int compareTo(Molecule other) {
    return weight.compareTo(other.weight);
  }
}
