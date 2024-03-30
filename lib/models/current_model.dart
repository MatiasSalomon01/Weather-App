// ignore_for_file: non_constant_identifier_names

import 'package:weather_app/models/models.dart';

class Current {
  final String last_updated;
  final double temp_c;
  final double mintemp_c;
  final double maxtemp_c;
  final int is_day;
  final Condition condition;
  final double wind_kph;
  final String wind_dir;
  final int humidity;
  final double feelslike_c;
  final double uv;
  final String sunrise;
  final String sunset;

  Current({
    required this.last_updated,
    required this.temp_c,
    required this.is_day,
    required this.condition,
    required this.wind_kph,
    required this.wind_dir,
    required this.humidity,
    required this.feelslike_c,
    required this.uv,
    this.maxtemp_c = 0.0,
    this.mintemp_c = 0.0,
    required this.sunrise,
    required this.sunset,
  });

  static Current empty() {
    return Current(
      last_updated: "",
      temp_c: 0,
      is_day: 0,
      condition: Condition.empty(),
      wind_kph: 0,
      wind_dir: "",
      humidity: 0,
      feelslike_c: 0,
      uv: 0,
      sunrise: "",
      sunset: "",
    );
  }

  factory Current.fromJson(Map<String, dynamic> map, Map<String, dynamic> map2,
      Map<String, dynamic> map3) {
    return Current(
      last_updated: map['last_updated'],
      temp_c: map['temp_c'],
      is_day: map['is_day'],
      condition: Condition.fromJson(map['condition']),
      wind_kph: map['wind_kph'],
      wind_dir: map['wind_dir'],
      humidity: map['humidity'],
      feelslike_c: map['feelslike_c'],
      uv: map['uv'],
      maxtemp_c: map2['maxtemp_c'],
      mintemp_c: map2['mintemp_c'],
      sunrise: map3["sunrise"],
      sunset: map3["sunset"],
    );
  }
}
