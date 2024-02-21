// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/current_weather_response.dart';
import 'package:weather_app/models/models.dart';
import 'package:http/http.dart' as http;

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherLoading()) {
    on<GetCurrentWeatherEvent>(getCurrentWeather);

    on<GetForecastWeatherEvent>((event, emit) {});
  }

  FutureOr<void> getCurrentWeather(event, emit) async {
    emit(WeatherLoading());
    final url = Uri.https(
      'api.weatherapi.com',
      '/v1/forecast.json',
      {
        'q': '-25.280296, -57.639788',
        'lang': 'es',
        'key': '058ba3442b2d4cfa99f130744242102',
      },
    );

    // try {
    final response = await http.get(url);

    if (response.statusCode != 200) {
      emit(WeatherError());
    } else {
      final map = json.decode(response.body) as Map<String, dynamic>;
      var currentWeather = CurrentWeatherResponse.fromJson(map);
      emit(WeatherResult(currentWeather: currentWeather));
    }
    // } catch (e) {
    //   print(e);
    //   emit(WeatherError());
    // }
  }
}
