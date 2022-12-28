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


extension TimePrettier on DateTime {
  String get toPrettyString {
    String timeString;
    DateTime now = DateTime.now();
    if(year == now.year && month == now.month && day == now.day) {
      timeString = toPrettyHour;
    } else if (year == now.year) {
      if(day < 10 && month < 10){
        timeString = "0$day.0$month";
      } else if (day < 10 && month >= 10){
        timeString = "0$day.$month";
      } else if (day >= 10 && month < 10){
        timeString = "$day.0$month";
      } else {
        timeString = "$day.$month";
      }
    } else {
      if(day < 10 && month < 10){
        timeString = "0$day.0$month.$year";
      } else if (day < 10 && month >= 10){
        timeString = "0$day.$month.$year";
      } else if (day >= 10 && month < 10){
        timeString = "$day.0$month.$year";
      } else {
        timeString = "$day.$month.$year";
      }
    }
    return timeString;
  }

  String get toPrettyHour {
    String timeString;
    if(hour >= 10 && minute < 10){
      timeString = "$hour:0$minute";
    } else if (hour < 10 && minute >= 10){
      timeString = "0$hour:$minute";
    } else if (hour < 10 && minute < 10){
      timeString = "0$hour:0$minute";
    } else {
      timeString = "$hour:$minute";
    }

    return timeString;
  }
}