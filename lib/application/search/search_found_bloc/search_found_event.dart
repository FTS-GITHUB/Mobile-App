part of 'search_found_bloc.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchSearch extends SearchEvent {
  FetchSearch({
    required this.searchText,
    required this.categories,
  });

  final List<Category> categories;
  final String searchText;
}

class AddSearchToPrevious extends SearchEvent {
  AddSearchToPrevious({
    required this.categories,
    required this.searchText,
  });

  final List<Category> categories;
  final String searchText;
}
