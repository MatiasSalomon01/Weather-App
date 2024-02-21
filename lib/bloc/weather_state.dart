part of 'weather_bloc.dart';

sealed class WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherResult extends WeatherState {
  final CurrentWeatherResponse currentWeather;

  WeatherResult({
    required this.currentWeather,
  });
}

class WeatherError extends WeatherState {}
