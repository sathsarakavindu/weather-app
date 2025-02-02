import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/data/weather_model.dart';
import 'package:weather/repositories/fetch_weather.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<WeatherInitialEvent>(weatherInitialEvent);
  }

  FutureOr<void> weatherInitialEvent(
      WeatherInitialEvent event, Emitter<HomeState> emit) async {
    emit(
      WeatherLoadingState(),
    );

    WeatherData weatherValue = await FetchWeather().fetchWeatherData("kandy");

    emit(WeatherSuccessState(weatherData: weatherValue));
  }
}
