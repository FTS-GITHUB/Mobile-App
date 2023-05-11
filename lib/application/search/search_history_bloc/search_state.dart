part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchStateInitial extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchStateLoaded extends SearchState {
  SearchStateLoaded({
    required this.previousSearches,
  });

  final List<PreviousSearches> previousSearches;
}

class SearchStateError extends SearchState {
  SearchStateError({
    required this.message,
  });

  final String message;
}
