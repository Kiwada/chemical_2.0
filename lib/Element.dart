import '../lib/atom.dart';

class Element {
  final Atom symbol;
  final String name;
  final String latinName;
  final int weight;

  Element(
      {required symbol,
      required this.name,
      required this.latinName,
      required this.weight})
      : symbol = Atom(symbol);
}
