part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPreviousSearches extends SearchEvent {
  FetchPreviousSearches();
}
