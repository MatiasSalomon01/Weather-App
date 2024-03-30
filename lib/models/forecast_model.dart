import 'package:weather_app/models/models.dart';

class Forecast {
  final List<Hour> hours;

  Forecast({required this.hours});

  static Forecast empty() {
    return Forecast(hours: Hour.empty());
  }

  factory Forecast.fromJson(List<dynamic> mapList) {
    return Forecast(
      hours: List<Hour>.from(mapList.map((e) => Hour.fromJson(e))),
    );
  }
}
