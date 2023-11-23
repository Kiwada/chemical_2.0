class Element{
   final String symbol;
   final String name;
   final String latinName;
   final int wight;

   Element(this.symbol,this.name,this.latinName,this.wight){
    if(!isValidSymbol(symbol)){
      throw Exception(('Símbolo inválida: $symbol'));
    }

   }
     bool isValidSymbol(String string){
      return symbol.isNotEmpty;
     }
   

}