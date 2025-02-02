part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class WeatherAction extends HomeState {}

final class HomeInitial extends HomeState {}

class WeatherLoadingState extends HomeState {}

class WeatherSuccessState extends HomeState {
  WeatherData weatherData;
  WeatherSuccessState({required this.weatherData});
}

class WeatherErrorState extends HomeState {}
