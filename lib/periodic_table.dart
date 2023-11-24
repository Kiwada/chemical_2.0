import 'dart:convert';
import 'dart:io';

import '../lib/element.dart';

class PeriodicTable {
  static final PeriodicTable _instance = PeriodicTable._();
  late final Map<String, Element> _elements;

  factory PeriodicTable() {
    return _instance;
  }

  PeriodicTable._() {
    _loadElements();
  }

  void _loadElements() {
    try {
      String jsonContent = File('elements.json').readAsStringSync();
      final elementsJson = jsonDecode(jsonContent);
      List teste = elementsJson.map((e) {
        return Element(
            symbol: e['symbol'],
            name: e['name'],
            latinName: e['latinName'],
            weight: int.parse(e['weight']));
      }).toList();
      Map<String, Element> mapa = {};
      teste.forEach((element) {
        mapa[element.name] = element;
      });
      _elements = mapa;
    } catch (e) {
      print('Erro ao carregar elementos: $e');
      _elements = {};
    }
  }

  static get elements {
    if (_instance._elements.isEmpty) {
      return _instance;
    }
    return _instance._elements;
  }
}

void main() {
  print(PeriodicTable.elements);
}
