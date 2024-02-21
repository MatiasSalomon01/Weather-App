// ignore_for_file: non_constant_identifier_names

import 'package:weather_app/models/models.dart';

class Current {
  final String last_updated;
  final double temp_c;
  final int is_day;
  final Condition condition;
  final double wind_kph;
  final String wind_dir;
  final double humidity;
  final double feelslike_c;
  final double uv;

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
  });
}
