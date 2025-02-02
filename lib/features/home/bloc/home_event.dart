part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class WeatherInitialEvent extends HomeEvent {}

class SearchEvent extends HomeEvent {}
