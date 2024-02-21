import 'package:weather_app/models/models.dart';

class CurrentWeatherResponse {
  final Location location;
  final Current current;

  CurrentWeatherResponse({
    required this.location,
    required this.current,
  });
}
