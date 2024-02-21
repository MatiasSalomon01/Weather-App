import 'package:weather_app/models/models.dart';

class CurrentWeatherResponse {
  final Location location;
  final Current current;

  CurrentWeatherResponse({
    required this.location,
    required this.current,
  });

  static CurrentWeatherResponse empty() {
    return CurrentWeatherResponse(
      location: Location.empty(),
      current: Current.empty(),
    );
  }

  factory CurrentWeatherResponse.fromJson(Map<String, dynamic> map) {
    return CurrentWeatherResponse(
      location: Location.fromJson(map['location']),
      current: Current.fromJson(
        map['current'],
        map["forecast"]['forecastday'][0]["day"],
      ),
    );
  }
}
