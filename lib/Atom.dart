import 'dart:convert';
import 'dart:io';

import '../lib/atom.dart';

class Atom {
  final String symbol;

  Atom(this.symbol) {
    if (!isValidSymbol(symbol)) {
      throw Exception("Invalid symbol for Atom");
    }
  }

  bool isValidSymbol(String symbol) {
    final jsonData = jsonDecode(File('elements.json').readAsStringSync());

    for (var s in jsonData) {
      if (s['symbol'].toString() == symbol) {
        return true;
      }
    }
    return false;
  }

  @override
  String toString() => symbol;
}

void main() {
  var x = Atom("Xe");
  print(x);
}
