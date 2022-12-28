extension Abbreviation on String {
  String get abbreviation {
    String abbreviation;
    if(contains(" ")){
      final List<String> split = this.split(" ");
      abbreviation = split[0][0] + split[1][0];
    } else {
      if(length > 2){
        abbreviation = substring(0, 2);
      } else {
        abbreviation = this;
      }
    }
    return abbreviation.toUpperCase();
  }
}
