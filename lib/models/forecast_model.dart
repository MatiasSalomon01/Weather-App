import 'package:weather_app/models/models.dart';

class Forecast {
  final List<Hour> hours;
  int minTemp;
  int maxTemp;

  Forecast({required this.hours, this.minTemp = 0, this.maxTemp = 0});

  static Forecast empty() {
    return Forecast(hours: Hour.empty());
  }

  factory Forecast.fromJson(List<dynamic> mapList) {
    var forecast = Forecast(
      hours: List<Hour>.from(mapList.map((e) => Hour.fromJson(e))),
    );

    forecast.minTemp = forecast.hours
        .map((e) => e.temp_c.toInt())
        .reduce((a, b) => a < b ? a : b);

    forecast.maxTemp = forecast.hours
        .map((e) => e.temp_c.toInt())
        .reduce((a, b) => a > b ? a : b);

    return forecast;
  }
}
