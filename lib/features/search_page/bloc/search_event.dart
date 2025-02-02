part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class InitialEvent extends SearchEvent {}

class SearchInitialTextEvent extends SearchEvent {
  String search_text;
  SearchInitialTextEvent({required this.search_text});
}
