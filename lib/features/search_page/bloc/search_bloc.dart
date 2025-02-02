import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/data/weather_model.dart';
import 'package:weather/repositories/fetch_weather.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<InitialEvent>(initialEvent);
    on<SearchInitialTextEvent>(searchEvent);
  }

  FutureOr<void> searchEvent(
      SearchInitialTextEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    String v = event.search_text;
    print(v);
    WeatherData weatherValue = await FetchWeather().fetchWeatherData(v);
    emit(
      SearchSuccessState(weatherData: weatherValue),
    );
  }

  FutureOr<void> initialEvent(InitialEvent event, Emitter<SearchState> emit) {}
}
