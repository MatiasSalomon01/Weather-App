import 'package:weather_app/models/models.dart';

class CurrentWeatherResponse {
  final Location location;
  final Current current;
  final Forecast forecast;

  CurrentWeatherResponse({
    required this.location,
    required this.current,
    required this.forecast,
  });

  static CurrentWeatherResponse empty() {
    return CurrentWeatherResponse(
      location: Location.empty(),
      current: Current.empty(),
      forecast: Forecast.empty(),
    );
  }

  factory CurrentWeatherResponse.fromJson(Map<String, dynamic> map) {
    return CurrentWeatherResponse(
      location: Location.fromJson(map['location']),
      current: Current.fromJson(
        map['current'],
        map["forecast"]['forecastday'][0]["day"],
      ),
      forecast: Forecast.fromJson(
          map["forecast"]['forecastday'][0]["hour"] as List<dynamic>),
    );
  }
}
