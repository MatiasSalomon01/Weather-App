// ignore_for_file: non_constant_identifier_names

import 'package:weather_app/models/models.dart';

class Hour {
  final String time;
  final double temp_c;
  final int is_day;
  final double wind_kph;
  final int humidity;
  final double feelslike_c;
  final int will_it_rain; //1 = Yes 0 = No, Will it will rain or not
  final int chance_of_rain; // Chance of rain as percentage
  final double uv;
  final Condition condition;

  Hour({
    required this.time,
    required this.temp_c,
    required this.is_day,
    required this.wind_kph,
    required this.humidity,
    required this.feelslike_c,
    required this.will_it_rain,
    required this.chance_of_rain,
    required this.uv,
    required this.condition,
  });

  static List<Hour> empty() {
    return [
      Hour(
        time: "",
        temp_c: 0,
        is_day: 0,
        wind_kph: 0,
        humidity: 0,
        feelslike_c: 0,
        will_it_rain: 0,
        chance_of_rain: 0,
        uv: 0,
        condition: Condition.empty(),
      )
    ];
  }

  factory Hour.fromJson(Map<String, dynamic> map) {
    return Hour(
      time: map["time"],
      temp_c: map["temp_c"],
      is_day: map["is_day"],
      wind_kph: map["wind_kph"],
      humidity: map["humidity"],
      feelslike_c: map["feelslike_c"],
      will_it_rain: map["will_it_rain"],
      chance_of_rain: map["chance_of_rain"],
      uv: map["uv"],
      condition: Condition.fromJson(map["condition"]),
    );
  }
}
