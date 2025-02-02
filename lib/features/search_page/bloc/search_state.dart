part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

abstract class SearchActionState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  WeatherData weatherData;
  SearchSuccessState({required this.weatherData});
}

class SearchNoDataState extends SearchState {}
