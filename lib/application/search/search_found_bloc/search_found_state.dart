part of 'search_found_bloc.dart';

abstract class SearchFoundState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchFoundStateInitial extends SearchFoundState {}

class SearchFoundStateLoading extends SearchFoundState {}

class SearchFoundStateLoaded extends SearchFoundState {
  SearchFoundStateLoaded({
    required this.categories,
  });

  final List<Category> categories;
}

class SearchFoundStateError extends SearchFoundState {
  SearchFoundStateError({
    required this.message,
  });

  final String message;
}
